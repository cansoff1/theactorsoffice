<CFINCLUDE template="/include/remote_load.cfm" />



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
                       <input type="hidden" name="old_customTestPageName" value="#details.customTestPageName#" >
                       <input type="hidden" name="old_customTestPageLink" value="#details.customTestPageLink#" >



<cfif "#old_ticketName#" is not "#new_ticketname#">

    <cfoutput>
    <cfset new_tlogDetails = "changed NAME from <strong>#chr(34)##old_ticketName##chr(34)#</strong> to <strong>#chr(34)##new_ticketname##chr(34)#</strong>." />
    <cfset new_ticketid = "#ticketid#" />
    <cfset new_ticketstatus = "#new_ticketStatus#" />
    </cfoutput>
     
    <cfinclude template="/include/qry/inserttlog.cfm" />
    
</cfif>


<cfif "#old_tickettype#" is not "#new_tickettype#">

    <cfoutput>
    <cfset new_tlogDetails = "changed TYPE from <strong>#chr(34)##old_tickettype##chr(34)#</strong> to <strong>#chr(34)##new_tickettype##chr(34)#</strong>." />
    <cfset new_ticketid = "#ticketid#" />
    <cfset new_ticketstatus = "#new_ticketStatus#" />
    </cfoutput>
     
    <cfinclude template="/include/qry/inserttlog.cfm" />
    
</cfif>

<cfif "#old_ticketpriority#" is not "#new_ticketpriority#">

    <cfoutput>
    <cfset new_tlogDetails = "changed PRIORITY from <strong>#chr(34)##old_ticketpriority##chr(34)#</strong> to <strong>#chr(34)##new_ticketpriority##chr(34)#</strong>." />
    <cfset new_ticketid = "#ticketid#" />
    <cfset new_ticketstatus = "#new_ticketStatus#" />
    </cfoutput>
     
    <cfinclude template="/include/qry/inserttlog.cfm" />
    
</cfif>

<cfif "#old_patchNote#" is not "#new_patchNote#">


    
    
<cfif "#old_patchNote#" is "">
   <cfoutput>
    <cfset new_tlogDetails = "added PATCH NOTE: <strong>#chr(34)##new_patchNote##chr(34)#</strong>." />
    <cfset new_ticketid = "#ticketid#" />
    <cfset new_ticketstatus = "#new_ticketStatus#" />
    </cfoutput>
     
    <cfinclude template="/include/qry/inserttlog.cfm" />
<cfelse>
    <cfoutput>
    <cfset new_tlogDetails = "changed PATCH NOTE from <strong>#chr(34)##old_patchNote##chr(34)#</strong> to <strong>#chr(34)##new_patchNote##chr(34)#</strong>." />
    <cfset new_ticketid = "#ticketid#" />
    <cfset new_ticketstatus = "#new_ticketStatus#" />
    </cfoutput>
     
    <cfinclude template="/include/qry/inserttlog.cfm" />
    </cfif>
</cfif>
    
<cfif "#old_customtestpagename#" is not "#new_customtestpagename#">
    
    <cfif "#old_customtestpagename#" is "">
   <cfoutput>
    <cfset new_tlogDetails = "added CUSTOM TEST PAGE NAME: <strong>#chr(34)##new_customtestpagename##chr(34)#</strong>." />
    <cfset new_ticketid = "#ticketid#" />
    <cfset new_ticketstatus = "#new_ticketStatus#" />
    </cfoutput>
     
    <cfinclude template="/include/qry/inserttlog.cfm" />
<cfelse>
    <cfoutput>
    <cfset new_tlogDetails = "changed CUSTOM TEST PAGE NAME from <strong>#chr(34)##old_customtestpagename##chr(34)#</strong> to <strong>#chr(34)##new_customtestpagename##chr(34)#</strong>." />
    <cfset new_ticketid = "#ticketid#" />
    <cfset new_ticketstatus = "#new_ticketStatus#" />
    </cfoutput>
     
    <cfinclude template="/include/qry/inserttlog.cfm" />
    </cfif>
</cfif>
    

<cfif "#old_ticketResponse#" is not "#new_ticketResponse#">

<cfif "#old_ticketResponse#" is "">
   <cfoutput>
    <cfset new_tlogDetails = "added RESPONSE: <strong>#chr(34)##new_ticketResponse##chr(34)#</strong>." />
    <cfset new_ticketid = "#ticketid#" />
    <cfset new_ticketstatus = "#new_ticketStatus#" />
    </cfoutput>
     
    <cfinclude template="/include/qry/inserttlog.cfm" />
<cfelse>
    <cfoutput>
    <cfset new_tlogDetails = "changed RESPONSE from <strong>#chr(34)##old_ticketResponse##chr(34)#</strong> to <strong>#chr(34)##new_ticketResponse##chr(34)#</strong>" />
    <cfset new_ticketid = "#ticketid#" />
    <cfset new_ticketstatus = "#new_ticketStatus#" />
    </cfoutput>
     
    <cfinclude template="/include/qry/inserttlog.cfm" />
    </cfif>
</cfif>
    
    <cfif "#old_ticketstatus#" is not "#new_ticketstatus#" >
     
         <cfoutput>
    <cfset new_tlogDetails = "changed STATUS from <strong>#chr(34)##old_ticketstatus##chr(34)#</strong> to <strong>#chr(34)##new_ticketstatus##chr(34)#</strong>." />
    <cfset new_ticketid = "#ticketid#" />
    <cfset new_ticketstatus = "#new_ticketStatus#" />
    </cfoutput>
     
    <cfinclude template="/include/qry/inserttlog.cfm" />
     
     
     
     </cfif>
     
    
  <cfif "#old_testingscript#" is not "#new_testingscript#">


<cfif "#old_testingscript#" is "">
   <cfoutput>
    <cfset new_tlogDetails = "added TESTING SCRIPT: <strong>#chr(34)##new_testingscript##chr(34)#</strong>." />
    <cfset new_ticketid = "#ticketid#" />
    <cfset new_ticketstatus = "#new_ticketStatus#" />
    </cfoutput>
     
    <cfinclude template="/include/qry/inserttlog.cfm" />
<cfelse>
    <cfoutput>
    <cfset new_tlogDetails = "changed TESTING SCRIPT from <strong>#chr(34)##old_testingscript##chr(34)#</strong> to <strong>#chr(34)##new_testingscript##chr(34)#</strong>." />
    <cfset new_ticketid = "#ticketid#" />
    <cfset new_ticketstatus = "#new_ticketStatus#" />
    </cfoutput>
     
    <cfinclude template="/include/qry/inserttlog.cfm" />
    </cfif>
</cfif>  
    
<cfif "#old_customtestpagelink#" is not "#new_customtestpagelink#">
      
<cfif "#old_customtestpagelink#" is "">
   <cfoutput>
    <cfset new_tlogDetails = "added CUSTOM TEST PAGE LINK: <strong>#chr(34)##new_customtestpagelink##chr(34)#</strong>." />
    <cfset new_ticketid = "#ticketid#" />
    <cfset new_ticketstatus = "#new_ticketStatus#" />
    </cfoutput>
     
    <cfinclude template="/include/qry/inserttlog.cfm" />
<cfelse>
    <cfoutput>
    <cfset new_tlogDetails = "changed CUSTOM TEST PAGE LINK from <strong>#chr(34)##old_customtestpagelink##chr(34)#</strong> to <strong>#chr(34)##new_customtestpagelink##chr(34)#</strong>." />
    <cfset new_ticketid = "#ticketid#" />
    <cfset new_ticketstatus = "#new_ticketStatus#" />
    </cfoutput>
     
    <cfinclude template="/include/qry/inserttlog.cfm" />
    </cfif>
</cfif>
    
    
    
<cfif "#old_ticketDetails#" is not "#new_ticketDetails#">

<cfif "#old_ticketDetails#" is "">
   <cfoutput>
    <cfset new_tlogDetails = "added DETAILS: <strong>#chr(34)##new_ticketDetails##chr(34)#</strong>." />
    <cfset new_ticketid = "#ticketid#" />
    <cfset new_ticketstatus = "#new_ticketStatus#" />
    </cfoutput>
     
    <cfinclude template="/include/qry/inserttlog.cfm" />
<cfelse>
    <cfoutput>
    <cfset new_tlogDetails = "changed DETAILS from <strong>#chr(34)##old_ticketDetails##chr(34)#</strong> to <strong>#chr(34)##new_ticketDetails##chr(34)#</strong>." />
    <cfset new_ticketid = "#ticketid#" />
    <cfset new_ticketstatus = "#new_ticketStatus#" />
    </cfoutput>
     
    <cfinclude template="/include/qry/inserttlog.cfm" />
    </cfif>
</cfif>
    


<cfif "#decimalformat(old_estHours)#" is not "#decimalformat(new_estHours)#">

<cfif "#decimalformat(old_estHours)#" is "0">
   <cfoutput>
    <cfset new_tlogDetails = "added HOURS: <strong>#chr(34)##decimalformat(new_estHours)##chr(34)#</strong>." />
    <cfset new_ticketid = "#ticketid#" />
    <cfset new_ticketstatus = "#new_ticketStatus#" />
    </cfoutput>
     
    <cfinclude template="/include/qry/inserttlog.cfm" />
<cfelse>
    <cfoutput>
    <cfset new_tlogDetails = "changed HOURS from <strong>#chr(34)##decimalformat(old_estHours)##chr(34)#</strong> to <strong>#chr(34)##decimalformat(new_estHours)##chr(34)#</strong>." />
    <cfset new_ticketid = "#ticketid#" />
    <cfset new_ticketstatus = "#new_ticketStatus#" />
    </cfoutput>
     
    <cfinclude template="/include/qry/inserttlog.cfm" />
    </cfif>
</cfif>
    
    <cfif "#old_environ#" is not "#new_environ#" >
    
<cfif #old_environ# is "P">

<cfset old_findname = "Production" />
<cfelse>

<cfset old_findname = "Development" />
</cfif>

<cfif #new_environ# is "P">

<cfset new_findname = "Production" />
<cfelse>

<cfset new_findname = "Development" />
</cfif>



    <cfoutput>
    <cfset new_tlogDetails = "changed ENVIRONMENT from <strong>#chr(34)##old_findname##chr(34)#</strong> to <strong>#chr(34)##new_findname##chr(34)#</strong>." />
    <cfset new_ticketid = "#ticketid#" />
    <cfset new_ticketstatus = "#new_ticketStatus#" />
    </cfoutput>
     
    <cfinclude template="/include/qry/inserttlog.cfm" />
    
</cfif>    
 
    
    
<cfif "#old_userid#" is not "#new_userid#">


<cfquery name="old" datasource="#dsn#" >
select recordname as old_findname from taousers where userid = #old_userid#

</cfquery>

<cfquery name="new" datasource="#dsn#" >
select recordname as new_findname from taousers where userid = #new_userid#

</cfquery>

    <cfoutput>
<cfif #old.recordcount# is "1">

<cfset old_findname = "#old.old_findname#" />

<cfelse>

<cfset old_findname = "NULL" />

</cfif>

<cfif #new.recordcount# is "1">

<cfset new_findname = "#new.new_findname#" />

<cfelse>

<cfset new_findname = "NULL" />

</cfif>

    <cfset new_tlogDetails = "changed REQUESTER from <strong>#chr(34)##old_findname##chr(34)#</strong> to <strong>#chr(34)##new_findname##chr(34)#</strong>." />
    <cfset new_ticketid = "#ticketid#" />
    <cfset new_ticketstatus = "#new_ticketStatus#" />
    </cfoutput>
     
    <cfinclude template="/include/qry/inserttlog.cfm" />
    
</cfif>
        
        
        
 <cfif "#old_pgid#" is not "#new_pgid#">


<cfquery name="old" datasource="#dsn#" >
select recordname as old_findname from pgpages where pgid = #old_pgid#

</cfquery>

<cfquery name="new" datasource="#dsn#" >
select recordname as new_findname from pgpages where pgid = #new_pgid#

</cfquery>

    <cfoutput>
<cfif #old.recordcount# is "1">

<cfset old_findname = "#old.old_findname#" />

<cfelse>

<cfset old_findname = "NULL" />

</cfif>

<cfif #new.recordcount# is "1">

<cfset new_findname = "#new.new_findname#" />

<cfelse>

<cfset new_findname = "NULL" />

</cfif>

    <cfset new_tlogDetails = "changed PAGE from <strong>#chr(34)##old_findname##chr(34)#</strong> to <strong>#chr(34)##new_findname##chr(34)#</strong>." />
    <cfset new_ticketid = "#ticketid#" />
    <cfset new_ticketstatus = "#new_ticketStatus#" />
    </cfoutput>
     
    <cfinclude template="/include/qry/inserttlog.cfm" />
    
</cfif>
    
        
 <cfif "#numberformat(old_verid)#" is not "#numberformat(new_verid)#">


<cfquery name="old" datasource="#dsn#" >
select CONCAT(v.major,'.',v.minor,'.',v.patch,'.',v.version,'.',v.build) as old_findname from taoversions v where v.verid = #numberformat(old_verid)#

</cfquery>

<cfquery name="new" datasource="#dsn#" >
select CONCAT(v.major,'.',v.minor,'.',v.patch,'.',v.version,'.',v.build) as new_findname from taoversions v where v.verid = #numberformat(new_verid)#

</cfquery>

    <cfoutput>
<cfif #old.recordcount# is "1">

<cfset old_findname = "#old.old_findname#" />

<cfelse>

<cfset old_findname = "NULL" />

</cfif>

<cfif #new.recordcount# is "1">

<cfset new_findname = "#new.new_findname#" />

<cfelse>

<cfset new_findname = "NULL" />

</cfif>

    <cfset new_tlogDetails = "changed VERSION from <strong>#chr(34)##old_findname##chr(34)#</strong> to <strong>#chr(34)##new_findname##chr(34)#</strong>." />
    <cfset new_ticketid = "#ticketid#" />
    <cfset new_ticketstatus = "#new_ticketStatus#" />
    </cfoutput>
     
    <cfinclude template="/include/qry/inserttlog.cfm" />
    
</cfif>
                
  
    
    
<cfquery name="update" datasource="#dsn#" >
UPDATE tickets
SET ticketname = <cfqueryparam cfsqltype="cf_sql_varchar" value="#new_ticketname#" />
,ticketdetails = <cfqueryparam cfsqltype="cf_sql_longvarchar" value="#new_ticketdetails#" />
,ticketresponse = <cfqueryparam cfsqltype="cf_sql_longvarchar" value="#new_ticketresponse#" />
,userid = <cfqueryparam cfsqltype="cf_sql_integer" value="#new_userid#" />
,ticketStatus = <cfqueryparam cfsqltype="cf_sql_varchar" value="#new_ticketStatus#" />
,ticketType = <cfqueryparam cfsqltype="cf_sql_varchar" value="#new_ticketType#" />
    <cfif #new_verid# is not "">
,verid = <cfqueryparam cfsqltype="cf_sql_integer" value="#new_verid#" />
        </cfif>
 
,customtestpagename = <cfqueryparam cfsqltype="cf_sql_varchar" value="#new_customtestpagename#" />
         

,customtestpagelink = <cfqueryparam cfsqltype="cf_sql_varchar" value="#new_customtestpagelink#" />


,testingscript = <cfqueryparam cfsqltype="cf_sql_longvarchar" value="#new_testingscript#" />

,patchNote = <cfqueryparam cfsqltype="cf_sql_varchar" value="#new_patchNote#" />
,pgid = <cfqueryparam cfsqltype="cf_sql_integer" value="#new_pgid#" />    
,environ = <cfqueryparam cfsqltype="cf_sql_char" value="#new_environ#" />
,ticketPriority = <cfqueryparam cfsqltype="cf_sql_varchar" value="#new_ticketPriority#" />
,esthours = <cfqueryparam cfsqltype="cf_sql_float" value="#decimalformat(new_esthours)#" />
WHERE ticketid = <cfqueryparam cfsqltype="cf_sql_integer" value="#ticketid#" />    
</cfquery>

<cfquery name="details"   datasource="#dsn#"    >
SELECT 
t.ticketid
,t.ticketID as recID
,t.ticketName
    ,t.testingscript
,CONCAT(u.userfirstname,' ',u.userlastname) AS username
,t.ticketCreatedDate AS createddate
,t.pgid
,t.userid
,t.ticketstatus
,t.tickettype
,t.environ
,t.ticketPriority
,p.pgname
,p.pgdir
,t.esthours
,t.ticketCompletedDate
,t.verid
,t.ticketdetails
,t.ticketResponse 
,t.patchnote
,t.recordname
,v.major
,v.minor
,v.patch
,v.alphabeta,v.version
,v.releasedate
,t.customtestpagename    
,t.customtestpagelink      
    
    
 FROM tickets t
 INNER JOIN taousers u ON u.userid = t.userid
 INNER JOIN pgpages p ON p.pgid = t.pgid
 LEFT JOIN taoversions v ON v.verid = t.verid
WHERE t.ticketid = <cfqueryparam cfsqltype="cf_sql_integer" value="#ticketid#" />    

</cfquery> 

<cfset to_email ="cansoff@gmail.com" />



 <cfif #details.customtestpagename# is "">
 
<cfset startpage = "https://dev.theactorsoffice.com/app/#details.pgdir#/" />
 <cfset pgnames = "#details.pgname#" />    
     <cfelse>
         
  <cfset startpage = "#details.customtestpagelink#" />       
        <cfset pgnames = "#details.customtestpagename#" />    
    </cfif>
     
<cfset ismail = "Y" />
     
  <cfif "#old_ticketstatus#" is not "#new_ticketstatus#">
     


<cfif #old_ticketstatus# is not "Implemented" and #new_ticketstatus# is "Implemented" >
    
    <cfoutput>
    
    <Cfset ismail = "Y">
        
    <cfset emailto="cansoff@gmail.com" />
        
    <cfset emailcc="jodie@jodiebentley.com,support@theactorsoffice.com" />
    
    <cfset emailsubject="Ready for Testing Approval" />
        
    <Cfset emailmessage="Please review the Testing Script and approve for Testing." />
        
    <cfset emaillink="https://#host#.theactorsoffice.com/app/testing/?recid=#ticketid#" />
        
    <cfset emaillinkname="REVIEW" />
        
    </cfoutput>
        
    <cfif #ismail# is "Y">
            
        <cfinclude template="ticketemail.cfm" />
 
    </cfif>    
        
  </cfif>
       
</cfif>

     
     
     
 
     
     
     

<cflocation url="/app/version/?recid=#new_verid#" />       
