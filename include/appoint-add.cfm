<cfparam name="rcontactid" default="0" />      



<style>
    
#hidden_div {
    display: none;
}

</style>



<CFINCLUDE template="/include/remote_load.cfm" /><cfquery datasource="#dsn#" name="relationships"  >
        select * from contactdetails d where recordname <> '' and userid = #session.userid# order by d.contactfullname
        </cfquery>

<cfinclude template="/include/qry/durations.cfm" />
<div class="row">


     <div class="col-xl-6 col-lg-8 col-md-12">
          <div class="card">


 <div class="card-body">
         
              <form method="post" action="/include/appoint-add2.cfm" class="parsley-examples" name="event-form" id="form-event"  data-parsley-excluded="input[type=button], input[type=submit], input[type=reset], input[type=hidden], [disabled], :hidden"
  data-parsley-trigger="keyup" data-parsley-validate>
<cfoutput>
       <input type="hidden" name="returnurl" value="#returnurl#">
    <input type="hidden" name="rcontactid" value="#rcontactid#">
              <input type="hidden" name="userid" value="#session.userid#">     
                  </cfoutput>
  <div class="row">
         <div class="col-12">
             <div class="form-group">
                 <label class="control-label">Title<span class="text-danger">*</span></label>
                 <input class="form-control"  autocomplete="off" placeholder="Insert Appointment Title"  type="text" name="eventTitle" id="eventTitle" 
                                    
                data-parsley-minlength="3" 
                data-parsley-minlength-message="Min length 3 characters" 
                data-parsley-maxlength="200" 
                data-parsley-maxlength-message="Max length 200 characters" 
                data-parsley-required data-parsley-error-message="Title is required" />
             </div>
         </div>
      
      
  
      
      <script>
          $(document).ready(function(){
$("#select-relationship").selectize({

      persist: !1,
                createOnBlur: !0,
                create: !0  ,
    
    
    plugins: ["remove_button"],
  delimiter: ",",
  persist: false,
  create: function (input) {
    return {
      value: input,
      text: input,
    };
  },
    
    
});
              
              });
</script>

      
        
      
      

           <div class="col-lg-12">
                                <div class="form-group mb-3">
                                  <label for="select-relationship">Relationships<span class="text-danger">*</span></label>
    <select id="select-relationship" name="relationships"  autocomplete="off"  multiple required data-parsley-required data-parsley-error-message="Relationship is required" class="demo-default selectize-close-btn" style="width: 100%" placeholder="Select a Relationship..." value="">
      <option value="">Select a Relationship...</option>
        
        
        <cfloop query="relationships">
   
            <cfoutput>
                <option value="#relationships.contactid#" <cfif "#relationships.contactid#" is "#rcontactid#">selected </cfif>>#recordname#</option>
                </cfoutput>
</cfloop>
        
        
    </select>
  </div>

                                                </div>
        
                   
                         
                     
                
                            <div class="form-group col-md-12">
                 <label for="eventDescription">Description</label>
                 <textarea class="form-control" type="text"  id="eventDescription" name="eventDescription" placeholder="Description" rows="4"></textarea>
            
             </div>
     
     
             <div class="form-group col-md-12">
                 <label for="eventLocation">Location</label>
                 <input class="form-control" type="text" id="eventLocation"  autocomplete="off"   name="eventLocation" placeholder="Location">
     </div>
               
             <div class="form-group col-md-6">
                 <label for="eventStart">Start Date<span class="text-danger">*</span></label>
                 <input id="eventStart"  class="form-control" autocomplete="off" name="eventStart"  type="date" data-parsley-required data-parsley-error-message="Start Date is required">
                 

                    
             </div>
                         
          
             <div class="form-group col-md-6">
                 <label for="eventTypeName">Type<span class="text-danger">*</span></label>
                 <select class="form-control" name="eventTypeName" id="eventTypeName"  data-parsley-required data-parsley-error-message="Type is required">
                        <option value="" ></option>
                     <cfoutput query="types">
                         <option value="#types.eventtypename#" >#types.eventtypename#</option>
</cfoutput>
</select>
              

             </div>
              
          <cfquery datasource="#dsn#" name="details">
    SELECT u.viewtypeid, u.add1, u.add2, u.city, u.region_id, u.zip, u.tzid, u.defRows,u.calstarttime, u.calendtime, u.avatarname, u.userfirstname, u.userlastname, u.useremail, u.nletter_yn,u.nletter_link, v.viewtype,
    u.add1,u.add2,u.city,u.region_id,u.zip
    
    FROM taousers u 
    
    left outer join viewtypes v on v.viewtypeid = u.viewtypeid
    left join regions r on r.region_id = u.region_id
    WHERE u.userid = #userid#
</cfquery>    
              
 
             <div class="form-group col-md-6">
                 <label for="eventStartTime">Start Time<span class="text-danger">*</span></label>
             

 

     <select class="form-control" name="eventStartTime"  autocomplete="off" id="eventStartTime"  data-parsley-required data-parsley-error-message="Start Time is required">
         <option value="">Select a Start Time</option>
         
         <Cfoutput>
         <cfset new_calstarttime = "#details.calstarttime#" />
         </Cfoutput>
         <option value="05:00:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('05:00:00')#">Selected</cfif>>5:00 AM</option>
<option value="05:15:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('05:15:00')#">Selected</cfif>>5:15 AM</option>
<option value="05:30:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('05:30:00')#">Selected</cfif>>5:30 AM</option>
<option value="05:45:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('05:45:00')#">Selected</cfif>>5:45 AM</option>
<option value="06:00:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('06:00:00')#">Selected</cfif>>6:00 AM</option>
<option value="06:15:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('06:15:00')#">Selected</cfif>>6:15 AM</option>
<option value="06:30:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('06:30:00')#">Selected</cfif>>6:30 AM</option>
<option value="06:45:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('06:45:00')#">Selected</cfif>>6:45 AM</option>
<option value="07:00:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('07:00:00')#">Selected</cfif>>7:00 AM</option>
<option value="07:15:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('07:15:00')#">Selected</cfif>>7:15 AM</option>
<option value="07:30:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('07:30:00')#">Selected</cfif>>7:30 AM</option>
<option value="07:45:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('07:45:00')#">Selected</cfif>>7:45 AM</option>
<option value="08:00:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('08:00:00')#">Selected</cfif>>8:00 AM</option>
<option value="08:15:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('08:15:00')#">Selected</cfif>>8:15 AM</option>
<option value="08:30:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('08:30:00')#">Selected</cfif>>8:30 AM</option>
<option value="08:45:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('08:45:00')#">Selected</cfif>>8:45 AM</option>
<option value="09:00:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('09:00:00')#">Selected</cfif>>9:00 AM</option>
<option value="09:15:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('09:15:00')#">Selected</cfif>>9:15 AM</option>
<option value="09:30:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('09:30:00')#">Selected</cfif>>9:30 AM</option>
<option value="09:45:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('09:45:00')#">Selected</cfif>>9:45 AM</option>
<option value="10:00:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('10:00:00')#">Selected</cfif>>10:00 AM</option>
<option value="10:15:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('10:15:00')#">Selected</cfif>>10:15 AM</option>
<option value="10:30:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('10:30:00')#">Selected</cfif>>10:30 AM</option>
<option value="10:45:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('10:45:00')#">Selected</cfif>>10:45 AM</option>
<option value="11:00:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('11:00:00')#">Selected</cfif>>11:00 AM</option>
<option value="11:15:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('11:15:00')#">Selected</cfif>>11:15 AM</option>
<option value="11:30:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('11:30:00')#">Selected</cfif>>11:30 AM</option>
<option value="11:45:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('11:45:00')#">Selected</cfif>>11:45 AM</option>
<option value="12:00:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('12:00:00')#">Selected</cfif>>12:00 PM</option>
<option value="12:15:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('12:15:00')#">Selected</cfif>>12:15 PM</option>
<option value="12:30:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('12:30:00')#">Selected</cfif>>12:30 PM</option>
<option value="12:45:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('12:45:00')#">Selected</cfif>>12:45 PM</option>
<option value="13:00:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('13:00:00')#">Selected</cfif>>1:00 PM</option>
<option value="13:15:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('13:15:00')#">Selected</cfif>>1:15 PM</option>
<option value="13:30:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('13:30:00')#">Selected</cfif>>1:30 PM</option>
<option value="13:45:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('13:45:00')#">Selected</cfif>>1:45 PM</option>
<option value="14:00:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('14:00:00')#">Selected</cfif>>2:00 PM</option>
<option value="14:15:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('14:15:00')#">Selected</cfif>>2:15 PM</option>
<option value="14:30:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('14:30:00')#">Selected</cfif>>2:30 PM</option>
<option value="14:45:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('14:45:00')#">Selected</cfif>>2:45 PM</option>
<option value="15:00:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('15:00:00')#">Selected</cfif>>3:00 PM</option>
<option value="15:15:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('15:15:00')#">Selected</cfif>>3:15 PM</option>
<option value="15:30:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('15:30:00')#">Selected</cfif>>3:30 PM</option>
<option value="15:45:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('15:45:00')#">Selected</cfif>>3:45 PM</option>
<option value="16:00:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('16:00:00')#">Selected</cfif>>4:00 PM</option>
<option value="16:15:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('16:15:00')#">Selected</cfif>>4:15 PM</option>
<option value="16:30:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('16:30:00')#">Selected</cfif>>4:30 PM</option>
<option value="16:45:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('16:45:00')#">Selected</cfif>>4:45 PM</option>
<option value="17:00:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('17:00:00')#">Selected</cfif>>5:00 PM</option>
<option value="17:15:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('17:15:00')#">Selected</cfif>>5:15 PM</option>
<option value="17:30:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('17:30:00')#">Selected</cfif>>5:30 PM</option>
<option value="17:45:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('17:45:00')#">Selected</cfif>>5:45 PM</option>
<option value="18:00:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('18:00:00')#">Selected</cfif>>6:00 PM</option>
<option value="18:15:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('18:15:00')#">Selected</cfif>>6:15 PM</option>
<option value="18:30:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('18:30:00')#">Selected</cfif>>6:30 PM</option>
<option value="18:45:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('18:45:00')#">Selected</cfif>>6:45 PM</option>
<option value="19:00:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('19:00:00')#">Selected</cfif>>7:00 PM</option>
<option value="19:15:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('19:15:00')#">Selected</cfif>>7:15 PM</option>
<option value="19:30:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('19:30:00')#">Selected</cfif>>7:30 PM</option>
<option value="19:45:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('19:45:00')#">Selected</cfif>>7:45 PM</option>
<option value="20:00:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('20:00:00')#">Selected</cfif>>8:00 PM</option>
<option value="20:15:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('20:15:00')#">Selected</cfif>>8:15 PM</option>
<option value="20:30:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('20:30:00')#">Selected</cfif>>8:30 PM</option>
<option value="20:45:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('20:45:00')#">Selected</cfif>>8:45 PM</option>
<option value="21:00:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('21:00:00')#">Selected</cfif>>9:00 PM</option>
<option value="21:15:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('21:15:00')#">Selected</cfif>>9:15 PM</option>
<option value="21:30:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('21:30:00')#">Selected</cfif>>9:30 PM</option>
<option value="21:45:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('21:45:00')#">Selected</cfif>>9:45 PM</option>
<option value="22:00:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('22:00:00')#">Selected</cfif>>10:00 PM</option>
<option value="22:15:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('22:15:00')#">Selected</cfif>>10:15 PM</option>
<option value="22:30:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('22:30:00')#">Selected</cfif>>10:30 PM</option>
<option value="22:45:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('22:45:00')#">Selected</cfif>>10:45 PM</option>
<option value="23:00:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('23:00:00')#">Selected</cfif>>11:00 PM</option>
<option value="23:15:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('23:15:00')#">Selected</cfif>>11:15 PM</option>
<option value="23:30:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('23:30:00')#">Selected</cfif>>11:30 PM</option>
<option value="23:45:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('23:45:00')#">Selected</cfif>>11:45 PM</option>
                 </select>
                     
                     
             </div>
     
     

               <div class="form-group col-md-6">
                                <label for="new_durid">Duration</label>
                                <select class="form-control" name="new_durid" autocomplete="off" id="new_durid">
                                    <cfoutput query="durations">
                                        <option value="#durations.durid#" <cfif #durations.durid# is "4"> selected </cfif> >#durations.durname#</option>
                                    </cfoutput>
                                </select>
                            </div>
         
         
         
         
         
         
         
         
         
                          <div class="form-group col-md-12">
                 <label for="noteDetails">Note</label>
                 <textarea class="form-control" type="text"  id="noteDetails" name="noteDetails" placeholder="Note to be added to Notes Log" rows="4"></textarea>
            
             </div>

<!-- include input widgets; this is independent of Datepair.js -->


      
   <div class="form-group col-md-12">    
        <label for="eventStopTime">Recurring every:</label>
<div id="checkboxes">
    <input type="checkbox" name="dow" value="1"  autocomplete="off"  onchange="showDiv('hidden_div', this)"> Monday
    &nbsp;<input type="checkbox" name="dow" value="2"  onchange="showDiv('hidden_div', this)"> Tuesday
    &nbsp; <input type="checkbox" name="dow" value="3"  onchange="showDiv('hidden_div', this)"> Wednesday
     &nbsp;<input type="checkbox" name="dow" value="4"  onchange="showDiv('hidden_div', this)"> Thursday
    &nbsp; <input type="checkbox" name="dow" value="5"  onchange="showDiv('hidden_div', this)"> Friday
    &nbsp; <input type="checkbox" name="dow" value="6"  onchange="showDiv('hidden_div', this)"> Saturday
    &nbsp; <input type="checkbox" name="dow" value="0"  onchange="showDiv('hidden_div', this)"> Sunday
</div>
     </div>
     
       
     
             <div class="form-group col-md-6"  id="hidden_div">
                 <label for="eventStart">Recurring Until:</label>
                 <input class="form-control" id="endRecur" name="endRecur" type="date"  >
                
             </div> 
    
    
     
     

         </div>
 
                         
                 
                     <div class="row mt-2">
                         <div class="col-6">
                
                         </div>
                         <div class="col-6 text-right">
                      <a href="javascript:history.go(-1)"><button type="button" class="btn btn-light mr-1 btn-sm" data-bs-dismiss="modal">Back</button></a>
                             <button type="submit" class="btn btn-primary btn-sm waves-effect waves-light" id="btn-save-event">Add</button>
                         </div>
                     </div>
                 </form>
              </div>
         </div>
         
    </div>
    

        <script>      
 $(document).ready(function() {
    $(".parsley-examples").parsley()
});
 </script>  
   



<script>                       
        function showDiv(divId, element)
{
    var checked = document.querySelectorAll('input:checked');
    if (checked.length === 0) {
document.getElementById(divId).style.display = 'none';

} else {
document.getElementById(divId).style.display = 'block';
        $("#divId").prop('required', true);
}
}
</script> 
    

 <script>
$('select[name=eventStartTime]').on("change",function(){
    var theSelectedIndex = $(this)[0].selectedIndex;
    $.each($('select[name=eventStopTime] option'), function(){
        var endOptionIndex = $(this).index();
        if (endOptionIndex < theSelectedIndex){
           $(this).attr('disabled','disabled');
        } else{
           $(this).removeAttr('disabled').prop('selected', true);
           return false;
        }
    });
});
</script>


<cfset script_name_include="/include/#ListLast(GetCurrentTemplatePath(), "\")#" /><cfinclude template="/include/bigbrotherinclude.cfm" /> 
