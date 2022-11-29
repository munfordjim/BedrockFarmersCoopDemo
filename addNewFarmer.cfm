<cfmodule template="customTags/siteChrome.cfm"  pageTitle="Add New Farmer">
    <cfscript>
        // INITIALIZE THE Address MANAGER createobject("component","logic.manager.addressManager")
        addressManager = new logic.manager.addressManager();
    
        // CREATE AN ADDRESS BEAN for use by the manager - also contains the farmerBean 
        objAddressBean = new logic.bean.addressBean().init();

        // INITIALIZE THE Utilities MANAGER 
        utilitiesManager = new logic.manager.utilsManager();

        //  Read in all US States 
        qAllUSStates = utilitiesManager.readUSStates();

        if ( structKeyExists(FORM, "btnAddNewFarmer") )
        {
            //  if the key parameter is used in the form when the token is generated it MUST be used here as well.
	        validate = CSRFverifyToken( form.token );
            if( !validate )
	        {
                writeOutput("<div style='margin-left: 15px; margin-top: 15px;')><h4 class='text-danger'>ADD ERROR</h4>There was error submitting the form.  Please use the button below to return to the form and try again.
                    <br>
                    <br>
                    <button type='button' class='btn btn-primary' tabindex='9' name='btnGoBack' onclick='history.back()'> Go Back </button></div>");
                abort;
            }
            /*
                Be sure we have clean data before updating.
                First, canonicalize the form before putting the data in the bean
            */
            utilitiesManager.decodeScope(#FORM#);
            for ( key in #FORM# ) 
            {
                if ( form[key] contains "ERROR" )
                {
                    writeOutput("<div style='margin-left: 15px; margin-top: 15px;')><h4 class='text-danger'>ADD ERROR</h4>There was an error validating the entered data. Please use the button below to return to the form and provide clean data.
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
                writeOutput("<div style='margin-left: 15px; margin-top: 15px;')><h4 class='text-danger'>ADD ERROR</h4>There was an error validating your entered data. Please use the button below to return to the form and be sure you provide valid information. #strResult#
                <br>
                <br>
                <button type='button' class='btn btn-primary' tabindex='9' name='btnGoBack' onclick='history.back()'> Go Back</button></div>")
                abort;
            }

            objAddressBean.setFirstName("#form.inputFirstName#");
            objAddressBean.setLastName("#form.inputLastName#");
            objAddressBean.setEmailAddress("#form.inputEmailAddress#");
            objAddressBean.setPhoneNumber("#form.inputPhoneNumber#");
            objAddressBean.setAddressLine1("#form.inputAddressLine1#");
            objAddressBean.setCity("#form.inputCity#");
            objAddressBean.setState("#form.inputState#");
            objAddressBean.setZip("#form.inputZip#");

            newAddressBean = 0;
            newAddressBean = addressManager.create(objAddressBean);
        }
    </cfscript>

    <div class="container-fluid">
        <div class="row">
            <!--- Main body content --->
            <div class="bg-white h-100 sidebar">
                <h2 class="p-3">Add New Farmer</h2>
                <div class="container-fluid">
                    <cfif structKeyExists(FORM, "btnAddNewFarmer")>
                        <cfif ( #newAddressBean.getAddrID()# neq 0 ) >
                            <h3 class="p-2 text-success">Successfully added a new farmer and address!</h3>
                        </cfif>
                        <div class="row">
                            <div class="col-md-4 ps-5 pb-4">
                                <cfoutput>
                                    <span class="fw-bold">
                                        Name:
                                    </span>#newAddressBean.getFirstName()# #newAddressBean.getLastName()#
                                    <br>
                                    <span class="fw-bold">
                                        Email Address:
                                    </span>#newAddressBean.getEmailAddress()#
                                    <br>
                                    <span class="fw-bold">
                                        Phone Number:
                                    </span>#newAddressBean.getPhoneNumber()#
                                    <br>
                                    <span class="fw-bold">
                                        Address:
                                    </span>
                                    <br>#newAddressBean.getAddressLine1()#
                                    <br>#newAddressBean.getCity()#, #newAddressBean.getState()# #newAddressBean.getZip()#
                                </cfoutput>
                            </div>
                            <div>
                                <button type="button" class="btn btn-primary" tabindex="9" name="btnDifferentFarmer"
                                        onclick="location.href='addNewFarmer.cfm'">
                                    Add Another Farmer
                                </button>
                            </div>
                        </div>
                    <cfelse>
                        <h4 class="text-success fw-bold pb-3">Add a farmer to Bedrock Farmers Coop:</h4>

                        <!--- form --->
                        <form class="g-3" action="addNewFarmer.cfm" method="post">
                            <!--- CSRF = Cross Site Request Forgery.  Prevents that kind of hackery.  The key parameter is optional but if used it MUST be used when 
					                the token is verified
                             --->
                            <cfoutput>
			                <input name="token" type="hidden" value="#CSRFGenerateToken( forceNew=true )#">
                            </cfoutput>

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
</cfmodule>