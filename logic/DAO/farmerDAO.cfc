<cfcomponent displayname="farmerBean" output="false" hint="the bean farmerBean">

	<cfproperty name="farmerID" type="numeric" default=0 />
    <cfproperty name="firstName" type="string" default="" />
    <cfproperty name="lastName" type="string" default="" />
    <cfproperty name="emailAddress" type="string" default="" />
    <cfproperty name="phoneNumber" type="string" default="" />

    <!--- Pseudo-Constructor  --->
    <cfset variables.instance = { farmerID=0, firstName='', lastName='', emailAddress='', phoneNumber='' } /> 

    <!---  CREATE New Farmer Record --->
    <cffunction name="createNewFarmerRecord" access="public" output="false" hint="creates a new farmer record and returns a farmerBean">
        <cfargument name="bean" required="true" type="logic.bean.farmerBean" hint="farmerBean" />
        <cfset nextFarmerID = 0 />
        
        <!--- Get next FarmerID --->        
        <cfquery name="qNextID" datasource="ncc-web" dbtype="oledb">
            SELECT MAX(FarmerID) + 1 'Next_FarmerID'
            FROM bfc_Farmer
        </cfquery>

        <cfif qNextID.Next_FarmerID neq "">
            <cfset nextFarmerID = #qNextID.Next_FarmerID#>
        <cfelse>
            <cfset nextFarmerID = 1>
        </cfif>        
        
        <cfquery name="qInsert" datasource="ncc-web" result="newRecord">
            SET QUOTED_IDENTIFIER ON
            INSERT INTO bfc_Farmer (FarmerID, FirstName, LastName, EmailAddress, PhoneNumber)
            VALUES (
            <cfqueryparam value="#nextFarmerID#" cfsqltype="CF_SQL_NUMERIC" />,
            <cfqueryparam value="#arguments.bean.getFirstName()#" cfsqltype="CF_SQL_VARCHAR" />,
            <cfqueryparam value="#arguments.bean.getLastName()#" cfsqltype="CF_SQL_VARCHAR" />,            
            <cfqueryparam value="#arguments.bean.getEmailAddress()#" cfsqltype="CF_SQL_VARCHAR" />,            
            <cfqueryparam value="#arguments.bean.getPhoneNumber()#" cfsqltype="CF_SQL_VARCHAR" />)
            SET QUOTED_IDENTIFIER OFF
        </cfquery>
            
        <cfreturn getRecordByFarmerID(nextFarmerID) />
    </cffunction>

    <!---  READ Farmer Record --->
    <cffunction name="getRecordByFarmerID" access="public" output="false" hint="Returns a record from the database by farmerID">
        <cfargument name="farmerID" required="true" type="numeric" hint="Farmer ID" />
        <cfquery name="qResult" datasource="ncc-web">
            SET QUOTED_IDENTIFIER ON
            SELECT FarmerID, FirstName, LastName, EmailAddress, PhoneNumber
            FROM bfc_Farmer
            WHERE FarmerID = <cfqueryparam value="#arguments.farmerID#" cfsqltype="CF_SQL_NUMERIC" />
            SET QUOTED_IDENTIFIER OFF            
        </cfquery>
        <!---<cfqueryparam value="#arguments.farmerID#" cfsqltype="CF_SQL_NUMERIC" />--->
        <cfif qResult.RecordCount>
            <cfset objFarmerBean = createObject('component', "logic.bean.farmerBean").init(
                farmerID = #qResult.FarmerID#, 
                firstName = "#qResult.FirstName#", 
                lastName = "#qResult.LastName#", 
                emailAddress = "#qResult.EmailAddress#", 
                phoneNumber = "#qResult.PhoneNumber#") />  
        </cfif>
        <cfreturn objFarmerBean />
    </cffunction>

    <!---  UPDATE Farmer Record --->
    <cffunction name="updateFarmerRecord" access="public" output="false" returntype="boolean" hint="Updates an farmer's record">
        <cfargument name="bean" required="true" type="logic.bean.farmerBean" hint="farmerBean" />
        <cfset var boolSuccess = true />
        <cftry>
            <cfquery name="qUpdate" datasource="ncc-web">
                UPDATE bfc_Farmer
                set FirstName = <cfqueryparam value="#arguments.bean.getFirstName()#" cfsqltype="CF_SQL_VARCHAR" />,
                    LastName = <cfqueryparam value="#arguments.bean.getLastName()#" cfsqltype="CF_SQL_VARCHAR" />,            
                    EmailAddress = <cfqueryparam value="#arguments.bean.getEmailAddress()#" cfsqltype="CF_SQL_VARCHAR" />,            
                    PhoneNumber = <cfqueryparam value="#arguments.bean.getPhoneNumber()#" cfsqltype="CF_SQL_VARCHAR" />
                WHERE FarmerID = <cfqueryparam value="#arguments.bean.getFarmerID()#" cfsqltype="CF_SQL_NUMERIC" />
            </cfquery>
        <cfcatch type="Database">
            <cfset boolSucess = false />    
        </cfcatch>
        </cftry>
        <cfreturn boolSuccess />
    </cffunction>


    <!---  DELETE Farmer Record --->
    <cffunction name="deleteFarmerRecordByFarmerID" access="public" output="false" returntype="boolean" hint="Deletes a farmer's record">
        <cfargument name="farmerID" required="true" type="numeric" hint="Farmer ID" />
        <cfset var boolSuccess = true />
        <!--- Delete the Farmer --->
        <cftry>
            <cfquery name="qDeleteFarmer" datasource="ncc-web">
                DELETE FROM bfc_Farmer
                WHERE FarmerID = <cfqueryparam value="#arguments.farmerID#" cfsqltype="CF_SQL_NUMERIC" />
            </cfquery>
        <cfcatch type="Database">
            <cfset boolSucess = false />    
        </cfcatch>
        </cftry>

        <!--- Delete the Farmer-Address map --->
        <cftry>
            <cfquery name="qDeleteMap" datasource="ncc-web">
                DELETE FROM bfc_Farmer_Address_Map
                WHERE FarmerID = <cfqueryparam value="#arguments.farmerID#" cfsqltype="CF_SQL_NUMERIC" />
            </cfquery>
        <cfcatch type="Database">
            <cfset boolSucess = false />    
        </cfcatch>
        </cftry>      

        <cfreturn boolSuccess />        
    </cffunction>

    <!---  READ Farmer and Address info based on the farmerID, populate an addressBean and return it --->
    <cffunction name="getFarmerAndAddressByFarmerID" access="public" output="false" hint="Returns an populated address bean">
        <cfargument name="farmerID" required="true" type="numeric" hint="Farmer ID" />
        <cfquery name="qResult" datasource="ncc-web">
            SELECT f.FarmerID, RTRIM(f.FirstName) 'FirstName', RTRIM(f.LastName) 'LastName', RTRIM(f.EmailAddress) 'EmailAddress', RTRIM(f.PhoneNumber) 'PhoneNumber',
                    a.AddrID, RTRIM(a.AddressLine1) 'AddressLine1', RTRIM(a.City) 'City', RTRIM(a.State) 'State', RTRIM(a.Zip) 'Zip'
            FROM bfc_Farmer f, bfc_Address a, bfc_Farmer_Address_Map m
            WHERE f.FarmerID = m.FarmerID
            AND a.AddrID = m.AddrID
            AND m.FarmerID = <cfqueryparam value="#arguments.farmerID#" cfsqltype="CF_SQL_NUMERIC" />
        </cfquery>

        <!--- Instantiate an addressBean and populate it --->
        <cfset objAddressBean = createObject("component", "logic.dao.addressDAO").getRecordByAddrID(#qResult.AddrID#) />
        <cfset objAddressBean.setFarmerID(#qResult.FarmerID#) />
        <cfset objAddressBean.setFirstName(#qResult.FirstName#) />        
        <cfset objAddressBean.setLastName(#qResult.LastName#) />
        <cfset objAddressBean.setEmailAddress(#qResult.EmailAddress#) />
        <cfset objAddressBean.setPhoneNumber(#qResult.PhoneNumber#) />

        <cfreturn objAddressBean />
    </cffunction>    
</cfcomponent>