


<cfparam name="new_audlocid" default="" />

<cfparam name="new_eventLocation" default="" />

<cfparam name="new_audlocadd1" default="" />

<cfparam name="new_audlocadd2" default="" />

<cfparam name="new_audcity" default="" />

<cfparam name="new_audzip" default="" />

<cfparam name="new_regionid" default="" />

<cfparam name="new_isDeleted" default="0" />

 
<CFINCLUDE template="/include/remote_load.cfm" />

<cfquery name="audlocations_upd" datasource="#dsn#" result="result" >
  
UPDATE audlocations  SET 

    userid = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#new_userid#"  null="#NOT len(trim(new_userid))#" /> ,

    eventLocation = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#new_eventLocation#" maxlength="500" null="#NOT len(trim(new_eventLocation))#" />,

    audlocadd1 = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#new_audlocadd1#" maxlength="500" null="#NOT len(trim(new_audlocadd1))#" />,

    audlocadd2 = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#new_audlocadd2#" maxlength="500" null="#NOT len(trim(new_audlocadd2))#" />,

    audcity = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#new_audcity#" maxlength="500" null="#NOT len(trim(new_audcity))#" />,

    regionid = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#new_regionid#" maxlength="3" null="#NOT len(trim(new_regionid))#" />,

    audzip = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#new_audzip#" maxlength="50" null="#NOT len(trim(new_audzip))#" />,

    isDeleted = <cfqueryparam cfsqltype="CF_SQL_BIT" value="#new_isDeleted#"  null="#NOT len(trim(new_isDeleted))#" /> 

WHERE audlocid = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#new_audlocid#" /> 

</cfquery>

     <cfoutput>
     <cfset returnurl = "/app/audition/?audprojectid=#audprojectid#&eventid=#eventid#&secid=#secid#&focusid=#eventid#" />
     </cfoutput>


<cflocation url="#returnurl#" />