<!doctype html>
<html lang="en">
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>Bedrock Farmers Coop - Add New Farmer</title>
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
                        <a class="nav-link ps-5" href="index.cfm">Home</a>
                    </li>              
                    <li class="nav-item">
                        <a class="nav-link ps-5 active" aria-current="page" href="addNewFarmer.cfm">New Farmer</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link  ps-5" href="updateFarmer.cfm">Update Farmer</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link  ps-5" href="deleteFarmer.cfm">Delete Farmer</a>
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
                
    <!---  INITIALIZE THE MANAGERs --->
    <cfset addressManager = createobject("component","logic.manager.addressManager")>
    <cfset farmerManager = createobject("component","logic.manager.farmerManager")>    

    <!--- Show a list of existing farmers to pick from for updating --->
    <cfset qAllFarmerRecords = "" />
    <cfset qAllFarmerRecords = farmerManager.getAllFarmers() />

    <div class="container-fluid">
        <div class="row">
            <!--- Main body content --->
            <div class="bg-white h-100 sidebar">
                <h2 class="p-3">Delete Farmer</h2>
                <div class="container-fluid">
                    <cfif structKeyExists(FORM, "btnSelectFarmerToDelete")>  <!--- Confirm the Delete --->
                        <cfset objAddrBean =farmerManager.readFarmerAndAddress(#form.selectFarmer#) /> 

                        <h3 class="p-2 text-success">Please confirm that you would like to DELETE the farmer below and their address:</h3>

                        <div class="row">
                            <div class="col-md-4 ps-5 pb-4">
                                <cfoutput>
                                <span class="fw-bold">Name:</span>  #objAddrBean.getFirstName()# #objAddrBean.getLastName()#<BR>
                                <span class="fw-bold">Email Address:</span>  #objAddrBean.getEmailAddress()#<BR>
                                <span class="fw-bold">Phone Number:</span>  #objAddrBean.getPhoneNumber()#<BR>
                                <span class="fw-bold">Address:</span> <BR>
                                #objAddrBean.getAddressLine1()#<BR>
                                #objAddrBean.getCity()#, #objAddrBean.getState()# #objAddrBean.getZip()#
                                </cfoutput>
                            </div>
                        </div>
                        <form class="g-3" action="deleteFarmer.cfm" method="post">
                            <cfoutput>
                                <input type="hidden" id="selectFarmer" name="selectFarmer" value="#form.selectFarmer#">
                            </cfoutput>
                            <div>
                                <button type="submit" class="btn btn-primary" tabindex="9" name="btnConfirmDelete">Confirm Delete</button>                                
                            </div>                        
                        </form>
                    <cfelseif structKeyExists(FORM, "btnConfirmDelete") >
                        <cfset boolDeleteAddrStatus = false />
                        <cfset boolDeleteFarmerStatus = false />

                        <cfset objAddrBean =farmerManager.readFarmerAndAddress(#form.selectFarmer#) /> 
                        <cfset boolDeleteFarmerStatus=farmerManager.delete(#objAddrBean.getFarmerID()#) />
                        <cfset boolDeleteAddrStatus=addressManager.delete(#objAddrBean.getAddrID()#) />

                        <cfif boolDeleteFarmerStatus AND boolDeleteAddrStatus>
                            <cfoutput><h3 class="p-2 text-success">Successfully deleted #objAddrBean.getFirstName()# #objAddrBean.getLastName()# and their address!</h3></cfoutput>
                        <cfelse>
                            <h3 class="p-2 text-success">UH-OH! Something went wrong!!</h3>                        
                        </cfif>

                        <div>
                            <button type="submit" class="btn btn-primary" tabindex="9" name="btnConfirmDelete" 
                                onclick="location.href='deleteFarmer.cfm'">Select Another Farmer</button>                                
                        </div>                        
                    <cfelse>
                        <!--- form --->
                        <form class="g-3 p-0" action="deleteFarmer.cfm" method="post">
                            <div class="p-3 m-0">
                                <h4 class="pb-3 text-success fw-bold">Please select an existing farmer to delete:</h4>                            
                                <select id="selectFarmer" name="selectFarmer" class="form-select-lg" tabindex="7"
                                        required="required" oninvalid="this.setCustomValidity('Please select a Farmer from the list')" 
                                        oninput="setCustomValidity('')">
                                    <option value="">Choose a Farmer</option>
                                    <cfloop index="s" from="1" to="#qAllFarmerRecords.RecordCount#">
                                        <cfoutput><option value="#qAllFarmerRecords.FarmerID[s]#">#qAllFarmerRecords.FirstName[s]# #qAllFarmerRecords.LastName[s]#</option></cfoutput>
                                    </cfloop>
                                </select>
                            </div>
                            <div class="p-3">
                                <button type="submit" class="btn btn-primary" tabindex="9" name="btnSelectFarmerToDelete">Select Farmer</button>
                            </div>                            
                        </form>                        
                    </cfif>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js" 
    integrity="sha384-u1OknCvxWvY5kfmNBILK2hRnQC3Pr17a+RTT6rIHI7NnikvbZlHgTPOOmMi466C8" 
    crossorigin="anonymous"></script>

    <script src="assets/js/bfc.js"></script>
  </body>
</html>
