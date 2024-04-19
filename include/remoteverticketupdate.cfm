<CFINCLUDE template="/include/remote_load.cfm" />

<cfquery name="details" datasource="#dsn#">
    SELECT
    p.pgid
    ,t.ticketID as recID
    ,t.ticketID as pk
    ,CONCAT(u.userfirstname,' ',u.userlastname) AS col1
    ,'User' as head1
    ,'Date' as head2
    ,'Time' as head3
    ,'Page' as head4
    ,'Status' as head5
    ,'Title' as head6
    ,'Response' as head7
    ,'Completed' as head8
    ,t.ticketResponse 
    ,t.ticketCompletedDate
    ,t.ticketdetails
    ,t.ticketCreatedDate 
    ,t.ticketCreatedDate 
    ,p.pgname
    ,t.ticketStatus
    ,t.ticketType
    ,t.ticketPriority
    ,t.verid
    ,t.esthours
    ,t.testingscript
    ,t.ticketName
    ,t.ticketResponse
    ,t.ticketCompletedDate
    ,p.pgname
    ,p.pgdir
    ,t.customtestpagename
    ,t.customtestpagelink
    ,t.patchnote
    ,t.complete_email
    ,t.initial_email
    FROM tickets t
    INNER JOIN taousers u ON u.userid = t.userid
    INNER JOIN pgpages p ON p.pgid = t.pgid
    WHERE t.ticketid = #recid#
</cfquery>

<cfquery name="uu" datasource="#dsn#">
select * from taousers where userid = #session.userid#
</cfquery>
    <cfquery name="pages" datasource="#dsn#" >
     SELECT p.pgid AS ID
	,p.pgname as name 

	from pgpages  p inner join pgcomps c ON c.compid = p.compid 
	WHERE c.compactive = 'Y'

	order BY p.pgname
</cfquery>

	<cfquery name="users" datasource="#dsn#" >
SELECT MIN(u.userid) AS id
,u.recordname AS name

FROM taousers u 
GROUP BY u.recordname
ORDER BY u.recordname
</cfquery>
    
  
    	<cfquery name="statuses" datasource="#dsn#" >
    
    SELECT ticketstatus AS id, ticketstatus AS name FROM ticketstatuses ORDER BY id
    </cfquery>
    
    
    
        	<cfquery name="types" datasource="#dsn#" >
    
    SELECT tickettype AS id, tickettype AS name FROM tickettypes ORDER BY tickettype
    </cfquery>
    
    
    	<cfquery name="priorities" datasource="#dsn#" >
    
    SELECT ticketpriority AS id, ticketpriority AS name FROM ticketpriority ORDER BY orderNo
    </cfquery>
    
    
    
    
        	<cfquery name="vers" datasource="#dsn#" >
    SELECT verid AS id, major,minor,patch,version, alphabeta,isactive FROM taoversions ORDER BY major,minor,patch,version
    </cfquery>

<div class="row">


<cfset cur_icon="">


   <form class="px-3 col-md-12" action="/include/remoteverticketupdate2.cfm">

    <cfoutput query="details">
        
        

      
      <input type="hidden" name="oldverid" value="#oldverid#" />
            <input type="hidden" name="ticketid" value="#details.recid#" />
        
        
        <div class="form-group col-md-12">
<label for="tickettype">Ticket Details</label>
<textarea class="form-control" type="text" id="new_ticketname" name="new_ticketname" placeholder="Details" rows="2" required>#details.ticketname#</textarea>    
</div>  
        
                <div class="form-group col-md-12">
<label for="tickettype">Developer Response</label>
<textarea class="form-control" type="text" id="new_ticketname" name="new_ticketResponse" placeholder="Developer Response" rows="2" >#details.ticketResponse#</textarea>    
</div>  
        
        
        
           <div class="form-group col-md-12">
<label for="testingscript">Testing Script</label>
<textarea class="form-control" type="text" id="new_testingscript" name="new_testingscript"  rows="2" >#details.testingscript#</textarea>    
</div>       
                                 
        
    </cfoutput>                            
                                    
         <div class="form-group col-md-12">                              
  <label for="tickettype"> Page</label>
         <select class="form-control" name="new_pgid" id="new_pgid" required>

<cfoutput query="pages" >
             <option value="#pages.id#" <cfif #pages.id# is "#details.pgid#"> selected </cfif>>#pages.name#</option>
</cfoutput>


        </select>
  </div>
    <cfoutput query="details">
             
             <div class="form-group col-md-12">
<label for="testingscript">Custom Test Page</label>
<input type="text" class="form-control"   id="new_customTestPageName" value="#details.customTestPageName#" name="new_customTestPageName"   />
</div>       
    
    
                 <div class="form-group col-md-12">
<label for="testingscript">Custom Test Page Link</label>
<input type="text" class="form-control"   id="new_customTestPageLink" value="#details.customTestPageLink#" name="new_customTestPageLink"   />
</div>       
    
    
    </cfoutput>
    
    <div class="form-group col-md-12">
    <label for="ticketstatus">Status</label>
        <select class="form-control" name="new_ticketstatus" id="new_ticketstatus" required>
            <cfoutput query="statuses" >
                <option value="#statuses.id#" <cfif #statuses.id# is "#details.ticketstatus#"> selected </cfif>  >#statuses.name#</option>
            </cfoutput>
        </select>
      </div>  


           <cfoutput>
    <input type="hidden" name="old_ticketstatus" value="#details.ticketstatus#" />
    </cfoutput>  
    
    
                        <div class="form-group col-md-12">
        <label for="tickettype">Type</label>
         <select class="form-control" name="new_tickettype" id="new_tickettype" required>

<cfoutput query="types" >
    <option value="#types.id#" <cfif #types.id# is "#details.tickettype#"> selected </cfif>  >#types.name#</option>
</cfoutput>
          
        </select>
                   
      </div>   

<div class="form-group col-md-12">
    <label for="tickettype">Priority</label>
        <select class="form-control" name="new_ticketpriority" id="new_ticketpriority" required>
            <cfoutput query="priorities" >
                <option value="#priorities.id#" <cfif #priorities.id# is "#details.ticketpriority#"> selected </cfif>  >#priorities.name#</option>
            </cfoutput>
        </select>
      </div>  




<div class="form-group col-md-12">
<label for="new_verid">Assigned Release</label>

<select class="form-control" name="new_verid" id="new_verid" required>
<option value="NULL">None</option>

    <cfoutput query="vers" >
        <option value="#vers.id#" <cfif #vers.id# is "#details.verid#"> selected </cfif>  >#vers.major#.#vers.minor#.#vers.patch#.#vers.version#</option>
    </cfoutput>
      
</select>
       
</div>                                 
                        





    
     <div class="form-group col-md-6">
    <label for="new_estHours">Est. Hours</label>
        <select class="form-control" name="new_estHours" id="new_estHours" required>
           <cfloop index="z" step=".25"  from="0" to="50" >
         
               <cfoutput><option value="#z#"  <cfif #z# is "#details.esthours#"> selected </cfif> >#z#</option> </cfoutput> 
</cfloop>
      </select>
            
            
      </div>  









             <div class="row mt-2">
                         <div class="col-6">
            
                         </div>
                         <div class="col-6 text-right">
                             <a href="javascript:history.go(-1)"><button type="button" class="btn btn-light mr-1 btn-sm" data-bs-dismiss="modal">Back</button></a>
                             <button type="submit" class="btn btn-primary btn-sm waves-effect waves-light" id="btn-save-event">Update</button>
                         </div>
                     </div>
                 </form>





</div>

  


<cfset script_name_include="/include/#ListLast(GetCurrentTemplatePath(), "\")#" /><cfinclude template="/include/bigbrotherinclude.cfm" /> 
