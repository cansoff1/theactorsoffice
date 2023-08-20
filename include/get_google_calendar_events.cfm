<cfquery datasource="abo" name="FindUser">
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
     ,u.viewtypeid, u.add1, u.add2, u.city, u.regionid, u.zip
    ,isauditionmodule
    ,u.access_token
    ,u.refresh_token
    FROM taousers u
    LEFT join timezones t on t.tzid = u.tzid
    WHERE u.userid = 30
</cfquery>

<cfset access_token = finduser.access_token/>

<cfset calendarId = "primary">
<cfset apiUrl = "https://www.googleapis.com/calendar/v3/calendars/#calendarId#/events">
<cfset accessToken = "#access_token#"> <!-- Replace with the access token from the database -->

<cfhttp url="#apiUrl#" method="get" result="calendarResponse">
    <cfhttpparam type="header" name="Authorization" value="Bearer #accessToken#">
</cfhttp>

<cfset events = DeserializeJSON(calendarResponse.FileContent)>

<cfdump var="#events#">
