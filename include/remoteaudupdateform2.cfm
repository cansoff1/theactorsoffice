<cfparam name="NEW_AUDBOOKTYPEID" default="0" />

<cfparam name="essence" default="" />

<cfinclude template="/include/remote_load.cfm" />

    <cfquery name="FIND" datasource="#dsn#" maxrows="1">
        Select audplatformid from audPlatforms_user_tbl where userid = #userid# and audplatform = '#CustomPlatform#'
    </cfquery>

<cfif #new_audPlatformid# is "CustomPlatform" and #CustomPlatform# is not "" and #find.recordcount# is "0">

    <cfquery name="insert" datasource="#dsn#" result="resultx">
        INSERT INTO audPlatforms_user_tbl (audPlatform,userid)
        VALUES ('#CustomPlatform#',#userid#)
    </cfquery>

    <cfset new_audPlatformid=resultx.generatedkey>

<Cfelseif #new_audplatformid# is "CustomPlatform" and #CustomPlatform# is not "" and #find.recordcount# is "1">

    <cfset new_audPlatformid=find.audplatformid />

<Cfelseif #new_audplatformid# is "CustomPlatform" and #CustomPlatform# is "">

    <cfset new_audPlatformid=old_audplatformid />

</cfif>
      
      
      
      
      
      
      


<cfinclude template="/include/qry/auditions_upd.cfm" />



<cfquery datasource="#dsn#" name="activate">
update events_tbl set isdeleted = 0 where eventid = #new_eventid#
</cfquery>


<cfquery datasource="#dsn#" name="FindEvent" maxrows="1" >
SELECT eventid,eventstart,eventstarttime,eventstoptime FROM events WHERE eventid = #new_eventid#
</cfquery>

 
  <cfquery name="auditionDetails" datasource="#dsn#">
SELECT 
pr.audprojectid as recid,
ad.eventid,
pr.audprojectid,
ad.audLocation,
ad.eventStart,
ad.eventStartTime,
ad.eventStopTime,
ad.parkingDetails,
ad.workwithcoach,
t.audtype,
s.audstep,
s.audstepid,
ad.audroleid,
ad.trackmileage,
ad.eventLocation,
pl.audplatform,
r.audprojectID,
pr.audSubCatID,
ad.audlocid,
t.islocation,
ad.audbooktypeid,
bt.audbooktype,
cbt.callbacktype,
cbt.callbacktypeid,
sub.audcatid,
ad.audtypeid,
ad.audlocadd1,
ad.audzip,
ad.audlocadd2,
ad.audcity,
ad.region_id,
rg.countryid,
c.countryname,
rg.regionname
    
FROM audprojects pr
    
    INNER JOIN audroles r ON pr.audprojectID = r.audprojectID
    
LEFT OUTER JOIN events_tbl ad ON r.audroleid = ad.audroleid 

LEFT OUTER JOIN audsubcategories sub on sub.audsubcatid = pr.audsubcatid
        
LEFT OUTER JOIN audcallbacktypes cbt on cbt.callbacktypeid = ad.callbacktypeid               

LEFT OUTER JOIN audtypes t ON t.audtypeid = ad.audtypeid

LEFT OUTER JOIN audplatforms pl on pl.audplatformid = ad.audplatformid

LEFT OUTER JOIN audsteps s ON s.audstepid = ad.audstepid
        
LEFT OUTER JOIN audbooktypes bt on bt.audbooktypeid = ad.audbooktypeid
    
LEFT OUTER JOIN regions rg on rg.region_id = ad.region_id
    
LEFT OUTER JOIN countries c on rg.countryid = c.countryid
    
WHERE  ad.eventid = #new_eventid#
</cfquery>

<cfquery name="projectDetails" datasource="#dsn#">
SELECT 
proj.`audprojectID`, 
r.audroleid,
proj.`projName`, 
proj.projDescription,
cat.`audCatName`, 
cat.audcatid,
subcat.`audSubCatName`, 
subcat.audsubcatid,
proj.contactid,
ct.contracttype,
ton.tone, 
net.network,
un.`unionName`,    
c.recordname as castingFullName
FROM audprojects proj 
    INNER JOIN audroles r on r.audprojectid = proj.audprojectid
    LEFT OUTER  JOIN audcontracttypes ct ON ( proj.`contractTypeID` = ct.contracttypeid  )  
	LEFT OUTER  JOIN audsubcategories subcat ON ( proj.`audSubCatID` = subcat.`audSubCatId`  )  
	LEFT OUTER  JOIN audcategories cat ON ( subcat.`audCatId` = cat.`audCatId`  )  
	LEFT OUTER JOIN audtones_user ton ON ( proj.`toneID` = ton.toneid  )  
	LEFT OUTER JOIN audnetworks_user net ON ( proj.`networkID` = net.networkid  )  
	LEFT OUTER JOIN contactdetails c on c.contactid = proj.contactid
	LEFT OUTER JOIN audunions un ON ( proj.`unionID` = un.`unionID`  )   
WHERE proj.audprojectID = #audprojectID#
</cfquery>

    
    <cfset new_audtypeid = auditionDetails.audtypeid />
    
    <cfset new_audLocation = auditionDetails.audLocation />
    
    <cfset new_audlocid = auditionDetails.audlocid />

    <cfset new_eventStart = auditionDetails.eventStart />
    
    <cfset new_eventStartTime = auditionDetails.eventStartTime />

    <cfset new_eventStopTime = auditionDetails.eventStopTime />
    
    <cfset new_contactid = projectDetails.contactid />
    
    <cfset new_projname = projectDetails.projName />
    
    <cfset new_projDescription = projectDetails.projDescription />



<cfif #FindEvent.recordcount# is "1">

    <cfquery datasource="#dsn#" name="updateEvent" >
    update events

    set eventid = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#findEvent.eventid#" /> 
        
         <cfif #new_eventStart# is not "">
       , eventstart = <cfqueryparam cfsqltype="CF_SQL_DATE" value="#new_eventStart#"  null="#NOT len(trim(new_eventStart))#" />
        </cfif>
        <cfif #new_eventStartTime# is not "">,
   eventStartTime = <cfqueryparam cfsqltype="CF_SQL_TIME" value="#new_eventStartTime#"  null="#NOT len(trim(new_eventStartTime))#" /> 
</cfif>
        
                <cfif #new_eventStopTime# is not "">,
    eventstoptime = <cfqueryparam cfsqltype="CF_SQL_TIME" value="#new_eventStopTime#"  null="#NOT len(trim(new_eventStopTime))#" /> 
        </cfif>
    where eventid = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#findEvent.eventid#" /> 
    </cfquery>

</cfif>


<cfif #findEvent.recordcount# is "0">
    
 
     

</cfif>

     <cfoutput>
         
     <cfset returnurl = "/app/audition/?audprojectid=#audprojectid#&secid=#secid#" />
         
     </cfoutput>
 
	 <cflocation url="#returnurl#" >