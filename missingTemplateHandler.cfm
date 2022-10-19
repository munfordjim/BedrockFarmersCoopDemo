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
                                <li><a class="dropdown-item" href="##">Some other type of report here</a></li>
                            </ul>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>
        <!--- End Navigation Bar --->
        <div class="container-fluid text-center">
            <div class="mt-5">
                <h1 class="display-1 fw-bold">404</h1>
                <p class="fs-3"> <span class="text-danger">Oops!</span> Page not found.</p>
                <p class="lead">
                    The page you're looking for doesn't exist.
                </p>
                <button type="button" class="btn btn-primary" tabindex="9" name="btnGoBack" onclick="location.href='index.cfm'">Go Home</button>
            </div>
        </div>
    </body>
</html>	