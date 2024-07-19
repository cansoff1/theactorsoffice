<CFINCLUDE template="/include/remote_load.cfm" />

<cfparam name="deleteitem" default="0" /> 
 <cfparam name="valuetext" default="" /> 
 <cfparam name="itemdate" default="" /> 
  <cfparam name="customtype" default="" /> 
  <cfparam name="countryid" default="" /> 
  <cfparam name="regionid" default="" /> 

<cfif #valuetype# is "Custom" and #customtype# is not "">
<cfquery name="insert" datasource="#dsn#" result="typeresult" >
insert into itemtypes_user (valuetype,userid)
values ('#customtype#',#session.userid#)
    </cfquery>
    <cfset new_typeid = typeresult.generatedkey />
    <cfoutput>
     <cfset valuetype = "#customtype#" />
    </cfoutput>
             <cfquery name="insertx" datasource="#dsn#">
                    INSERT INTO `itemcatxref_user` (`typeid`, `catid`, `userid`,`IsCustom`) 
                    VALUES (#new_typeid#,#catid#,#session.userid#,1);
                </cfquery>


</cfif>

<cfquery name="add" datasource="#dsn#" result="result" >
INSERT INTO contactitems (contactid,valuetype,itemStatus,valueCategory)
VALUES (<cfqueryparam cfsqltype="cf_sql_integer" value="#contactid#" /> ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(valuetype)#" />,<cfqueryparam cfsqltype="cf_sql_varchar" value="Active" /> 
,<cfqueryparam cfsqltype="cf_sql_varchar" value="#valueCategory#" />    
    )
</cfquery>

<cfset itemid = result.generatedkey />



    <cfparam name="new_countryname" default="" />
    <cfparam name="new_regionname" default="" />
      
<cfif #catid# is "2">
<cfquery name="findcountry" datasource="#dsn#">
select countryid,countryname from countries where countryid = '#countryid#'
</cfquery>

<cfif #findcountry.recordcount# is "1">
<cfset new_countryname = findcountry.countryname />
      <cfset old_countryid = findcountry.countryid />
</cfif>

<cfquery name="findregion" datasource="#dsn#">
select regionname from regions where regionid = '#regionid#' and countryid = '#old_countryid#'
</cfquery>

<cfif #findregion.recordcount# is "1">
<cfset new_regionname = findregion.regionname />
</cfif>

</cfif>

<cfif #catid# is "4">
<cfset preurl = "https://" />
<cfif #left(valuetext,4)# is "http">

<cfelse>

    <cfoutput>
    <cfset valuetext = "#preurl##valuetext#" /> 
    </cfoutput>
    
</cfif>
</cfif>

<cfif #catid# is "5">
<cfset preurl = "https://" />
<cfif #left(valuetext,4)# is "http">

<cfelse>

    <cfoutput>
    <cfset valuetext = "#preurl##valuetext#" /> 
    </cfoutput>
    
</cfif>
</cfif>
    
    <cfif #catid# is "9">
        <CFIF #VALUECOMPANY# IS "custom">
        <cfset valuecompany = "#TRIM(custom)#" />
        </CFIF>
    </cfif>

<cfquery name="update" datasource="#dsn#" result="result" >
UPDATE contactitems
SET valuetext = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(valuetext)#" />
          
<cfif #catid# is "9">
    <cfif #valuecompany# is not "">
    ,valueCompany = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(valuecompany)#" />
    </cfif>
    
    ,valueDepartment = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(valueDepartment)#" />
    ,valueTitle = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(valueTitle)#" /> 
</cfif>
    
<cfif #catid# is "2">
     ,valueStreetAddress = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(valueStreetAddress)#" />   
    ,valueExtendedAddress = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(valueExtendedAddress)#" />    
  ,valueCity = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(valueCity)#" /> 
 ,valueRegion = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(new_regionname)#" /> 
 ,valueCountry = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(new_countryname)#" /> 
 ,valuePostalCode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(valuePostalCode)#" /> 
    </cfif>
    
    <cfif #itemdate# is not "">
        ,itemdate = <cfqueryparam cfsqltype="cf_sql_date" value="#itemdate#" /> 
    </cfif>
        
WHERE itemid = #itemid#
</cfquery>

<cfset script_name_include="/include/#ListLast(GetCurrentTemplatePath(), "\")#" /><cfinclude template="/include/bigbrotherinclude.cfm" /> 


<cflocation url="/app/contact/?contactid=#contactid#" />       


