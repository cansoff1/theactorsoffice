<cfinclude template="/include/remote_load.cfm" />
<cfinclude template="/include/qry/countries.cfm" />
<cfinclude template="/include/qry/regions.cfm" />

<cfquery name="details" datasource="#dsn#">
    SELECT i.itemid
    ,i.contactid
    ,i.valueType
    ,i.valueCategory
    ,i.valueText
    ,i.valueCompany
    ,i.valueDepartment
    ,i.valueTitle
    ,i.valueStreetAddress
    ,i.valueExtendedAddress
    ,i.valueCity
    ,i.valueRegion
    ,i.itemdate
    ,i.itemnotes
    ,i.itemstatus
    ,i.valueCountry
    ,i.valuePostalCode
    ,c.catid
    ,c.caticon
    ,c.recordname
    ,c.catfieldset
    FROM contactitems i

    INNER JOIN itemcategory c ON c.valuecategory = i.valuecategory WHERE i.itemid = #itemid#
</cfquery>


<cfparam name="new_countryid" default="" />
<cfparam name="new_regionid" default="" />


<cfquery name="findcountry" datasource="#dsn#">
    select * from countries where countryname = '#details.valuecountry#'
</cfquery>

<cfif #findcountry.recordcount# is "1">
    <cfset new_countryid=findcountry.countryid />
</cfif>

<cfquery name="findregion" datasource="#dsn#">
    select regionid from regions where regionname = '#details.valueregion#'
</cfquery>

<cfif #findregion.recordcount# is "1">
    <cfset new_regionid=findregion.regionid />
</cfif>



<cfset new_catid=details.catid />


<cfquery name="types" datasource="#dsn#">
    SELECT distinct i.valuetype
    FROM itemcategory c

    inner join itemcatxref_user x ON x.catid = c.catid

    INNER JOIN itemtypes_user i ON i.typeid = x.typeid

    WHERE x.catid = #new_catid# and i.userid = #userid# and x.userid = #userid#

    ORDER BY valuetype
</cfquery>

<cfoutput>
    <cfset formid="remoteupdate#itemid#" />

</cfoutput>

<form action="/include/remoteUpdateCUpdate.cfm" method="post" class="parsley-examples" id="<cfoutput>#formid#</cfoutput>" data-parsley-excluded="input[type=button], input[type=submit], input[type=reset], input[type=hidden], [disabled], :hidden" data-parsley-trigger="keyup" data-parsley-validate>
    <cfoutput>
        <input type="hidden" name="catid" value="#new_catid#">
        <input type="hidden" name="itemid" value="#details.itemid#">
        <input type="hidden" name="contactid" value="#details.contactid#">
    </cfoutput>


    <div class="row" />
    <cfif #types.recordcount# is "1">

        <cfoutput><input type="hidden" name="valuetype" value="#types.valuetype#" /></cfoutput>
        <cfelse>

            <div class="form-group col-md-6">
                <label for="valuetext">Type <span class="text-danger">*</span></label>

                <select id="valueType" name="valueType" class="form-control" data-parsley-required data-parsley-error-message="Type is required" onchange="showDiv('hidden_div', this)">


                    <option value=""></option>
                    <cfoutput query="types">
                        <option value="#types.valuetype#" <cfif #types.valuetype# is "#details.valueType#"> Selected
    </cfif>>#types.valuetype#</option>


    </cfoutput>
    </select>




    </div>


    </cfif>


    <div id="hidden_div" class="form-group col-md-6">
        <label for="customtype">Custom Type</label>

        <input class="form-control" type="text" id="customtype" name="customtype" placeholder="Add a custom type">

    </div>

    <cfset valuefieldtype="text">

        <cfif #new_catid# is "10">

            <cfset valuefieldtype="email" />

        </cfif>

        <cfif #new_catid# is "13">

            <cfset valuefieldtype="date" />

        </cfif>

        <Cfif #new_catid# is not "9" and #new_catid# is not "2" and #new_catid# is not "13" and #new_catid# is not "1">



            <cfoutput>
                <cfset minlength="3" />
                <cfif #new_catid# is "4">
                    <cfset minlength="3" />
                </cfif>

                <cfif #new_catid# is "5">
                    <cfset minlength="14" />
                </cfif>



                <div class="form-group col-md-12">
                    <label for="valuetext">#details.recordname#<span class="text-danger">*</span></label>

                    <input class="form-control" type="#valuefieldtype#" id="valuetext" name="valuetext" value="#details.valuetext#" data-parsley-minlength="#minlength#" data-parsley-minlength-message="Min length #minlength# characters" data-parsley-maxlength="800" data-parsley-maxlength-message="Max length 800 characters" data-parsley-required data-parsley-error-message="Valid #details.recordname# is required" placeholder="Enter #details.recordname#">


                </div>




            </cfoutput>


        </Cfif>




        <Cfif #new_catid# is "1">
            <cfoutput>




                <div class="form-group col-md-12">
                    <label for="valuetext">#details.recordname#<span class="text-danger">*</span></label>

                    <input class="form-control" type="text" id="valuetext" name="valuetext" value="#details.valuetext#" data-parsley-minlength="7" data-parsley-minlength-message="Min length 7 characters" data-parsley-maxlength="25" data-parsley-maxlength-message="Max length 25 characters" data-parsley-pattern="^[\d\+\-\.\(\)\/\s]*$" data-parsley-pattern-message="Must be a valid phone number (no letters)" data-parsley-required placeholder="Enter #details.recordname#">


                </div>




            </cfoutput>






        </Cfif>





        <Cfif #new_catid# is "2">
            <cfoutput>

                <div class="form-group col-md-12">
                    <label for="valueStreetAddress">Address<span class="text-danger">*</span></label>

                    <input class="form-control" type="text" id="valueStreetAddress" value="#details.valueStreetAddress#" name="valueStreetAddress" data-parsley-minlength="2" data-parsley-minlength-message="Min length 3 characters" data-parsley-maxlength="100" data-parsley-maxlength-message="Max length 100 characters" data-parsley-required data-parsley-error-message="Street is required" placeholder="Enter Street">


                </div>



                <div class="form-group col-md-12">
                    <label for="valueExtendedAddress">Extended Address</label>

                    <input class="form-control" type="text" id="valueExtendedAddress" value="#details.valueExtendedAddress#" name="valueExtendedAddress" placeholder="Enter Street">


                </div>


                <div class="form-group col-md-6">
                    <label for="valuetext">Town/City</label>

                    <input class="form-control" type="text" id="valueCity" value="#details.valuecity#" name="valueCity" placeholder="Enter City">


                </div>



                <div class="form-group col-md-6">
                    <label for="valuetext">Postal Code</label>

                    <input class="form-control" type="text" id="valuePostalCode" value="#details.valuePostalCode#" name="valuePostalCode" placeholder="Enter Postal Code">


                </div>
            </cfoutput>





            <div class="form-group col-md-6">
                <label for="countryid">Country<span class="text-danger">*</span></label>

                <select id="countryid" class="form-control" name="countryid" data-parsley-required data-parsley-error-message="Country is required">
                    <option value="">--</option>
                    <cfoutput query="countries">
                        <option value="#countries.countryid#" <cfif #countries.countryid# is "#new_countryid#"> selected
        </cfif>>#countries.countryname# </option>
        </cfoutput>
        </select>




        </div>



        <div class="form-group col-md-6">
            <label for="regionid">State/Region<span class="text-danger">*</span></label>

            <select id="regionid" name="regionid" class="form-control">
                <option value="">--</option>

                <cfoutput query="regions">
                    <option value="#regions.regionid#" data-chained="#regions.countryid#" <cfif #regions.regionid# is "#new_regionid#"> selected</cfif> >#regions.regionname#</option>
                </cfoutput>

            </select>


        </div>










        </Cfif>









        <Cfif #new_catid# is "13">


            <cfoutput>

                <div class="form-group col-md-12">
                    <label for="itemDate">Important Date<span class="text-danger">*</span></label>

                    <input class="form-control" id="itemDate" data-parsley-required data-parsley-error-message="Date is required" type="date" value="#details.itemdate#" name="itemDate">

                </div>
            </cfoutput>


        </cfif>










        <Cfif #new_catid# is "9">

            <cfquery name="companies" datasource="#dsn#">
                SELECT DISTINCT i.valueCompany as new_valuecompany
                FROM contactitems i
                INNER JOIN contactdetails d ON d.contactid = i.contactid
                WHERE i.VALUEcategory = 'company' AND d.userid = #userid#
                AND i.valuecompany <> '' 
                AND i.valueCompany IS NOT NULL
                and i.valuecompany <> 'Custom'
                    ORDER BY i.valuecompany
            </cfquery>
            <cfoutput>



                <div class="form-group col-md-12">
                    <label for="valueCompany">#details.recordname# Name<span class="text-danger">*</span></label>
            </cfoutput>

            <select id="valueCompany" name="valueCompany" class="form-control" data-parsley-required data-parsley-error-message="Name is required." onchange="if (this.value=='custom'){this.form['custom'].style.visibility='visible'} else {this.form['custom'].style.visibility='hidden'};">


                <option value=""></option>
                <cfoutput query="companies">
                    <option value="#companies.new_valuecompany#" <cfif #companies.new_valuecompany# is "#details.valuecompany#"> selected
        </cfif>>#companies.new_valuecompany# </option>


        </cfoutput>
        <option value="custom">Custom</option>

        </select>

        </div>


        <div class="form-group col-md-12" id="special" style="visibility:hidden">
            <cfoutput>


                <input class="form-control" type="text" id="custom" name="custom" style="visibility:hidden;" value="" placeholder="Enter Custom #details.recordname#">


        </div>



        <div class="form-group col-md-12">
            <label for="valuetext">Department</label>

            <input class="form-control" type="text" id="valueDepartment" name="valueDepartment" value="#details.valueDepartment#" placeholder="Enter Department">


        </div>





        <div class="form-group col-md-12">
            <label for="valuetext">Title</label>

            <input class="form-control" type="text" id="valuetitle" name="valuetitle" value="#details.valuetitle#" placeholder="Enter Title">


        </div>






        </cfoutput>



        </Cfif>


        <div class="form-group col-md-12">

            <div class="custom-control custom-checkbox">


                <label class="custom-control-label">
                    <input type="checkbox" class="custom-control-input" id="deleteitem" value="1" name="deleteitem">
                    <span class="custom-control-label" for="deleteitem">Delete</span></label>
            </div>


        </div>


        <div class="form-group text-center col-md-12">
            <button class=" btn btn-primary editable-submit btn-sm waves-effect waves-light" type="submit" style="background-color: #406e8e; border: #406e8e;">Update</button>
        </div>



        </div>
</form>
<script>
    $("#regionid").chained("#countryid");

</script>
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


<cfset script_name_include="/include/#ListLast(GetCurrentTemplatePath(), " \")#" />
<cfinclude template="/include/bigbrotherinclude.cfm" />
