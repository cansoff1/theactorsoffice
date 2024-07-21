<CFINCLUDE template="/include/remote_load.cfm" />

<cfparam name="deleteitem" default="0" /> 
 <cfparam name="valuetext" default="" /> 
 <cfparam name="refer_contact_id" default="" /> 
 <cfparam name="custompronoun" default="" /> 

    

<cfoutput>
contactpronoun: #contactpronoun#<BR>
    custom: #custom#<BR>

</cfoutput>
<cfset contactBirthdayValue = iif(contactbirthday EQ '', javaCast('null', ''), contactbirthday) />


<cfscript>
    // Sample date from the form
    formDate = trim(contactmeetingdate);

    // Use LSParseDateTime to parse the date string to a ColdFusion date object
    parsedDate = LSParseDateTime(formDate);

    // Format the date to a database-friendly format
    formattedDate = DateFormat(parsedDate, "yyyy-mm-dd");
</cfscript>

<cfscript>
    // Get the date from the form
    contactbirthday = trim(detais.contactbirthday);

    // Initialize formattedDate
    contactbirthdayformatted = "";

    try {
        // Validate the date format using a regular expression
        if (REFind("^\d{4}-\d{2}-\d{2}$", contactbirthday)) {
            // Parse the date string to a ColdFusion date object
            parsedDate = ParseDateTime(contactbirthday);

            // Format the date to a database-friendly format
            contactbirthdayformatted = DateFormat(parsedDate, "yyyy-mm-dd");
        } else {
            // Handle invalid date format
            throw(message="Invalid date format", detail="Expected format is YYYY-MM-DD");
        }
    } catch (any e) {
        // Handle the error, e.g., invalid date format
        writeOutput("Invalid date format: " & contactbirthday);
        abort;
    }
</cfscript>


<cfquery name="update" datasource="#dsn#" >
UPDATE contactdetails
SET contactfullname = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(contactfullname)#" />
             


    
    <cfif #contactPronoun# is "custom">
    ,contactPronoun = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(custom)#" />
 <cfelse>
     ,contactPronoun = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(contactPronoun)#" />
     </cfif>
 
<cfif #contactbirthdayformatted# is not "">
        ,contactbirthday = 
 
<cfqueryparam value="#contactbirthdayformatted#" cfsqltype="cf_sql_date">
</cfif>

             <cfif #contactmeetingdate# is not "">
    ,contactmeetingdate = 
 

    <cfqueryparam cfsqltype="cf_sql_date" value="#formattedDate#" />

    </cfif>
     ,contactmeetingloc = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(contactmeetingloc)#" />
                
    <cfif #deleteitem# is "1">
    ,isdeleted = 1
    </cfif>


        <cfif #refer_contact_id# is not  "">
,refer_contact_id = #refer_contact_id#

        </cfif>
    

WHERE contactid = #contactid#
</cfquery>

  <cfif #contactbirthday# is not "">
      
  <cfinclude template="/include/birthday_fix.cfm" >    
</cfif>
      
      
      
<cfif  #custom# is not "" and #contactPronoun# is "custom">
      <cfquery name="find" datasource="#dsn#" >
      SELECT * from genderpronouns_users where userid = #session.userid# and genderPronoun = '#custom#'
    </cfquery>
    
    <cfif #find.recordcount# is "0">
    
     <cfquery name="add" datasource="#dsn#" >
      insert into genderpronouns_users_tbl
         (userid,isDeleted,isCustom,genderpronoun,genderpronounPlural)
         Values (#session.userid#,0,1,'#custom#','#custom#')
        </cfquery>
    </cfif>
      
      
      </cfif>      


<cfset script_name_include="/include/#ListLast(GetCurrentTemplatePath(), "\")#" /><cfinclude template="/include/bigbrotherinclude.cfm" /> 

<cflocation url="/app/contact/?contactid=#contactid#" /> 
