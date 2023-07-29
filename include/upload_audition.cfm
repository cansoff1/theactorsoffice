 
    <div class="modal" tabindex="-1" role="dialog" id="errorModal">
      <div class="modal-dialog" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title">Error</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
          <div class="modal-body">
            <p>#SESSION.ErrorMessage#</p>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
          </div>
        </div>
      </div>
    </div>

    
 
 


<cfparam name="new_projName" default=""/>

<cfparam name="new_projDescription" default=""/>

<cfparam name="new_audSubCatID" default=""/>

<cfparam name="new_unionID" default=""/>

<cfparam name="new_networkID" default=""/>

<cfparam name="new_toneID" default=""/>

<cfparam name="new_contractTypeID" default=""/>

<cfparam name="new_contactid" default=""/>

<cfparam name="isdirect" default="0"/>

<cfparam name="isbooked" default="0"/>

<cfparam name="ispin" default="0"/>

 
 
<cfinclude template="/include/remote_load.cfm"/>

<cfparam name="new_audsourceid" default="0"/>

<cfset currentURL = cgi.server_name/>
<cfset host = ListFirst(currentURL, ".")/>

<cfquery datasource="#dsn#" name="FindUser">
    SELECT
    u.userid
    ,u.userFirstName
    ,u.recordname
    ,u.userLastName
    ,u.userEmail
    ,u.contactid
    ,u.userRole
    ,u.contactid AS userContactID
    FROM taousers u
    WHERE u.userid = #userid#
</cfquery>

<cfquery datasource="#dsn#" name="INSERT" result="result">
    INSERT INTO `uploads` (userid)
    values (#userid#)
</cfquery>

<cfset new_uploadid = result.generatedkey>

<cfoutput>

    <cfset cUploadFolder = "C:\home\theactorsoffice.com\wwwroot\#host#-subdomain\media-#host#\users\#finduser.userid#"/>
</cfoutput>

<cfif not DirectoryExists("#cUploadFolder#")>

    <cfdirectory directory="#cUploadFolder#" action="create">
</cfif>

<cffile action="upload" filefield="form.file" destination="#cUploadFolder#\" 
        nameconflict="MAKEUNIQUE"/>

<!--- read the spreadsheet data into a query object --->
<cfspreadsheet action="read" query="importdata" src="#cUploadFolder#\#cffile.serverfile#" 
columnnames="projDate,projName,audRoleName,audCatName,audsource,cdfirstname,cdlastname,callback_yn,redirect_yn,pin_yn,booked_yn,projDescription,charDescription,note" 
               headerrow="1"/>

<cffunction name="arraysAreEqual" returntype="boolean">
    <cfargument name="array1" type="array" required="true">
    <cfargument name="array2" type="array" required="true">
    <cfset var i = "">
    
    <!--- Check if arrays are of same size --->
    <cfif arrayLen(arguments.array1) neq arrayLen(arguments.array2)>
        <cfreturn false>
    </cfif>
    
    <!--- Check if arrays have same elements in same order --->
    <cfloop index="i" from="1" to="#arrayLen(arguments.array1)#">
        <cfif arguments.array1[i] neq arguments.array2[i]>
            <cfreturn false>
        </cfif>
    </cfloop>
    
    <!--- If no differences were found, the arrays are equal --->
    <cfreturn true>
</cffunction>

<!--- Get the column names from the imported data --->
<cfset spreadsheetColumns = importdata.columnList/>

<!--- Convert the string of column names to an array --->
<cfset spreadsheetColumnsArray = ListToArray(spreadsheetColumns) />

<!--- Define the correct columns for your application --->
<cfset correctColumns = "projdate,projname,audrolename,audcatname,audsource,cdfirstname,cdlastname,callback_yn,redirect_yn,pin_yn,booked_yn,projdescription,chardescription,note" />

<!--- Convert the correct column list to an array --->
<cfset correctColumnsArray = ListToArray(correctColumns) />

<!--- Compare the arrays --->
 
<cfif NOT arraysAreEqual(spreadsheetColumnsArray, correctColumnsArray)>
   <h3>The spreadsheet is not in the correct format.  Please use the template provided and upload again.</h3>
<p>&nbsp;</p>
      <Center> <button onclick="goBack()">Go Back</button> </center>

    <script>
    function goBack() {
        window.history.back();
    }
    </script>
</cfif>

<!--- create a variable to store the codes of products that could not be imported --->
<cfset failedimports = ""/>

<!--- loop through the query starting with the first row containing data (row 2) --->
<cfloop query="importdata" startrow="2">
    <!--- check row contains valid data (all fields must contain a value and price must be numeric) 
    --->
    <cfif LEN(importdata.projName) gt 0>
    
        <cfquery datasource="#dsn#" name="find">
            INSERT INTO `auditionsimport` (`uploadid`
            <cfif #importdata.projDate# is not "">
                , `projDate` 
            </cfif>
            , `projName`, `audRoleName`, `audCatName`,  `audsource`,
            `cdfirstname`,`cdlastname`, `callback_yn`, `redirect_yn`, `pin_yn`, `booked_yn`,
            `projDescription`, `charDescription`, `note`)
            VALUES
            ( <cfqueryparam cfsqltype="cf_sql_integer" value="#new_uploadid#"/>
        
            <cfif #importdata.projDate# is not "">
            
                ,
                <cfqueryparam cfsqltype="cf_sql_varchar" 
                              value="#dateformat(importdata.projDate,"yyyy-mm-dd")#"/>
            </cfif>
        
        ,<cfqueryparam cfsqltype="cf_sql_varchar" maxlength="500" 
                      value="#TRIM(importdata.projName)#"/>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" maxlength="500" 
                      value="#TRIM(importdata.audRoleName)#"/>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" maxlength="100" 
                      value="#TRIM(importdata.audCatName)#"/>
            
            ,<cfqueryparam cfsqltype="cf_sql_varchar" maxlength="100" 
                      value="#TRIM(importdata.audsource)#"/>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" maxlength="100" 
                      value="#TRIM(importdata.cdfirstname)#"/>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" maxlength="100" 
                      value="#TRIM(importdata.cdlastname)#"/>
            ,<cfqueryparam cfsqltype="cf_sql_char" maxlength="1" 
                      value="#LEFT(importdata.callback_yn,1)#"/>
            ,<cfqueryparam cfsqltype="cf_sql_char" maxlength="1" 
                      value="#left(importdata.redirect_yn,1)#"/>
            ,<cfqueryparam cfsqltype="cf_sql_char" maxlength="1" value="#left(importdata.pin_yn,1)#"/>
            ,<cfqueryparam cfsqltype="cf_sql_char" maxlength="1" 
                      value="#left(importdata.booked_yn,1)#"/>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" maxlength="500" 
                      value="#TRIM(importdata.projDescription)#"/>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" maxlength="500" 
                      value="#TRIM(importdata.charDescription)#"/>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" maxlength="500" 
                      value="#TRIM(importdata.note)#"/>
            )
        </cfquery>
    </cfif>
</cfloop>


<cfinclude template="transfer_audition.cfm" />
<cflocation url="/app/auditions-import/?uploadid=#new_uploadid#">