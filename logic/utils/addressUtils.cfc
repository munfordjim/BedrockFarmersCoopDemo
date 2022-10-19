<cfcomponent displayname="utils - used for utilities methods, queries." output="true" hint="Utilities" >

	<cffunction name="getUSStates" access="public" output="false" returntype="query" hint="Returns All US States" >
		<CFQUERY name="qGetStates" datasource="NCC-WEB" dbtype="oledb">
			SELECT RTRIM(StAB) as StAB, RTRIM(StateName) as StateName
			FROM US_States 
			ORDER BY StateName
		</cfquery>
		<cfreturn qGetStates>
	</cffunction>
        
</cfcomponent>
