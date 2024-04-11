<CFINCLUDE template="/include/remote_load.cfm" />

<cfparam name="TIMETITLE" default="" />

<cfparam name="pgaction" default="view" />

<cfparam name="subdomain" default="app" />

<cfparam name="thispage2" default="" />

<cfparam name="rpgid" default="0" />

<cfset currentURL=cgi.server_name />

<cfset host=ListFirst(currentURL, "." ) />



<cfoutput>
    
   
    <cfinclude template="/include/toast.cfm" />

    <cfset thisPath=ExpandPath("*.*") />

    <cfset thisDirectory="#GetDirectoryFromPath(thisPath)#" />

    <cfset thispage="#replace('#thisDirectory#','C:\home\theactorsoffice.com\wwwroot\#host#-subdomain#suffix#\app\','')#" />

    <cfset thispage="#replace('#thispage#','\','')#" />

    <cfset currentpage="#cgi.script_name#?#cgi.query_string#" />

    <cfset returnpage="#cgi.script_name#?#cgi.query_string#" />

</cfoutput>

<cffunction name="formatUserDate" returntype="string">
    <cfargument name="date" type="date" required="yes">
    <cfargument name="userId" type="numeric" required="yes">

    <!--- Check if the session variable for date format is set --->
    <cfif NOT StructKeyExists(session, "dateFormat") OR session.dateFormat.userId NEQ arguments.userId>
        <!--- Retrieve the user's date format preference from the database --->
        <cfquery name="getUserFormat" datasource="yourDataSource">
            SELECT formatExample FROM dateformats WHERE id = <cfqueryparam value="#arguments.userId#" cfsqltype="CF_SQL_INTEGER">
        </cfquery>

        <!--- Set the session variable --->
        <cfset session.dateFormat = {userId = arguments.userId, formatString = getUserFormat.formatExample}>
    </cfif>

    <!--- Format and return the date using the session variable --->
    <cfreturn dateFormat(arguments.date, session.dateFormat.formatString)>
</cffunction>



<cfif isdefined('dn')>
    
    <cfquery name="update">
        update notifications
        set `read` = 1
        where id = <cfqueryparam cfsqltype="cf_sql_integer" value="#numberformat(dn)#">
    </cfquery>
</cfif>

<cfif #isdefined('ca')#>
    <Cfif #ca# is "Y">
        <cfquery name="update">
            update notifications
            set trash = 1
            where userid = <cfqueryparam cfsqltype="cf_sql_integer" value="#session.userid#">
                and trash = 0
        </cfquery>
        <cfset StructDelete(Variables, "ca" ) />


    </cfif>

</cfif>




<cfif #isdefined('session.userid')#>
<Cfset cookie.userid=session.userid />
    <Cfset userid=session.userid />

    <cfelse>

        <cflocation url="/loginform.cfm" />

</cfif>

<cfparam name="catArea_UCB" default="C" />

<cfparam name="contactid" default="0" />

<cfoutput>
    <cfset cal_root_dir="C:\home\theactorsoffice.com\media-#host#\calendar\" />
    <cfset cal_root_url="https://#host#.theactorsoffice.com/calendar/" />
</cfoutput>

<cfquery datasource="#dsn#" name="version" maxrows="1">
    SELECT verid,major,minor,patch,alphabeta,releaseDate FROM taoversions WHERE IsActive = 1 order by verid desc LIMIT 1
</cfquery>

<cfquery datasource="#dsn#" name="nextversion" maxrows="1">
    SELECT * FROM taoversions WHERE IsActive = 0 ORDER BY verid DESC LIMIT 1
</cfquery>

<cfif #version.recordcount# is "1">
    <cfoutput>
        <cfset taoversion="v#version.major#.#version.minor#.#version.patch#-#version.alphabeta#" />
        <cfset next_verid="#nextversion.verid#" />
    </cfoutput>
</cfif>


<cfquery datasource="#dsn#" name="FindUser">
    SELECT
    u.userid
    ,u.recordname
    ,u.userFirstName
    ,u.userLastName
    ,u.userEmail
    ,u.contactid
    ,u.userRole
    ,u.IsBetaTester
    ,u.defRows
    ,u.calstarttime
    ,u.calendtime
    ,u.avatarname
    ,u.contactid AS userContactID
    ,u.tzid
    ,c.countryname
    ,t.tzname
    ,u.customerid
     ,u.countryid
    ,left(u.passwordhash,10) as U
     ,u.viewtypeid, u.add1, u.add2, u.city, u.regionid, u.zip
    ,isauditionmodule
    ,u.access_token
    ,u.refresh_token
    ,u.dateformatid
    ,df.formatExample
    ,df.formatNotes
    FROM taousers u
    LEFT JOIN dateformats df on df.id = u.dateFormatid
    LEFT join timezones t on t.tzid = u.tzid
    LEFT JOIN countries c on c.countryid = u.countryid
    WHERE u.userid = #userid#
</cfquery>
    
    

<cfoutput>

    <cfset dir_user_avatar_loc="C:\home\theactorsoffice.com\media-#host#\users\#finduser.userid#" />

    <cfset dir_user_avatar_filename="#dir_user_avatar_loc#\avatar.jpg" />

    <cfset browser_user_avatar_loc="/media-#host#/users/#finduser.userid#" />

    <cfset browser_user_avatar_filename="#browser_user_avatar_loc#/avatar.jpg" />

    <cfset dir_user_imports_loc="#dir_user_avatar_loc#\imports" />

    <cfset dir_contact_avatar_loc="C:\home\theactorsoffice.com\media-#host#\users\#finduser.userid#\contacts\#contactid#" />

    <cfset dir_contact_avatar_filename="#dir_contact_avatar_loc#\avatar.jpg" />

    <cfset browser_contact_avatar_loc="/media-#host#/users/#finduser.userid#/contacts/#contactid#" />

    <cfset browser_contact_avatar_filename="#browser_contact_avatar_loc#/avatar.jpg" />

    <cfset calendar_name3="#FindUser.userfirstname##FindUser.userlastname#" />

    <cfset calendar_name2=#REReplace(calendar_name3,"[^0-9A-Za-z ]","","all")# />

    <cfset calendar_name=#replace(calendar_name2," ",""," all")# />

    <cfset calendar_dir="#cal_root_dir##calendar_name#.ics" />

    <cfset calendar_url="#cal_root_url##calendar_name#.ics" />

</cfoutput>


<cfif #FindUser.avatarname# is "">





    <cfquery datasource="#dsn#" name="InsertContact" result="result">
        update taousers
        set avatarname = '#FindUser.userfirstname#'
        where userid = #userid#
    </cfquery>




    <cfquery datasource="#dsn#" name="FindUser">
        SELECT
        u.userid
        ,u.recordname
        ,u.userFirstName
        ,u.userLastName
        ,u.userEmail
        ,u.contactid
        ,u.userRole
        ,c.countryname
        ,u.calstarttime
        ,u.calendtime
        ,u.avatarname
        ,u.IsBetaTester
        ,u.defRows
        ,u.contactid AS userContactID
        ,u.tzid
        ,t.tzname
        ,u.customerid
        ,u.countryid
        ,left(u.passwordhash,10) as U
        ,u.viewtypeid, u.add1, u.add2, u.city, u.regionid, u.zip
          ,u.access_token
    ,u.refresh_token
    ,isauditionmodule
    ,u.dateformatid
    ,df.formatExample
    ,df.formatNotes
    FROM taousers u
    LEFT JOIN dateformats df on df.id = u.dateFormatid

        LEFT join timezones t on t.tzid = u.tzid
     LEFT JOIN countries c on c.countryid = u.countryid
        WHERE u.userid = '#userid#'
    </cfquery>
</cfif>



<cfif #FindUser.contactid# is "">


    <cfquery datasource="#dsn#" name="InsertContact" result="result">
        INSERT INTO contactdetails (Contactfullname,userid,user_yn)
        values ('#finduser.userfirstname# #finduser.userlastname#',#userid#,'Y')
    </cfquery>


    <cfset new_contactid=result.generatedkey>

        <cfquery datasource="#dsn#" name="InsertContact" result="result">
            update taousers
            set contactid = #new_contactid#
            where userid = #userid#
        </cfquery>

        <cfquery datasource="#dsn#" name="FindUser">
            SELECT
            u.userid
            ,u.recordname
            ,u.userFirstName
            ,u.userLastName
            ,u.userEmail
            ,u.contactid
            ,u.userRole
            ,c.countryname
            ,u.calstarttime
            ,u.calendtime
            ,u.avatarname
            ,u.IsBetaTester
            ,u.defRows
            ,u.contactid AS userContactID
            ,u.tzid
            ,t.tzname
            ,u.customerid
            ,left(u.passwordhash,10) as U
            ,u.viewtypeid, u.add1, u.add2, u.city, u.regionid, u.zip,c.countryid
            
              ,u.access_token
    ,u.refresh_token
            
            
    ,isauditionmodule
           ,u.dateformatid
    ,df.formatExample
    ,df.formatNotes
    FROM taousers u
    LEFT JOIN dateformats df on df.id = u.dateFormatid
            LEFT join timezones t on t.tzid = u.tzid
       LEFT JOIN countries c on c.countryid = u.countryid
            WHERE u.userid = '#userid#'
        </cfquery>
</cfif>





<cfquery datasource="#dsn#" name="FindPage">
    SELECT
    a.appname
    ,p.allowdelete_yn
    ,p.allowupdate_yn
    ,p.allowadd_yn
    ,p.allowdetails_yn
    ,a.appAuthor
    ,c.compname
    ,p.pgname
    ,a.appId
    ,a.appDescription
    ,a.appLogoName
    ,a.colorTopBar
    ,a.colorLeftSideBar
    ,a.mocktoday
    ,a.mock_yn
    ,c.compid
    ,c.compDir
    ,c.compTable
    ,c.compowner
    ,c.compIcon
    ,c.menuYN
    ,c.menuOrder
    ,c.compInner
    ,c.compRecordName
    ,c.compActive
    ,p.pgid
    ,p.pgDir
    ,p.pgTitle
    ,p.pgHeading
    ,p.pgFilename
    ,p.datatables_YN
    ,p.fullcalendar_YN
    ,p.editable_YN
    ,p.newdatatables_YN
    ,p.pk
    ,p.update_type
    FROM pgpages p
    INNER JOIN pgcomps c ON c.compID = p.compID
    INNER JOIN pgapps a ON a.appID = c.appid
<cfif #isdefined('new_pgid')#>
    WHERE p.pgid = #new_pgid#
   <cfelse>
        WHERE p.pgDir = '#trim(thispage)#'
        and p.isdef = 1
 
     </cfif>
</cfquery>

    
    
    <Cfif #Findpage.recordcount# is not "1">
        <cfoutput>
    <h2>#trim(thispage)# Not found</h2>
            <p>    SELECT
    a.appname
    ,a.appAuthor
    ,c.compname
    ,p.pgname
    ,a.appId
    ,a.appDescription
    ,a.appLogoName
    ,a.colorTopBar
    ,a.colorLeftSideBar
    ,a.mocktoday
    ,a.mock_yn
    ,c.compid
    ,c.compDir
    ,c.compTable
    ,c.compowner
    ,c.compIcon
    ,c.menuYN
    ,c.menuOrder
    ,c.compInner
    ,c.compRecordName
    ,c.compActive
    ,p.pgid
    ,p.pgDir
    ,p.pgTitle
    ,p.pgHeading
    ,p.pgFilename
    ,p.datatables_YN
    ,p.fullcalendar_YN
    ,p.editable_YN
    ,p.newdatatables_YN
    ,p.pk
    ,p.update_type
    FROM pgpages p
    INNER JOIN pgcomps c ON c.compID = p.compID
    INNER JOIN pgapps a ON a.appID = c.appid
<cfif #isdefined('new_pgid')#>
    WHERE p.pgid = #new_pgid#
   <cfelse>
        WHERE p.pgDir = '#trim(thispage)#'
        and p.isdef = 1
 
     </cfif></p>
            
            
            </cfoutput>
    </Cfif>
    
    <cfquery datasource="#dsn#" name="FindOptions">
    SELECT
    a.appname
    ,a.appAuthor
    ,c.compname
    ,p.pgname
    ,a.appId
    ,a.appDescription
    ,a.appLogoName
    ,a.colorTopBar
    ,a.colorLeftSideBar
    ,a.mocktoday
    ,a.mock_yn
    ,c.compid
    ,c.compDir
    ,c.compTable
    ,c.compowner
    ,c.compIcon
    ,c.menuYN
    ,c.menuOrder
    ,c.compInner
    ,c.compRecordName
    ,c.compActive
    ,p.pgid
    ,p.pgDir
    ,p.pgTitle
    ,p.pgHeading
    ,p.pgFilename
    ,p.datatables_YN
    ,p.fullcalendar_YN
    ,p.editable_YN
    ,p.newdatatables_YN
    ,p.pk
    ,p.update_type
    FROM pgpages p
    INNER JOIN pgcomps c ON c.compID = p.compID
    INNER JOIN pgapps a ON a.appID = c.appid
   
        WHERE p.pgDir = '#findpage.pgDir#'
   and p.isdef is not NULL
    
</cfquery>





<cfquery datasource="#dsn#" name="FindFields">
    SELECT
    a.appname
    ,c.compname
    ,p.pgname
    ,f.fname
    ,a.appId
    ,a.appName
    ,a.appDescription
    ,a.appLogoName
    ,a.colorTopBar
    ,a.colorLeftSideBar
    ,c.compid
    ,c.compDir
    ,c.compTable
    ,c.compowner
    ,c.compIcon
    ,c.menuYN
    ,c.menuOrder
    ,c.compInner
    ,c.compRecordName
    ,c.compActive
    ,p.pgid
    ,p.pgDir
    ,p.pgTitle
    ,p.pgHeading
    ,p.pgFilename
    ,p.datatables_YN
    ,p.fullcalendar_YN
    ,p.editable_YN
    ,p.newdatatables_YN
    ,p.pk
    ,f.fieldid
    ,f.pgid
    ,f.ftype
    ,f.ftypefull
    ,f.update_yn
    ,f.updatename
    ,f.updatetype
    ,f.fkey
    ,f.num_min
    ,f.num_max
    FROM pgpages p
    INNER JOIN pgcomps c ON c.compID = p.compID
    INNER JOIN pgapps a ON a.appID = c.appid
    INNER join pgfields f on f.pgid = p.pgid
    WHERE p.pgDir = '#trim(thispage)#'
</cfquery>

<cfif #FindPage.RecordCount# is "1">


    <cfquery datasource="#dsn#" name="FindLinksT">
        SELECT

        l.linkid
        ,l.linkurl
        ,l.linkname
        ,l.linktype
        ,l.link_no
        ,l.linkloc_tb
        ,l.pluginname
        ,l.rel
        ,l.hrefid


        FROM pgapplinks l

        INNER JOIN pgplugins p ON p.pluginName = l.pluginname
        INNER JOIN pgpagespluginsxref x ON x.pluginid = p.pluginid
        INNER JOIN pgpages g ON g.pgid = x.pgid


        WHERE g.pgid = #findpage.pgid# AND l.linkloc_tb = 't'

        ORDER BY l.link_no
    </cfquery>


    <cfquery datasource="#dsn#" name="FindLinksB">
        SELECT

        l.linkid
        ,l.linkurl
        ,l.linkname
        ,l.linktype
        ,l.link_no
        ,l.linkloc_tb
        ,l.pluginname
        ,l.rel
        ,l.hrefid


        FROM pgapplinks l

        INNER JOIN pgplugins p ON p.pluginName = l.pluginname
        INNER JOIN pgpagespluginsxref x ON x.pluginid = p.pluginid
        INNER JOIN pgpages g ON g.pgid = x.pgid


        WHERE g.pgid = #findpage.pgid# AND l.linkloc_tb = 'b' and l.linkname NOT like '%calendar - custom%'
and l.linktype <> 'css'
        ORDER BY l.link_no
    </cfquery>


    <cfquery datasource="#dsn#" name="FindLinksExtra">
        SELECT distinct
        l.pluginname

        FROM pgapplinks l

        INNER JOIN pgplugins p ON p.pluginName = l.pluginname
        INNER JOIN pgpagespluginsxref x ON x.pluginid = p.pluginid
        INNER JOIN pgpages g ON g.pgid = x.pgid

        WHERE g.pgid = #findpage.pgid# AND l.linkloc_tb = 'b'
        and l.pluginname <> 'global'
            ORDER BY l.link_no
    </cfquery>

        
      

    <!--- Application variables --->

    <cfset appName=FindPage.appName />
    <cfset appDescription=FindPage.appDescription />
    <cfset appAuthor=FindPage.appAuthor />
    <cfset appLogoName=FindPage.appLogoName />
    <cfif #host# is "uat">
        <cfset colorTopBar="Purple" />
        <cfelse>
            <cfset colorTopBar=FindPage.colorTopBar />
    </cfif>
    <cfset colorLeftSideBar=FindPage.colorLeftSideBar />
    <cfset home="/app/dashboard" />
    <cfset mocktoday=FindPage.mocktoday />
    <cfset mock_yn=FindPage.mock_yn />
    <!--- Component variables --->

    <cfset compid=FindPage.compid />
    <cfset compname=FindPage.compname />
    <cfset compDir=FindPage.compDir />
    <cfset compTable=FindPage.compTable />
    <cfset compowner=FindPage.compowner />

    <!--- Page variables --->

    <cfset pgid=FindPage.pgid />
    <cfset cookie.pgid=FindPage.pgid />
    <cfset pgname=FindPage.pgname />
    <cfset pgDir=FindPage.pgDir />
    <cfset pgTitle=FindPage.pgTitle />
    <cfset pgHeading=FindPage.pgHeading />
    <cfset pgFilename=FindPage.pgFilename />
    <cfset update_type=FindPage.update_type />
    <!--- User variables --->

        
         <cfset useradd1=FindUser.add1 />
         <cfset useradd2=FindUser.add2 />
         <cfset usercity=FindUser.city />
         <cfset userregionid=FindUser.regionid />
         <cfset userzip=FindUser.zip />
         <cfset userviewtypeid=FindUser.viewtypeid />

  <cfset refresh_token=FindUser.refresh_token />
    <cfset access_token=FindUser.access_token />
    <cfset userContactid=FindUser.userContactID />
    <cfset userCalStarttime=FindUser.calstarttime />
    <cfset userCalendtime=FindUser.calendtime />
    <cfset useravatarname=FindUser.avatarname />
    <cfset userIsBetaTester=FindUser.IsBetaTester />
    <cfset userdefRows=FindUser.defRows + 1 />
    <cfset userdefCountry=FindUser.countryid />
    <cfset userdefState=FindUser.regionid />
        <cfset usercountryname=FindUser.countryname />
    <cfset def_countryid=FindUser.countryid />
    <cfset def_regionid=FindUser.regionid />  
        
    <cfset usertzid=FindUser.tzid />
    <cfset usercustomerid=FindUser.customerid />
    <cfset u=FindUser.u />
    <cfset isauditionmodule=FindUser.isauditionmodule />
        
    <cfif "#usercontactid#" is "#contactid#">
        <Cfset catArea_UCB="U" />
    </cfif>





    <cfinclude template="/include/qry/mylinks.cfm" />




    <cfset userFirstName=FindUser.userFirstName />
    <cfset userLastName=FindUser.userLastName />
    <cfset userEmail=FindUser.userEmail />
    <cfset userRole=FindUser.userRole />

    <cfoutput>
        <cfset pageTitle="#appName# | #pgTitle#" />

    </cfoutput>

    <cfif #pgfilename# is not "">



        <cfinclude template="/include/qry/#pgfilename#" />


    </cfif>
    <cfelse>


        <cfoutput> No record!#trim(thispage)#</cfoutput>

</cfif>


