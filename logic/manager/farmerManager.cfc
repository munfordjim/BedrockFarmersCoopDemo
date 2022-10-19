<cfcomponent displayname="farmerManager - service for farmers." output="false" hint="farmerManager manager class">
    <cfset variables.instance = { farmerDAO = "", farmerGateway = "" } />
    
    <cfset variables.instance.farmerDAO = createObject('component', 'logic.DAO.farmerDAO') />
    
    <cfset variables.instance.farmerGateway = createObject('component', 'logic.Gateway.farmerGateway') />
    
    <!---  CRUD functions --->
    <!--- CREATE --->
    <cffunction name="create" output="false" hint="creates a new address record">
        <cfargument name="objFarmerBean" required="true" type="logic.bean.farmerBean" hint="farmerBean bean" />
        <cfreturn variables.instance.farmerDAO.createNewFarmerRecord(arguments.objFarmerBean) />    
    </cffunction>
    
    <!--- READ  --->
    <cffunction name="read" output="false" hint="returns an addressBean">
        <cfargument name="farmerID" required="true" type="numeric" hint="farmer id used to pull farmer record" />
        <cfreturn variables.instance.farmerDAO.getRecordByFarmerID(arguments.farmerID) />
    </cffunction>    
    
    <!--- UPDATE --->
    <cffunction name="update" output="false" hint="updates an farmer record by farmerID">
        <cfargument name="objFarmerBean" required="true" type="logic.bean.farmerBean" hint="farmerBean bean with info to use for updates." />
        <cfreturn variables.instance.farmerDAO.updateFarmerRecord(arguments.objFarmerBean) />
    </cffunction>        
    
    <!--- DELETE --->
    <cffunction name="delete" output="false" hint="deletes an farmer record by farmerID">
        <cfargument name="farmerID" required="true" type="numeric" hint="farmer id used to delete an farmer record" />
        <cfreturn variables.instance.farmerDAO.deleteFarmerRecordByFarmerID(arguments.FarmerID) />    
    </cffunction>     
    
    <!--- READ Farmer AND Address by FarmerID --->
    <cffunction name="readFarmerAndAddress" output="false" hint="reads a farmer AND address record by farmerID">
        <cfargument name="farmerID" required="true" type="numeric" hint="farmer id used to delete an farmer record" />
        <cfreturn variables.instance.farmerDAO.getFarmerAndAddressByFarmerID(arguments.FarmerID) />    
    </cffunction>         
    
    <!--- GATEWAY functions --->
    <!---  Get All Farmers --->
    <cffunction name="getAllFarmers" output="false" hint="gets all farmer records in db.">
        <cfreturn variables.instance.farmerGateway.getAllFarmerRecords() />    
    </cffunction>

    <!---  Get All Farmers by Last Name--->
    <cffunction name="getAllFarmersByLastName" output="false" hint="gets all farmer records in db with a last name like what is passed in.">
        <cfargument name="lastName" required="true" type="string" hint="string used to retrieve farmers like last name passed in" />
        <cfreturn variables.instance.farmerGateway.getAllFarmerRecordsByLastName(arguments.lastName) />    
    </cffunction>
</cfcomponent>