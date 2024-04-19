<cfif not #isdefined('recid')#>
<cfset recid = verid />
</cfif>
<CFINCLUDE template="/include/remote_load.cfm" />
<cfquery name="details"  datasource="#dsn#"  >
SELECT 
v.verid
,v.major
,v.minor
,v.patch
,v.alphabeta,v.version
,v.releasedate
,v.releaseTime
,v.reviewDate
,v.reviewtime
,v.versionstatus
,v.isActive
,((v.hoursavail) - (SELECT SUM(esthours) FROM tickets t WHERE verid = v.verid)) AS hoursleft 
,CONCAT(v.major,'.',v.minor,'.',v.patch,'.',v.version) AS vername
,(SELECT COUNT(*) FROM tickets WHERE verid = v.verid) AS total_tickets
,(SELECT sum(esthours) FROM tickets WHERE verid = v.verid) AS total_hours
 FROM taoversions v
where v.verid = #recid#
 </cfquery>   



<cfquery name="results"   datasource="#dsn#"   >
SELECT 
'ID' as head1
,'Details' as head2    
,'Page' as head3  
,'Type' as head4 
,'Status' as head45
,'Priority' as head5
,'Hours' as head6
,'Release' as head7
,t.ticketID as col1
    ,t.ticketID as recid
,t.ticketName AS col2   
,p.pgname AS col3
,t.tickettype as col4
,t.ticketstatus as col45
,t.ticketpriority as col5
,t.esthours as col6
,CONCAT(v.major,'.',v.minor,'.',v.patch,'.',v.version) AS col7

,p.pgname
,p.pgdir
,v.verid
 FROM tickets t
 INNER JOIN taousers u ON u.userid = t.userid
 INNER JOIN pgpages p ON p.pgid = t.pgid
inner join taoversions v on v.verid = t.verid
WHERE t.verid =  #recid#
    order by t.ticketid desc
</cfquery>


    	<cfquery name="priorities" datasource="#dsn#" >
    
    SELECT ticketpriority AS id, ticketpriority AS name FROM ticketpriority ORDER BY orderNo
    </cfquery>
    