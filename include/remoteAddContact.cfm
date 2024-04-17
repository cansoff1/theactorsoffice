<CFINCLUDE template="/include/remote_load.cfm" />

<cfparam name="tagtypes" default="team" /> 


<cfquery name="tags" datasource="#dsn#" >
SELECT  * from tags_user where userid = #session.userid# <cfif #tagtypes# is "team"> and isteam = 1 </cfif>
    
    order by tagname
</cfquery>


<form action="/include/remoteAddContactAdd.cfm" method="post"  class="needs-validation"  id="profile-form">
    <cfoutput>
      <input type="hidden" name="new_tag" value="My Team" >
<input type="hidden" name="userid" value="#userid#" >
        <input type="hidden" name="src" value="#src#" >
    </cfoutput>
    
    
        <div class="row" />
 
     
        

    
                <div class="form-group col-md-6">
          <label for="contactFullName">Name:</label>
 
          <input class="form-control" type="text" id="contactfullname" name="contactfullname"   required placeholder="Enter Name">
 
           
                </div>
    
                 

        
        
                      <div class="form-group required  col-md-6">
          <label for="company">Company:</label>
 
          <input class="form-control" type="text" id="company" name="company"    placeholder="Add Company">
 
    
                </div>
        
   
    
    
                    <div class="form-group col-sm-6 mb-6">
                     
                     
                               <label for="tag">Tag</label>
                     
    
                  <select id="new_tag" name="new_tag" required class="form-control">
                                                        <option value="">Select a type</option>
                                               <cfloop query="tags">
                                                
                                                   <cfoutput>
                                                       <option value="#tags.tagname#"  >#tags.tagname#</option>
                                                 
                                                 </cfoutput>
                                                 </cfloop>
                                                    </select>
    
    
    
    </div>

    
 
               <div class="form-group col-md-6">
          <label for="workphone">Phone:</label>
 
          <input class="form-control" type="text" id="workphone" name="workphone"    placeholder="Enter Work Phone">
 
                <div class="invalid-feedback">
                    Please add work phone.
                </div>
                </div>
        

               <div class="form-group col-md-6">
          <label for="workemail">Email:</label>
 
          <input class="form-control" type="text" id="workemail" name="workemail"    placeholder="Enter Email">
 
          
                </div>
        
    
    
    
    
    
    
</div>



      <div class="form-group text-center col-md-12"><p>
                            <button class=" btn btn-primary editable-submit btn-sm waves-effect waves-light" type="submit" style="background-color: #406e8e; border: #406e8e;">Add</button></p>
                        </div>

      
    
    </div>
</form>





<cfset script_name_include="/include/#ListLast(GetCurrentTemplatePath(), "\")#" /><cfinclude template="/include/bigbrotherinclude.cfm" /> 


