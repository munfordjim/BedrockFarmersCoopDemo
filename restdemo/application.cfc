<cfcomponent output="false">
    <cfset this.name="cfrestdemo">
    <cfset this.restsettings.cfclocation = "./">
    <cfset this.restsettings.skipcfcwitherror = true>

    <!--- 
        "The onApplicationStart method declares one application variable jwtkey at line 9 and 
        restInitApplication method on line 10, this helps us to register/re-register our REST 
        service. We can also specify an alternate string, which can be used for application 
        name while calling the REST service. So, here I have given it a name as controller."
    --->
    <cffunction name="onApplicationStart" returnType="boolean">
        <cfset Application.jwtkey = "My$secretKey">
        <cfset restInitApplication(getDirectoryFromPath(getCurrentTemplatePath()) & 'restapi', 'controller')>
        <cfreturn true>
    </cffunction>

    <cffunction name="onApplicationEnd" returnType="void">
        <cfargument name="ApplicationScope" required=true/>
    </cffunction>
    
    <!---
        "The onRequestStart method does nothing unless it encounters URL variable reload with the 
        value of “r3l0ad”. This triggers onApplicationStart method, which register/re-register our 
        REST service and displays an alertbox with a message, “Application was refreshed”".    
    --->
    <cffunction name="onRequestStart" returntype="void" output="true">
        <cfif isdefined("URL.reload") AND URL.reload EQ "r3l0ad">
            <cflock timeout="10" throwontimeout="No" type="Exclusive" scope="Application">
                <cfset onApplicationStart()>
            </cflock>
            <cfhtmlhead text="<script language='Javascript'>alert('Application was refreshed.');</script>">
        </cfif>
    </cffunction>

	<cffunction name="onRequestEnd" returntype="void" output="yes">
   	</cffunction>    

    <cffunction name="onSessionStart" returntype="void">
    </cffunction>

    <cffunction name="onSessionEnd" returntype="void">
    	<cfargument name="theSession" type="struct" required="yes">
        <cfargument name="theApplication" required="no">
    </cffunction>

	<cffunction name="onMissingTemplate" returntype="boolean" output="no">
    	<cfargument name="targetpage" type="string" required="yes">
    </cffunction>    
</cfcomponent>