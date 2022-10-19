<cfcomponent hint="User specific functions" displayname="user">
	<!---
		"The user.cfc is a simple coldfusion component which can access 
		server resources like database.	""
	--->

	<!---
		"The loginUser method validates the user credentials against the database 
		and generates JWT token, which is returned back to the client. The client 
		stores this JWT token locally (in a cookie or local storage), and sends the 
		same as a authorization header parameter with any secure API call."	
	--->
	<!--- User Login --->
	<cffunction name="loginUser" access="public" output="false" hint="Login User" returntype="struct">

	<cfargument name="structform" required="true" type="any" />

	<cfset var resObj = {}>

	<!--- <cfquery> to check user credentials --->

	<cfif 1 eq 1> <!--- if user credentials are valid --->
		<cfset expdt =  dateAdd("n",30,now())>
		<cfset utcDate = dateDiff('s', dateConvert('utc2Local', createDateTime(1970, 1, 1, 0, 0, 0)), expdt) />

		<cfset jwt = new jwt(Application.jwtkey)>
		<cfset payload = {"iss" = "restdemo", "exp" = utcDate, "sub": "JWT Token"}>
		<cfset token = jwt.encode(payload)>

		<cfset resObj["success"] = true>
		<cfset resObj["message"] = "Login Successful">
		<cfset resObj["token"] = token>
	<cfelse> <!--- if user credentials are invalid --->
		<cfset resObj["success"] = false>
		<cfset resObj["message"] = "Incorrect login credentials.">
	</cfif>

	<cfreturn resObj>

	</cffunction>

	<!---
		"The userDetails method returns the user details of any user 
		whose id is passed as an argument."	
	--->
	<!--- User Details --->
	<cffunction name="userDetails" access="public" output="false" hint="Get user details" returntype="struct">

	<cfargument name="userid" required="true" type="numeric" />
	<cfset var resObj = {}>
	<cfset returnArray = ArrayNew(1) />

	<!--- <cfquery> to get user details --->

	<cfif 1 neq 1> <!--- if user not found --->
		<cfset resObj["success"] = false>
		<cfset resObj["message"] = "Incorrect user id provided.">
	<cfelse> <!--- if user found --->
		<cfset userStruct = StructNew() />          
		<cfset userStruct["firstname"] = "John" />
		<cfset userStruct["lastname"] = "Doe" />
		<cfset userStruct["email"] = "johndoe@fakemail.com" />
		<cfset ArrayAppend(returnArray,userStruct) />

		<cfset resObj["success"] = true>
		<cfset resObj["data"] = SerializeJSON(returnArray)>

	</cfif>

	<cfreturn resObj>
	</cffunction>

</cfcomponent>