<CFINCLUDE template="/include/remote_load.cfm" />

<cfparam name="deleteitem" default="0" />

<cfparam name="valuetext" default="" />

<cfparam name="itemdate" default="" />

<cfparam name="new_countryname" default="" />

<cfparam name="new_regionname" default="" />

<cfparam name="countryid" default="" />

<cfparam name="old_countryid" default="" />

<cfparam name="old_region_id" default="" />

<cfparam name="region_id" default="" />







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







<cfquery name="findcountry" datasource="#dsn#">
    select countryid,countryname from countries where countryid = '#countryid#'
</cfquery>

<cfif #findcountry.recordcount# is "1">
    
    <cfset new_countryid=findcountry.countryname />
    
    <cfset old_countryid=findcountry.countryid />
    
</cfif>


<cfquery name="findregion" datasource="#dsn#">
    select regionname from regions where region_id = '#region_id#' and countryid = '#old_countryid#'
</cfquery>


<cfif #findregion.recordcount# is "1">
    <cfset new_region_id=findregion.regionname />
</cfif>



<cfif #catid# is "4">
    
    <cfset preurl="https://" />
    
    <cfif #left(valuetext,4)# is "http">

        <cfelse>

            <cfoutput>
                
                <cfset valuetext="#preurl##valuetext#" />
                
            </cfoutput>

    </cfif>
        
</cfif>
    
<cfif #catid# is "5">
    
    <cfset preurl="https://" />
    
    <cfif #left(valuetext,4)# is "http">

        <cfelse>

            <cfoutput>
                
                <cfset valuetext="#preurl##valuetext#" />
                
            </cfoutput>

    </cfif>
        
</cfif>  
    

 
<cfquery name="update" datasource="#dsn#">
    UPDATE contactitems
    SET valuetext =
  
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(valuetext)#" />
    ,valuetype =
  
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(valuetype)#" />
  
    <cfif #catid# is "9">
        
   
     
        <cfif #valuecompany# is "custom" and #custom# is not "" and #custom# is not "custom">
            ,valueCompany =
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(custom)#" />
            
            <cfelse>
                
               ,valueCompany =
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(valuecompany)#" />
                
        </cfif>
        
        
        
        
        ,valueDepartment =
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(valueDepartment)#" />
        ,valueTitle =
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(valueTitle)#" />
    </cfif>


    <cfif #catid# is "2">
        ,valueStreetAddress =
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(valueStreetAddress)#" />
        ,valueExtendedAddress =
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(valueExtendedAddress)#" />
        ,valueCity =
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(valueCity)#" />
        ,valueRegion =
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(new_region_id)#" />
        ,valueCountry =
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(new_countryid)#" />
        ,valuePostalCode =
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(valuePostalCode)#" />
    </cfif>

    <cfif #itemdate# is not "">
        ,itemdate =
        <cfqueryparam cfsqltype="cf_sql_date" value="#itemdate#" />
    </cfif>


    <cfif #deleteitem# is "1">
        ,isdeleted = 1
    </cfif>


    WHERE itemid = #itemid#
</cfquery>

<cfquery name="update2" datasource="#dsn#">
update contactitems set valuetype = '#valuetype#'
    WHERE itemid = #itemid#
</cfquery>
<cfoutput>update contactitems set valuetype = '#valuetype#'
    WHERE itemid = #itemid#</cfoutput>

<cfset script_name_include="/include/#ListLast(GetCurrentTemplatePath(), " \")#" />
<cfinclude template="/include/bigbrotherinclude.cfm" />

<cflocation url="/app/contact/?contactid=#contactid#" />
