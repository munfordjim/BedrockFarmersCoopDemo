component accessors="true" displayname="addressBean" output="false" hint="the bean addressBean" extends="farmerBean"
{
	property name="addrID" type="numeric" default="0" ;
    property name="addressLine1" type="string" default="" ;
    property name="city" type="string" default="";
    property name="state" type="string" default="";
    property name="zip" type="string" default="";

    // Pseudo-Constructor
    variables.instance = { addrID=0, addressLine1='', city='', state='', zip='' };

    public any function init (required numeric addrID=0, required string addressLine1="", required string city="", required string state="", required string zip="" )
    {
        setAddrID(arguments.addrID);          
        setAddressLine1(arguments.addressLine1);
        setCity(arguments.city);           
        setState(arguments.state);
        setZip(arguments.zip);

        Super.init();

        return this;
    }

    public string function getFullAddress()
    {
        full_address = "";
        full_address = full_address & this.getAddressLine1() & '<BR>' & this.getCity() & ', ' & this.getState() & ' ' & this.getZip();
        return full_address;
    }

    // Used for troubleshooting purposes 
    public any function getMemento()
    {
        return variables.instance;
    }
          
}