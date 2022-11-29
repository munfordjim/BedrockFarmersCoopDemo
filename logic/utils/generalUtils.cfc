component displayname="general utils - used for utilities methods, queries." output="true" hint="General Utilities"
{
    public any function decodeScope( required struct scope )
    {
        key = "";
        for (key in arguments.scope )
        {
            if ( isSimpleValue(arguments.scope[key]))
            {
                try 
                {
                      /* 
                        From CFDocs.org:
                        "Canonicalize or decode the input string. Canonicalization is simply the operation of reducing a possibly
                         encoded string down to its simplest form. This is important because attackers frequently use encoding 
                         to change their input in a way that will bypass validation filters, but still be interpreted properly 
                         by the target of the attack."
                      */  
					  arguments.scope[key] = canonicalize(arguments.scope[key], true, true, true);
                } 
                catch( any e )
                {
                    arguments.scope[key] = "ERROR: Invalid input found - canonicalization.";
                }
            }

            // Check for potential XSS in the inputs that may fall through canonicalization 
            tempFindScript = "";  
            tempFindScript  = reFindNoCase("/script/i", arguments.scope[key], "1", true, "one");
            if ( tempFindScript.LEN[1] )  
            {
                arguments.scope[key] = "ERROR: Invalid input found - script.";
            }
            else
            {
                // remove any html tags from form inputs 
                // are there any html tags?  If so, remove them AND the content they attempt to display. 
                tempFindHTML = "";
                tempFindHTML = reFindNoCase("<[^>]*>", arguments.scope[key], "1", true, "one");
                if ( tempFindHTML.LEN[1] )
                {
                    arguments.scope[key] = "ERROR:  Invalid input found - html.";
                }
            }
        }
        return arguments.scope;
    }

    public any function validateInput( required string emailAddress, required string phoneNumber, required string state, required string zip )
    {
        retFormatPhone = "";
        retFormatPhone = formatPhone(arguments.phoneNumber);
        returnValue = "";

        if ( arguments.emailAddress neq "" and !isValid( "email", arguments.emailAddress ) )
        {
            returnValue = "ERROR:  validating emailAddress: #arguments.emailAddress#";
        }
        else if ( arguments.phoneNumber neq "" and retFormatPhone contains "ERROR" )
        {
            returnValue = "#retFormatPhone#";
        }
        else if ( arguments.zip neq "" and !isValid( "zipcode", arguments.zip ))
        {
            returnValue = "ERROR:  validating zip";
        }
        else if (  arguments.state neq "" and !isValid("regular_expression", arguments.state, "^(?:(A[KLRZ]|C[AOT]|D[CE]|FL|GA|HI|I[ADLN]|K[SY]|LA|M[ADEINOST]|N[CDEHJMVY]|O[HKR]|P[AR]|RI|S[CD]|T[NX]|UT|V[AIT]|W[AIVY]))$") )
        {
            returnValue = "ERROR:  validating state: #arguments.state#";
        }
        else
        {
            returnValue = "GOOD DATA";
        }

        return returnValue;
    }

    public any function formatPhone( required string phoneNumber )
    {
        failedReturn = 0;

        // Strip out everything but the numbers --->
        cleanNumber = REReplaceNoCase(arguments.phoneNumber, "[^0-9]", "", "All");

        // area code can't start with a 1 or 0, so remove them if they are at the beginning 
        if ( Left(cleanNumber, 1) eq 1 OR Left(cleanNumber, 1) eq 0 ) 
        {
            cleanNumber = right(cleanNumber, len(cleanNumber) - 1);
        }

        // If there are still 10 or more digits left, lets use the left 10 and drop the rest
        if ( len(cleanNumber) LT 10 )
        {
            return "ERROR:  could not format phone number.  Be sure the phone number entered does not start with a 0 or 1 and has 10 numeric digits.";
        }
        else
        {
            cleanNumber = left(cleanNumber, 10) ;
        }
        
        // Format the 10 digits we have --->
        cleanNumber = "(" & #left(cleanNumber, 3)# & ") " & #mid(cleanNumber, 4, 3)# & "-" & #right(cleanNumber, 4)#;
    
        return cleanNumber;
    }
    
}
