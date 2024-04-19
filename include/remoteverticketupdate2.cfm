<CFINCLUDE template="/include/remote_load.cfm" />
 

<cfquery name="update" datasource="#dsn#" >
UPDATE tickets
SET ticketname = <cfqueryparam cfsqltype="cf_sql_varchar" value="#new_ticketname#" />
,testingscript = <cfqueryparam cfsqltype="cf_sql_varchar" value="#new_testingscript#" />
,ticketType = <cfqueryparam cfsqltype="cf_sql_varchar" value="#new_ticketType#" />
 ,ticketStatus = <cfqueryparam cfsqltype="cf_sql_varchar" value="#new_ticketStatus#" />   
    <cfif #new_verid# is "NULL">
    ,verid = NULL
        ,ticketstatus = 'Pending'
        <cfelse>
      ,verid = <cfqueryparam cfsqltype="cf_sql_integer" value="#new_verid#" />      
    </cfif>


,pgid = <cfqueryparam cfsqltype="cf_sql_integer" value="#new_pgid#" />    
        ,customtestpagename = <cfqueryparam cfsqltype="cf_sql_varchar" value="#new_customtestpagename#" />
        ,customtestpagelink = <cfqueryparam cfsqltype="cf_sql_varchar" value="#new_customtestpagelink#" />

,ticketPriority = <cfqueryparam cfsqltype="cf_sql_varchar" value="#new_ticketPriority#" />
,esthours = <cfqueryparam cfsqltype="cf_sql_float" value="#numberformat(new_esthours,9.99)#" />
WHERE ticketid = <cfqueryparam cfsqltype="cf_sql_integer" value="#ticketid#" />    
</cfquery>
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
<cfquery name="details"   datasource="#dsn#"    >
SELECT 
t.ticketid
,t.ticketID as recID
,t.ticketName
    ,t.testingscript
,CONCAT(u.userfirstname,' ',u.userlastname) AS username
,t.ticketCreatedDate AS createddate
,t.pgid
,t.userid
,t.ticketstatus
,t.tickettype
,t.environ
,t.ticketPriority
,p.pgname
,p.pgdir
,t.esthours
,t.ticketCompletedDate
,t.verid
,t.ticketdetails
,t.ticketResponse 
,t.patchnote
,t.recordname
,v.major
,v.minor
,v.patch
,v.alphabeta,v.version
,v.releasedate
,t.customtestpagename    
,t.customtestpagelink      
    
    
 FROM tickets t
 INNER JOIN taousers u ON u.userid = t.userid
 INNER JOIN pgpages p ON p.pgid = t.pgid
 LEFT JOIN taoversions v ON v.verid = t.verid
WHERE t.ticketid = <cfqueryparam cfsqltype="cf_sql_integer" value="#ticketid#" />    

</cfquery> 

<cfset to_email ="cansoff@gmail.com" />



 <cfif #details.customtestpagename# is "">
 
<cfset startpage = "https://dev.theactorsoffice.com/app/#details.pgdir#/" />
 <cfset pgnames = "#details.pgname#" />    
     <cfelse>
         
  <cfset startpage = "#details.customtestpagelink#" />       
        <cfset pgnames = "#details.customtestpagename#" />    
    </cfif>
     
     
     

<cfif #old_ticketstatus# is not "Implemented" and #new_ticketstatus# is "Implemented" >
<cfmail from="support@theactorsoffice.com" failto="kevinking7135@gmail.com" replyto="kevinking7135@gmail.com" to="cansoff@gmail.com" bcc="kevinking7135@gmail.com"  cc="jodie@jodiebentley.com" 
         usessl="true"
         usetls="true"
     
       
        subject="TICKET NO #details.recid# - Ready for Testing" type="HTML">
    <HTML>
       <head><title>TAO TICKET NO #details.recid#</title>

       </head>
       <body>
           <!--- Style Tag in the Body, not Head, for Email --->
           <style type="text/css">
               body { font-size: 14px; }
           </style>
          <p>Hi Chris,</p>
            <p>This is to inform you that  ticket No. #details.recid# has been implement and ready for testing in the dev environment.</p>
         
           <h4><A HREF="https://app.theactorsoffice.com/app/testing/?recid=#details.ticketid#">TEST</A></h4>
        
 
 
           
           
           <p>&nbsp;</p>
           <p>Best,</p>
        
           <p>Kevin</p>
                 
                 <p>&nbsp;</p>
           
             <table class="main_html" style="direction: ltr;                                                                                                        border-radius: 0;                                    moz-border-radius:0;                                    khtml-border-radius:0;                                    o-border-radius:0;                                    webkit-border-radius:0;                                    ms-border-radius:0;                                    border-collapse: collapse;">
                    <tbody>
                        <tr>
                            <td>

                                <table cellpadding="0" cellspacing="0" class="ws-tpl" style="font-family: Verdana; line-height: 1.25;padding-bottom: 10px;color:##000;">
                                    <tbody>
                                        <tr>
                                            <td style="vertical-align: top; padding-right: 24px;">

                                                <table cellpadding="0" cellspacing="0" class="ws-tpl-photo" style="width:65px;">
                                                    <tbody>
                                                        <tr>
                                                            <td><img src="https://d36urhup7zbd7q.cloudfront.net/9f1033c8-aa07-4e56-a7e8-dedf97184598/IMG_4968.format_png.resize_200x.jpeg" height="100" width="65" style="width: 65px; border-radius: 0px; height: 100px;" class="fr-fil fr-dib"></td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </td>
                                            <td style="vertica-align:top;" valign="top">

                                                <table cellpadding="0" cellspacing="0" style="font-family: Verdana;">
                                                    <tbody>
                                                        <tr>
                                                            <td style="line-height: 1.32 ;"><span class="ws-tpl-name" data-acs="name" style="color-scheme: light only;  color: ##406E8E;  font-size: 12px;  font-family: Verdana;  font-weight: bold;">&nbsp;Kevin King&nbsp;</span>
                                                                <br><span class="ws-tpl-title" data-acs="title" style="color-scheme: light only;  font-size: 12px;  letter-spacing: 0px;  color: ##4e4b4c;  font-family: Verdana;  text-transform: initial;  color: ##406E8E;">&nbsp;Partner / Lead Application Developer at&nbsp;</span> <span class="ws-tpl-company" data-acs="company" style="color-scheme: light only;  font-size: 12px;  letter-spacing: 0px; color: ##4e4b4c;  font-family: Verdana;  text-transform: initial;  color: ##406E8E;">&nbsp;<strong>The Actor&##39;s Office&nbsp;</strong></span>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="line-height: 0;  padding-top: 14px;  padding-bottom: 14px ;">

                                                                <table cellpadding="0" cellspacing="0" style="width: 100%;">
                                                                    <tbody>
                                                                        <tr>
                                                                            <td class="ws-tpl-separator" style="line-height: 0;  font-size: 1pt;  border-bottom-width: 5px;  border-bottom-style: solid ;  border-bottom-color: ##406E8E ;">&nbsp;</td>
                                                                        </tr>
                                                                    </tbody>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="line-height:0;">

                                                                <table cellpadding="0" cellspacing="0">
                                                                    <tbody>
                                                                        <tr>
                                                                            <td>

                                                                                <table cellpadding="0" cellspacing="0">
                                                                                    <tbody>
                                                                                        <tr>
                                                                                            <td style="line-height: 0%; padding-bottom: 8px;">

                                                                                                <table cellpadding="0" cellspacing="0" class="ws-tpl-website" style="line-height: 14px; font-size: 12px;font-family: Verdana;">
                                                                                                    <tbody>
                                                                                                        <tr>
                                                                                                            <td style=" color-scheme: light only; font-family: Verdana; font-weight:bold; font-size: 12px; color: ##406E8E ;"><span style="line-height: 1.2;">W</span></td>
                                                                                                            <td style="width: 7px; font-size: 1pt; line-height: 0;" width="7">&nbsp;</td>
                                                                                                            <td style="color-scheme: light only; font-family: Verdana;font-size: 12px;"><a href="http://www.theactorsoffice.com" style="color-scheme: light only; text-decoration: none; font-size: 12px;font-family: Verdana;" target="_blank">&nbsp;<span data-acs="website" style="line-height: 1.2; color-scheme: light only; color: ##212121; font-family: Verdana; white-space: nowrap; font-size: 12px;">&nbsp;www.theactorsoffice.com&nbsp;</span>&nbsp;</a></td>
                                                                                                        </tr>
                                                                                                    </tbody>
                                                                                                </table>
                                                                                            </td>
                                                                                            <td style="line-height: 0%; padding-bottom: 8px;">

                                                                                                <table cellpadding="0" cellspacing="0" class="ws-tpl-email" style="line-height: 14px; font-size: 12px;font-family: Verdana;">
                                                                                                    <tbody>
                                                                                                        <tr>
                                                                                                            <td style="padding: 0 8px;"><span style="color-scheme: light only; font-family: Verdana; font-weight:bold; font-size: 12px; color: ##212121;">&nbsp;</span></td>
                                                                                                            <td style=" color-scheme: light only; font-family: Verdana; font-weight:bold; font-size: 12px; color: ##406E8E ;"><span style="line-height: 1.2;">E</span></td>
                                                                                                            <td style="width: 7px; font-size: 1pt; line-height: 0;" width="7">&nbsp;</td>
                                                                                                            <td style="color-scheme: light only; font-family: Verdana;font-size: 12px;"><a href="mailto:kking@theactorsoffice.com" style="color-scheme: light only; text-decoration: none; font-size: 12px;font-family: Verdana;" target="_blank">&nbsp;<span data-acs="email" style="line-height: 1.2; color-scheme: light only; color: ##212121; font-family: Verdana; white-space: nowrap; font-size: 12px;">&nbsp;kking@theactorsoffice.com&nbsp;</span>&nbsp;</a></td>
                                                                                                        </tr>
                                                                                                    </tbody>
                                                                                                </table>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </tbody>
                                                                                </table>
                                                                            </td>
                                                                        </tr>
                                                                    </tbody>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>

                                <table border="0" cellpadding="0" cellspacing="0">
                                    <tbody>
                                        <tr>
                                            <td style="line-height:0;">
                                                <br>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </td>
                        </tr>
                    </tbody>
                </table>

                <table cellpadding="0" cellspacing="0" style="opacity:0!important;">
                    <tbody>
                        <tr>
                            <td height="1" style="height: 1px!important; width:1px!important; font-size: 0px!important;" width="1">&zwnj;</td>
                        </tr>
                    </tbody>
                </table>

           
           
           
           
           
           
     
       </body>
    </HTML>
</cfmail>


</cfif>
     
     
     

<cflocation url="/app/version/?recid=#oldverid#" />       
