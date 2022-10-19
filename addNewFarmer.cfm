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
                            <li><a class="dropdown-item" href="##">Some other type of report here</a></li>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
    <!--- End Navigation Bar --->
                
    <!---  INITIALIZE THE Address MANAGER --->
    <cfset addressManager = createobject("component","logic.manager.addressManager")>

    <!--- CREATE AN ADDRESS BEAN for use by the manager - also contains the farmerBean --->
    <cfset objAddressBean = createObject("component", "logic.bean.addressBean").init() />

    <!---  INITIALIZE THE Utilities MANAGER --->
    <cfset utilitiesManager = createobject("component","logic.manager.utilsManager")>

    <div class="container-fluid">
        <div class="row">
            <!--- Main body content --->
            <div class="bg-white h-100 sidebar">
                <h2 class="p-3">Add New Farmer</h2>
                <div class="container-fluid">
                    <cfif structKeyExists(FORM, "btnAddNewFarmer")>
                        <cfset objAddressBean.setFirstName("#form.inputFirstName#") />
                        <cfset objAddressBean.setLastName("#form.inputLastName#") />                        
                        <cfset objAddressBean.setEmailAddress("#form.inputEmailAddress#") />                        
                        <cfset objAddressBean.setPhoneNumber("#form.inputPhoneNumber#") />                        
                        <cfset objAddressBean.setAddressLine1("#form.inputAddressLine1#") />                        
                        <cfset objAddressBean.setCity("#form.inputCity#") />                        
                        <cfset objAddressBean.setState("#form.inputState#") />                        
                        <cfset objAddressBean.setZip("#form.inputZip#") />       

                        <cfset newAddressBean = 0 />
                        <cfset newAddressBean = addressManager.create(objAddressBean) />
                        
                        <cfif ( #newAddressBean.getAddrID()# neq 0 ) >
                            <h3 class="p-2 text-success">Successfully added a new farmer and address!</h3>
                        </cfif>
                        <!--- form --->
                        <form class="g-3" action="addNewFarmer.cfm" method="post">
                            <cfoutput>
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="form-floating mb-3">
                                        <input type="text" class="form-control" id="inputFirstName" name="inputFirstName" maxlength="100" 
                                            placeholder="First Name" tabindex="1" value="#newAddressBean.getFirstName()#">
                                        <label for="inputFirstName" class="form-label text-success fw-bold">First Name</label>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-floating mb-3">
                                        <input type="text" class="form-control" id="inputLastName" name="inputLastName" maxlength="100" 
                                            placeholder="Last Name" tabindex="2" value="#newAddressBean.getLastName()#">
                                        <label for="inputLastName" class="form-label text-success fw-bold">Last Name</label>         
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="form-floating mb-3">
                                        <input type="email" class="form-control" id="inputEmailAddress" name="inputEmailAddress" maxlength="100" 
                                            placeholder="Email Address" tabindex="3" value="#newAddressBean.getEmailAddress()#">
                                        <label for="inputEmailAddress" class="form-label text-success fw-bold">Email Address</label>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-floating mb-3">
                                        <input type="text" class="form-control" id="inputPhoneNumber" name="inputPhoneNumber" maxlength="100" 
                                            placeholder="Phone inputPhoneNumber" tabindex="4" value="#newAddressBean.getPhoneNumber()#">
                                        <label for="inputPhoneNumber" class="form-label text-success fw-bold">Phone Number</label>         
                                    </div>
                                </div>
                            </div>	
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="form-floating mb-3">                                
                                        <input type="text" class="form-control" id="inputAddressLine1" name="inputAddressLine1" maxlength="100" 
                                            placeholder="Address Line 1" tabindex="5" value="#newAddressBean.getAddressLine1()#">
                                        <label for="inputAddressLine1" class="form-label text-success fw-bold">Address Line 1</label>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="form-floating mb-3">           
                                        <input type="text" class="form-control" id="inputCity" name="inputCity" maxlength="100" 
                                            placeholder="City" tabindex="6" value="#newAddressBean.getCity()#">
                                        <label for="inputCity" class="form-label text-success fw-bold">City</label>
                                    </div>
                                </div>
                                <!---  Read in all US States --->
                                <cfset qAllUSStates = utilitiesManager.readUSStates() />
                                <div class="col-md-4 col-lg-3 pt-2 pb-3 pb-sm-3">
                                    <select id="inputState" name="inputState" class="form-select-lg" tabindex="7">
                                        <option value="" class="text-success fw-bold">Choose a State   </option>
                                        <cfloop index="s" from="1" to="#qAllUSStates.RecordCount#">
                                            <cfif qAllUSStates.StAB[s] eq #newAddressBean.getState()# >
                                                <option value="#qAllUSStates.StAB[s]#" selected>#qAllUSSTates.StateName[s]#</option>
                                            <cfelse>
                                                <option value="#qAllUSStates.StAB[s]#">#qAllUSSTates.StateName[s]#</option>
                                            </cfif>
                                        </cfloop>
                                    </select>
                                </div>
                                <div class="col-md-3 col-lg-2 pl-sm-3 pl-md-3 pl-lg-3">
                                    <div class="form-floating mb-3">           
                                        <input type="text" class="form-control" id="inputZip" name="inputZip" maxlength="10" 
                                        placeholder="Zip Code" tabindex="8" value="#newAddressBean.getZip()#">
                                        <label for="inputZip" class="form-label text-success fw-bold">Zip</label>
                                    </div>
                                </div>
                            </div>
                            </cfoutput>
                            <div class="col-12">
                                &nbsp;
                            </div>
                            <div class="col-12">
                                <button type="submit" class="btn btn-primary" tabindex="9" name="btnAddNewFarmer">ADD</button>
                            </div>
                        </form>
                    <cfelse>
                        <h4 class="text-success fw-bold pb-3">Add another farmer to Bedrock Farmers Coop:</h4>

                        <!--- form --->
                        <form class="g-3" action="addNewFarmer.cfm" method="post">
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="form-floating mb-3">
                                        <input type="text" class="form-control" id="inputFirstName" name="inputFirstName" maxlength="100" placeholder="First Name" tabindex="1"
                                            required="required" oninvalid="this.setCustomValidity('Please Enter a valid First Name')" 
                                            oninput="setCustomValidity('')">
                                        <label for="inputFirstName" class="form-label text-success fw-bold">First Name</label>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-floating mb-3">
                                        <input type="text" class="form-control" id="inputLastName" name="inputLastName" maxlength="100" placeholder="Last Name" tabindex="2"
                                            required="required" oninvalid="this.setCustomValidity('Please Enter a valid Last Name')" 
                                            oninput="setCustomValidity('')">
                                        <label for="inputLastName" class="form-label text-success fw-bold">Last Name</label>         
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="form-floating mb-3">
                                        <input type="email" class="form-control" id="inputEmailAddress" name="inputEmailAddress" maxlength="100" placeholder="Email Address" tabindex="3">
                                        <label for="inputEmailAddress" class="form-label text-success fw-bold">Email Address</label>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-floating mb-3">
                                        <input type="text" class="form-control" id="inputPhoneNumber" name="inputPhoneNumber" maxlength="100" placeholder="Phone inputPhoneNumber" tabindex="4">
                                        <label for="inputPhoneNumber" class="form-label text-success fw-bold">Phone Number</label>         
                                    </div>
                                </div>
                            </div>	
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="form-floating mb-3">                                
                                        <input type="text" class="form-control" id="inputAddressLine1" name="inputAddressLine1" maxlength="100" placeholder="Address Line 1" tabindex="5"
                                            required="required" oninvalid="this.setCustomValidity('Please Enter a valid Address Line 1')" 
                                            oninput="setCustomValidity('')">
                                        <label for="inputAddressLine1" class="form-label text-success fw-bold">Address Line 1</label>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="form-floating mb-3">           
                                        <input type="text" class="form-control" id="inputCity" name="inputCity" maxlength="100" placeholder="City" tabindex="6"
                                            required="required" oninvalid="this.setCustomValidity('Please Enter a valid City')" 
                                            oninput="setCustomValidity('')">
                                        <label for="inputCity" class="form-label text-success fw-bold">City</label>
                                    </div>
                                </div>
                                <!---  Read in all US States --->
                                <cfset qAllUSStates = utilitiesManager.readUSStates() />
                                <div class="col-md-4 col-lg-3 pt-2 pb-3 pb-sm-3">
                                    <select id="inputState" name="inputState" class="form-select-lg" tabindex="7"
                                        required="required" oninvalid="this.setCustomValidity('Please select a valid state')" 
                                        oninput="setCustomValidity('')">
                                        <option value="" class="text-success fw-bold">Choose a state</option>
                                        <cfloop index="s" from="1" to="#qAllUSStates.RecordCount#">
                                            <cfoutput><option value="#qAllUSStates.StAB[s]#">#qAllUSSTates.StateName[s]#</option></cfoutput>
                                        </cfloop>
                                    </select>
                                </div>
                                <div class="col-md-3 col-lg-2 pl-sm-3 pl-md-3 pl-lg-3">
                                    <div class="form-floating mb-3">           
                                        <input type="text" class="form-control" id="inputZip" name="inputZip" maxlength="10" placeholder="Zip Code" tabindex="8"
                                            required="required" oninvalid="this.setCustomValidity('Please Enter a valid Zip Code')" 
                                            oninput="setCustomValidity('')">
                                        <label for="inputZip" class="form-label text-success fw-bold">Zip</label>
                                    </div>
                                </div>
                            </div>
                            <div class="col-12">
                                &nbsp;
                            </div>
                            <div class="col-12">
                                <button type="submit" class="btn btn-primary" tabindex="9" name="btnAddNewFarmer">ADD</button>
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
