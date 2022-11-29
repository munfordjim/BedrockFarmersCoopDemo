component accessors="true" displayname="farmerBean" output="false" hint="the bean farmerBean"
{
	property name="farmerID" type="numeric" default=0;
    property name="firstName" type="string" default="";
    property name="lastName" type="string" default="";
    property name="emailAddress" type="string" default="";
    property name="phoneNumber" type="string" default="";

    // Pseudo-Constructor 
    variables.instance = { farmerID=0, firstName='', lastName='', emailAddress='', phoneNumber='' };

    public any function init(required numeric farmerID=0, required string firstName="", required string lastName="", required string emailAddress="", required string phoneNumber="")
    {
        setFarmerID(arguments.farmerID);           
        setFirstName(arguments.firstName);
        setLastName(arguments.lastName);     
        setEmailAddress(arguments.emailAddress);
        setPhoneNumber(arguments.phoneNumber);
        
        return this;
    }

    // Get the FULL Farmer Name concatenated together 
    public string function getFullFarmerName()
    {
        full_farmer_name = "";
        full_farmer_name = full_farmer_name & this.getFirstName() & '<BR>' & this.getLastName();
        return full_farmer_name;
    }

    // Used for troubleshooting purposes
    public any function getMemento()
    {
        return variables.instance;
    }
}