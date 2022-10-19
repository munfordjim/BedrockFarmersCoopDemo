<cfoutput>
    <!--- Created using the article https://medium.com/analytics-vidhya/building-an-awesome-restful-apis-with-coldfusion-86422f6b2b6f --->
    <!---
        Displays "the REST API path and the application root path. The only purpose of this 
        file is to invoke application.cfc, which will be automatically called when we run index
        .cfm in the browser."    
    --->
    <strong>REST API</strong> is running at <i>https://www.cotton.org/rest/controller/APIroutes/</i><br>
    <strong>Application root:</strong #getPageContext().getRequest().getRequestURI()#
</cfoutput>