<cfscript>

public boolean function onApplicationStart() 
{
    application.companyName = "Bedrock Farmers Coop";
    return true;
}    

public void function onSessionStart() 
{ 

    session.created = Now(); // timestamp when this session was created;
    session.loggedIn = false;	// new users are logged out by default;
} 

function onRequestStart( string targetPage ) 
{
    if (not isdefined("application.datasource"))
    {
        application.datasource = "ncc-web";
    }

    if( url.keyExists( "reinit" ) )
    {
        lock type="exclusive" scope="application" timeout="20"
        {
            onApplicationStart();
            onSessionStart();
        }
    }
}

function onRequest( string targetPage ) 
{
    try 
    {
       include arguments.targetPage;
    } 
    catch (any e) 
    {
        //writeDump(application.customTagPaths);
        WriteOutput( "Error trying to include template #targetPage#." );
        WriteDump( e );
    }
}

function onRequestEnd( string targetPage ) 
{
    
}

function onSessionEnd( struct SessionScope, struct ApplicationScope ) 
{

}

function onApplicationEnd( struct ApplicationScope ) 
{

}

function onError( any Exception, string EventName ) 
{
    //  Exception is a struct.  EventName is a string
    //  Use for friendly error handling.
    WriteOutput( "bad thing happened!" );
    WriteDump( arguments.exception );
    WriteDump( arguments.eventName );
}

public boolean function onMissingTemplate( required string targetPage ) 
{ 
    location url="https://www.cotton.org/jim_dev/test/bfc-demo/missingTemplateHandler.cfm?missingtemplate=#URLEncodedFormat(arguments.targetpage)#" addtoken="no";
} 

    
</cfscript>