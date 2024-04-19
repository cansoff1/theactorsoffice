<cfset sel_search = ""><CFINCLUDE template="/include/remote_load.cfm" />
<cfparam name="select_userid" default="%" />
<cfparam name="select_ticketstatus" default="%" />
   <cfparam name="select_tickettype" default="%" />     
       <cfparam name="select_pgid" default="%" />     
<cfquery name="details"   datasource="#dsn#"   >
SELECT 

t.ticketID as recID
,t.ticketName
,CONCAT(u.userfirstname,' ',u.userlastname) AS username
,t.ticketCreatedDate AS createddate




,t.ticketstatus
,t.tickettype
,t.environ
,t.ticketPriority



,p.pgname
,t.esthours
,t.ticketCompletedDate
,t.verid
,t.testingscript
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
 LEFT JOIN taousers_tbl u ON u.userid = t.userid
 LEFT JOIN pgpages p ON p.pgid = t.pgid
 LEFT JOIN taoversions v ON v.verid = t.verid
WHERE t.ticketid = #recid#

</cfquery> 
    
