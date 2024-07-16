<CFINCLUDE template="/include/remote_load.cfm" />

<cfquery name="countries"  datasource="#dsn#" >
SELECT countryid, countryname FROM countries 
    WHERE isdeleted = 0 and countryid in (select countryid from regions)
    ORDER BY countryname
</cfquery>