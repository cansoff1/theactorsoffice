<cfinclude template="/include/remote_load.cfm" />

<cfparam name="new_userid" default="" />

<cfparam name="new_audRoleID" default="" />

<cfparam name="new_audTypeID" default="" />

<cfparam name="new_audLocation" default="" />

<cfparam name="new_audlocid" default="" />

<cfparam name="new_eventStart" default="" />

<cfparam name="new_eventStartTime" default="" />

<cfparam name="new_eventStopTime" default="" />

<cfparam name="new_audplatformid" default="4" />

<cfparam name="new_audStepID" default="1" />

<cfparam name="new_parkingDetails" default="" />

<cfparam name="new_workwithcoach" default="0" />

<cfparam name="new_isDeleted" default="0" />

<cfparam name="new_trackmileage" default="0" />

<cfif #new_eventStartTime# is not "">

    <cfinclude template="/include/qry/duration.cfm" />

 <cfset new_durseconds = duration.durseconds />
    
    
<cfset new_eventStopTime = "#DateAdd("s","#new_eventStartTime#","#new_durseconds#")#" />

<cfoutput>
    
    new_eventStartTime: #timeformat(new_eventStartTime,'HH:MM:SS')#<BR>
    new_durseconds: #new_durseconds#<BR>

  statement:     SELECT ADDTIME("#timeformat('#new_eventStartTime#','HH:MM:SS')#", "#new_durseconds#") as new_eventStopTime <BR>  
    
        <cfset new_eventStopTime="#timeformat(DateAdd("s","#new_durseconds#","#new_eventStartTime#"),'HH:MM:SS')#" />
   
    
    new_eventStopTime: #new_eventStopTime#<BR>
    
    </cfoutput>

</cfif>

<cfquery name="auditions_ins" datasource="#dsn#" result="result">


    INSERT INTO events_tbl (

    userid,

    audRoleID,

    audTypeID,

    audLocation,

    eventStart,

    eventStartTime,

    eventStopTime,

    audplatformID,

    audStepID,

    parkingDetails,

    workwithcoach,

    trackmileage )


    VALUES (

    <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#new_userid#" null="#NOT len(trim(new_userid))#" />,

    <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#new_audRoleID#" null="#NOT len(trim(new_audRoleID))#" />,

    <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#new_audTypeID#" null="#NOT len(trim(new_audTypeID))#" />,

    <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#new_audLocation#" maxlength="500" null="#NOT len(trim(new_audLocation))#" />,

    <cfqueryparam cfsqltype="CF_SQL_DATE" value="#new_eventStart#" null="#NOT len(trim(new_eventStart))#" />,

    <cfqueryparam cfsqltype="CF_SQL_TIME" value="#new_eventStartTime#" null="#NOT len(trim(new_eventStartTime))#" />,

    <cfqueryparam cfsqltype="CF_SQL_TIME" value="#new_eventStopTime#" null="#NOT len(trim(new_eventStopTime))#" />,

    <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#new_audplatformid#" null="#NOT len(trim(new_audplatformid))#" />,

    <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#new_audStepID#" null="#NOT len(trim(new_audStepID))#" />,

    <cfqueryparam cfsqltype="CF_SQL_LONGVARCHAR" value="#new_parkingDetails#" null="#NOT len(trim(new_parkingDetails))#" />,

    <cfqueryparam cfsqltype="CF_SQL_BIT" value="#new_workwithcoach#" null="#NOT len(trim(new_workwithcoach))#" />,

    <cfqueryparam cfsqltype="CF_SQL_BIT" value="#new_trackmileage#" null="#NOT len(trim(new_trackmileage))#" /> 

    );
</cfquery>

<cfset new_eventid = result.generatedkey>
    
    
    <cfquery datasource="#dsn#" name="update"  >
Update events set 
eventLocation = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#new_eventLocation#" maxlength="500" null="#NOT len(trim(new_eventLocation))#" /> ,
audlocadd1 = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#new_audlocadd1#" maxlength="500" null="#NOT len(trim(new_audlocadd1))#" /> ,
audlocadd2 = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#new_audlocadd2#" maxlength="500" null="#NOT len(trim(new_audlocadd2))#" /> ,
audcity = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#new_audcity#" maxlength="500" null="#NOT len(trim(new_eventLocation))#" /> , 
region_id = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#new_region_id#" maxlength="2" null="#NOT len(trim(new_region_id))#" /> ,
audzip = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#new_audzip#" maxlength="10" null="#NOT len(trim(new_audzip))#" />    
where eventid = #new_eventid#
</cfquery>

 

