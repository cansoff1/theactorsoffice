<CFINCLUDE template="/include/remote_load.cfm" />

<cfquery name="results"  datasource="#dsn#"  >
SELECT 
v.verid

,'Release' as head1
,'Review Date' as head2
,'Release Date' as head3
,'Status' as head4
,'Total Tickets' as head5
,'Hours Left' as head6

    
    
,CONCAT(v.major,'.',v.minor,'.',v.patch,'-',v.version) AS col1
,v.reviewDate as col2
,v.reviewtime 
,v.releasedate as col3
,v.releaseTime
,v.versionstatus  as col4
,(SELECT COUNT(*) FROM tickets WHERE verid = v.verid) AS col5
,(SELECT sum(esthours) FROM tickets WHERE verid = v.verid) AS col6b   
    
,v.major
,v.minor
,v.patch
,v.alphabeta

,((v.hoursavail) - (SELECT SUM(esthours) FROM tickets t WHERE verid = v.verid)) AS col6 
,v.isActive


 FROM taoversions v
 
 ORDER BY v.major,v.minor,v.patch
 </cfquery>   