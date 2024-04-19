<CFINCLUDE template="/include/remote_load.cfm" /><cfset sel_search = "">
<cfparam name="select_userid" default="%" />
<cfparam name="select_ticketstatus" default="%" />
   <cfparam name="select_tickettype" default="%" />     
       <cfparam name="select_pgid" default="%" />     
<cfquery name="details"   datasource="#dsn#"   >
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
 INNER JOIN taousers_tbl u ON u.userid = t.userid
 left JOIN pgpages p ON p.pgid = t.pgid
 LEFT JOIN taoversions v ON v.verid = t.verid
WHERE t.ticketid = #recid#

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