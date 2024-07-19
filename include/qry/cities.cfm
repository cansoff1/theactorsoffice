<CFINCLUDE template="/include/remote_load.cfm" />

<cfquery name="cities"  datasource="#dsn#" >
SELECT id, countryid, region_id, cityname FROM cities ORDER BY cityname
</cfquery>