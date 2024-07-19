<cfinclude template="/include/remote_load.cfm" />


<cfparam name="new_userid" default="" />

<cfparam name="new_audRoleID" default="" />

<cfparam name="new_audTypeID" default="" />

<cfparam name="new_audLocation" default="" />

<cfparam name="new_audlocid" default="" />

<cfparam name="new_eventStart" default="" />

<cfparam name="new_eventStartTime" default="" />

<cfparam name="new_eventStopTime" default="" />

<cfparam name="new_audplatformid" default="" />

<cfparam name="new_audStepID" default="1" />

<cfparam name="new_parkingDetails" default="" />

<cfparam name="new_workwithcoach" default="0" />

<cfparam name="new_isDeleted" default="0" />

<cfparam name="new_trackmileage" default="0" />

<cfparam name="new_audbooktypid" default="0" />

<cfparam name="new_callbacktypid" default="" />

<cfparam name="new_eventLocation" default="" />

<cfparam name="new_audlocadd1" default="" />

<cfparam name="new_audlocadd2" default="" />

<cfparam name="new_audcity" default="" />

<cfparam name="new_region_id" default="" />

<cfparam name="new_audzip" default="" />

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



<cfquery name="auditions_ins" datasource="#dsn#" result="result" >
  
UPDATE events_tbl  SET 

userid = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#new_userid#"  null="#NOT len(trim(new_userid))#" /> ,

audRoleID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#new_audRoleID#"  null="#NOT len(trim(new_audRoleID))#" /> ,

audTypeID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#new_audTypeID#"  null="#NOT len(trim(new_audTypeID))#" /> ,
    

audBookTypeID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#new_audBookTypeID#"  null="#NOT len(trim(new_audBookTypeID))#" /> ,
    
audLocation = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#new_audLocation#" maxlength="500" null="#NOT len(trim(new_audLocation))#" /> ,
    
eventLocation = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#new_eventLocation#" maxlength="500" null="#NOT len(trim(new_eventLocation))#" /> ,
    
audlocadd1 = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#new_audlocadd1#" maxlength="500" null="#NOT len(trim(new_audlocadd1))#" /> ,

audlocadd2 = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#new_audlocadd2#" maxlength="500" null="#NOT len(trim(new_audlocadd2))#" /> ,
    
audcity = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#new_audcity#" maxlength="500" null="#NOT len(trim(new_audcity))#" /> ,
    
region_id = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#new_region_id#" maxlength="2" null="#NOT len(trim(new_region_id))#" /> ,
    
audzip = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#new_audzip#" maxlength="10" null="#NOT len(trim(new_audzip))#" /> ,

eventStart = <cfqueryparam cfsqltype="CF_SQL_DATE" value="#new_eventStart#"  null="#NOT len(trim(new_eventStart))#" /> ,

eventStartTime = <cfqueryparam cfsqltype="CF_SQL_TIME" value="#new_eventStartTime#"  null="#NOT len(trim(new_eventStartTime))#" /> ,

eventStopTime = <cfqueryparam cfsqltype="CF_SQL_TIME" value="#new_eventStopTime#"  null="#NOT len(trim(new_eventStopTime))#" /> ,

audplatformID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#new_audplatformid#"  null="#NOT len(trim(new_audplatformid))#" /> ,

audStepID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#new_audStepID#"  null="#NOT len(trim(new_audStepID))#" /> ,

parkingDetails = <cfqueryparam cfsqltype="CF_SQL_LONGVARCHAR" value="#new_parkingDetails#"  null="#NOT len(trim(new_parkingDetails))#" /> ,

workwithcoach = <cfqueryparam cfsqltype="CF_SQL_BIT" value="#new_workwithcoach#"  null="#NOT len(trim(new_workwithcoach))#" /> ,
    
trackmileage = <cfqueryparam cfsqltype="CF_SQL_BIT" value="#new_trackmileage#"  null="#NOT len(trim(new_trackmileage))#" /> ,
    
<cfif #new_callbacktypeid# is not "">
    
    callbacktypeid = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#new_callbacktypeid#"  null="#NOT len(trim(new_callbacktypeid))#" /> ,
    
</cfif>

isDeleted = <cfqueryparam cfsqltype="CF_SQL_BIT" value="#new_isDeleted#"  null="#NOT len(trim(new_isDeleted))#" /> 

    
WHERE eventid = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#new_eventid#" /> 

</cfquery>
    
        
        <cfoutput>

        <cfset eventstart="#new_eventStart#" />

        <cfset eventStartTime="#new_eventStartTime#" />

        <cfset eventStopTime="#new_eventStopTime#" />

    </cfoutput>
    
    
    
 <cfquery datasource="#dsn#" name="FInd"  >
update events
     set eventid = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#new_eventid#" />  
     
     
     <cfif #eventStart# is not "">,eventstart =<cfqueryparam cfsqltype="cf_sql_date" value="#eventStart#" /></cfif>
             <cfif #eventStartTime# is not "">,eventStartTime = <cfqueryparam cfsqltype="cf_sql_time" value="#eventStartTime#" /></cfif>
          <cfif #eventStopTime# is not "">,eventStopTime =<cfqueryparam cfsqltype="cf_sql_time" value="#eventStopTime#" /></cfif>
     
     
     
    WHERE eventid = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#new_eventid#" /> 
    
</cfquery>  
    
    
    
    
    
    
