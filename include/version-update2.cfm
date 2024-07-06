<CFINCLUDE template="/include/remote_load.cfm" />
 

<cfquery name="update" datasource="#dsn#" >
UPDATE taoversions
SET major = <cfqueryparam cfsqltype="cf_sql_integer" value="#new_major#" />
,minor = <cfqueryparam cfsqltype="cf_sql_integer" value="#new_minor#" />
,patch = <cfqueryparam cfsqltype="cf_sql_integer" value="#new_patch#" />
,versionstatus = <cfqueryparam cfsqltype="cf_sql_varchar" value="#new_versionstatus#" />
,version = <cfqueryparam cfsqltype="cf_sql_integer" value="#new_version#" />
,build = <cfqueryparam cfsqltype="cf_sql_integer" value="#new_build#" />

    
<cfif #new_reviewDate# is not "">
,reviewDate = <cfqueryparam cfsqltype="cf_sql_date" value="#new_reviewDate#" />
</cfif>

<cfif #new_releaseDate# is not "">
,releaseDate = <cfqueryparam cfsqltype="cf_sql_date" value="#new_releaseDate#" />
</cfif>

<cfif #new_reviewtime# is not "">
,reviewtime = <cfqueryparam cfsqltype="cf_sql_time" value="#new_reviewtime#" />
</cfif>

<cfif #new_releasetime# is not "">
,releasetime = <cfqueryparam cfsqltype="cf_sql_time" value="#new_releasetime#" />
</cfif>

<cfif #new_hoursavail# is not "">
,hoursavail = <cfqueryparam cfsqltype="cf_sql_float" value="#numberformat(new_hoursavail,9.99)#" />
</cfif>

WHERE verid = <cfqueryparam cfsqltype="cf_sql_integer" value="#verid#" />    
</cfquery>

<cflocation url="/app/version/?recid=#verid#" />       
