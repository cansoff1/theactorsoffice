<cfquery name="timezones"  datasource="#dsn#"   >	
SELECT tzid,gmt,tzname,utchouroffset FROM timezones
ORDER BY utcHourOffset
</cfquery>		

<cfquery name="timezones_min"  datasource="#dsn#"   >	
SELECT tzid,gmt,tzname,tzgeneral,utchouroffset FROM timezones
WHERE tzgeneral IS NOT null and tzgeneral <> ''
ORDER BY gmt
</cfquery>	