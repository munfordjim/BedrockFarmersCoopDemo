<!doctype html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Bedrock Farmers Coop</title>
        <link rel="stylesheet" href="assets/css/custom.css">
    </head>
    <body>
    <!--- Heading --->
    <div class="w-100 has-bg-img header-image text-center" style="background-image: url('assets/images/cotton-field-2500wX450h.png'); background-repeat:no-repeat; background-size:cover; 
        background-position:center; height: 250px;">
        <h1 class="fw-bold custom-hero-text">Bedrock Farmers Coop</h1>
    </div>
    <!--- End Heading --->

    <!--- Begin Navigation Bar --->
    <nav class="navbar navbar-expand-lg navbar-dark bg-customNavBarColor">
        <div class="container-fluid">
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="##navbarSupportedContent" 
                aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav mx-auto">
                    <li class="nav-item">
                        <a class="nav-link ps-5 active" aria-current="page" href="index.cfm">Home</a>
                    </li>              
                    <li class="nav-item">
                        <a class="nav-link ps-5" href="addNewFarmer.cfm">New Farmer</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link  ps-5" href="updateFarmer.cfm" tabindex="-1">Update Farmer</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link  ps-5" href="deleteFarmer.cfm" tabindex="-1">Delete Farmer</a>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link  ps-5 dropdown-toggle" href="##" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            Reports
                        </a>
                        <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                            <li><a class="dropdown-item" href="call-rest-api.cfm?report=all">All Farmers (via rest api)</a></li>
                            <li><a class="dropdown-item" href="call-rest-api.cfm?report=flintstone">Farmers by Last Name (via rest api)</a></li>
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item" href="reportAllFarmers.cfm">Show all Farmers</a></li>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
    <!--- End Navigation Bar --->

    <!--- Main content --->
    <div class="container-fluid">
        <div class="row">
            <!--- Main body content --->
            <div class="ms-4 mt-4 bg-white h-100 sidebar col-12 col-sm-8 col-md-8 col-lg-9 col-xl-9 col-xxl-10">
                <h2 class="p-2 mb-0">ALL Farmers</h2>
                <!---  INITIALIZE THE Address MANAGER --->
                <cfset qryAllFarmers = createobject("component","logic.manager.farmerManager").getAllFarmers()>
                <cfif qryAllFarmers.RecordCount>
                    <cfoutput>
                        <cfsavecontent variable="rptAllFarmers">
                            <link rel="stylesheet" type="text/css" src="#expandPath('assets/css/')#custom.css">
                            <table class="table">
                            <tr>
                                <td class="fw-bold fs-5">First Name</td>
                                <td class="fw-bold fs-5">Last Name</td>
                                <td class="fw-bold fs-5">Email Address</td>
                                <td class="fw-bold fs-5">Phone Number</td>                    
                                <td class="fw-bold fs-5">Address</td>
                                <td class="fw-bold fs-5">City</td>
                                <td class="fw-bold fs-5">State</td>                        
                                <td class="fw-bold fs-5">Zip</td>                        
                            </tr>
                            <cfloop index="x" from="1" to="#qryAllFarmers.RecordCount#">
                                <tr>
                                    <td>#qryAllFarmers.FirstName[x]#</td>
                                    <td>#qryAllFarmers.LastName[x]#</td>
                                    <td>#qryAllFarmers.EmailAddress[x]#</td>
                                    <td>#qryAllFarmers.PhoneNumber[x]#</td>                    
                                    <td>#qryAllFarmers.AddressLine1[x]#</td>
                                    <td>#qryAllFarmers.City[x]#</td>
                                    <td>#qryAllFarmers.State[x]#</td>                        
                                    <td>#qryAllFarmers.Zip[x]#</td>                                                
                                </tr>
                            </cfloop> 
                            </table>
                        </cfsavecontent>                    

                    </cfoutput>
                    <cfif isDefined("form.selectOutput") and form.selectOutput is "screen">
                        <cfoutput>#rptAllFarmers#</cfoutput>
                    <cfelseif isdefined("form.selectOutput") and form.selectOutput is "pdf">
                        <cfdocument format="PDF" orientation="landscape">
                        <cfoutput>
                            <cfset rptAllFarmers = #Replace(rptAllFarmers, 'class="fw-bold fs-5', 'style="font-weight: bold; font-size:large; border-color: LightGrey; border-bottom-width: 1px;"', "ALL")#>
                            <cfset rptAllFarmers = #Replace(rptAllFarmers, 'class="table"', 'class="table" style="width: 100%"', "ALL")#>
                            <cfset rptAllFarmers = #Replace(rptAllFarmers, '<td>', '<td style="border-bottom-width: 1px; border-color: LightGrey">', "ALL")#>                                
                            <html>
                                <head>
                                    <link rel="stylesheet" href="assets/css/custom.css">
                                </head>
                                <body>
                                    #rptAllFarmers#
                                </body>
                            </html>
                        </cfoutput>
                        </cfdocument>
                    <cfelseif isdefined("form.selectOutput") and form.selectOutput is "EXCEL">
                        <!---<cfoutput>#GetDirectoryFromPath(expandPath("*.*"))#<BR></cfoutput>--->
                        <cfscript>
                            //Use an absolute path for the files.
                            theDir=GetDirectoryFromPath(expandPath("*.*")); 
                            theFile = theDir & "farmers.xls";    
                            //writedump(theFile);                    
                            // Create a new spreadsheet
                            spreadsheetObj = SpreadsheetNew('Farmers');
                            // Add a header row
                            //SpreadSheetAddRow(spreadsheetObj,'First Name,Last Name,Email Address,Phone Number, Address Line 1, City, State, Zip');
                            //Populate each object with a query.
                            SpreadsheetAddRows(spreadsheetObj,qryAllFarmers,1,1,true,[""],true); 
                            //Format Header
                            SpreadsheetformatRow(spreadsheetobj,{bold=true,alignment='center'},1);                            
                            //writedump(spreadsheetObj);
                            //Write File
                            //Spreadsheetwrite(spreadsheetobj,'#theFile#',true);
                            cfheader(name="Content-Disposition", value="inline; filename=farmers.xls");
                            cfcontent(type="application/vnd.ms-excel", variable=spreadSheetReadBinary(spreadsheetobj));
                        </cfscript>

                         <!--- Write the sheet to a single file
                        <cfspreadsheet action="write" filename="#theFile#" name="spreadsheetObj" sheetname="farmers" overwrite=true>     --->                        

                    </cfif>
                    <form class="g-3" action="reportAllFarmers.cfm" method="POST">
                        <div class="row">
                            <div class="col-md-4 col-lg-3 pt-2 pb-3 pb-sm-3">
                                <label for="selectOutput" class="form-label text-success fw-bold mb-3">Choose how you would like to view this report:</label>                        
                                <select id="selectOutput" name="selectOutput" class="form-select-lg mb-3" tabindex="1"
                                    required="required" oninvalid="this.setCustomValidity('Please select how you would like to view this report')" 
                                    oninput="setCustomValidity('')">
                                    <option value="" class="text-success fw-bold">Choose an output destination:</option>
                                    <option value="SCREEN">Screen</option>
                                    <option value="PDF">PDF</option>
                                    <option value="EXCEL">Excel Spreadsheet</option>
                                </select>        
                                <button type="submit" class="btn btn-primary" tabindex="9" name="btnAddNewFarmer">Choose Output Destination</button>
                            </div>
                        </dif>
                    </form>
                </cfif>
            </div>
        </div>
    </div>
    <!--- End Main Content --->

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js" 
    integrity="sha384-u1OknCvxWvY5kfmNBILK2hRnQC3Pr17a+RTT6rIHI7NnikvbZlHgTPOOmMi466C8" 
    crossorigin="anonymous"></script>

    <script src="assets/js/bfc.js"></script>
  </body>
</html>