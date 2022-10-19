<cfcomponent displayname="addressManager - service for addresses." output="false" hint="addressManager manager class">
    <cfset variables.instance = { addressDAO = "", addressGateway = "" } />
    
    <cfset variables.instance.addressDAO = createObject('component', 'logic.DAO.addressDAO') />
    
    <cfset variables.instance.addressGateway = createObject('component', 'logic.Gateway.addressGateway') />
    
    <!---  CRUD functions --->
    <!--- CREATE --->
    <cffunction name="create" output="false" hint="creates a new address record">
        <cfargument name="objAddressBean" required="true" type="logic.bean.addressBean" hint="addressBean bean" />
        <cfreturn variables.instance.addressDAO.createNewAddressRecord(arguments.objAddressBean) />    
    </cffunction>
    
    <!--- READ  --->
    <cffunction name="read" output="false" hint="returns an addressBean">
        <cfargument name="addrID" required="true" type="numeric" hint="address id used to pull address record" />
        <cfreturn variables.instance.addressDAO.getRecordByAddrID(arguments.addrID) />
    </cffunction>    
    
    <!--- UPDATE --->
    <cffunction name="update" output="false" hint="updates an address record by addrid">
        <cfargument name="objAddressBean" required="true" type="bean.addressBean" hint="addressBean bean with info to use for updates." />
        <cfreturn variables.instance.addressDAO.updateAddressRecord(arguments.objAddressBean) />
    </cffunction>        
    
    <!--- DELETE --->
    <cffunction name="delete" output="false" hint="deletes an address record by addrid">
        <cfargument name="addrID" required="true" type="numeric" hint="address id used to delete an address record" />
        <cfreturn variables.instance.addressDAO.deleteAddressRecordByAddrID(arguments.addrID) />    
    </cffunction>     
    
    
    <!--- GATEWAY functions --->
    <!---  Get All Addresses --->
    <cffunction name="getAllAddresses" output="false" hint="gets all address recordsin db.">
        <cfreturn variables.instance.addressGateway.getAllAddressRecords() />    
    </cffunction>

    <!---  Get All Addresses by City--->
    <cffunction name="getAllAddressesByCity" output="false" hint="gets all address recordsin db with a city like what is passed in.">
        <cfargument name="city" required="true" type="string" hint="string used to retrieve addresses like city passed in" />
        <cfreturn variables.instance.addressGateway.getAllAddressRecordsByCity(arguments.city) />    
    </cffunction>
</cfcomponent>