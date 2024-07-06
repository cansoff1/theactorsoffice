<CFINCLUDE template="/include/remote_load.cfm" />

<cfparam name="userrole" default="U" />

<cfquery name="pages" datasource="#dsn#" >
     SELECT distinct p.pgid AS ID
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


<cfset new_pgid = pgid />

<p>Please feel free to enter any type of note to our development team, including errors discovered, change request or general notes/opinions regarding your experience. All feedback is welcomed and appreciated.  Thank you!</p>

<form action="/include/remoteSupportFormAdd.cfm" method="post" class="needs-validation" validate>
    <cfoutput>
 

    <input type="hidden" name="pgdir" value="#pgdir#" />
 <input type="hidden" name="qstring" value="#qstring#" />

</cfoutput>
    <div class="row" />
    
        <div class="form-group col-md-12">
        <label for="ticketDetails">Title</label>
        <input class="form-control" type="text" id="new_ticketName" name="new_ticketName" placeholder="One-sentence summary"   required /> 

        <div class="invalid-feedback">
            Please enter a Title.
        </div>



    </div>

    
    
    
    

    
      <cfif #userRole# is "Administrator">
      
    
    
    
         <div class="form-group col-md-12">
        <label for="tickettype">User</label>
         <select class="form-control" name="new_userid" id="new_userid" required>

<cfoutput query="users" >
    <option value="#users.id#" <cfif #users.id# is "#session.userid#"> selected </cfif>  >#users.name#</option>
</cfoutput>
          
        </select>


        <div class="invalid-feedback">
            Please enter a User.
        </div>
</div>

<cfelse>
      <cfoutput>  <input type="hidden" name="new_userid" value="#session.userid#" /></cfoutput>
    </cfif>




          
          

    <div class="form-group col-md-6">
        <label for="tickettype">Type</label>
         <select class="form-control" name="new_tickettype" placeholder="select a Type" id="new_tickettype" required>
  <option value=""></option>

            <option value="Bug">Error Found</option>
<cfif #session.userid# is "1" or #session.userid# is "12" or #session.userid# is "30" or #session.userid# is "17">
 <option value="Feature">Feature</option>
    <Cfelse>
            <option value="User Request">User Request</option>
        </Cfif>

        </select>


        <div class="invalid-feedback">
            Please enter a Type.
        </div>
</div>
    
    
    
    




     <div class="form-group col-md-6">
        <label for="tickettype"> Page</label>
         <select class="form-control" name="new_pgid" id="new_pgid" required>


   <option value="">SELECT A PAGE</option>
   <cfoutput query="pages" >
             <option value="#pages.id#">#pages.name#</option>
</cfoutput>


        </select>


        <div class="invalid-feedback">
            Please enter a Page.
        </div>
</div>
    
    

    <div class="form-group col-md-12">
        <label for="ticketDetails">Details</label>
        <textarea class="form-control" type="text" id="new_ticketDetails" name="new_ticketDetails" placeholder="Details" rows="4" required></textarea>

        <div class="invalid-feedback">
            Please enter a Details.
        </div>



    </div>





    <div class="form-group col-md-12">
        <center>
        <button class="btn btn-xs btn-primary waves-effect mb-2 waves-light" style="background-color: #406e8e; border: #406e8e;" type="submit">Add</button>
        </center>
    </div>

</form>


<cfset script_name_include="/include/#ListLast(GetCurrentTemplatePath(), "\")#" /><cfinclude template="/include/bigbrotherinclude.cfm" /> 
