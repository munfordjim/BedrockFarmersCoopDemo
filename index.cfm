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
                <h2 class="p-2 mb-0">Data Maintenance</h2>
                <h3 class="p-2 mb-0">Select an option from the green bar above</h3>
                <p class="p-2">
                    This app is a very simple demonstration of creating, reading, updating, and deleting (CRUD) 
                    the basic information of a Farmer at Bedrock Farmers Coop.  
                    The app uses object-oriented ColdFusion to accomplish this along utilizing the following technologies:
                </p>
                <ol>
                    <li>Bootstrap 5.2</li>
                    <li>Javascript (Vanilla, JQuery, Node)</li>
                    <li>SASS</li>
                    <li>CSS</li>
                    <li>ColdFusion 2018</li>
                    <li>MS SQL Server, SQL Server Studio</li>
                    <li>MS Visual Studio Code</li>
                    <li>REST API concepts using ColdFusion (Reports)
                    <li>Protection against SQL injection (SQLi), Cross-Site Scripting (XSS), etc. using appropriate ColdFusion
                        tags and functions (ie, cfqueryparam, canonicalize, regular expressions, etc.)</li>
                </ol>
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