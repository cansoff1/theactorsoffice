
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
    ,v.hoursavail
    ,v.build
,v.reviewtime
,v.versionstatus
,v.isActive
,CONCAT(v.major,'.',v.minor,'.',v.patch,'.',v.version,'.',v.version,'.',v.build) AS vername
,(SELECT COUNT(*) FROM tickets WHERE verid = v.verid) AS total_tickets
,(SELECT sum(esthours) FROM tickets WHERE verid = v.verid) AS total_hours
 FROM taoversions v
where v.verid = #recid#
 </cfquery>   
    	<cfquery name="statuses" datasource="#dsn#" >
  SELECT 'Completed' AS id, 'Completed' AS name FROM ticketstatuses 
  UNION
    SELECT 'Pending' AS id, 'Pending' AS name FROM ticketstatuses 
           
     
    </cfquery>