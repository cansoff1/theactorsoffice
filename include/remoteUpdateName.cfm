<CFINCLUDE template="/include/remote_load.cfm" />

<cfquery name="pronouns" datasource="#dsn#">
    SELECT genderPronoun FROM genderpronouns_users where userid = #userid#
</cfquery>

<cfquery name="refers" datasource="#dsn#">
    SELECT * FROM contactdetails where userid = #userid# order by contactfullname
</cfquery>

<cfquery name="details" datasource="#dsn#">
    SELECT * from contactdetails where contactid = #contactid#
</cfquery>


<form action="/include/remoteUpdateNameUpdate.cfm" method="post" class="parsley-examples" id="profile-form" data-parsley-excluded="input[type=button], input[type=submit], input[type=reset], input[type=hidden], [disabled], :hidden" data-parsley-trigger="keyup" data-parsley-validate>
    <cfoutput>

        <input type="hidden" name="contactid" value="#details.contactid#">
    </cfoutput>


    <div class="row" />




    <cfoutput>




        <div class="form-group col-md-12">
            <label for="contactfullname">Name<span class="text-danger">*</span></label>
            
      

            <input class="form-control" type="text" id="contactfullname" name="contactfullname" value="#details.contactfullname#" data-parsley-maxlength="500" data-parsley-maxlength-message="Max length 500 characters" data-parsley-required data-parsley-error-message="Valid Name is required" placeholder="Enter Name">


        </div>





        <div class="form-group col-sm-6 mb-6">
            <label for="simpleinput">Next Birthday</label>


            <input class="form-control" id="contactbirthday" value="#details.contactbirthday#" type="date" name="contactbirthday">

        </div>



        <div class="form-group col-sm-6 mb-6">
            <label for="simpleinput">Initial Meeting Date</label>


            <input class="form-control" id="contactmeetingdate" value="#details.contactmeetingdate#" type="date" name="contactmeetingdate">
        </div>

        <div class="form-group col-sm-6 mb-6">
            <label for="contactmeetingloc">Initial Meeting Location</label>


            <input class="form-control" id="contactmeetingloc" type="text" name="contactmeetingloc" value="#details.contactmeetingloc#">
        </div>



    </cfoutput>

    <div class="form-group col-sm-6 mb-6">


        <label for="contactPronoun">Gender Pronoun</label>

        <select id="contactPronoun" name="contactPronoun" class="form-control" onchange="if (this.value=='custom'){this.form['custom'].style.visibility='visible',this.form['custom'].required=true}else {this.form['custom'].style.visibility='hidden',this.form['custom'].required=false};">


            <option value="">Select a Pronoun</option>
            <cfoutput query="pronouns">
                <option value="#pronouns.genderPronoun#" <cfif #pronouns.genderPronoun# is "#details.contactPronoun#"> Selected</cfif>>#pronouns.genderPronoun#</option>


            </cfoutput>
    <option value="custom">Custom</option>
        </select>



    </div>

      <div class="form-group col-sm-6 mb-6">


        <label for="refer_contact_id">Referred By</label>

        <select id="refer_contact_id" name="refer_contact_id" class="form-control" style="width:100%;" >


            <option value="">Select a Relationship</option>
            <cfoutput query="refers">
                <option value="#refers.contactid#" <cfif "#refers.contactid#" is "#details.refer_contact_id#"> selected</cfif>>#refers.contactfullname#</option>


            </cfoutput>
        
        </select>



    </div>

    <div class="form-group col-sm-6 mb-6">
        

        
 <div class="input-group">
<input class="form-control" type="text"  name="custom" id="custom" style="visibility:hidden;"   data-parsley-maxlength="50"  placeholder="Add a Gender Pronoun in single/plural format.">
       

 
</div>

      

 


    </div>

  




<input type="hidden" name="deleteitem" value="0" />




    <div class="form-group text-center col-md-12">
        <button class=" btn btn-primary editable-submit btn-sm waves-effect waves-light" type="submit" style="background-color: #406e8e; border: #406e8e;">Update</button>
    </div>



    </div>
</form>
<script>
    $(document).ready(function() {
        $(".parsley-examples").parsley()
    });

</script>





<cfset script_name_include="/include/#ListLast(GetCurrentTemplatePath(), " \")#" />
<cfinclude template="/include/bigbrotherinclude.cfm" />
