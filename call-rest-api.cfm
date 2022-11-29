<cfscript>
    testJSON = {"test": "test"};
    cfhttpLoginResult = "";
    loginResult = "";
    cfhttpReportResult = "";
    reportResult = "";
    returnedToken = "";
    _report = "";

    if ( isdefined("URL.report") and URL.report neq "" )
    {
        _report = encodeForHTML(URL.report);
    }

    // Login (using dummy testJSON data) and get a token back used for authorization
    // on future calls.
    
    httpService = new http(method="POST", charset="utf-8", url="https://www.cotton.org/rest/controller/APIroutes/login");
    httpService.addParam(type="header", name="Content-Type", value="application/json");
    httpService.addParam(type="body", name="field", value="#serializeJSON(testJSON)#");
    cfhttpLoginResult = httpService.send().getPrefix();

    loginResult = DeserializeJSON(cfhttpLoginResult.filecontent);
    returnedToken = "#loginResult.token#";

    if ( returnedToken neq "")
    {
        if (  _report is "all" )
        {
            writeOutput("<h2>REST API request results for ALL farmers at BFC</h2>");
        }
        else
        {
            writeOutput('<h2>REST API request for all farmers at BFC with the last name of "#_report#"</h2>');
        }

        httpService = new http(method="GET", charset="utf-8", url="https://www.cotton.org/rest/controller/APIroutes/report/#_report#");
        httpService.addParam(type="header", name="Content-Type", value="application/json");
        httpService.addParam(type="header", name="authorization", value="#returnedToken#");
        cfhttpReportResult = httpService.send().getPrefix();

        reportResult = DeserializeJSON(cfhttpReportResult.filecontent, false);
        for ( i = 1; i <= #reportResult.recordCount#; i++ )
        {
            writeOutput("first name = #reportResult.FirstName[i]#<BR>");
            writeOutput("last name = #reportResult.LastName[i]#<BR>");
            writeOutput("email address = #reportResult.EmailAddress[i]#<BR>");
            writeOutput("phone number = #reportResult.PhoneNumber[i]#<BR><BR>");
        }
    }
</cfscript>
