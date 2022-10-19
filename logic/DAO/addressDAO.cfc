<cfcomponent displayname="addressDAO - used for CRUD - single records." output="true" hint="DAO class addressDAO" >
	<cfproperty name="addrID" type="numeric" />
    <cfproperty name="addressLine1" type="string" />
    <cfproperty name="city" type="string" default="" />
    <cfproperty name="state" type="string" default="" />
    <cfproperty name="zip" type="string" default="" />

    <!--- Pseudo-Constructor  --->
    <cfset variables.instance = { addrID=0, addressLine1='', city='', state='', zip='' } />    
    
    <!---  CREATE New Address Record --->
    <cffunction name="createNewAddressRecord" access="public" output="false" hint="creates a new addrID">
        <cfargument name="bean" required="true" type="logic.bean.addressBean" hint="addressBean" />
        <!--- Add the Farmer, first --->
        <!--- Instantiate the farmer manager --->
        <cfset farmerManager = createobject("component","logic.manager.farmerManager")>

        <!--- Instantiate a farmer bean and load it up --->
        <cfset objFarmerBean = createObject("component", "logic.bean.farmerBean").init() />
        <cfset objFarmerBean.setFirstName("#bean.getFirstName()#") />
        <cfset objFarmerBean.setLastName("#bean.getLastName()#") />                        
        <cfset objFarmerBean.setEmailAddress("#bean.getEmailAddress()#") />
        <cfset objFarmerBean.setPhoneNumber("#bean.getPhoneNumber()#") />                        
        
        <!--- Call the create method of the farmer manager, which adds the farmer and returns a farmer bean --->
        <cfset newFarmerBean = 0 />
        <cfset newFarmerBean = farmerManager.create(objFarmerBean) />

        <!--- Now add the address --->
        <cfset nextAddrID = 0 />
        
        <!--- First, get next AddrID --->        
        <cfquery name="qNextID" datasource="ncc-web" dbtype="oledb">
            SELECT MAX(AddrID) + 1 'Next_AddrID'
            FROM bfc_Address
        </cfquery>

        <cfif qNextID.Next_AddrID neq "">
            <cfset nextAddrID = #qNextID.Next_AddrID#>
        <cfelse>
            <cfset nextAddrID = 1>
        </cfif>        
        
        <cfquery name="qInsert" datasource="ncc-web" result="newRecord">
            SET QUOTED_IDENTIFIER ON
            INSERT INTO bfc_Address (AddrID, AddressLine1, City, State, Zip)
            VALUES (
            <cfqueryparam value="#nextAddrID#" cfsqltype="CF_SQL_NUMERIC" />,
            <cfqueryparam value="#arguments.bean.getAddressLine1()#" cfsqltype="CF_SQL_VARCHAR" />,
            <cfqueryparam value="#arguments.bean.getCity()#" cfsqltype="CF_SQL_VARCHAR" />,            
            <cfqueryparam value="#arguments.bean.getState()#" cfsqltype="CF_SQL_VARCHAR" />,            
            <cfqueryparam value="#arguments.bean.getZip()#" cfsqltype="CF_SQL_VARCHAR" />)
            SET QUOTED_IDENTIFIER OFF
        </cfquery>

        <!---  
            Now we need to map the farmer to the address.  Use the farmer ID that came back from the call to the farmerManager create
            method and the addr ID above to map the farmer and the address together.
        --->
        <cfquery name="qAddMapping" datasource="ncc-web" result="newRecord">
            INSERT INTO bfc_Farmer_Address_Map (FarmerID, AddrID)
            VALUES ( #newFarmerBean.getFarmerID()#, #nextAddrID# )
        </cfquery>

        <cfset newAddressBean = "" />
        <cfset newAddressBean = getRecordByAddrID(#nextAddrID#) />
        <cfset newAddressBean.setFarmerID(#newFarmerBean.getFarmerID()#) />
        <cfset newAddressBean.setFirstName(#newFarmerBean.getFirstName()#) />        
        <cfset newAddressBean.setLastName(#newFarmerBean.getLastName()#) />        
        <cfset newAddressBean.setEmailAddress(#newFarmerBean.getEmailAddress()#) />        
        <cfset newAddressBean.setPhoneNumber(#newFarmerBean.getPhoneNumber()#) />

        <cfreturn  newAddressBean />
    </cffunction>

    
    <!---  READ Address Record --->
    <cffunction name="getRecordByAddrID" access="public" output="false" hint="Returns a record from the database by addrID">
        <cfargument name="addrID" required="true" type="numeric" hint="Address ID" />
        <cfquery name="qResult" datasource="ncc-web">
            SET QUOTED_IDENTIFIER ON
            SELECT AddrID, AddressLine1, City, State, Zip
            FROM bfc_Address
            WHERE AddrID = <cfqueryparam value="#arguments.addrID#" cfsqltype="CF_SQL_NUMERIC" />
            SET QUOTED_IDENTIFIER OFF
        </cfquery>
        <cfif qResult.RecordCount>
            <cfset objAddressBean = createObject('component', "logic.bean.addressBean").init(
                addrID = #qResult.AddrID#, 
                addressLine1 = "#qResult.AddressLine1#", 
                city = "#qResult.City#", 
                state = "#qResult.State#", 
                zip = "#qResult.Zip#") />  
        </cfif>
        <cfreturn objAddressBean />
    </cffunction>

    
    <!---  UPDATE Address Record --->
    <cffunction name="updateAddressRecord" access="public" output="false" returntype="boolean" hint="Updates an address record">
        <cfargument name="bean" required="true" type="logic.bean.addressBean" hint="addressBean" />
        <cfset var boolSuccess = true />
        <cftry>
            <cfquery name="qUpdate" datasource="ncc-web">
                UPDATE bfc_Address
                set AddressLine1 = <cfqueryparam value="#arguments.bean.getAddressLine1()#" cfsqltype="CF_SQL_VARCHAR" />,
                    City = <cfqueryparam value="#arguments.bean.getCity()#" cfsqltype="CF_SQL_VARCHAR" />,            
                    State = <cfqueryparam value="#arguments.bean.getState()#" cfsqltype="CF_SQL_VARCHAR" />,            
                    Zip = <cfqueryparam value="#arguments.bean.getZip()#" cfsqltype="CF_SQL_VARCHAR" />
                WHERE AddrID = <cfqueryparam value="#arguments.bean.getAddrID()#" cfsqltype="CF_SQL_NUMERIC" />
            </cfquery>
        <cfcatch type="Database">
            <cfset boolSucess = false />    
        </cfcatch>
        </cftry>
        <cfreturn boolSuccess />
    </cffunction>

    
    <!---  DELETE Address Record --->
    <cffunction name="deleteAddressRecordByAddrID" access="public" output="false" returntype="boolean" hint="Deletes an address record">
        <cfargument name="addrID" required="true" type="numeric" hint="Address ID" />
        <cfset var boolSuccess = true />
        <cftry>
            <cfquery name="qDeleteAddress" datasource="ncc-web">
                DELETE FROM bfc_Address
                WHERE AddrID = <cfqueryparam value="#arguments.addrID#" cfsqltype="CF_SQL_NUMERIC" />
            </cfquery>
        <cfcatch type="Database">
            <cfset boolSucess = false />    
        </cfcatch>
        </cftry>
        <cfreturn boolSuccess />        
    </cffunction>
</cfcomponent>