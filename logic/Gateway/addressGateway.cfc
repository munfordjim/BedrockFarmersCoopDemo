<cfcomponent displayname="addressGateway - used for multiple records." output="false" hint="addressGateway Gateway class">

    <!---  Get ALL Address Records --->
    <cffunction name="getAllAddressRecords" access="public" output="false" hint="Returns All Address Records">
        <cfquery name="qAllRecords" datasource="" result="newRecord">
            SELECT AddrID, AddressLine1, City, State, Zip
            FROM
        </cfquery>
        <cfreturn qAllRecords />
    </cffunction>

    
    <!--- Get All Address records where City is like the string passed in --->
    <cffunction name="getAllAddressRecordsByCity" access="public" output="false" hint="Returns All Address Records that have the City passed in.">
        <cfargument name="city" required="true" type="string" hint="Search parameter for returning records based on the city passed in." />
        <cfquery name="qAllRecordsByCity" datasource="" result="newRecord">
            SELECT AddrID, AddressLine1, City, State, Zip
            FROM
            WHERE City like <cfqueryparam value="%#arguments.city#%" cfsqltype="CF_SQL_VARCHAR" />
        </cfquery>
        <cfreturn qAllRecordsByCity />
    </cffunction>
</cfcomponent>
