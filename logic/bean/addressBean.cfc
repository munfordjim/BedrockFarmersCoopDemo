<cfcomponent displayname="addressBean" output="false" hint="the bean addressBean" extends="farmerBean">
	<cfproperty name="addrID" type="numeric" />
    <cfproperty name="addressLine1" type="string" />
    <cfproperty name="city" type="string" default="" />
    <cfproperty name="state" type="string" default="" />
    <cfproperty name="zip" type="string" default="" />

    <!--- Pseudo-Constructor  --->
    <cfset variables.instance = { addrID=0, addressLine1='', city='', state='', zip='' } />    
       
    <cffunction name="init" access="public" output="false" returntype="any" hint="constructor method for the object">
        <cfargument name="addrID" required="true" type="numeric" default=0 />
        <cfargument name="addressLine1" required="true" type="string" default='' />
        <cfargument name="city" required="true" type="string" default='' />        
        <cfargument name="state" required="true" type="string" default='' />
        <cfargument name="zip" required="true" type="string" default='' />
        
        <cfset setAddrID(arguments.addrID)/>            
        <cfset setAddressLine1(arguments.addressLine1)/>            
        <cfset setCity(arguments.city)/>            
        <cfset setState(arguments.state)/>            
        <cfset setZip(arguments.zip)/>        
        
        <!--- Instantiate the farmerBean --->
        <cfset Super.init() />

        <cfreturn this />
    </cffunction>

    <!---Get the FULL Address concatenated together --->
    <cffunction name="getFullAddress" access="public" output="false" returntype="string">
        <cfset full_address = "" />
        <cfset full_address = full_address & this.getAddressLine1() & '<BR>' & this.getCity() & ', ' & this.getState() & ' ' & this.getZip() />
        <cfreturn full_address />
    </cffunction>
    
    
    <!---  Setters --->
    <cffunction name="setAddrID" access="public" output="false" hint="sets the addrID var in variables.instance">
        <cfargument name="addrID" type="numeric" required="true" />
        <cfset variables.instance.addrID = arguments.addrID />
    </cffunction>    
    
    <cffunction name="setAddressLine1" access="public" output="false" hint="sets the addressLine1 var in variables.instance">
        <cfargument name="addressLine1" type="string" required="true" />
        <cfset variables.instance.addressLine1 = arguments.addressLine1 />
    </cffunction>    
    
    <cffunction name="setCity" access="public" output="false" hint="sets the city var in variables.instance">
        <cfargument name="city" type="string" required="true" />
        <cfset variables.instance.city = arguments.city />
    </cffunction>        

    <cffunction name="setState" access="public" output="false" hint="sets the state var in variables.instance">
        <cfargument name="state" type="string" required="true" />
        <cfset variables.instance.state = arguments.state />
    </cffunction>        

    <cffunction name="setZip" access="public" output="false" hint="sets the zip var in variables.instance">
        <cfargument name="zip" type="string" required="true" />
        <cfset variables.instance.zip = arguments.zip />
    </cffunction>                 
    
    
    <!--- Getters --->
    <cffunction name="getAddrID" access="public" output="false" hint="returns the addrID">
        <cfreturn variables.instance.addrID />
    </cffunction>
    
    <cffunction name="getAddressLine1" access="public" output="false" hint="returns the addressLine1">
        <cfreturn variables.instance.addressLine1 />
    </cffunction>
    
    <cffunction name="getCity" access="public" output="false" hint="returns the city">
        <cfreturn variables.instance.city />
    </cffunction>    

    <cffunction name="getState" access="public" output="false" hint="returns the state">
        <cfreturn variables.instance.state />
    </cffunction>    
    
    <cffunction name="getZip" access="public" output="false" hint="returns the zip">
        <cfreturn variables.instance.zip />
    </cffunction>    
    
    
    <!--- Used for troubleshooting purposes --->
    <cffunction name="getMemento" access="public" output="false" hint="returns the variables.instance">
        <cfreturn variables.instance />
    </cffunction>    
    
</cfcomponent>