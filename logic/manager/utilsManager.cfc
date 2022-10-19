<cfcomponent displayname="utilsManager- service for utilities class." output="false" hint="utilsManager manager class">
    <cfset variables.instance = { addressUtils = "", generalUtils = "" } />

    <cfset variables.instance.addressUtils = createObject('component', 'logic.utils.addressUtils') />
    <cfset variables.instance.generalUtils = createObject('component', 'logic.utils.generalUtils') />    
    
    <!---  Address Utilities Functions --->
    <!--- READ US States --->
    <cffunction name="readUSStates" output="false" hint="reads all US States">
        <cfreturn variables.instance.addressUtils.getUSStates() />    
    </cffunction>

    <!--- General Utilities --->
    <!--- canonicalize the form inputs --->
    <cffunction name="decodeScope" output="false" hint="canonicalize form inputs">
        <cfargument name="scope" required="true" type="struct" hint="scope - form, url, - with info to use for canonicalizing." />
        <cfreturn variables.instance.generalUtils.decodeScope(arguments.scope) />    
    </cffunction>    

    <!--- validate the form inputs --->
    <cffunction name="validateInput" output="false" hint="validates form inputs">
        <cfargument name="emailAddress" type="string" required="true" hint="email address field">        
        <cfargument name="phoneNumber" type="string" required="true" hint="phone number field">        
        <cfargument name="state" type="string" required="true" hint="state field">                
        <cfargument name="zip" type="string" required="true" hint="zip field">        

        <cfreturn variables.instance.generalUtils.validateInput(arguments.emailAddress, arguments.phoneNumber, arguments.state, arguments.zip) />    
    </cffunction>        
</cfcomponent>