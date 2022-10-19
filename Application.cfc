<!---
	Filename:  Aplication.cfc
	Created By:  Jim Thornton
	Creation Date:  10/10/2022
	Purpose:  Sets up the global website variables and the main template of the site.
--->

<cfcomponent output="no">
	<cfset this.name ="BedrockFarmersCoopDemo">
	<cfset this.sessionManagement=true>
    <cfset this.sessiontimeout = "#CreateTimeSpan(0,0,30,0)#">
    <cfset this.ClientManagement="no">
    <cfset this.scriptProtect = "All">
    <cfset this.ApplicationTimeout = "#CreateTimeSpan(1,0,0,0)#">
    
    <cffunction name="onApplicationStart" returntype="boolean">
        <cfreturn true>
    </cffunction>
    
    <cffunction name="onApplicationEnd" returnType="void">
        <cfargument name="ApplicationScope" required=true/>
    </cffunction>
    
	<cffunction name="onRequestStart" returntype="boolean" output="yes">  
        <cfif structKeyExists(url, "restartApp")>
            <cfset onApplicationStart()>
        </cfif>
        <cfreturn true>
	</cffunction>

	<cffunction name="onRequestEnd" returntype="void" output="yes">
		<!--- Add the Google Analytics Script --->
   	</cffunction>
	
    <cffunction name="onSessionStart" returntype="void">
    </cffunction>

    <cffunction name="onSessionEnd" returntype="void">
    	<cfargument name="theSession" type="struct" required="yes">
        <cfargument name="theApplication" required="no">
	</cffunction>

    <!---  ***TURN THIS ON PRIOR TO PRODUCTION *** 

	<cffunction name="onError" returntype="void" output="false">
		<cfargument name="exception" required="yes">
        <cfargument name="eventName" type="string" required="yes">
        
        <cfif arguments.eventName is "">
        	<cfmail from="no-reply@cotton.org" to="munfordjim@gmail.com" subject="Error:  Beltwide website" type="html">
				<cfdump var="#arguments#">
            </cfmail>
        <cfelse>
        	<cfmail from="no-reply@cotton.org" to="munfordjim@gmail.com" subject="Error:  Beltwide website" type="html">
				Error in Method #arguments.eventName# <br />
				<cfdump var="#arguments#">
            </cfmail>
        </cfif>

		Let the <cferror> tags do their job. 
		<cfthrow object="#arguments.exception#">
   	</cffunction>
	--->
    <!---  ***TURN THIS ON PRIOR TO PRODUCTION ***
	<cfoutput>
		<cferror type="request" template="ErrorRequest.cfm" mailto="munfordjim@gmail.com">
		<cferror type="exception" template="ErrorException.cfm" mailto="munfordjim@gmail.com">
	</cfoutput>
	--->
	<cffunction name="onMissingTemplate" returntype="boolean" output="no">
    	<cfargument name="targetpage" type="string" required="yes">
		<cfoutput>
	        <cflocation 
            	url="https://www.cotton.org/jim_dev/test/bedrockfarmerscoopdemo/missingTemplateHandler.cfm?missingtemplate=#EncodeForURL(arguments.targetpage)#" addtoken="no">
    	</cfoutput>
		<cfreturn true>
    </cffunction>

</cfcomponent>