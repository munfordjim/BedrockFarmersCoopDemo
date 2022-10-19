<cfcomponent displayname="farmerBean" output="false" hint="the bean farmerBean">
	<cfproperty name="farmerID" type="numeric" default=0 />
    <cfproperty name="firstName" type="string" default="" />
    <cfproperty name="lastName" type="string" default="" />
    <cfproperty name="emailAddress" type="string" default="" />
    <cfproperty name="phoneNumber" type="string" default="" />

    <!--- Pseudo-Constructor  --->
    <cfset variables.instance = { farmerID=0, firstName='', lastName='', emailAddress='', phoneNumber='' } />    
       
    <cffunction name="init" access="public" output="false" returntype="any" hint="constructor method for the object">
        <cfargument name="farmerID" required="true" type="numeric" default=0 />
        <cfargument name="firstName" required="true" type="string" default='' />
        <cfargument name="lastName" required="true" type="string" default='' />        
        <cfargument name="emailAddress" required="true" type="string" default='' />
        <cfargument name="phoneNumber" required="true" type="string" default='' />
        
        <cfset setFarmerID(arguments.farmerID)/>            
        <cfset setFirstName(arguments.firstName)/>            
        <cfset setLastName(arguments.lastName)/>            
        <cfset setEmailAddress(arguments.emailAddress)/>            
        <cfset setPhoneNumber(arguments.phoneNumber)/>        
        
        <cfreturn this />
    </cffunction>

    <!---Get the FULL Farmer Name concatenated together --->
    <cffunction name="getFullFarmerName" access="public" output="false" returntype="string">
        <cfset full_farmer_name = "" />
        <cfset full_farmer_name = full_farmer_name & this.getFirstName() & '<BR>' & this.getLastName()/>
        <cfreturn full_farmer_name />
    </cffunction>

    <!---  Setters --->
    <cffunction name="setFarmerID" access="public" output="false" hint="sets the farmerID var in variables.instance">
        <cfargument name="farmerID" type="numeric" required="true" />
        <cfset variables.instance.farmerID = arguments.farmerID />
    </cffunction>    
    
    <cffunction name="setFirstName" access="public" output="false" hint="sets the firstName var in variables.instance">
        <cfargument name="firstName" type="string" required="true" />
        <cfset variables.instance.firstName = arguments.firstName />
    </cffunction>    
    
    <cffunction name="setLastName" access="public" output="false" hint="sets the city var in variables.instance">
        <cfargument name="lastName" type="string" required="true" />
        <cfset variables.instance.lastName = arguments.lastName />
    </cffunction>        

    <cffunction name="setEmailAddress" access="public" output="false" hint="sets the state var in variables.instance">
        <cfargument name="emailAddress" type="string" required="true" />
        <cfset variables.instance.emailAddress = arguments.emailAddress />
    </cffunction>        

    <cffunction name="setPhoneNumber" access="public" output="false" hint="sets the zip var in variables.instance">
        <cfargument name="phoneNumber" type="string" required="true" />
        <cfset variables.instance.phoneNumber = arguments.phoneNumber />
    </cffunction>      

    <!--- Getters --->
    <cffunction name="getFarmerID" access="public" output="false" hint="returns the farmerID">
        <cfreturn variables.instance.farmerID />
    </cffunction>
    
    <cffunction name="getFirstName" access="public" output="false" hint="returns the firstName">
        <cfreturn variables.instance.firstName />
    </cffunction>
    
    <cffunction name="getLastName" access="public" output="false" hint="returns the lastName">
        <cfreturn variables.instance.lastName />
    </cffunction>    

    <cffunction name="getEmailAddress" access="public" output="false" hint="returns the emailAddress">
        <cfreturn variables.instance.emailAddress />
    </cffunction>    
    
    <cffunction name="getPhoneNumber" access="public" output="false" hint="returns the phoneNumber">
        <cfreturn variables.instance.phoneNumber />
    </cffunction>    
    
    
    <!--- Used for troubleshooting purposes --->
    <cffunction name="getMemento" access="public" output="false" hint="returns the variables.instance">
        <cfreturn variables.instance />
    </cffunction>                       
</cfcomponent>