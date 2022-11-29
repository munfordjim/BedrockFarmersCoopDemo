component displayname="utilsManager- service for utilities class." output="false" hint="utilsManager manager class"
{
    variables.instance = { addressUtils = "", generalUtils = "" };
    variables.instance.addressUtils = createObject('component', 'logic.utils.addressUtils');
    variables.instance.generalUtils = createObject('component', 'logic.utils.generalUtils');

    // Address Utilities Functions
    // READ US States --->
    public any function readUSStates()
    {
        return variables.instance.addressUtils.getUSStates();
    }

    // General Utilities
    // canonicalize the form inputs 
    public any function decodeScope( required struct scope )
    {
        return variables.instance.generalUtils.decodeScope(arguments.scope);
    }

    // validate the form inputs 
    public any function validateInput( required string emailAddress, required string phoneNumber, required string state, required string zip )
    {
        return variables.instance.generalUtils.validateInput(arguments.emailAddress, arguments.phoneNumber, arguments.state, arguments.zip);
    }

    //  format phone
    public any function formatPhone( required string phoneNumber )
    {
        return variables.instance.generalUtils.formatPhone(arguments.phoneNumber);
    }

}
