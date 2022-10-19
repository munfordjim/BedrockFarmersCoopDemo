<cfcomponent displayname="farmerGateway - used for multiple records." output="false" hint="farmerGateway Gateway class">

    <!---  Get ALL Farmer Records --->
    <cffunction name="getAllFarmerRecords" access="public" output="false" hint="Returns All Farmer Records">
        <cfquery name="qAllRecords" datasource="ncc-web" result="newRecord">
            SELECT RTRIM(f.FirstName) 'FirstName', RTRIM(f.LastName) 'LastName', RTRIM(f.EmailAddress) 'EmailAddress', RTRIM(f.PhoneNumber) 'PhoneNumber',
                    a.AddrID, RTRIM(a.AddressLine1) 'AddressLine1', RTRIM(a.City) 'City', RTRIM(a.State) 'State', RTRIM(a.Zip) 'Zip'
            FROM bfc_Farmer f, bfc_Address a, bfc_Farmer_Address_Map m
            WHERE f.FarmerID = m.FarmerID
            AND a.AddrID = m.AddrID
        </cfquery>
        <cfreturn qAllRecords />
    </cffunction>

    
    <!--- Get All Farmer records where Last Name is like the string passed in --->
    <cffunction name="getAllFarmerRecordsByLastName" access="public" output="false" hint="Returns All Farmer Records that have the Last Name passed in.">
        <cfargument name="lastName" required="true" type="string" hint="Search parameter for returning records based on the Last Name passed in." />
        <cfquery name="qAllRecordsByLastName" datasource="ncc-web" result="newRecord">
            SELECT FarmerID, FirstName, LastName, EmailAddress, PhoneNumber
            FROM bfc_Farmer
            WHERE LastName like <cfqueryparam value="%#arguments.lastName#%" cfsqltype="CF_SQL_VARCHAR" />
        </cfquery>
        <cfreturn qAllRecordsByLastName />
    </cffunction>
</cfcomponent>
