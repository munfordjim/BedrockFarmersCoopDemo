<cfset testJSON = {"test": "test"} />
<cfset cfhttpLoginResult = "" />
<cfset loginResult = "" />
<cfset cfhttpReportResult = "" />
<cfset reportResult = "" />
<cfset returnedToken = "" />

<!--- 
    Login (using dummy testJSON data) and get a token back used for authorization
    on future calls.
--->
<cfhttp url="https://www.cotton.org/rest/controller/APIroutes/login"
    method="POST" result="cfhttpLoginResult">
    <cfhttpparam type="header" name="Content-Type" value="application/json">
    <cfhttpparam type="body" name="field" value="#serializeJSON(testJSON)#" />
</cfhttp>

<!---<cfdump var="#cfhttpLoginResult.filecontent#"  label="login result">--->
<cfset loginResult = DeserializeJSON(cfhttpLoginResult.filecontent) />
<!---<cfdump var="#loginResult#" label="after derserialization" >--->
<cfset returnedToken = "#loginResult.token#" />
<!---<cfdump var="#returnedToken#" label="token" />--->

<cfif returnedToken neq "">
    <!---<cfoutput>#returnedToken#</cfoutput>--->
    <!---  
        Call for a report (report/all is for all farmers, report/"lastname" is used
        to filter by a last name)
    --->
    <cfif isdefined("URL.report") AND URL.report is "all">
        <h2>REST API request results for ALL farmers at BFC</h2>
    <cfelse>
        <cfoutput><h2>REST API request for all farmers at BFC with the last name of "#url.report#"</h2></cfoutput>    
    </cfif>
    <cfhttp url="https://www.cotton.org/rest/controller/APIroutes/report/#URL.report#"
        method="GET" result="cfhttpReportResult">
        <cfhttpparam type="header" name="Content-Type" value="application/json">
        <cfhttpparam type="header" name="authorization" value="#returnedToken#" />
    </cfhttp>

    <cfset reportResult = DeserializeJSON(cfhttpReportResult.filecontent, false) />
    <cfloop index="i" from="1" to="#reportResult.recordCount#">
        <cfoutput>
            first name = #reportResult.FirstName[i]#<BR>
            last name = #reportResult.LastName[i]#<BR>            
            email address = #reportResult.EmailAddress[i]#<BR>            
            phone number = #reportResult.PhoneNumber[i]#<BR><BR>            
        </cfoutput>
    </cfloop>    
</cfif>