


<cfquery name="results"     >
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
,CONCAT(v.major,'.',v.minor,'.',v.patch,'.',v.version,'.',v.build) AS col7

,p.pgname
,p.pgdir
 FROM tickets t
 INNER JOIN taousers_tbl u ON u.userid = t.userid
 INNER JOIN pgpages p ON p.pgid = t.pgid
inner join taoversions v on v.verid = t.verid
WHERE t.ticketstatus in ('Implemented','Testing')
</cfquery>