component displayname="addressManager - service for addresses." output="false" hint="addressManager manager class"
{
    variables.instance = { addressDAO = "", addressGateway = "" };
    variables.instance.addressDAO = createObject('component', 'logic.DAO.addressDAO');
    variables.instance.addressGateway = createObject('component', 'logic.Gateway.addressGateway');

    // CRUD functions 
    // CREATE
    public any function create ( required logic.bean.addressBean objAddressBean)
    {
        return variables.instance.addressDAO.createNewAddressRecord(arguments.objAddressBean);
    }

    // READ
    public any function read ( required numeric addrID )
    {
        return variables.instance.addressDAO.getRecordByAddrID(arguments.addrID);
    }    

    // UPDATE
    public any function update ( required bean.addressBean objAddressBean )
    {
        return variables.instance.addressDAO.updateAddressRecord(arguments.objAddressBean);
    }

    // DELETE
    public any function delete ( required numeric addrID )
    {
        return variables.instance.addressDAO.deleteAddressRecordByAddrID(arguments.addrID);
    }

    // Gateway functions
    public any function getAllAddresses()
    {
        return variables.instance.addressGateway.getAllAddressRecords();
    }

    public any function getAllAddressesByCity( required string city)
    {
        return variables.instance.addressGateway.getAllAddressRecordsByCity(arguments.city);
    }

}