<script>
$(document).keypress(function (e) {
    if (e.which == 13 && e.target.nodeName != "TEXTAREA") {
        event.preventDefault();
        return false;
    }
});
</script>

<script>
function unlock(){
    document.getElementById('buttonSubmit').removeAttribute("disabled");
}
</script>

<cfparam name="dir" default="account" />
<cfparam name="audprojectid" default="0" />

<CFINCLUDE template="/include/remote_load.cfm" />
<cfparam name="placeholder" default="" />
<cfparam name="audid" default="" />
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
    
    
    ,u.contactid AS userContactID
    ,u.tzid
    FROM taousers u
    WHERE u.userid = '#session.userid#'
</cfquery>

<cfinclude template="/include/qry/materials_details.cfm" />

   <cfquery datasource="#dsn#" name="Type"  >             
SELECT mediatypeid,mediatype from audmediatypes WHERE mediatype <> 'Headshot' and isdeleted = 0
                </cfquery>  

 
 <form action="/include/remoteUpdateMaterial2.cfm" method="post" class="parsley-examples" enctype="multipart/form-data" id="upload" data-parsley-excluded="input[type=button], input[type=submit], input[type=reset], input[type=hidden], [disabled], :hidden"
  data-parsley-trigger="keyup" data-parsley-validate>


     <div class="row" />

     <cfset placeholder="https://" />

     <cfset minlength="3" />
     
<cfoutput query="materials_details" >
 
    <div class="form-group col-md-6 col-sm-12">
    <label for="new_mediatypeid">Media Type<span class="text-danger">*</span></label>
<input type="hidden" name="audprojectid" value="#audprojectid#" />
<input type="hidden" name="dir" value="#dir#" />
</cfoutput>


    <select id="new_mediatypeid" name="new_mediatypeid" class="form-control" data-parsley-required data-parsley-error-message="Media Type is required">
     
 
        <cfoutput query="type">
            <option value="#type.mediatypeid#" <cfif  "#type.mediatypeid#" is "#materials_details.mediatypeid#">selected</cfif>  >#type.mediatype#</option>
        </cfoutput>

    </select>


</div>


<cfoutput query="materials_details" >
<input type="hidden" name="new_mediaid" value="#materials_details.mediaid#" />




            <div class="form-group col-md-12">

         <label for="new_medianame">Name</label>

         <input class="form-control" type="text" id="new_medianame" name="new_medianame" data-parsley-maxlength="800" data-parsley-maxlength-message="Max length 800 characters" value="#materials_details.medianame#"   placeholder="Add a name/brief description">


     </div>




               <div class="form-group col-md-12">

         <label for="new_medialoc">URL</label>

         <input class="form-control" type="text" id="new_mediaurl" name="new_mediaurl" data-parsley-maxlength="800" data-parsley-maxlength-message="Max length 800 characters"  value="#materials_details.mediaurl#"    placeholder="Add a URL">


     </div>


     
    <div class="form-group col-md-6 col-sm-12">
    <label for="new_mediatypeid">Share?<span class="text-danger">*</span></label>

 

    <select id="new_isShare" name="new_isShare" class="form-control" data-parsley-required data-parsley-error-message="Shareable is required">
     
  
<option value="1" <cfif #materials_details.isshare# is "1">selected</cfif>  >Yes</option>
   
<option value="0" <cfif #materials_details.isshare# is "0">selected</cfif>  >No</option>


    </select>


</div>


     </cfoutput>
   




         <div class="form-group text-center col-md-12">
             <button class="btn btn-primary editable-submit btn-sm waves-effect waves-light" type="submit"  id="buttonSubmit"  style="background-color: #406e8e; border: #406e8e;" >Update  </button>
         </div>
     
     

     



         </div>
 </form>
        
    <script>      
 $(document).ready(function() {
    $(".parsley-examples").parsley()
});
 </script>     

        


        
        
<cfset script_name_include="/include/#ListLast(GetCurrentTemplatePath(), "\")#" /><cfinclude template="/include/bigbrotherinclude.cfm" /> 
