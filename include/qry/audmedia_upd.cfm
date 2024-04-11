<cfinclude template="/include/remote_load.cfm" />

<cfparam name="new_isshare" default="1" />


<cfparam name="new_mediaTypeID" default="" />

<cfparam name="new_mediaURL" default="" />

<cfparam name="new_mediaName" default="" />

 

<cfparam name="new_mediaFilename" default="" />

<cfparam name="new_mediaExt" default="" />

<cfparam name="new_userid" default="" />

<cfparam name="new_isDeleted" default="0" />

 <cfif #left(new_mediaURL,4)# is not "http">
<cfset new_mediaURL = "https://#new_mediaURL#" />
</cfif>




<cfquery name="audmedia_upd" datasource="#dsn#" >
  
UPDATE audmedia  SET 

mediaTypeID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#new_mediaTypeID#"  null="#NOT len(trim(new_mediaTypeID))#" /> ,

mediaURL = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#new_mediaURL#"  null="#NOT len(trim(new_mediaURL))#" /> ,

mediaName = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#new_mediaName#"  null="#NOT len(trim(new_mediaName))#" /> ,
<cfif #isdefined('sdffdsfsdds')#>
mediaFilename = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#new_mediaFilename#" maxlength="200" null="#NOT len(trim(new_mediaFilename))#" /> ,

mediaExt = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#new_mediaExt#" maxlength="3" null="#NOT len(trim(new_mediaExt))#" /> ,
</cfif>
userid = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#new_userid#"  null="#NOT len(trim(new_userid))#" /> ,

isDeleted = <cfqueryparam cfsqltype="CF_SQL_BIT" value="#new_isDeleted#"  null="#NOT len(trim(new_isDeleted))#" /> ,

isShare = <cfqueryparam cfsqltype="CF_SQL_BIT" value="#new_isShare#"  null="#NOT len(trim(new_isShare))#" /> 

WHERE mediaID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#new_mediaID#" /> 

</cfquery>
