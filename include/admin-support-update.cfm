



 

<div class="row">


     <div class="col-xl-6 col-lg-8 col-md-12">
          <div class="card">




            <div class="card-body">
         
              <form method="post" action="/include/admin-support-update2.cfm" class="parsley-examples" name="ticket-form" id="form-ticket"   data-parsley-excluded="input[type=button], input[type=submit], input[type=reset], input[type=hidden], [disabled], :hidden"
  data-parsley-trigger="keyup" data-parsley-validate>
                  
                  <cfoutput>
         <input type="hidden" name="verid" value="#details.verid#" >
                      <input type="hidden" name="ticketid" value="#details.ticketid#" >
                          <input type="hidden" name="recid" value="#details.ticketid#" >
                      <input type="hidden" name="old_ticketName" value="#details.ticketName#" >
                      <input type="hidden" name="old_pgid" value="#details.pgid#" >
                      <input type="hidden" name="old_userid" value="#details.userid#" >
                      <input type="hidden" name="old_tickettype" value="#details.tickettype#" >
                      <input type="hidden" name="old_environ" value="#details.environ#" >
                      <input type="hidden" name="old_ticketpriority" value="#details.ticketpriority#" >
                      <input type="hidden" name="old_ticketdetails" value="#details.ticketdetails#" >
                      <input type="hidden" name="old_ticketResponse" value="#details.ticketResponse#" >
                      <input type="hidden" name="old_verid" value="#details.verid#" >
                      <input type="hidden" name="old_estHours" value="#details.estHours#" >
                       <input type="hidden" name="old_testingscript" value="#details.testingscript#" >
                     <input type="hidden" name="old_patchnote" value="#details.patchnote#" >
                       <input type="hidden" name="old_customTestPageName" value="#details.customTestPageName#" >
                       <input type="hidden" name="old_customTestPageLink" value="#details.customTestPageLink#" >
                      
                      
                      
                     <div class="row">
                         <div class="col-12">
                             <div class="form-group">
                                 <label class="control-label">Name<span class="text-danger">*</span></label>
                                 <input class="form-control" placeholder="Add Ticket Name" value="#details.ticketName#" type="text" name="new_ticketName" id="new_ticketName"  data-parsley-minlength="3" 
                data-parsley-minlength-message="Min length 3 characters" 
                data-parsley-maxlength="200" 
                data-parsley-maxlength-message="Max length 200 characters" 
                data-parsley-required data-parsley-error-message="Name is required" />  
                          
                             </div>
                         </div>
                         </cfoutput> 
                      
                      
 
                      

<div class="col-lg-6">
    <div class="form-group">
                       
  <label for="tickettype"> Page<span class="text-danger">*</span></label>
<select class="form-control" name="new_pgid" id="new_pgid" required>

    <cfoutput query="pages" >
             <option value="#pages.id#" <cfif #pages.id# is "#details.pgid#"> selected </cfif>>#pages.name#</option>
    </cfoutput>


</select>
                      
  </div>
                  
</div>
                
                
                
                 <div class="form-group col-md-6">
        <label for="tickettype">Requester<span class="text-danger">*</span></label>
         <select class="form-control" name="new_userid" id="new_userid" required>

<cfoutput query="users" >
    <option value="#users.id#" <cfif #users.id# is "#details.userid#"> selected </cfif>  >#users.name#</option>
</cfoutput>
          
        </select>
                   
      </div>
 
                                   
       
                
                
                       
                 <div class="form-group col-md-6">
        <label for="tickettype">Status<span class="text-danger">*</span></label>
         <select class="form-control" name="new_ticketstatus" id="new_ticketstatus" required>

<cfoutput query="statuses" >
    <option value="#statuses.id#" <cfif #statuses.id# is "#details.ticketstatus#"> selected </cfif>  >#statuses.name#</option>
</cfoutput>
          
        </select>
              <cfoutput>
    <input type="hidden" name="old_ticketstatus" value="#details.ticketstatus#" />
    </cfoutput>     
      </div>

                                   
       
                
                       
                
                    <div class="form-group col-md-6">
        <label for="tickettype">Type<span class="text-danger">*</span></label>
         <select class="form-control" name="new_tickettype" id="new_tickettype" required>

<cfoutput query="types" >
    <option value="#types.id#" <cfif #types.id# is "#details.tickettype#"> selected </cfif>  >#types.name#</option>
</cfoutput>
          
        </select>
                   
      </div>             
                
                
                
                       <div class="form-group col-md-6">
        <label for="tickettype">Environment<span class="text-danger">*</span></label>
         <select class="form-control" name="new_environ" id="new_environ" required>

 
    <option value="D" <cfif #details.environ# is "D"> selected </cfif>  >Development</option>
      <option value="P" <cfif #details.environ# is "P"> selected </cfif>  >Production</option>
          
        </select>
                   
      </div>             
          
<div class="form-group col-md-6">
    <label for="tickettype">Priority<span class="text-danger">*</span></label>
        <select class="form-control" name="new_ticketpriority" id="new_ticketpriority" required>
            <cfoutput query="priorities" >
                <option value="#priorities.id#" <cfif #priorities.id# is "#details.ticketpriority#"> selected </cfif>  >#priorities.name#</option>
            </cfoutput>
        </select>
      </div>  


<cfoutput>
                
<div class="form-group col-md-12">
<label for="tickettype">Ticket Details<span class="text-danger">*</span></label>
<textarea class="form-control" type="text" id="new_ticketDetails" name="new_ticketDetails" placeholder="Details" rows="2" required>#details.ticketdetails#</textarea>    
</div>       
                
<div class="form-group col-md-12">
<label for="tickettype">Developer Response</label>
<textarea class="form-control" type="text" id="new_ticketResponse" name="new_ticketResponse" placeholder="Details" rows="2" >#details.ticketResponse#</textarea>    
</div>       
                                
</cfoutput>               
                                 
  <div class="form-group col-md-6">
    <label for="new_estHours">Est. Hours<span class="text-danger">*</span></label>
        <select class="form-control" name="new_estHours" id="new_estHours" required>
           <cfloop index="z" step=".25"  from="0" to="50" >
         
               <cfoutput><option value="#z#"  <cfif #z# is "#details.esthours#"> selected </cfif> >#z#</option> </cfoutput> 
</cfloop>
      </select>
            
            
      </div>                                 
                                 
                   
                                 
<div class="form-group col-md-6">
<label for="new_verid">Assigned Release</label>

<select class="form-control" name="new_verid" id="new_verid" >
<option value="">None</option>

    <cfoutput query="vers" >
        <option value="#vers.id#" <cfif #vers.id# is "#details.verid#"> selected </cfif>  >#vers.major#.#vers.minor#.#vers.patch#.#vers.version#</option>
    </cfoutput>
      
</select>
       
</div>                                 
                        


<cfoutput>

       <div class="col-12">
                             <div class="form-group">
                                 <label class="control-label">Patch Note</label>
                                 <input class="form-control" placeholder="Add Patch Note" value="#details.patchNote#" type="text" name="new_patchNote" id="new_patchNote"  
                />  
                          
                             </div>
                         </div>
    
    <div class="form-group col-md-12">
<label for="new_testingscript">Testing Script</label>
<textarea class="form-control" type="text" id="new_testingscript" name="new_testingscript" rows="2">#details.testingscript#</textarea>    
</div>
    
    
    
    
    
    
           <div class="col-6">
                             <div class="form-group">
                                 <label class="control-label">Custom Test Page Name</label>
                                 <input class="form-control" placeholder="Add Page Name" value="#details.customTestPageName#" type="text" name="new_customTestPageName" id="new_customTestPageName"  
                />  
                          
                             </div>
                         </div>

    
    
           <div class="col-6">
                             <div class="form-group">
                                 <label class="control-label">Custom Test Page Link</label>
                                 <input class="form-control" placeholder="Add Page Link" value="#details.customTestPageLink#" type="text" name="new_customTestPageLink" id="new_customTestPageLink"  
                />  
                          
                             </div>
                         </div>

    
    
    

</cfoutput>

                
                
                
</div>    
                
                
                     <div class="row mt-2">
                         <div class="col-6">
            
                         </div>
                         <div class="col-6 text-right">
                    
                             <input type="submit" class="btn btn-primary btn-sm waves-effect waves-light" ivalue="Update">
                         </div>
                     </div>
                 </form>
              </div>
         </div>
         
    </div>
    
</div>
<style>
         .selectize-dropdown, .selectize-input { 
  line-height: 28px; }
</style>



        <script>      
 $(document).ready(function() {
    $(".form-ticket").parsley()
});
 </script>  
         
 
    <script>
        $('#eventStartTime').timepicker(
        
        );
         $('#eventStopTime').timepicker();
        $('#eventStart').datepicker({           
            autoclose: true
        });
        
           $('#endRecur').datepicker({           
            autoclose: true
        });
         
        
        
    </script>


<cfset script_name_include="/include/#ListLast(GetCurrentTemplatePath(), "\")#" /><cfinclude template="/include/bigbrotherinclude.cfm" /> 
