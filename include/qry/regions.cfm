<CFINCLUDE template="/include/remote_load.cfm" />

<cfquery name="regions"  datasource="#dsn#" >
SELECT countryid, region_id,regionname FROM regions ORDER BY regionname
</cfquery>