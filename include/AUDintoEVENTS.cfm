<cfparam name="new_audtypeid" default="" />

<cfparam name="new_audLocation" default="" />

<cfparam name="new_audlocid" default="" />

<cfparam name="new_eventStart" default="" />

<cfparam name="new_eventStartTime" default="" />

<cfparam name="new_eventStopTime" default="" />

<cfparam name="new_contactid" default="" />

<cfif #new_audtypeid# is not "">

    <cfquery datasource="#dsn#" name="findtype">
        SELECT audtype FROM audtypes WHERE audtypeid = #new_audtypeid#
    </cfquery>

    <cfoutput>

        <cfset new_audtype="#findtype.audtype#" />

    </cfoutput>

    <cfif #new_audtype# is "Online">

        <cfif #new_audlocation# is not "">

            <cfset eventLocation="Online: #new_audLocation#" />

        </cfif>

        <Cfif #new_audlocation# is "">

            <cfset eventlocation="" />

        </Cfif>

    </cfif>

    <cfif #new_audtype# is not "Online">

    

            <cfquery datasource="#dsn#" name="findloc">
                SELECT 
                ad.eventLocation
                ,ad.audlocadd1
                ,ad.audlocadd2
                ,ad.audcity
                ,ad.region_id
                ,ad.audzip
                ,rg.regionname
                ,c.countryname 
                FROM events  ad
                LEFT OUTER JOIN regions rg on rg.region_id = ad.region_id  
                LEFT OUTER JOIN countries c on rg.countryid = c.countryid
                where ad.eventid = #new_eventid#
            </cfquery>

            <cfoutput>

                <cfset eventlocation="#findloc.eventLocation#<cfif #findloc.audlocadd1# is not "">, #findloc.audlocadd1#</cfif><cfif #findloc.audlocadd2# is not "">, #findloc.audlocadd2#</cfif><cfif #findloc.audcity# is not "">, #findloc.audcity#<cfif>
                
                <cfif #findloc.regionname# is not ""> ,#findloc.regionname#</cfif> #findloc.audzip#<cfif #findloc.countryname# is not ""> , #findloc.countryname#</cfif>" />

            </cfoutput>
 

        <cfif #new_audlocid# is "0">

            <cfset eventlocation="" />

        </cfif>

    </cfif>

    <cfoutput>

        <cfset eventstart="#new_eventStart#" />

        <cfset eventStartTime="#new_eventStartTime#" />

        <cfset eventStopTime="#new_eventStopTime#" />

    </cfoutput>



    <cfquery datasource="#dsn#" name="add" result="result">
        INSERT INTO events_tbl (
        eventTitle
        ,eventTypeName
        ,eventDescription
        ,eventLocation
        <cfif #eventStart# is not "">,eventStart</cfif>
        <cfif #eventStartTime# is not "">,eventStartTime</cfif>
        <cfif #eventStopTime# is not "">,eventStopTime</cfif>
        ,userid
        ,eventid)

        VALUES (
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#new_projname#" />
        ,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="Audition" />
        ,
        <cfqueryparam cfsqltype="cf_sql_longvarchar" value="#new_projDescription#" />
        ,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#eventLocation#" />
        <cfif #eventStart# is not "">,
            <cfqueryparam cfsqltype="cf_sql_date" value="#eventStart#" />
        </cfif>
        <cfif #eventStartTime# is not "">,'#eventStartTime#'</cfif>
        <cfif #eventStopTime# is not "">,
            <cfqueryparam cfsqltype="cf_sql_time" value="#eventStopTime#" />
        </cfif>
        ,
        <cfqueryparam cfsqltype="cf_sql_integer" value="#cookie.userid#" />
        ,
        <cfqueryparam cfsqltype="cf_sql_integer" value="#new_eventid#" />
        )
    </cfquery>

    <cfset new_eventid=result.GENERATEDKEY />

    <cfquery datasource="#dsn#" name="t">
        UPDATE events
        SET eventstarttime = '12:00:00'
        WHERE eventstarttime IS NULL
    </cfquery>

    <cfquery datasource="#dsn#" name="tt">
        UPDATE events
        SET eventstoptime = TIME((ADDTIME(TIME(eventstarttime), TIME('01:00:00')))%(TIME('24:00:00')))
        WHERE eventstarttime IS NOT NULL AND eventstoptime IS NULL
    </cfquery>

    <cfquery datasource="#dsn#" name="dd">
        UPDATE events SET eventstop = eventstart WHERE eventstop IS NULL AND eventstart IS NOT null;
    </cfquery>
<cfif #new_contactid# is not "">
    
    
    <cfquery datasource="#dsn#" name="inserts">
        Insert into eventcontactsxref (eventid,contactid) values (
        <cfqueryparam cfsqltype="cf_sql_integer" value="#new_eventid#" />,
        <cfqueryparam cfsqltype="cf_sql_integer" value="#new_contactid#" />)
    </cfquery>
    
    </cfif>
    
    

</cfif>
