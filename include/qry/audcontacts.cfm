<cfparam name="dbug" default="N" />
<cfparam name="audprojectid" default="0" />
<CFINCLUDE template="/include/remote_load.cfm" />


<cfquery name="audcontacts" datasource="#dsn#">
SELECT distinct d.contactid
,d.recordname as contactname

,d.contactStatus

  
    
FROM contactdetails d

INNER JOIN audcontacts_auditions_xref X ON x.contactid = d.contactid

 
WHERE x.audprojectid = #audprojectid# 
    
    
    ORDER BY d.recordname
</cfquery>

<cfquery name="audcontacts_sel" datasource="#dsn#">
SELECT distinct d.contactid
,d.recordname as contactname

,d.contactStatus

  
    
FROM contactdetails d where d.userid = #userid# and d.contact_id NOT IN 
(select contact_id from audcontacts_auditions_xref where audprojectid = #audprojectid#)
    
    
    ORDER BY d.recordname
</cfquery>