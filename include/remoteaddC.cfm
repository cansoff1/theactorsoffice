<style>
    #hidden_div {
        display: none;
    }
</style>

<CFINCLUDE template="/include/remote_load.cfm" />
<cfparam name="placeholder" default="" />

<cfquery name="FindUser" datasource="#dsn#">
    SELECT
    u.userid
    ,u.recordname
    ,u.userFirstName
    ,u.userLastName
    ,u.userEmail
    ,u.contactid
    ,u.userRole
    ,u.calstarttime
    ,u.calendtime
    ,u.avatarname
    ,u.IsBetaTester
    ,u.defRows
    ,u.regionid
    ,u.contactid AS userContactID
    ,u.tzid
    FROM taousers u
    WHERE u.userid = #userid#
</cfquery>


<cfset new_catid=catid />
<Cfoutput>
<cfparam name="new_regionid" default="" >
    <cfparam name="new_countryid" default="" >
        
         
        
        </Cfoutput>
        
        
    <cfparam name="valuetext" default="" >
    <cfinclude template="/include/qry/countries.cfm" />
       <cfinclude template="/include/qry/regions.cfm" />
          <cfinclude template="/include/qry/cities.cfm" />
        
        

<cfif #FindUser.regionid# is not "">

    <cfset new_regionid = FindUser.regionid />
 
    <cfquery name="findcountryb" datasource="#dsn#" maxrows="1">
    select countryid from regions where regionid = '#new_regionid#'
    </cfquery>    
            
    <cfif #findcountryb.recordcount# is "1">
         
        <cfset new_countryid = findcountryb.countryid />
 
    </cfif>
  
 
</cfif>


      
        
        
        
        
        
        
        
        
        
        
 <cfquery name="details" datasource="#dsn#">
     select * from itemcategory where catid = #new_catid#
 </cfquery>
        
        <cfif #new_catid# is "4">
         <cfquery name="types" datasource="#dsn#">
 SELECT i.valuetype FROM itemtypes i INNER JOIN itemcatxref x ON x.typeid = i.typeid WHERE x.catid = 4 AND i.typeid <> 1000
 ORDER BY i.valuetype
 </cfquery>
        
        <cfelse>
           <cfquery name="types" datasource="#dsn#">
     SELECT distinct i.valuetype
     FROM itemcategory c

     inner join itemcatxref_user x ON x.catid = c.catid

     INNER JOIN itemtypes_user i ON i.typeid = x.typeid

     WHERE x.catid = #new_catid# and i.userid = #userid# and x.userid = #userid#

     ORDER BY valuetype
 </cfquery>  
            
            
        </cfif>

<cfoutput>
        <cfset formid = "remoteAddC#new_catid#" />
</cfoutput>

 <form action="/include/remoteAddCAdd.cfm" method="post" class="parsley-examples"  id="<Cfoutput>#formid#</cfoutput>" data-parsley-excluded="input[type=button], input[type=submit], input[type=reset], input[type=hidden], [disabled], :hidden"
  data-parsley-trigger="keyup" data-parsley-validate>
     <cfoutput>
         <input type="hidden" name="catid" value="#new_catid#">
      <input type="hidden" name="valueCategory" value="#details.valueCategory#">
         <input type="hidden" name="contactid" value="#contactid#">
     </cfoutput>


     <div class="row" />
     
     <cfif #types.recordcount# is "1">
         
         <cfoutput><input type="hidden" name="valuetype" value="#types.valuetype#" /></cfoutput>
         <cfelse>


     <div class="form-group col-md-6">
         <label for="valuetext">Type<span class="text-danger">*</span></label>




         <select id="valueType" name="valueType" class="form-control" data-parsley-required data-parsley-error-message="Type is required"    onchange="showDiv('hidden_div', this)">


             <option value=""></option>
             <cfoutput query="types">
 
                 <option value="#types.valuetype#" <cfif #types.valuetype# is "#details.valuetypedef#"> selected </cfif>><cfif #types.valuetype# is "Custom">*Add New Type<Cfelse>#types.valuetype#</cfif></option>
  
 
             </cfoutput>
         </select>




     </div>


             </cfif>
 
                            <div id="hidden_div" class="form-group col-md-6">
          <label for="customtype">Custom Type</label>

                    
                    
                    

          <input class="form-control" type="text" id="customtype" name="customtype"  value="Custom" >




           
                </div>
 
        <cfset valuefieldtype = "text">
            
              <cfif #new_catid# is "4">
                  <cfset valuefieldtype = "text" />
            </cfif>
            
            <cfif #new_catid# is "10">
                
                <cfset valuefieldtype = "email" />
                
            </cfif>
            
            <cfif #new_catid# is "13">
                
                <cfset valuefieldtype = "date" />
                
            </cfif>

     <Cfif #new_catid# is not "9" and #new_catid# is not "2" and #new_catid# is not "13"  and #new_catid# is not "1">
         <cfoutput>

             
<cfif #new_catid# is "4">
    <cfset placeholder = "https://www.yourwebsite.com" />
             
             </cfif>
             
         <cfif #new_catid# is "12">
    <cfset placeholder = "https://" />
             
             </cfif>    
             
<cfif #new_catid# is "5">
    <cfset placeholder = "https://" />
             
             </cfif>
             
             
              <cfset minlength = "3" />

   
             
             

             <div class="form-group col-md-12">
                 <label for="valuetext">#details.recordname#<span class="text-danger">*</span></label>

                 <input class="form-control" type="#valuefieldtype#" placeholder="#placeholder#" id="valuetext" value="#valuetext#" name="valuetext" 
   
       
                data-parsley-maxlength="800" 
                data-parsley-maxlength-message="Max length 800 characters" 
 
             
             <cfif #new_catid# is not "4">
                placeholder="Enter #details.recordname#"
             </cfif>
             >

        
             </div>




         </cfoutput>


     </Cfif>
            
            
                         
     <Cfif #new_catid# is "1">
             <cfoutput>
        
        

    
                <div class="form-group col-md-12">
          <label for="valuetext">#details.recordname#<span class="text-danger">*</span></label>
 
          <input class="form-control" type="text" id="valuetext" name="valuetext"  
                   
                 placeholder="Enter #details.recordname#">
 
        
                </div>
    
    
    

    </cfoutput>
         
         
         
         
         
         
                </Cfif>
            
            
            
            
     
        <Cfif #new_catid# is "1sfdfdsf">
            
            <cfoutput>
        
             <div class="form-group col-md-12">
                 <label for="valuetext">#details.recordname#</label>

                 <input id="phone" type="tel">
         <span id="valid-msg" class="hide">
              <span id="valid-msg" class="hide">Valid</span>
<span id="error-msg" class="hide"></span>
             </div>




         </cfoutput>    
            
            
     </Cfif>

     <Cfif #new_catid# is "2">
         <cfoutput>

             <div class="form-group col-md-12">
                 <label for="valueStreetAddress">Address<span class="text-danger">*</span></label>

                 <input class="form-control" type="text" id="valueStreetAddress" name="valueStreetAddress" 
                        data-parsley-minlength="5" 
                        data-parsley-minlength-message="Min length 5 characters" 
                        data-parsley-maxlength="800" 
                        data-parsley-maxlength-message="Max length 800 characters" 
                        data-parsley-required data-parsley-error-message="Street is required"
                        
                        placeholder="Enter Street">

                
             </div>

             
             
                <div class="form-group col-md-12">
                 <label for="valueExtendedAddress">Extended Address</label>

                 <input class="form-control" type="text" id="valueExtendedAddress"  name="valueExtendedAddress" placeholder="Enter Street">

             
             </div>          
             
             
               <div class="form-group col-md-6">
                 <label for="valuetext">Town/City</label>

                 <input class="form-control" type="text" id="valueCity"  name="valueCity" placeholder="Enter City">

                
             </div>           
             
         </cfoutput>
         
         
                 
               <div class="form-group col-md-6">
                 <label for="valuetext">Postal Code</label>

                 <input class="form-control" type="text" id="valuePostalCode"   name="valuePostalCode" placeholder="Enter Postal Code">

             </div>                      
        
             
      
         
         
         
                        <div class="form-group col-md-6">
                            <label for="countryid">Country<span class="text-danger">*</span></label>

<select id="countryid" class="form-control" name="countryid"  data-parsley-required data-parsley-error-message="Country is required">
    <option value="">--</option>
    <cfoutput query="countries" >
        <option value="#countries.countryid#"   <cfif #countries.countryid# is "#new_countryid#">selected </cfif> >#countries.countryname#</option>
</cfoutput>
</select>
                



                        </div>
        
        


                        <div class="form-group col-md-6">
                            <label for="regionid">State/Region<span class="text-danger">*</span></label>

            <select id="regionid" name="regionid" class="form-control" >
    <option value="">--</option>

     <cfoutput query="regions" >
         <option value="#regions.regionid#"  data-chained="#regions.countryid#" <cfif #regions.regionid# is "#new_regionid#">selected </cfif>   >#regions.regionname#</option>
</cfoutput>

</select>


                        </div>




         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         





     </Cfif>
     

         <Cfif #new_catid# is "13">
  




                 <div class="form-group col-md-12">
                     <label for="itemDate">Important Date<span class="text-danger">*</span></label>

                             <input class="form-control" id="itemDate"  type="date" name="itemDate" data-parsley-required data-parsley-error-message="Date is required"  >

                 </div>


             </cfif>
         <Cfif #new_catid# is "9">
             
             
                         <cfquery name="companies" datasource="#dsn#">
                SELECT DISTINCT i.valueCompany as new_valuecompany
                FROM contactitems i
                INNER JOIN contactdetails d ON d.contactid = i.contactid
                WHERE i.VALUEcategory = 'company' AND d.userid = #userid#
                AND i.valuecompany <> '' AND i.valueCompany IS NOT NULL
                and i.valuecompany <> 'Custom'
                    ORDER BY i.valuecompany
            </cfquery>
             
             
             
             
             
             
             
             
             
     <cfoutput>
    <div class="form-group col-md-12">
        <label for="valueCompany">#details.recordname# Name<span class="text-danger">*</span></label>
    </div>
</cfoutput>
    <!-- Select Dropdown -->
    <select id="valueCompany" name="valueCompany" class="form-control" data-parsley-required data-parsley-error-message="Name is required." onchange="toggleCustomField(this);">
        <option value=""></option>
        <option value="custom" selected>***ADD NEW***</option>
        <cfoutput query="companies">
            <option value="#companies.new_valuecompany#">#companies.new_valuecompany#</option>
        </cfoutput>
    </select>
</cfoutput>

<cfoutput>
    <!-- Custom Text Field -->
    <div class="form-group col-md-12" id="special" style="visibility:visible;">
        <input class="form-control" type="text" id="custom" name="custom" style="visibility:visible;" value="" placeholder="Enter Custom #details.recordname#">
    </div>
</cfoutput>

<script>
    function toggleCustomField(select) {
        var isCustomSelected = select.value === 'custom';
        var customField = document.getElementById('special');
        customField.style.visibility = isCustomSelected ? 'visible' : 'hidden';
    }
</script>



                 <div class="form-group col-md-12">
                     <label for="valuetext">Department</label>

                     <input class="form-control" type="text" id="valueDepartment" name="valueDepartment" placeholder="Enter Department">

                    
                 </div>





                 <div class="form-group col-md-12">
                     <label for="valuetext">Title</label>

                     <input class="form-control" type="text" id="valuetitle" name="valuetitle" placeholder="Enter Title">

                  
                 </div>

           
                  

         </Cfif>

   


         <div class="form-group text-center col-md-12">
             <button class=" btn btn-primary editable-submit btn-sm waves-effect waves-light" type="submit" style="background-color: #406e8e; border: #406e8e;">Add</button>
         </div>



         </div>
 </form>




<cfif #new_catid# is "1665">
<script src="/app/assets/js/intlTelInput.js"></script>

    <script>
    var input = document.querySelector("#phone"),
  errorMsg = document.querySelector("#error-msg"),
  validMsg = document.querySelector("#valid-msg");

// here, the index maps to the error code returned from getValidationError - see readme
var errorMap = ["Invalid number", "Invalid country code", "Too short", "Too long", "Invalid number"];

// initialise plugin
var iti = window.intlTelInput(input, {
  utilsScript: "https://cdn.jsdelivr.net/npm/intl-tel-input@17.0.3/build/js/utils.js"
});

var reset = function() {
  input.classList.remove("error");
  errorMsg.innerHTML = "";
  errorMsg.classList.add("hide");
  validMsg.classList.add("hide");
};

// on blur: validate
input.addEventListener('blur', function() {
  reset();
  if (input.value.trim()) {
    if (iti.isValidNumber()) {
      validMsg.classList.remove("hide");
    } else {
      input.classList.add("error");
      var errorCode = iti.getValidationError();
      errorMsg.innerHTML = errorMap[errorCode];
      errorMsg.classList.remove("hide");
    }
  }
});

// on keyup / change flag: reset
input.addEventListener('change', reset);
input.addEventListener('keyup', reset);
    </script>
    

</cfif>
        
    <script>      
 $(document).ready(function() {
    $(".parsley-examples").parsley()
});
 </script>     

        
        

<script>
    function showDiv(divId, element) {
        document.getElementById(divId).style.display = element.value == "Custom" ? 'block' : 'none';
    }

</script>



        
        
<cfset script_name_include="/include/#ListLast(GetCurrentTemplatePath(), "\")#" /><cfinclude template="/include/bigbrotherinclude.cfm" /> 
