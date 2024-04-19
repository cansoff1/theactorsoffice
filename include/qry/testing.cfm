<cfset sel_search = "">
<cfparam name="select_userid" default="%" />
<cfparam name="select_ticketstatus" default="%" />
   <cfparam name="select_tickettype" default="%" />     
       <cfparam name="select_pgid" default="%" />     
    <cfquery name="statuses"     >
    select ticketstatus as name from ticketstatuses
    </cfquery>
<cfquery name="details"     >
SELECT 

t.ticketID as recID
,t.ticketName
,CONCAT(u.userfirstname,' ',u.userlastname) AS username
,t.ticketCreatedDate AS createddate




,t.ticketstatus
,t.tickettype
,t.environ
,t.ticketPriority

,p.pgdir

,p.pgname
,t.esthours
,t.ticketCompletedDate
,t.verid

,t.ticketdetails

,t.ticketResponse 

,t.patchnote
,t.recordname
,t.testingscript
    
,v.major
,v.minor
,v.patch
,v.alphabeta,v.version
,v.releasedate
    
 ,t.customtestpagelink
,t.customtestpagename
    
    
 FROM tickets t
 INNER JOIN taousers_tbl u ON u.userid = t.userid
 INNER JOIN pgpages p ON p.pgid = t.pgid
 LEFT JOIN taoversions v ON v.verid = t.verid
WHERE t.ticketid = #recid#

</cfquery> 
    
