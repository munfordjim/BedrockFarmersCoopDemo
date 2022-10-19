<cfcomponent rest="true" restpath="APIroutes">
	<!---
		The controller.cfc is the REST API, as it is marked as rest=”true”, 
		and it’s alias is APIroutes. So the REST API path will 
		be http://{server_name}/rest/controller/APIroutes/  

		This component also imports user.cfc, which contain methods for accessing 
		the user related data.		
	--->
	<cfobject name="objUser" component="cfc.user">

	<!---
		"The authenticate method is used to validate the JWT token and it is called in 
		all secured APIs, where user must be logged in to access any server resources. 
		This method looks for the authorization key within the http headers parameter 
		to validate its validity."
	--->
	<!--- Function to validate token--->
	<cffunction name="authenticate" returntype="any">

	<cfset var response = {}>
	<cfset requestData = GetHttpRequestData()>
	<cfif StructKeyExists( requestData.Headers, "authorization" )>
		<cfset token = GetHttpRequestData().Headers.authorization>
		<cftry>
		<cfset jwt = new cfc.jwt(Application.jwtkey)>
		<cfset result = jwt.decode(token)>
		<cfset response["success"] = true>
		<cfcatch type="Any">
			<cfset response["success"] = false>
			<cfset response["message"] = cfcatch.message>
			<cfreturn response>
		</cfcatch>
		</cftry>
	<cfelse>
		<cfset response["success"] = false>
		<cfset response["message"] = "Authorization token invalid or not present.">
	</cfif>
	<cfreturn response>

	</cffunction>

	<!---
		"The login method is a non secure API, which facilitates user to login into their 
		account with their login credentials using POST verb."	
	--->
	<!--- User Login--->
	<cffunction name="login" restpath="login" access="remote" returntype="struct" httpmethod="POST" produces="application/json">

	<cfargument name="structform" type="any" required="yes">

	<cfset var response = {}>
	<cfset response = objUser.loginUser(structform)>
	<cfreturn response>

	</cffunction>

	<!---
		"The getuser method is a secure API, which fetches the details of the 
		user, whose id is passed within the API path using GET verb."
	--->
	<!--- User specific functions --->
	<cffunction name="getuser" restpath="user/{id}" access="remote" returntype="struct" httpmethod="GET" produces="application/json">

	<cfargument name="id" type="any" required="yes" restargsource="path"/>
	<cfset var response = {}>

	<cfset verify = authenticate()>
	<cfif not verify.success>
		<cfset response["success"] = false>
		<cfset response["message"] = verify.message>
		<cfset response["errcode"] = 'no-token'>
	<cfelse>
		<cfset response = objUser.userDetails(arguments.id)>
	</cfif>

	<cfreturn response>
	</cffunction>

	<!---
		JIM TEST
		The reports method is used to pull either all (report/all) or a filtered 
		list (report/"lastname") of farmers in the Bedrock Farmers Coop Demo
		application.  Requires a valid jwt token received after the login process.
	--->
	<!--- Report specific functions --->
	<cffunction name="reports" restpath="report/{type}" access="remote" returntype="query" httpmethod="GET" produces="application/json">
		<cfargument name="type" type="any" required="yes" restargsource="path"/>
		<cfset var response = {}>

		<cfset verify = authenticate()>
		<cfif not verify.success>
			<cfset response["success"] = false>
			<cfset response["message"] = verify.message>
			<cfset response["errcode"] = 'no-token'>
		<cfelse>
			<cfif arguments.type eq "all">
				<!---  Get ALL Farmer Records --->
				<cfquery name="qAllFarmers" datasource="ncc-web" result="newRecord">
					SELECT RTRIM(FirstName) 'FirstName', RTRIM(LastName) 'LastName', RTRIM(EmailAddress) 'EmailAddress', RTRIM(PhoneNumber) 'PhoneNumber'
					FROM bfc_Farmer
					ORDER BY LastName, FirstName
				</cfquery>
			<cfelseif arguments.type neq "all">
				<cfquery name="qAllFarmers" datasource="ncc-web" result="newRecord">
					SELECT RTRIM(FirstName) 'FirstName', RTRIM(LastName) 'LastName', RTRIM(EmailAddress) 'EmailAddress', RTRIM(PhoneNumber) 'PhoneNumber'
					FROM bfc_Farmer
					WHERE LastName like <cfqueryparam value="%#arguments.type#%" cfsqltype="CF_SQL_VARCHAR" />
				</cfquery>			
			</cfif>
			<!---<cfset response["message"] = "authenticated to call reports of type: #arguments.type#">--->
		</cfif>		
		<cfreturn qAllFarmers>
	</cffunction>

</cfcomponent>