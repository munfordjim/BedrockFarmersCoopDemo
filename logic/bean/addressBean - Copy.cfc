component accessors="true" {
    property name="addressLine1"   type="string";
    property name="city"    type="string";
	property name="state"    type="string";
	property name="zip"    type="string";
	property name="country"    type="string";

    public Address function init( 
		required string addressLine1, 
		required string city,
		required string state,
		required string zip,
		required string country
	){
		/*  the setters save the value for the property in the object's VARIABLES scope */ 
        setAddressLine1( arguments.addressLine1 );
        setCity( arguments.city );
		setState( arguments.state );
		setZip( arguments.zip );
		setCountry( arguments.country );
		
        return this;
    }

    public string function getFullAddress()
	{
		/*  Calls on the getFirstName "getter"s which returns the values found in "firstName" and "lastName", 
			then concatenates them and returns the newly concatenated string. 
		*/
		full_address = "";
		full_address = full_address & this.getAddressLine1() & '<BR>' & this.getCity() & ', ' & this.getState() & ' ' & this.getZip();
        return full_address;
    }

}
