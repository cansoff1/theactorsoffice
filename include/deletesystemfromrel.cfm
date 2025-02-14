 

<cfset dbug="n" />
 
<cfparam name="idlist" default="0" />

<Cfif not #isdefined('session.idlist')#>
<cfset session.idlist = idlist />

</cfif>

 <cfif #idlist# is "0" and #session.idlist# is not "0">
 <cfset idlist = session.idlist />

 </cfif>



<CFINCLUDE template="/include/remote_load.cfm" />
<Cfset session.pg_action = "bulk" />
<cfquery name="find_d"  datasource="#dsn#" >	
select count(*) as totals
from  fusystemusers_tbl  
where isdeleted = 0
and contactid IN (#idlist#)
AND systemid = #new_systemid#
</cfquery>


 
<cfquery name="deletesystem"  datasource="#dsn#" >	
update fusystemusers_tbl  
SET isdeleted = 1
WHERE contactid IN (#idlist#)
AND systemid = #new_systemid#
</cfquery>


 <cflocation url="/app/contacts/?pgaction=bulk&bt=system&d=#find_d.recordcount#&s=0&a=0&t=#new_systemid#" />