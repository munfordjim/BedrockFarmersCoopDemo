<cfmodule template="customTags/siteChrome.cfm"  pageTitle="Delete Farmer"> 
    <cfscript>
        //  INITIALIZE THE MANAGERs 
        addressManager = new logic.manager.addressManager();
        farmerManager = new logic.manager.farmerManager();

        // Show a list of existing farmers to pick from for updating 
        qAllFarmerRecords = "";
        qAllFarmerRecords = farmerManager.getAllFarmers();
        
        if ( structKeyExists(FORM, "btnSelectFarmerToDelete") )   // Confirm the Delete
        {
            //  if the key parameter is used in the form when the token is generated it MUST be used here as well.
	        validate = CSRFverifyToken( form.token );
            if( !validate )
	        {
                writeOutput("<div style='margin-left: 15px; margin-top: 15px;')><h4 class='text-danger'>DELETE ERROR</h4>There was error submitting the form.  Please use the button below to return to the form and try again.
                    <br>
                    <br>
                    <button type='button' class='btn btn-primary' tabindex='9' name='btnGoBack' onclick='history.back()'> Go Back </button></div>");
                abort;
            }
            objAddrBean = farmerManager.readFarmerAndAddress(#form.selectFarmer#);
        }
        else if ( structKeyExists(FORM, "btnConfirmDelete") )
        {
            boolDeleteAddrStatus = false;
            boolDeleteFarmerStatus = false;

            objAddrBean = farmerManager.readFarmerAndAddress(#form.selectFarmer#);
            boolDeleteFarmerStatus = farmerManager.delete(#objAddrBean.getFarmerID()#);
            boolDeleteAddrStatus = addressManager.delete(#objAddrBean.getAddrID()#);

        }    
    </cfscript>            



    <div class="container-fluid">
        <div class="row">
            <!--- Main body content --->
            <div class="bg-white h-100 sidebar">
                <h2 class="p-3">Delete Farmer</h2>
                <div class="container-fluid">
                    <cfif structKeyExists(FORM, "btnSelectFarmerToDelete")>  <!--- Confirm the Delete --->
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
                            <cfoutput>
                                <input name="token" type="hidden" value="#CSRFGenerateToken( forceNew=true )#">
                            </cfoutput>
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
</cfmodule>