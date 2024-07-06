<CFINCLUDE template="/include/remote_load.cfm" />
 

<cfquery name="update" datasource="#dsn#" >
UPDATE tickets

    <cfif #new_verid# is "NULL">
   SET verid = NULL
        ,ticketstatus = 'Pending'
        <cfelse>
  SET verid = <cfqueryparam cfsqltype="cf_sql_integer" value="#new_verid#" />      
    </cfif>
        
        
        
,ticketpriority = <cfqueryparam cfsqltype="cf_sql_varchar" value="#new_ticketpriority#" />    

WHERE ticketid = <cfqueryparam cfsqltype="cf_sql_integer" value="#ticketid#" />    
</cfquery>

    <cfquery name="details" datasource="#dsn#" >
        select ticketstatus as new_ticketstatus from tickets where ticketid = #ticketid#
    </cfquery>
    <cfoutput>
    <cfset new_ticketstatus = "#details.new_ticketstatus#" />
    </cfoutput>

<cfif "#old_ticketpriority#" is not "#new_ticketpriority#">

    <cfoutput>
    <cfset new_tlogDetails = "changed PRIORITY from <strong>#chr(34)##old_ticketpriority##chr(34)#</strong> to <strong>#chr(34)##new_ticketpriority##chr(34)#</strong>." />
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
                
  
    
      
    
<Cfif #isdefined('oldverid')#>

<cflocation url="/app/version/?recid=#oldverid#" />  
<cfelse>
<cflocation url="/app/admin-support/" />  
</Cfif>

     