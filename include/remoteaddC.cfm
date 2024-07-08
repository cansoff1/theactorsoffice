
<style>
    #hidden_div {
        display: none;
    }
</style>

<CFINCLUDE template="/include/remote_load.cfm" />
<cfparam name="placeholder" default="" />
<cfparam name="userid" default="0" type="integer">
<cfparam name="new_catid" default="0" type="integer">
<cfparam name="new_regionid" default="" type="string">

<cfquery name="FindUser" datasource="#dsn#">
    SELECT
    u.userid,
    u.recordname,
    u.userFirstName,
    u.userLastName,
    u.userEmail,
    u.contactid,
    u.userRole,
    u.calstarttime,
    u.calendtime,
    u.avatarname,
    u.IsBetaTester,
    u.defRows,
    u.regionid,
    u.contactid AS userContactID,
    u.tzid
    FROM taousers u
    WHERE u.userid = <cfqueryparam value="#userid#" cfsqltype="cf_sql_integer">
</cfquery>

<cfset new_catid=catid />
<cfoutput>
<cfparam name="new_countryid" default="" >
</cfoutput>

<cfparam name="valuetext" default="" >
<cfinclude template="/include/qry/countries.cfm" />
<cfinclude template="/include/qry/regions.cfm" />
<cfinclude template="/include/qry/cities.cfm" />

<cfif FindUser.regionid neq "">
    <cfset new_regionid = FindUser.regionid />

    <cfquery name="findcountryb" datasource="#dsn#" maxrows="1">
        SELECT countryid 
        FROM regions 
        WHERE regionid = <cfqueryparam value="#new_regionid#" cfsqltype="cf_sql_varchar">
    </cfquery>

    <cfif findcountryb.recordcount eq 1>
        <cfset new_countryid = findcountryb.countryid />
    </cfif>
</cfif>

<cfquery name="details" datasource="#dsn#">
    SELECT * 
    FROM itemcategory 
    WHERE catid = <cfqueryparam value="#new_catid#" cfsqltype="cf_sql_integer">
</cfquery>

<cfif new_catid eq "4">
    <cfquery name="types" datasource="#dsn#">
        SELECT i.valuetype 
        FROM itemtypes i 
        INNER JOIN itemcatxref x ON x.typeid = i.typeid 
        WHERE x.catid = 4 AND i.typeid <> 1000
        ORDER BY i.valuetype
    </cfquery>
<cfelse>
    <cfquery name="types" datasource="#dsn#">
        SELECT DISTINCT i.valuetype
        FROM itemcategory c
        INNER JOIN itemcatxref_user x ON x.catid = c.catid
        INNER JOIN itemtypes_user i ON i.typeid = x.typeid
        WHERE x.catid = <cfqueryparam value="#new_catid#" cfsqltype="cf_sql_integer"> 
        AND i.userid = <cfqueryparam value="#userid#" cfsqltype="cf_sql_integer"> 
        AND x.userid = <cfqueryparam value="#userid#" cfsqltype="cf_sql_integer">
        ORDER BY valuetype
    </cfquery>
</cfif>

<cfoutput>
    <cfset formid = "remoteAddC#new_catid#" />
</cfoutput>

<form action="/include/remoteAddCAdd.cfm" method="post" class="parsley-examples" id="#formid#" data-parsley-excluded="input[type=button], input[type=submit], input[type=reset], input[type=hidden], [disabled], :hidden"
  data-parsley-trigger="keyup" data-parsley-validate>
    <cfoutput>
        <input type="hidden" name="catid" value="#new_catid#">
        <input type="hidden" name="valueCategory" value="#details.valueCategory#">
        <input type="hidden" name="contactid" value="#contactid#">
    </cfoutput>

    <div class="row"></div>

    <cfif types.recordcount eq 1>
        <cfoutput><input type="hidden" name="valuetype" value="#types.valuetype#" /></cfoutput>
    <cfelse>
        <div class="form-group col-md-6">
            <label for="valuetext">Type<span class="text-danger">*</span></label>
            <select id="valueType" name="valueType" class="form-control" data-parsley-required data-parsley-error-message="Type is required" onchange="showDiv('hidden_div', this)">
                <option value=""></option>
                <cfoutput query="types">
                    <option value="#types.valuetype#" <cfif types.valuetype eq details.valuetypedef>selected</cfif>>
                        <cfif types.valuetype eq "Custom">*Add New Type<cfelse>#types.valuetype#</cfif>
                    </option>
                </cfoutput>
            </select>
        </div>
    </cfif>

    <div id="hidden_div" class="form-group col-md-6">
        <label for="customtype">Custom Type</label>
        <input class="form-control" type="text" id="customtype" name="customtype" value="Custom">
    </div>

    <cfset valuefieldtype = "text">

    <cfif new_catid eq "4">
        <cfset valuefieldtype = "text">
    </cfif>
    <cfif new_catid eq "10">
        <cfset valuefieldtype = "email">
    </cfif>
    <cfif new_catid eq "13">
        <cfset valuefieldtype = "date">
    </cfif>

    <cfif new_catid neq "9" and new_catid neq "2" and new_catid neq "13" and new_catid neq "1">
        <cfoutput>
            <cfif new_catid eq "4">
                <cfset placeholder = "https://www.yourwebsite.com">
            </cfif>
            <cfif new_catid eq "12">
                <cfset placeholder = "https://">
            </cfif>
            <cfif new_catid eq "5">
                <cfset placeholder = "https://">
            </cfif>
            <cfset minlength = "3">
            <div class="form-group col-md-12">
                <label for="valuetext">#details.recordname#<span class="text-danger">*</span></label>
                <input class="form-control" type="#valuefieldtype#" placeholder="#placeholder#" id="valuetext" value="#valuetext#" name="valuetext"
                    data-parsley-maxlength="800" data-parsley-maxlength-message="Max length 800 characters"
                    <cfif new_catid neq "4">placeholder="Enter #details.recordname#"</cfif>
                >
            </div>
        </cfoutput>
    </cfif>

    <cfif new_catid eq "1">
        <cfoutput>
            <div class="form-group col-md-12">
                <label for="valuetext">#details.recordname#<span class="text-danger">*</span></label>
                <input class="form-control" type="text" id="valuetext" name="valuetext" placeholder="Enter #details.recordname#">
            </div>
        </cfoutput>
    </cfif>

    <cfif new_catid eq "1sfdfdsf">
        <cfoutput>
            <div class="form-group col-md-12">
                <label for="valuetext">#details.recordname#</label>
                <input id="phone" type="tel">
                <span id="valid-msg" class="hide">Valid</span>
                <span id="error-msg" class="hide"></span>
            </div>
        </cfoutput>
    </cfif>

    <cfif new_catid eq "2">
        <cfoutput>
            <div class="form-group col-md-12">
                <label for="valueStreetAddress">Address<span class="text-danger">*</span></label>
                <input class="form-control" type="text" id="valueStreetAddress" name="valueStreetAddress"
                    data-parsley-minlength="5" data-parsley-minlength-message="Min length 5 characters"
                    data-parsley-maxlength="800" data-parsley-maxlength-message="Max length 800 characters"
                    data-parsley-required data-parsley-error-message="Street is required"
                    placeholder="Enter Street">
            </div>

            <div class="form-group col-md-12">
                <label for="valueExtendedAddress">Extended Address</label>
                <input class="form-control" type="text" id="valueExtendedAddress" name="valueExtendedAddress" placeholder="Enter Street">
            </div>

            <div class="form-group col-md-6">
                <label for="valuetext">Town/City</label>
                <input class="form-control" type="text" id="valueCity" name="valueCity" placeholder="Enter City">
            </div>
        </cfoutput>

        <div class="form-group col-md-6">
            <label for="valuetext">Postal Code</label>
            <input class="form-control" type="text" id="valuePostalCode" name="valuePostalCode" placeholder="Enter Postal Code">
        </div>

   




   
<div class="form-group col-md-6">
    <label for="countryid">Country<span class="text-danger">*</span></label>
    <select id="countryid" class="form-control" name="countryid" data-parsley-required data-parsley-error-message="Country is required">
        <option value="">--</option>
        <cfoutput query="countries">
            <option value="#countries.countryid#" <cfif countries.countryid eq new_countryid>selected</cfif>>#countries.countryname#</option>
        </cfoutput>
    </select>
</div>

<div class="form-group col-md-6">
    <label for="regionid">State/Region<span class="text-danger">*</span></label>
    <select id="regionid" name="regionid" class="form-control">
        <option value="">--</option>
    </select>
</div>

    <cfif new_catid eq "13">
        <div class="form-group col-md-12">
            <label for="itemDate">Important Date<span class="text-danger">*</span></label>
            <input class="form-control" id="itemDate" type="date" name="itemDate" data-parsley-required data-parsley-error-message="Date is required">
        </div>
    </cfif>

    <cfif new_catid eq "9">
        <cfquery name="companies" datasource="#dsn#">
            SELECT DISTINCT i.valueCompany as new_valuecompany
            FROM contactitems i
            INNER JOIN contactdetails d ON d.contactid = i.contactid
            WHERE i.VALUEcategory = 'company' AND d.userid = <cfqueryparam value="#userid#" cfsqltype="cf_sql_integer">
            AND i.valuecompany <> '' AND i.valueCompany IS NOT NULL
            AND i.valuecompany <> 'Custom'
            ORDER BY i.valuecompany
        </cfquery>

 
<div class="form-group col-md-12">
  <CFoutput>  <label for="valueCompany">#details.recordname# Name<span class="text-danger">*</span></label></cfoutput>
    <select id="valueCompany" name="valueCompany" class="form-control" data-parsley-required data-parsley-error-message="Name is required." onchange="toggleCustomField(this)">
        <option value="" selected></option>
        <option value="custom">***ADD NEW***</option>
        <cfoutput query="companies">
            <option value="#companies.new_valuecompany#">#companies.new_valuecompany#</option>
        </cfoutput>
    </select>
</div>

<script>
    function toggleCustomField(select) {
        var customField = document.getElementById('special');
        customField.style.display = select.value === 'custom' ? 'block' : 'none';
    }

    window.onload = function() {
        toggleCustomField(document.getElementById('valueCompany'));
    };
</script>

<cfoutput>
<div class="form-group col-md-12" id="special" style="display: none;">
    <label for="custom">Custom Name</label>
    <input class="form-control" type="text" id="custom" name="custom" value="" placeholder="Enter Custom #details.recordname#">
</div>
</cfoutput>

        <script>
            window.onload = function() {
                // Adjust visibility based on the initial value of the select field
                toggleCustomField(document.getElementById('valueCompany'));
            };

            function toggleCustomField(select) {
                var isCustomSelected = select.value === 'custom';
                document.getElementById('special').style.display = isCustomSelected ? 'block' : 'none';
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
    </cfif>

    <div class="form-group text-center col-md-12">
        <button class="btn btn-primary editable-submit btn-sm waves-effect waves-light" type="submit" style="background-color: #406e8e; border: #406e8e;">Add</button>
    </div>
</form>

<cfif new_catid eq "1665">
    <script src="/app/assets/js/intlTelInput.js"></script>
    <script>
        var input = document.querySelector("#phone"),
        errorMsg = document.querySelector("#error-msg"),
        validMsg = document.querySelector("#valid-msg");

        var errorMap = ["Invalid number", "Invalid country code", "Too short", "Too long", "Invalid number"];

        var iti = window.intlTelInput(input, {
            utilsScript: "https://cdn.jsdelivr.net/npm/intl-tel-input@17.0.3/build/js/utils.js"
        });

        var reset = function() {
            input.classList.remove("error");
            errorMsg.innerHTML = "";
            errorMsg.classList.add("hide");
            validMsg.classList.add("hide");
        };

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

        input.addEventListener('change', reset);
        input.addEventListener('keyup', reset);
    </script>
</cfif>

<script>
    $(document).ready(function() {
        $(".parsley-examples").parsley();
    });
</script>

<script>
    function showDiv(divId, element) {
        document.getElementById(divId).style.display = element.value == "Custom" ? 'block' : 'none';
    }
</script>



<script>
$(document).ready(function(){
    // Store the regions data in a variable
    var regions = [
        <cfoutput query="regions">
        {countryid: '#regions.countryid#', regionid: '#regions.regionid#', regionname: '#regions.regionname#'}<cfif regions.currentRow neq regions.recordCount>,</cfif>
        </cfoutput>
    ];

    
    // Function to populate the states based on selected country
    function populateRegions(countryid) {
        var regionSelect = $('#regionid');
        regionSelect.empty();
        regionSelect.append('<option value="">--</option>');
        $.each(regions, function(index, region) {
            if(region.countryid == countryid) {
                regionSelect.append('<option value="' + region.regionid + '">' + region.regionname + '</option>');
            }
        });
    }

    // Event listener for country select change
    $('#countryid').on('change', function() {
        var selectedCountryId = $(this).val();
        populateRegions(selectedCountryId);
    });

    // Initialize the regions based on the pre-selected country if any
    var initialCountryId = $('#countryid').val();
    if(initialCountryId) {
        populateRegions(initialCountryId);
    }
});
</script>

<cfset script_name_include="/include/#ListLast(GetCurrentTemplatePath(), '\')#" />
<cfinclude template="/include/bigbrotherinclude.cfm">