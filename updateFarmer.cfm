<cfmodule template="customTags/siteChrome.cfm" pageTitle="Update Farmer">
    <cfscript>
        //  INITIALIZE THE MANAGERs 
        addressManager = new logic.manager.addressManager();
        farmerManager = new logic.manager.farmerManager();
    
        //  INITIALIZE THE Utilities MANAGER 
        utilitiesManager = new logic.manager.utilsManager();
        //  Read in all US States 
        qAllUSStates = utilitiesManager.readUSStates();
        
        if ( structKeyExists(FORM, "btnUpdateFarmer") ) // Do the Update 
        {
            /*
                Be sure we have clean data before updating.
                First, canonicalize the form before putting the data in the bean
            */
            utilitiesManager.decodeScope(#FORM#);
            for ( key in #FORM# ) 
            {
                if ( form[key] contains "ERROR" )
                {
                    writeOutput("<div style='margin-left: 15px; margin-top: 15px;')><h4 class='text-danger'>UPDATE ERROR</h4>There was an error validating the updated data. Please use the button below to return to the form and provide clean updated data.
                    <br>
                    <br>
                    <button type='button' class='btn btn-primary' tabindex='9' name='btnGoBack' onclick='history.back()'> Go Back </button></div>");
                    abort;
                }
            }
            //  Now, validate the clean data 
            strResult = "";
            strResult = utilitiesManager.validateInput(form.inputEmailAddress, form.inputPhoneNumber, form.inputState, form.inputZip);
            if ( strResult contains "ERROR" )
            {
                writeOutput("<div style='margin-left: 15px; margin-top: 15px;')><h4 class='text-danger'>UPDATE ERROR</h4>There was an error validating your updated data. Please use the button below to return to the form and be sure you provide valid information. #strResult#
                <br>
                <br>
                <button type='button' class='btn btn-primary' tabindex='9' name='btnGoBack' onclick='history.back()'> Go Back</button></div>")
                abort;
            }
        
            // Populate the address bean 
            objAddressBean = new logic.bean.addressBean().init(AddrID=#form.inputAddrID#, AddressLine1=#form.inputAddressLine1#, City=#form.inputCity#, State=#form.inputState#, Zip=#form.inputZip#);
        
            // Update the Address 
            boolAddrStatus =  addressManager.update(#objAddressBean#);
        
            // Be sure the format of the valid phone number is correct 
            strPhoneNumber = utilitiesManager.formatPhone(form.inputPhoneNumber);
        
            // Populate the farmer bean 
            try {
                objFarmerBean = new logic.bean.farmerBean().init(FarmerID=#form.inputFarmerID#, FirstName=#form.inputFirstName#, LastName=#form.inputLastName#, EmailAddress=#form.inputEmailAddress#, PhoneNumber=#strPhoneNumber#);                  
            } 
            catch( any e ){
                throw( type="custom", message="Error in updateFarmer.cfm: #e.message#; detail=#e.detail#" );
            }


            // Update the Farmer 
            boolFarmerStatus = farmerManager.update(#objFarmerBean#);

        }
        else if ( structKeyExists(FORM, "btnSelectFarmerToUpdate") )
        {
            //  if the key parameter is used in the form when the token is generated it MUST be used here as well.
	        validate = CSRFverifyToken( form.token );
            if( !validate )
	        {
                writeOutput("<div style='margin-left: 15px; margin-top: 15px;')><h4 class='text-danger'>UPDATE ERROR</h4>There was error submitting the form.  Please use the button below to return to the form and try again.
                    <br>
                    <br>
                    <button type='button' class='btn btn-primary' tabindex='9' name='btnGoBack' onclick='history.back()'> Go Back </button></div>");
                abort;
            }
            objAddrBean = farmerManager.readFarmerAndAddress(#form.selectFarmer#);
        }
        else 
        {
            qAllFarmerRecords = "";
            qAllFarmerRecords = farmerManager.getAllFarmers();
        }
    </cfscript>
    
        <div class="container-fluid">
            <div class="row">
                <!--- Main body content --->
                <div class="bg-white h-100 sidebar">
                    <h2 class="p-3">
                        Update Farmer
                    </h2>
                    <div class="container-fluid">
                        <cfif structKeyExists(FORM, "btnUpdateFarmer")><!--- Do the Update --->
                            <cfif boolAddrStatus AND boolFarmerStatus>
                                <h3 class="p-2 text-success">
                                    Successfully updated the farmer and address!
                                </h3>
                                <p class="p-2 mb-0 text-success fw-bold">
                                    Updated information:
                                </p>
                                
                                <div class="row">
                                    <div class="col-md-4 ps-5 pb-4">
                                        <cfoutput>
                                            <span class="fw-bold">
                                                Name:
                                            </span>#objFarmerBean.getFirstName()# #objFarmerBean.getLastName()#
                                            <br>
                                            <span class="fw-bold">
                                                Email Address:
                                            </span>#objFarmerBean.getEmailAddress()#
                                            <br>
                                            <span class="fw-bold">
                                                Phone Number:
                                            </span>#objFarmerBean.getPhoneNumber()#
                                            <br>
                                            <span class="fw-bold">
                                                Address:
                                            </span>
                                            <br>#objAddressBean.getAddressLine1()#
                                            <br>#objAddressBean.getCity()#, #objAddressBean.getState()# #objAddressBean.getZip()#
                                        </cfoutput>
                                    </div>
                                </div>
                                
                            <cfelse>
                                <h3 class="p-2 text-success">
                                    UH-OH! Something went wrong!!
                                </h3>
                            </cfif>
                        
                            <div>
                                <button type="button" class="btn btn-primary" tabindex="9" name="btnDifferentFarmer"
                                        onclick="location.href='updateFarmer.cfm'">
                                    Select Another Farmer
                                </button>
                            </div>
                            
                        <cfelseif structKeyExists(FORM, "btnSelectFarmerToUpdate")><!--- Show the current information for the farmer selected for updating --->
                            <h4 class="pb-3 ps-1 text-success fw-bold">
                                Update an existing Bedrock Farmers Coop farmer:
                            </h4>
                            
                            <!--- form --->
                            <form class="g-3" action="updateFarmer.cfm" method="post">
                                <cfoutput>
                                    <input type="hidden" id="inputAddrID" name="inputAddrID" value="#objAddrBean.getAddrID()#">
                                    <input type="hidden" id="inputFarmerID" name="inputFarmerID" value="#objAddrBean.getFarmerID()#">
                                    
                                    <div class="row">
                                        <div class="col-md-4">
                                            <div class="form-floating mb-3">
                                                <input type="text" class="form-control" id="inputFirstName" name="inputFirstName"
                                                       maxlength="100" placeholder="First Name" tabindex="1" value="#objAddrBean.getFirstName()#"
                                                       required="required" oninvalid="this.setCustomValidity('Please Enter a valid First Name')" oninput="setCustomValidity('')">
                                                <label for="inputFirstName" class="form-label text-success fw-bold">
                                                    First Name
                                                </label>
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="form-floating mb-3">
                                                <input type="text" class="form-control" id="inputLastName" name="inputLastName"
                                                       maxlength="100" placeholder="Last Name" tabindex="2" value="#objAddrBean.getLastName()#"
                                                       required="required" oninvalid="this.setCustomValidity('Please Enter a valid Last Name')" oninput="setCustomValidity('')">
                                                <label for="inputLastName" class="form-label text-success fw-bold">
                                                    Last Name
                                                </label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-4">
                                            <div class="form-floating mb-3">
                                                <input type="email" class="form-control" id="inputEmailAddress" name="inputEmailAddress"
                                                       maxlength="100" placeholder="Email Address" tabindex="3" value="#objAddrBean.getEmailAddress()#">
                                                <label for="inputEmailAddress" class="form-label text-success fw-bold">
                                                    Email Address
                                                </label>
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="form-floating mb-3">
                                                <input type="text" class="form-control" id="inputPhoneNumber" name="inputPhoneNumber"
                                                       maxlength="100" placeholder="Phone inputPhoneNumber" tabindex="4" value="#objAddrBean.getPhoneNumber()#">
                                                <label for="inputPhoneNumber" class="form-label text-success fw-bold">
                                                    Phone Number
                                                </label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-4">
                                            <div class="form-floating mb-3">
                                                <input type="text" class="form-control" id="inputAddressLine1" name="inputAddressLine1"
                                                       maxlength="100" placeholder="Address Line 1" tabindex="5" value="#objAddrBean.getAddressLine1()#"
                                                       required="required" oninvalid="this.setCustomValidity('Please Enter a valid Address Line 1')" oninput="setCustomValidity('')">
                                                <label for="inputAddressLine1" class="form-label text-success fw-bold">
                                                    Address Line 1
                                                </label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-4">
                                            <div class="form-floating mb-3">
                                                <input type="text" class="form-control" id="inputCity" name="inputCity"
                                                       maxlength="100" placeholder="City" tabindex="6" value="#objAddrBean.getCity()#"
                                                       required="required" oninvalid="this.setCustomValidity('Please Enter a valid City')" oninput="setCustomValidity('')">
                                                <label for="inputCity" class="form-label text-success fw-bold">
                                                    City
                                                </label>
                                            </div>
                                        </div>

                                        <div class="col-md-4 col-lg-3 pt-2 pb-3 pb-sm-3">
                                            <select id="inputState" name="inputState" class="form-select-lg" tabindex="7"
                                                    required="required" oninvalid="this.setCustomValidity('Please select a valid state')" oninput="setCustomValidity('')">
                                                <option value="" class="text-success fw-bold">
                                                    Choose a State 
                                                </option>
                                                <cfloop index="s" from="1" to="#qAllUSStates.RecordCount#">
                                                    <cfif qAllUSStates.StAB[s] eq #objAddrBean.getState()#>
                                                        <option value="#qAllUSStates.StAB[s]#" selected>
                                                            #qAllUSSTates.StateName[s]#
                                                        </option>
                                                    <cfelse>
                                                        <option value="#qAllUSStates.StAB[s]#">
                                                            #qAllUSSTates.StateName[s]#
                                                        </option>
                                                    </cfif>
                                                </cfloop>
                                            </select>
                                        </div>
                                        <div class="col-md-3 col-lg-2 pl-sm-3 pl-md-3 pl-lg-3">
                                            <div class="form-floating mb-3">
                                                <input type="text" class="form-control" id="inputZip" name="inputZip"
                                                       maxlength="10" placeholder="Zip Code" tabindex="8" value="#objAddrBean.getZip()#"
                                                       required="required" oninvalid="this.setCustomValidity('Please select a valid zip code')" oninput="setCustomValidity('')">
                                                <label for="inputZip" class="form-label text-success fw-bold">
                                                    Zip
                                                </label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-12">
                                        &nbsp;
                                    </div>
                                    <div class="col-12">
                                        <button type="submit" class="btn btn-primary" tabindex="9" name="btnUpdateFarmer">
                                            UPDATE
                                        </button>
                                        <button type="button" class="btn btn-primary" tabindex="9" name="btnDifferentFarmer"
                                                onclick="location.href='updateFarmer.cfm'">
                                            Select Another Farmer
                                        </button>
                                    </div>
                                </cfoutput>
                            </form>
                        <cfelse><!--- Show a list of existing farmers to pick from for updating --->
                            <!--- form --->
                            <form class="g-3 p-0" action="updateFarmer.cfm" method="post">
                                <cfoutput>
                                    <input name="token" type="hidden" value="#CSRFGenerateToken( forceNew=true )#">
                                </cfoutput>
                                <div class="p-3 m-0">
                                    <h4 class="pb-3 text-success fw-bold">
                                        Please select an existing farmer to update:
                                    </h4>
                                    <select id="selectFarmer" name="selectFarmer" class="form-select-lg" tabindex="7"
                                            required="required" oninvalid="this.setCustomValidity('Please select a Farmer from the list')" oninput="setCustomValidity('')">
                                        <option value="">
                                            Choose a Farmer
                                        </option>
                                        <cfloop index="s" from="1" to="#qAllFarmerRecords.RecordCount#">
                                            <cfoutput>
                                                <option value="#qAllFarmerRecords.FarmerID[s]#">
                                                    #qAllFarmerRecords.FirstName[s]# 
                                                    #qAllFarmerRecords.LastName[s]#
                                                </option>
                                            </cfoutput>
                                        </cfloop>
                                    </select>
                                </div>
                                <div class="p-3">
                                    <button type="submit" class="btn btn-primary" tabindex="9" name="btnSelectFarmerToUpdate">
                                        Select Farmer
                                    </button>
                                </div>
                            </form>
                        </cfif>
                    </div>
                </div>
            </div>
        </div>
    </cfmodule>