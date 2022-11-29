<cfscript>

this.name = "BedrockFarmersCoopDemo" & left( hash( getCurrentTemplatePath()), 64 );
this.ApplicationTimeout = "#CreateTimeSpan(1,0,0,0)#";
this.sessionManagement = true;
this.sessiontimeout = "#CreateTimeSpan(0,0,30,0)#";
this.ClientManagement = "no";
// This prevents the cookie from being read from JavaScript. 
this.sessioncookie.httpOnly = true;
this.scriptProtect = "All";
//this.customTagPaths = [ expandPath( './customTags' ) ];  //getting errors that this is undefined...changing the calling method...
this.datasource = "ncc-web";

</cfscript>