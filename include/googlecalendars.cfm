<cfparam name="userid" default="30" />

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

<cfhttp url="https://dev.theactorsoffice.com/include/get_google_calendars.cfm?userid=#userid#" method="get" result="calendarsResponse">
</cfhttp>

<cfset calendars = DeserializeJSON(calendarsResponse.FileContent)>

<cfloop array="#calendars.items#" index="calendar">
    <cfoutput>
        Calendar ID: #calendar.id#<br>
        Summary: #calendar.summary#<br>
        <!-- Add other fields as needed -->
    </cfoutput>
</cfloop>