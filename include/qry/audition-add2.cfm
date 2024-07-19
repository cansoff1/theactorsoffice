<cfoutput>
<cfset new_userid = #cookie.userid# />
</cfoutput>

     <CFINCLUDE template="/include/remote_load.cfm" />





<cfif #new_contactid# is "0" and #cdfullname# is not "">
    
    <cfquery datasource="#dsn#" name="add" result="result">
    INSERT INTO contactdetails (userid,contactfullname) 
    VALUES (#userid#,'#cdfullname#');
    </cfquery>

    <cfset new_contactid = result.generatedkey />
    
   
    <cfquery datasource="#dsn#" name="insert"  >
        INSERT INTO CONTACTITEMS (CONTACTID,VALUETYPE,VALUECATEGORY,VALUETEXT,ITEMSTATUS)
        VALUES (#new_contactid#,'Tags','Tag','#cdtype#','Active')
    </cfquery>

    <cfif #cdco# is not "">
       <cfquery datasource="#dsn#" name="insert"  >
        INSERT INTO CONTACTITEMS (CONTACTID,VALUETYPE,VALUECATEGORY,ValueCompany,ITEMSTATUS)
        VALUES (#new_contactid#,'Company','Company','#cdco#','Active')
    </cfquery>


    </cfif>

</cfif>


<cfif #new_contactid# is "0" and #cdco# is not "">

    <cfquery datasource="#dsn#" name="add" result="result">
    INSERT INTO contactdetails (userid,cdco) 
    VALUES (#userid#,'#cdfullname#');
    </cfquery>

    
    <cfset new_contactid = result.generatedkey />
    
   
    <cfquery datasource="#dsn#" name="insert"  >
        INSERT INTO CONTACTITEMS (CONTACTID,VALUETYPE,VALUECATEGORY,VALUETEXT,ITEMSTATUS)
        VALUES (#new_contactid#,'Tags','Tag','#cdtype#','Active')
    </cfquery>

        <cfquery datasource="#dsn#" name="insert"  >
        INSERT INTO CONTACTITEMS (CONTACTID,VALUETYPE,VALUECATEGORY,ValueCompany,ITEMSTATUS)
        VALUES (#new_contactid#,'Company','Company','#cdco#','Active')
    </cfquery>

</cfif>

<cfinclude template="/include/qry/audprojects_ins.cfm" />
<cfinclude template="/include/qry/audroles_ins.cfm" />
 <cfabort>
<cfif #isdirect# is "0">
<cfinclude template="/include/qry/auditions_ins.cfm" />



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
        
     </cfif>


         <cfquery name="add_cd" datasource="#dsn#">
    INSERT IGNORE INTO `audcontacts_auditions_xref`
SET `audprojectid` = #audprojectid#,
        xrefNotes = 'audition-add2.cfm',
`contactid` = #new_contactid#;
    </cfquery>




<cflocation url="/app/audition/?audprojectid=#new_audprojectid#" />
