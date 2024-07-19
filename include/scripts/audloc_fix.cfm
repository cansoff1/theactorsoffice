         <CFINCLUDE template="/include/remote_load.cfm" /><cfquery datasource="#dsn#" name="x"  >
SELECT a.eventid,l.eventLocation,l.audlocadd1,l.audlocadd2,l.audcity,l.region_id,l.audzip FROM audlocations l INNER JOIN events a ON a.audlocid = l.audlocid
         </cfquery>

<cfloop query="x">


<cfquery datasource="#dsn#" name="update"  >
UPDATE auditions
    SET eventLocation = <cfqueryparam cfsqltype="cf_sql_varchar" value="#x.eventLocation#" />
    
    ,audlocadd1 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#x.audlocadd1#" />
    ,audlocadd2 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#x.audlocadd2#" />
    ,audcity = <cfqueryparam cfsqltype="cf_sql_varchar" value="#x.audcity#" />
    ,region_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#x.region_id#" />
    ,audzip = <cfqueryparam cfsqltype="cf_sql_varchar" value="#x.audzip#" />
    
    where eventid = <cfqueryparam cfsqltype="cf_sql_integer" value="#x.eventid#" />

    </cfquery>
    
 

</cfloop>
