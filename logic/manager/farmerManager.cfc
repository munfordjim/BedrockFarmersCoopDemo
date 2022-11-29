component displayname="farmerManager - service for farmers." output="false" hint="farmerManager manager class"
{
    variables.instance = { farmerDAO = "", farmerGateway = "" };
    variables.instance.farmerDAO = createObject('component', 'logic.DAO.farmerDAO');
    variables.instance.farmerGateway = createObject('component', 'logic.Gateway.farmerGateway');

    // CRUD Functions
    // CREATE
    public any function create( required logic.bean.farmerBean objFarmerBean )
    {
        return variables.instance.farmerDAO.createNewFarmerRecord(arguments.objFarmerBean);
    }

    // READ
    public any function read( required numeric farmerID )
    {
        return variables.instance.farmerDAO.getRecordByFarmerID(arguments.farmerID);
    }

    // UPDATE
    public any function update( required logic.bean.farmerBean objFarmerBean )
    {
        return variables.instance.farmerDAO.updateFarmerRecord(arguments.objFarmerBean);
    }    

    // DELETE
    public any function delete( required numeric farmerID )
    {
        return variables.instance.farmerDAO.deleteFarmerRecordByFarmerID(arguments.FarmerID);
    }        

    // READ Farmer AND Address by FarmerID
    public any function readFarmerAndAddress( required numeric farmerID )
    {
        return variables.instance.farmerDAO.getFarmerAndAddressByFarmerID(arguments.FarmerID);
    }

    // GATEWAY functions 
    // Get All Farmers 
    public any function getAllFarmers()
    {
        return variables.instance.farmerGateway.getAllFarmerRecords();
    }

    //  Get All Farmers by Last Name
    public any function getAllFarmersByLastName( required string lastName )
    {
        return variables.instance.farmerGateway.getAllFarmerRecordsByLastName(arguments.lastName);
    }
}