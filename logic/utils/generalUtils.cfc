<component displayname="general utils - used for utilities methods, queries." output="true" hint="General Utilities" >
	<!---  
		"Borrowed :)" from https://www.learncfinaweek.com/course/index/section/Security/item/Cross-Site_Scripting_(XSS).html 
	--->        
    <cffunction name="decodeScope" output="false" returntype="Any">
        <cfargument name="scope" type="struct" required="true">
        <cfset key = "">
        <cfloop collection="#arguments.scope#" item="key">
            <cfif isSimpleValue(arguments.scope[key])>
                <cftry>
                    <!--- 
                        From CFDocs.org:
                        "Canonicalize or decode the input string. Canonicalization is simply the operation of reducing a possibly
                         encoded string down to its simplest form. This is important because attackers frequently use encoding 
                         to change their input in a way that will bypass validation filters, but still be interpreted properly 
                         by the target of the attack."
                    --->
					<cfset arguments.scope[key] = canonicalize(arguments.scope[key], true, true, true)>
				<cfcatch type="any">
                    <cfset arguments.scope[key] = "ERROR: Invalid input found - canonicalization.">
				</cfcatch>	
                </cftry>
            </cfif>    

            <!--- Check for potential XSS in the inputs that may fall through canonicalization --->      
            <cfset tempFindScript = "">  
            <cfset tempFindScript  = reFindNoCase("/script/i", arguments.scope[key], "1", true, "one")>
            <cfif tempFindScript.LEN[1]>
                <cfset arguments.scope[key] = "ERROR: Invalid input found - script.">
            <cfelse>
                <!--- remove any html tags from form inputs --->
                <!--- are there any html tags?  If so, remove them AND the content they attempt to display. --->
                <cfset tempFindHTML = "">
                <cfset tempFindHTML = reFindNoCase("<[^>]*>", arguments.scope[key], "1", true, "one")>
                <cfif tempFindHTML.LEN[1]>
                    <cfset arguments.scope[key] = "ERROR:  Invalid input found - html.">
                </cfif>
            </cfif>

        </cfloop>

		<cfset arguments.scope />
    </cffunction>

    <cffunction name="validateInput" output="false" returntype="Any">
        <cfargument name="emailAddress" type="string" required="true" hint="email address field">        
        <cfargument name="phoneNumber" type="string" required="true" hint="phone number field">        
        <cfargument name="state" type="string" required="true" hint="state field">                
        <cfargument name="zip" type="string" required="true" hint="zip field">        

        <cfif arguments.emailAddress neq "" and !isValid("email", arguments.emailAddress)>
            <cfreturn "ERROR:  validating emailAddress: #arguments.emailAddress#">
        <cfelseif arguments.phoneNumber neq "" and !isValid("telephone", arguments.phoneNumber)>
            <cfreturn "ERROR:  validating phoneNumber">            
        <cfelseif arguments.zip neq "" and !isValid("zipcode", arguments.zip)>
            <cfreturn "ERROR:  validating zip">                        
        <cfelseif arguments.state neq "" and !isValid("regular_expression",arguments.state, "^(?:(A[KLRZ]|C[AOT]|D[CE]|FL|GA|HI|I[ADLN]|K[SY]|LA|M[ADEINOST]|N[CDEHJMVY]|O[HKR]|P[AR]|RI|S[CD]|T[NX]|UT|V[AIT]|W[AIVY]))$")>
            <cfreturn "ERROR:  validating state: #arguments.state#">                                    
        <cfelse>
            <cfreturn "GOOD DATA">
        </cfif>
    </cffunction>    
</component>