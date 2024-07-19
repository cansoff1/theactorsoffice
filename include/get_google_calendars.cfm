<cfquery datasource="abod" name="FindUser">
    SELECT
    u.userid
    ,u.recordname
    ,u.userFirstName
    ,u.userLastName
    ,u.userEmail
    ,u.contactid
    ,u.userRole
    ,u.IsBetaTester
    ,u.defRows
    ,u.calstarttime
    ,u.calendtime
    ,u.avatarname
    ,u.contactid AS userContactID
    ,u.tzid
    ,t.tzname
    ,u.customerid
     ,u.countryid
    ,left(u.passwordhash,10) as U
     ,u.viewtypeid, u.add1, u.add2, u.city, u.region_id, u.zip
    ,isauditionmodule
    ,u.access_token
    ,u.refresh_token
    FROM taousers u
    LEFT join timezones t on t.tzid = u.tzid
    WHERE u.userid = #userid#
</cfquery>

<cfset access_token = finduser.access_token/>

<cfset apiUrl = "https://www.googleapis.com/calendar/v3/users/me/calendarList">
<cfset accessToken = "#access_token#"> 

<cfhttp url="#apiUrl#" method="get" result="calendarListResponse">
    <cfhttpparam type="header" name="Authorization" value="Bearer #accessToken#">
</cfhttp>


<cfabort>

<cfset calendars = DeserializeJSON(calendarListResponse.FileContent)>

<cfset calendarsJSON = SerializeJSON(calendars)>
<cfheader name="Content-Type" value="application/json">
<cfoutput>#calendarsJSON#</cfoutput>
