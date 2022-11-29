<cfparam name="attributes.pageTitle" default="Data Maintenance" />
<cfif thisTag.executionMode EQ 'start'>
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
                            <cfif isdefined("attributes.PageTitle") and attributes.PageTitle eq "Data Maintenance">
                                <a class="nav-link ps-5 active" aria-current="page" href="index.cfm">Home</a>
                            <cfelse>
                                <a class="nav-link ps-5" href="index.cfm">Home</a>
                            </cfif>
                        </li>              
                        <li class="nav-item">
                            <cfif isdefined("attributes.PageTitle") and attributes.PageTitle eq "Add New Farmer">                            
                                <a class="nav-link ps-5 active"  aria-current="page" href="addNewFarmer.cfm">New Farmer</a>
                            <cfelse>
                                <a class="nav-link ps-5" href="addNewFarmer.cfm">New Farmer</a>
                            </cfif>
                        </li>
                        <li class="nav-item">
                            <cfif isdefined("attributes.PageTitle") and attributes.PageTitle eq "Update Farmer">                                                        
                                <a class="nav-link  ps-5 active" aria-current="page" href="updateFarmer.cfm" tabindex="-1">Update Farmer</a>
                            <cfelse>
                                <a class="nav-link  ps-5" href="updateFarmer.cfm" tabindex="-1">Update Farmer</a>
                            </cfif>
                        </li>
                        <li class="nav-item">
                            <cfif isdefined("attributes.PageTitle") and attributes.PageTitle eq "Delete Farmer">                                                                                    
                                <a class="nav-link  ps-5 active" aria-current="page" href="deleteFarmer.cfm" tabindex="-1">Delete Farmer</a>
                            <cfelse>
                                <a class="nav-link  ps-5" href="deleteFarmer.cfm" tabindex="-1">Delete Farmer</a>
                            </cfif>
                        </li>
                        <li class="nav-item dropdown">
                            <cfif isdefined("attributes.PageTitle") and attributes.PageTitle eq "Reports">                                                                                                                
                                <a class="nav-link  ps-5 dropdown-toggle active" aria-current="page" href="##" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                    Reports
                                </a>
                            <cfelse>
                                <a class="nav-link  ps-5 dropdown-toggle" href="##" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                    Reports
                                </a>
                            </cfif>
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
<cfelse>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-u1OknCvxWvY5kfmNBILK2hRnQC3Pr17a+RTT6rIHI7NnikvbZlHgTPOOmMi466C8" 
            crossorigin="anonymous"></script>

        <script src="assets/js/bfc.js"></script>
    </body>
    </html>    
</cfif>