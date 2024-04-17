 <CFINCLUDE template="/include/remote_load.cfm" />

<cfset modalid = "dashboardupdate" />
<cfset modaltitle = "Dashboard Peferences" />
<cfoutput>#modalTItle#</cfoutput>
<cfinclude template="/include/modal.cfm" />


<cfquery datasource="#dsn#" name="details">
    SELECT u.viewtypeid, u.add1, u.add2, u.city, u.regionid, u.zip, u.tzid, u.defRows,u.calstarttime, u.calendtime, u.avatarname, u.userfirstname, u.userlastname, u.useremail, u.nletter_yn,u.nletter_link, v.viewtype,u.defcountry,u.defstate,
    u.add1,u.add2,u.city,u.regionid,u.zip,u.dateformatid,df.*
    
    FROM taousers u 
    LEFT JOIN dateformats df on df.id = u.dateFormatid
    left outer join viewtypes v on v.viewtypeid = u.viewtypeid
    left join regions r on r.regionid = u.regionid
    WHERE u.userid = #userid#
</cfquery>



<cfquery name="FindUser" datasource="#dsn#">
    SELECT
    u.userid
    ,u.recordname
    ,u.userFirstName
    ,u.userLastName
    ,u.userEmail
    ,u.contactid
    ,u.userRole
    ,u.calstarttime
    ,u.calendtime
    ,u.avatarname
    ,u.IsBetaTester
    ,u.defRows
    
    
    ,u.contactid AS userContactID
    ,u.tzid
   ,u.add1,u.add2,u.city,u.regionid,u.zip,u.countryid

 ,u.dateformatid

    FROM taousers u
    LEFT JOIN dateformats df on df.id = u.dateFormatid
 

     
    WHERE u.userid = '#userid#'  
 
    
</cfquery>

        
  <cfinclude template="/include/qry/dateformats.cfm" />      
        
        
        
        
        
        
        
<cfparam name="ctaction" default="view" />





<cfif #ctaction# is "excludeaction">
    <cfquery datasource="#dsn#" name="update">
        UPDATE actionusers_tbl
        SET isdeleted = 1

        WHERE id = #new_id#
    </cfquery>

    <cfset ctaction="view" />
</cfif>

<cfif #ctaction# is "excludeaction">
    <cfquery datasource="#dsn#" name="update">
        UPDATE actionusers_tbl
        SET isdeleted = 1

        WHERE id = #new_id#
    </cfquery>

    <cfset ctaction="view" />
</cfif>



<cfif #ctaction# is "includeaction">
    <cfquery datasource="#dsn#" name="update">
        UPDATE actionusers_tbl
        SET isdeleted = 0

        WHERE id = #new_id#
    </cfquery>
    <cfset ctaction="view" />
</cfif>


<cfquery datasource="#dsn#" name="actions">
    SELECT au.id,
    s.systemID
    ,s.systemName
    ,s.SystemType
    ,s.SystemScope
    ,s.SystemDescript
    ,s.SystemTriggerNote
    ,a.actionID
    ,a.actionNo
    ,a.actionDetails
    ,a.actionTitle
    ,a.navToURL
    ,au.actionDaysNo
    ,au.actionDaysRecurring
    ,a.actionNotes
    ,a.actionInfo
    FROM fusystems s
    INNER JOIN fuactions a ON s.systemid = a.systemid
    INNER JOIN actionusers au on au.actionid = a.actionid
    WHERE au.userid = #userid#
    ORDER BY a.actionNo
</cfquery>





<cfparam name="new_isAuditionModule" default="0" />


<cfif #ctaction# is "update">

    <cfquery datasource="#dsn#" name="update">
        update taousers
        set userfirstname = '#new_userfirstname#'
        ,userlastname = '#new_userlastname#'
        ,avatarname = '#new_avatarname#'
        ,useremail = '#new_useremail#'
 
        ,add1 = '#add1#'
        ,add2 = '#add2#'
        ,city = '#city#'
        ,zip = '#zip#'
        ,regionid = '#new_regionid#'
        ,countryid = '#new_countryid#'
        ,isAuditionModule = #new_isAuditionModule#
        where userid = #userid#
    </cfquery>

    <cfset ctaction="view" />
    
    
    
    

    <Cflocation url="/app/myaccount/?t0=1" />

</cfif>

<cfparam name="new_regionid" default="" />

<cfparam name="new_countryid" default="" />

<cfparam name="valueCountry" default="" />

<cfparam name="valuestate" default="" />

<cfparam name="valuetext" default="" />

<cfparam name="def_regionid" default="" />

<cfparam name="def_countryid" default="" />

<cfinclude template="/include/qry/countries.cfm" />

<cfinclude template="/include/qry/regions.cfm" />

<cfinclude template="/include/qry/cities.cfm" />

<cfif #ctaction# is "addmember">

    <cfquery datasource="#dsn#" name="FINDK" maxrows="1">
        SELECT CONTACTID from contacts_ss WHERE userid = #userid# and col1 = '#topsearch_myteam#'
    </cfquery>

    <cfif #findK.recordcount# is "1">

        <cfset new_contactid=findk.contactid />
<Cfif #new_contactid# is not "">
        <cfquery datasource="#dsn#" name="insert">
            INSERT INTO contactitems (contactid,valuetype,valuecategory,valuetext,itemstatus, primary_yn)
            VALUES (#new_contactid#,'Tags','Tag','My Team','Active', 'Y')
        </cfquery>

        </cfif>

    </cfif>

<cfif #new_regionid# is "" and #def_regionid# is not "">

    <cfset new_regionid=def_regionid />

</cfif>


<cfif #new_countryid# is "" and #def_countryid# is not "">

    <cfset new_countryid=def_countryid />

</cfif>


<cfinclude template="/include/qry/timezones.cfm" />
<cfparam name="t2" default="0" />




<cfif #devicetype# is "mobile">

    <cfif #t2# is "1">

        <Cflocation url="/app/contact/?contactid=#contactid#&new_pgid=122" />

    </cfif>

    <cfparam name="t3" default="0" />

    <cfif #t3# is "1">

        <Cflocation url="/app/contact/?contactid=#contactid#&new_pgid=124" />

    </cfif>

    <cfparam name="t7" default="0" />

    <cfif #t7# is "1">

        <Cflocation url="/app/contact/?contactid=#contactid#&new_pgid=125" />

    </cfif>
</cfif>
 




<script>
    $(document).ready(function() {
        $("#dashboardupdate").on("show.bs.modal", function(event) {
            // Place the returned HTML into the selected element
            $(this).find(".modal-body").load("<cfoutput>/include/dashboardupdate.cfm?userid=#userid#</cfoutput>");
        });
    });
</script>








<cfloop query="actions">
    <cfoutput>
        <script>
            $(document).ready(function() {
                $("##updateaction_#actions.id#").on("show.bs.modal", function(event) {
                    // Place the returned HTML into the selected element
                    $(this).find(".modal-body").load("/include/remoteactionUpdate.cfm?id=#actions.id#");
                });
            });
        </script>
    </cfoutput>

    <cfoutput>
        <div id="updateaction_#actions.id#" class="modal fade" tabindex="-1" aria-labelledby="standard-modalLabel" aria-hidden="true">

            <div class="modal-dialog">

                <div class="modal-content">

                    <div class="modal-header" style="background-color: ##f3f7f9;">

                        <h4 class="modal-title" id="standard-modalLabel">#actions.systemName# Action Update</h4>

                        <button type="button" class="close" data-bs-dismiss="modal" aria-hidden="true"><i class="mdi mdi-close-thick"></i>

                        </button>

                    </div>

                    <div class="modal-body">

                    </div>

                </div>

            </div>

        </div>

    </cfoutput>

</cfloop>



<div id="updatenewsletter" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="standard-modalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header" style="background-color: ##f3f7f9;">
                <h4 class="modal-title" id="standard-modalLabel">Newsletter Update</h4>
                <button type="button" class="close" data-bs-dismiss="modal" aria-hidden="true"><i class="mdi mdi-close-thick"></i></button>
            </div>
            <div class="modal-body">

                <form action="/app/myaccount/update_newsletter.cfm" method="post" class="parsley-examples" validate id="newsletter" data-parsley-excluded="input[type=button], input[type=submit], input[type=reset], input[type=hidden], [disabled], :hidden" data-parsley-trigger="keyup" data-parsley-validate>



                    <cfoutput>
                        <input type="hidden" name="ctaction" value="update_newsletter" />
                        <input type="hidden" name="t4" value="1" />


                        <div class="form-group col-md-3">
                            <label for="eventTypeName">Newsletter</label>
                            <select class="form-control" name="new_nletter_yn" id="new_nletter_yn">


                                <option value="N" <cfif #details.nletter_yn# is "N"> Selected </cfif>>No</option>

                                <option value="Y" <cfif #details.nletter_yn# is "Y"> Selected </cfif>>Yes</option>

                            </select>
                            <div class="invalid-feedback">
                                Please select Yes or No.
                            </div>

                        </div>

                        <div class="form-group col-md-12">
                            <label for="userLastName">Newsletter Link<span class="text-danger">*</span></label>

                            <input class="form-control" type="text" id="new_nletter_link" name="new_nletter_link" value="#details.nletter_link#" placeholder="Enter your newsletter link">

                        </div>

                        <div class="form-group text-center col-md-12">
                            <button class=" btn btn-primary editable-submit btn-sm waves-effect waves-light" type="submit" style="background-color: ##406e8e; border: ##406e8e;">Update</button>
                        </div>
                    </cfoutput>

                </form>

            </div>
        </div>


    </div>
</div>



<div id="updatecal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="standard-modalLabel" aria-hidden="true">

    <div class="modal-dialog">

        <div class="modal-content">

            <div class="modal-header" style="background-color: ##f3f7f9;">

                <h4 class="modal-title" id="standard-modalLabel">Default Settings Update</h4>

                <button type="button" class="close" data-bs-dismiss="modal" aria-hidden="true"><i class="mdi mdi-close-thick"></i>

                </button>

            </div>


            <div class="modal-body">

                <p>Update your default settings.</p>

                <form action="/app/myaccount/update_cal.cfm" method="post" class="parsley-examples" data-parsley-excluded="input[type=button], input[type=submit], input[type=reset], input[type=hidden], [disabled], :hidden" data-parsley-trigger="keyup" data-parsley-validate id="preferences">

                    <div class="row" />

                    <cfoutput>

                        <input type="hidden" name="ctaction" value="update_cal" />

                        <input type="hidden" name="t4" value="1" />

                        <div class="form-group col-md-6">

                            <label for="calstarttime">Start Time<span class="text-danger">*</span></label>

           
                            
                                     <select class="form-control" name="calstarttime" id="calstarttime">
                                    <Cfoutput> 
                                        
<cfset new_calstarttime = "#details.calstarttime#" />
<option value="05:00:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('05:00:00')#">Selected</cfif>>5:00 AM</option>
<option value="05:15:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('05:15:00')#">Selected</cfif>>5:15 AM</option>
<option value="05:30:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('05:30:00')#">Selected</cfif>>5:30 AM</option>
<option value="05:45:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('05:45:00')#">Selected</cfif>>5:45 AM</option>
<option value="06:00:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('06:00:00')#">Selected</cfif>>6:00 AM</option>
<option value="06:15:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('06:15:00')#">Selected</cfif>>6:15 AM</option>
<option value="06:30:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('06:30:00')#">Selected</cfif>>6:30 AM</option>
<option value="06:45:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('06:45:00')#">Selected</cfif>>6:45 AM</option>
<option value="07:00:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('07:00:00')#">Selected</cfif>>7:00 AM</option>
<option value="07:15:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('07:15:00')#">Selected</cfif>>7:15 AM</option>
<option value="07:30:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('07:30:00')#">Selected</cfif>>7:30 AM</option>
<option value="07:45:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('07:45:00')#">Selected</cfif>>7:45 AM</option>
<option value="08:00:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('08:00:00')#">Selected</cfif>>8:00 AM</option>
<option value="08:15:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('08:15:00')#">Selected</cfif>>8:15 AM</option>
<option value="08:30:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('08:30:00')#">Selected</cfif>>8:30 AM</option>
<option value="08:45:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('08:45:00')#">Selected</cfif>>8:45 AM</option>
<option value="09:00:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('09:00:00')#">Selected</cfif>>9:00 AM</option>
<option value="09:15:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('09:15:00')#">Selected</cfif>>9:15 AM</option>
<option value="09:30:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('09:30:00')#">Selected</cfif>>9:30 AM</option>
<option value="09:45:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('09:45:00')#">Selected</cfif>>9:45 AM</option>
<option value="10:00:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('10:00:00')#">Selected</cfif>>10:00 AM</option>
<option value="10:15:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('10:15:00')#">Selected</cfif>>10:15 AM</option>
<option value="10:30:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('10:30:00')#">Selected</cfif>>10:30 AM</option>
<option value="10:45:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('10:45:00')#">Selected</cfif>>10:45 AM</option>
<option value="11:00:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('11:00:00')#">Selected</cfif>>11:00 AM</option>
<option value="11:15:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('11:15:00')#">Selected</cfif>>11:15 AM</option>
<option value="11:30:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('11:30:00')#">Selected</cfif>>11:30 AM</option>
<option value="11:45:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('11:45:00')#">Selected</cfif>>11:45 AM</option>
<option value="12:00:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('12:00:00')#">Selected</cfif>>12:00 PM</option>
<option value="12:15:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('12:15:00')#">Selected</cfif>>12:15 PM</option>
<option value="12:30:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('12:30:00')#">Selected</cfif>>12:30 PM</option>
<option value="12:45:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('12:45:00')#">Selected</cfif>>12:45 PM</option>
<option value="13:00:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('13:00:00')#">Selected</cfif>>1:00 PM</option>
<option value="13:15:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('13:15:00')#">Selected</cfif>>1:15 PM</option>
<option value="13:30:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('13:30:00')#">Selected</cfif>>1:30 PM</option>
<option value="13:45:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('13:45:00')#">Selected</cfif>>1:45 PM</option>
<option value="14:00:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('14:00:00')#">Selected</cfif>>2:00 PM</option>
<option value="14:15:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('14:15:00')#">Selected</cfif>>2:15 PM</option>
<option value="14:30:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('14:30:00')#">Selected</cfif>>2:30 PM</option>
<option value="14:45:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('14:45:00')#">Selected</cfif>>2:45 PM</option>
<option value="15:00:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('15:00:00')#">Selected</cfif>>3:00 PM</option>
<option value="15:15:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('15:15:00')#">Selected</cfif>>3:15 PM</option>
<option value="15:30:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('15:30:00')#">Selected</cfif>>3:30 PM</option>
<option value="15:45:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('15:45:00')#">Selected</cfif>>3:45 PM</option>
<option value="16:00:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('16:00:00')#">Selected</cfif>>4:00 PM</option>
<option value="16:15:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('16:15:00')#">Selected</cfif>>4:15 PM</option>
<option value="16:30:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('16:30:00')#">Selected</cfif>>4:30 PM</option>
<option value="16:45:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('16:45:00')#">Selected</cfif>>4:45 PM</option>
<option value="17:00:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('17:00:00')#">Selected</cfif>>5:00 PM</option>
<option value="17:15:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('17:15:00')#">Selected</cfif>>5:15 PM</option>
<option value="17:30:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('17:30:00')#">Selected</cfif>>5:30 PM</option>
<option value="17:45:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('17:45:00')#">Selected</cfif>>5:45 PM</option>
<option value="18:00:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('18:00:00')#">Selected</cfif>>6:00 PM</option>
<option value="18:15:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('18:15:00')#">Selected</cfif>>6:15 PM</option>
<option value="18:30:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('18:30:00')#">Selected</cfif>>6:30 PM</option>
<option value="18:45:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('18:45:00')#">Selected</cfif>>6:45 PM</option>
<option value="19:00:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('19:00:00')#">Selected</cfif>>7:00 PM</option>
<option value="19:15:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('19:15:00')#">Selected</cfif>>7:15 PM</option>
<option value="19:30:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('19:30:00')#">Selected</cfif>>7:30 PM</option>
<option value="19:45:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('19:45:00')#">Selected</cfif>>7:45 PM</option>
<option value="20:00:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('20:00:00')#">Selected</cfif>>8:00 PM</option>
<option value="20:15:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('20:15:00')#">Selected</cfif>>8:15 PM</option>
<option value="20:30:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('20:30:00')#">Selected</cfif>>8:30 PM</option>
<option value="20:45:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('20:45:00')#">Selected</cfif>>8:45 PM</option>
<option value="21:00:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('21:00:00')#">Selected</cfif>>9:00 PM</option>
<option value="21:15:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('21:15:00')#">Selected</cfif>>9:15 PM</option>
<option value="21:30:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('21:30:00')#">Selected</cfif>>9:30 PM</option>
<option value="21:45:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('21:45:00')#">Selected</cfif>>9:45 PM</option>
<option value="22:00:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('22:00:00')#">Selected</cfif>>10:00 PM</option>
<option value="22:15:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('22:15:00')#">Selected</cfif>>10:15 PM</option>
<option value="22:30:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('22:30:00')#">Selected</cfif>>10:30 PM</option>
<option value="22:45:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('22:45:00')#">Selected</cfif>>10:45 PM</option>
<option value="23:00:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('23:00:00')#">Selected</cfif>>11:00 PM</option>
<option value="23:15:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('23:15:00')#">Selected</cfif>>11:15 PM</option>
<option value="23:30:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('23:30:00')#">Selected</cfif>>11:30 PM</option>
<option value="23:45:00" <cfif "#timeformat(new_calstarttime)#" is "#timeformat('23:45:00')#">Selected</cfif>>11:45 PM</option>

                            </select>
</Cfoutput>   

                        </div>

                        <div class="form-group col-md-6">

                            <label for="calendtime">End Time<span class="text-danger">*</span></label>

    
                            
                                     <select class="form-control" name="calendtime" id="calendtime">
                                    <Cfoutput> 
                                        
<cfset new_calendtime = "#details.calendtime#" />
<option value="05:00:00" <cfif "#timeformat(new_calendtime)#" is "#timeformat('05:00:00')#">Selected</cfif>>5:00 AM</option>
<option value="05:15:00" <cfif "#timeformat(new_calendtime)#" is "#timeformat('05:15:00')#">Selected</cfif>>5:15 AM</option>
<option value="05:30:00" <cfif "#timeformat(new_calendtime)#" is "#timeformat('05:30:00')#">Selected</cfif>>5:30 AM</option>
<option value="05:45:00" <cfif "#timeformat(new_calendtime)#" is "#timeformat('05:45:00')#">Selected</cfif>>5:45 AM</option>
<option value="06:00:00" <cfif "#timeformat(new_calendtime)#" is "#timeformat('06:00:00')#">Selected</cfif>>6:00 AM</option>
<option value="06:15:00" <cfif "#timeformat(new_calendtime)#" is "#timeformat('06:15:00')#">Selected</cfif>>6:15 AM</option>
<option value="06:30:00" <cfif "#timeformat(new_calendtime)#" is "#timeformat('06:30:00')#">Selected</cfif>>6:30 AM</option>
<option value="06:45:00" <cfif "#timeformat(new_calendtime)#" is "#timeformat('06:45:00')#">Selected</cfif>>6:45 AM</option>
<option value="07:00:00" <cfif "#timeformat(new_calendtime)#" is "#timeformat('07:00:00')#">Selected</cfif>>7:00 AM</option>
<option value="07:15:00" <cfif "#timeformat(new_calendtime)#" is "#timeformat('07:15:00')#">Selected</cfif>>7:15 AM</option>
<option value="07:30:00" <cfif "#timeformat(new_calendtime)#" is "#timeformat('07:30:00')#">Selected</cfif>>7:30 AM</option>
<option value="07:45:00" <cfif "#timeformat(new_calendtime)#" is "#timeformat('07:45:00')#">Selected</cfif>>7:45 AM</option>
<option value="08:00:00" <cfif "#timeformat(new_calendtime)#" is "#timeformat('08:00:00')#">Selected</cfif>>8:00 AM</option>
<option value="08:15:00" <cfif "#timeformat(new_calendtime)#" is "#timeformat('08:15:00')#">Selected</cfif>>8:15 AM</option>
<option value="08:30:00" <cfif "#timeformat(new_calendtime)#" is "#timeformat('08:30:00')#">Selected</cfif>>8:30 AM</option>
<option value="08:45:00" <cfif "#timeformat(new_calendtime)#" is "#timeformat('08:45:00')#">Selected</cfif>>8:45 AM</option>
<option value="09:00:00" <cfif "#timeformat(new_calendtime)#" is "#timeformat('09:00:00')#">Selected</cfif>>9:00 AM</option>
<option value="09:15:00" <cfif "#timeformat(new_calendtime)#" is "#timeformat('09:15:00')#">Selected</cfif>>9:15 AM</option>
<option value="09:30:00" <cfif "#timeformat(new_calendtime)#" is "#timeformat('09:30:00')#">Selected</cfif>>9:30 AM</option>
<option value="09:45:00" <cfif "#timeformat(new_calendtime)#" is "#timeformat('09:45:00')#">Selected</cfif>>9:45 AM</option>
<option value="10:00:00" <cfif "#timeformat(new_calendtime)#" is "#timeformat('10:00:00')#">Selected</cfif>>10:00 AM</option>
<option value="10:15:00" <cfif "#timeformat(new_calendtime)#" is "#timeformat('10:15:00')#">Selected</cfif>>10:15 AM</option>
<option value="10:30:00" <cfif "#timeformat(new_calendtime)#" is "#timeformat('10:30:00')#">Selected</cfif>>10:30 AM</option>
<option value="10:45:00" <cfif "#timeformat(new_calendtime)#" is "#timeformat('10:45:00')#">Selected</cfif>>10:45 AM</option>
<option value="11:00:00" <cfif "#timeformat(new_calendtime)#" is "#timeformat('11:00:00')#">Selected</cfif>>11:00 AM</option>
<option value="11:15:00" <cfif "#timeformat(new_calendtime)#" is "#timeformat('11:15:00')#">Selected</cfif>>11:15 AM</option>
<option value="11:30:00" <cfif "#timeformat(new_calendtime)#" is "#timeformat('11:30:00')#">Selected</cfif>>11:30 AM</option>
<option value="11:45:00" <cfif "#timeformat(new_calendtime)#" is "#timeformat('11:45:00')#">Selected</cfif>>11:45 AM</option>
<option value="12:00:00" <cfif "#timeformat(new_calendtime)#" is "#timeformat('12:00:00')#">Selected</cfif>>12:00 PM</option>
<option value="12:15:00" <cfif "#timeformat(new_calendtime)#" is "#timeformat('12:15:00')#">Selected</cfif>>12:15 PM</option>
<option value="12:30:00" <cfif "#timeformat(new_calendtime)#" is "#timeformat('12:30:00')#">Selected</cfif>>12:30 PM</option>
<option value="12:45:00" <cfif "#timeformat(new_calendtime)#" is "#timeformat('12:45:00')#">Selected</cfif>>12:45 PM</option>
<option value="13:00:00" <cfif "#timeformat(new_calendtime)#" is "#timeformat('13:00:00')#">Selected</cfif>>1:00 PM</option>
<option value="13:15:00" <cfif "#timeformat(new_calendtime)#" is "#timeformat('13:15:00')#">Selected</cfif>>1:15 PM</option>
<option value="13:30:00" <cfif "#timeformat(new_calendtime)#" is "#timeformat('13:30:00')#">Selected</cfif>>1:30 PM</option>
<option value="13:45:00" <cfif "#timeformat(new_calendtime)#" is "#timeformat('13:45:00')#">Selected</cfif>>1:45 PM</option>
<option value="14:00:00" <cfif "#timeformat(new_calendtime)#" is "#timeformat('14:00:00')#">Selected</cfif>>2:00 PM</option>
<option value="14:15:00" <cfif "#timeformat(new_calendtime)#" is "#timeformat('14:15:00')#">Selected</cfif>>2:15 PM</option>
<option value="14:30:00" <cfif "#timeformat(new_calendtime)#" is "#timeformat('14:30:00')#">Selected</cfif>>2:30 PM</option>
<option value="14:45:00" <cfif "#timeformat(new_calendtime)#" is "#timeformat('14:45:00')#">Selected</cfif>>2:45 PM</option>
<option value="15:00:00" <cfif "#timeformat(new_calendtime)#" is "#timeformat('15:00:00')#">Selected</cfif>>3:00 PM</option>
<option value="15:15:00" <cfif "#timeformat(new_calendtime)#" is "#timeformat('15:15:00')#">Selected</cfif>>3:15 PM</option>
<option value="15:30:00" <cfif "#timeformat(new_calendtime)#" is "#timeformat('15:30:00')#">Selected</cfif>>3:30 PM</option>
<option value="15:45:00" <cfif "#timeformat(new_calendtime)#" is "#timeformat('15:45:00')#">Selected</cfif>>3:45 PM</option>
<option value="16:00:00" <cfif "#timeformat(new_calendtime)#" is "#timeformat('16:00:00')#">Selected</cfif>>4:00 PM</option>
<option value="16:15:00" <cfif "#timeformat(new_calendtime)#" is "#timeformat('16:15:00')#">Selected</cfif>>4:15 PM</option>
<option value="16:30:00" <cfif "#timeformat(new_calendtime)#" is "#timeformat('16:30:00')#">Selected</cfif>>4:30 PM</option>
<option value="16:45:00" <cfif "#timeformat(new_calendtime)#" is "#timeformat('16:45:00')#">Selected</cfif>>4:45 PM</option>
<option value="17:00:00" <cfif "#timeformat(new_calendtime)#" is "#timeformat('17:00:00')#">Selected</cfif>>5:00 PM</option>
<option value="17:15:00" <cfif "#timeformat(new_calendtime)#" is "#timeformat('17:15:00')#">Selected</cfif>>5:15 PM</option>
<option value="17:30:00" <cfif "#timeformat(new_calendtime)#" is "#timeformat('17:30:00')#">Selected</cfif>>5:30 PM</option>
<option value="17:45:00" <cfif "#timeformat(new_calendtime)#" is "#timeformat('17:45:00')#">Selected</cfif>>5:45 PM</option>
<option value="18:00:00" <cfif "#timeformat(new_calendtime)#" is "#timeformat('18:00:00')#">Selected</cfif>>6:00 PM</option>
<option value="18:15:00" <cfif "#timeformat(new_calendtime)#" is "#timeformat('18:15:00')#">Selected</cfif>>6:15 PM</option>
<option value="18:30:00" <cfif "#timeformat(new_calendtime)#" is "#timeformat('18:30:00')#">Selected</cfif>>6:30 PM</option>
<option value="18:45:00" <cfif "#timeformat(new_calendtime)#" is "#timeformat('18:45:00')#">Selected</cfif>>6:45 PM</option>
<option value="19:00:00" <cfif "#timeformat(new_calendtime)#" is "#timeformat('19:00:00')#">Selected</cfif>>7:00 PM</option>
<option value="19:15:00" <cfif "#timeformat(new_calendtime)#" is "#timeformat('19:15:00')#">Selected</cfif>>7:15 PM</option>
<option value="19:30:00" <cfif "#timeformat(new_calendtime)#" is "#timeformat('19:30:00')#">Selected</cfif>>7:30 PM</option>
<option value="19:45:00" <cfif "#timeformat(new_calendtime)#" is "#timeformat('19:45:00')#">Selected</cfif>>7:45 PM</option>
<option value="20:00:00" <cfif "#timeformat(new_calendtime)#" is "#timeformat('20:00:00')#">Selected</cfif>>8:00 PM</option>
<option value="20:15:00" <cfif "#timeformat(new_calendtime)#" is "#timeformat('20:15:00')#">Selected</cfif>>8:15 PM</option>
<option value="20:30:00" <cfif "#timeformat(new_calendtime)#" is "#timeformat('20:30:00')#">Selected</cfif>>8:30 PM</option>
<option value="20:45:00" <cfif "#timeformat(new_calendtime)#" is "#timeformat('20:45:00')#">Selected</cfif>>8:45 PM</option>
<option value="21:00:00" <cfif "#timeformat(new_calendtime)#" is "#timeformat('21:00:00')#">Selected</cfif>>9:00 PM</option>
<option value="21:15:00" <cfif "#timeformat(new_calendtime)#" is "#timeformat('21:15:00')#">Selected</cfif>>9:15 PM</option>
<option value="21:30:00" <cfif "#timeformat(new_calendtime)#" is "#timeformat('21:30:00')#">Selected</cfif>>9:30 PM</option>
<option value="21:45:00" <cfif "#timeformat(new_calendtime)#" is "#timeformat('21:45:00')#">Selected</cfif>>9:45 PM</option>
<option value="22:00:00" <cfif "#timeformat(new_calendtime)#" is "#timeformat('22:00:00')#">Selected</cfif>>10:00 PM</option>
<option value="22:15:00" <cfif "#timeformat(new_calendtime)#" is "#timeformat('22:15:00')#">Selected</cfif>>10:15 PM</option>
<option value="22:30:00" <cfif "#timeformat(new_calendtime)#" is "#timeformat('22:30:00')#">Selected</cfif>>10:30 PM</option>
<option value="22:45:00" <cfif "#timeformat(new_calendtime)#" is "#timeformat('22:45:00')#">Selected</cfif>>10:45 PM</option>
<option value="23:00:00" <cfif "#timeformat(new_calendtime)#" is "#timeformat('23:00:00')#">Selected</cfif>>11:00 PM</option>
<option value="23:15:00" <cfif "#timeformat(new_calendtime)#" is "#timeformat('23:15:00')#">Selected</cfif>>11:15 PM</option>
<option value="23:30:00" <cfif "#timeformat(new_calendtime)#" is "#timeformat('23:30:00')#">Selected</cfif>>11:30 PM</option>
<option value="23:45:00" <cfif "#timeformat(new_calendtime)#" is "#timeformat('23:45:00')#">Selected</cfif>>11:45 PM</option>

                            </select>
</Cfoutput>   
                        </div>


                        <div class="form-group col-md-6">

                            <label for="defrows">Rows Per Page<span class="text-danger">*</span></label>

                            <select class="form-control" name="defrows" id="defrows">

                                <cfoutput>

                                    <option value="10" <cfif #details.defrows# is "10"> Selected </cfif> >10</option>

                                    <option value="25" <cfif #details.defrows# is "25"> Selected </cfif>>25</option>

                                    <option value="50" <cfif #details.defrows# is "50"> Selected </cfif>>50</option>

                                    <option value="100" <cfif #details.defrows# is "100"> Selected </cfif>>100</option>

                                </cfoutput>

                            </select>

                        </div>



<input type="hidden" name="viewtypeid" value="#details.viewtypeid#"  />


                    </cfoutput>

                    <div class="form-group col-md-12">

                        <label for="tzid">Timezone<span class="text-danger">*</span></label>

                        <select class="form-control" name="tzid" id="tzid" data-parsley-required data-parsley-error-message="Timezone is required">

                            <cfoutput query="timezones">

                                <option value="#timezones.tzid#" <cfif #details.tzid# is "#timezones.tzid#"> Selected </cfif> >(#timezones.gmt#) #timezones.tzname#</option>

                            </cfoutput>

                        </select>

                    </div>

                    <div class="form-group text-center col-md-12">

                        <button class=" btn btn-primary editable-submit btn-sm waves-effect waves-light" type="submit" style="background-color: ##406e8e; border: ##406e8e;">Update</button>

                    </div>

            </div><!-- row end -->
            </form>



        </div><!-- modal-body end -->
    </div><!-- modal-content end -->

</div><!-- modal-dialog end -->

</div> <!-- modal end -->



<div id="remoteUpdateAccount" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="standard-modalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header" style="background-color: #f3f7f9;">
                <h4 class="modal-title" id="standard-modalLabel">Account & Security</h4>
                <button type="button" class="close" data-bs-dismiss="modal" aria-hidden="true"><i class="mdi mdi-close-thick"></i></button>
            </div>
            <div class="modal-body">


                <cfparam name="new_pgid" default="121" />

                <form action="/app/myaccount/?new_pgid=<cfoutput>#new_pgid#</cfoutput>" method="post" class="parsley-examples" id="account" data-parsley-excluded="input[type=button], input[type=submit], input[type=reset], input[type=hidden], [disabled], :hidden" data-parsley-trigger="keyup" data-parsley-validate>

                    <cfoutput>
                        <input type="hidden" name="ctaction" value="update" />

                        <div class="form-group col-md-12">
                            <label for="userFirstName">First Name<span class="text-danger">*</span></label></label>


                            <input class="form-control" type="text" id="new_userFirstName" name="new_userFirstName" value="#details.userFirstName#" data-parsley-required data-parsley-error-message="First Name is required" placeholder="Enter your first name">


                        </div>

                        <div class="form-group col-md-12">
                            <label for="userLastName">Last Name<span class="text-danger">*</span></label></label>


                            <input class="form-control" type="text" id="new_userLastName" name="new_userLastName" value="#details.userLastName#" data-parsley-required data-parsley-error-message="Last Name is required" placeholder="Enter your last name">


                        </div>

                        <div class="form-group col-md-12">
                            <label for="new_AvatarName">Avatar Name<span class="text-danger">*</span></label></label>


                            <input class="form-control" type="text" id="new_AvatarName" name="new_AvatarName" value="#details.avatarname#" data-parsley-required data-parsley-error-message="Avatar Name is required" placeholder="Enter your Avatar name">


                        </div>



                        <div class="form-group col-md-12">
                            <label for="useremail">Email<span class="text-danger">*</span></label>


                            <input class="form-control" name="new_useremail" value="#details.useremail#" data-parsley-type="email" id="email_address" placeholder="Enter your email">


                        </div>
            
            
            
            
            
            
            
     <div class="form-group col-md-12">
        <label for="projName">Address </label>
        <input class="form-control" type="text" id="add1" name="add1" value="#details.add1#" placeholder="Address" />

        <div class="invalid-feedback">
            Please enter an address.
        </div>
    </div>
    
         <div class="form-group col-md-12">
        <label for="projName">Extended Address </label>
        <input class="form-control" type="text" id="add2" name="add2" value="#details.add2#" placeholder="Extended address" />

        <div class="invalid-feedback">
            Please enter an extended address.
        </div>
    </div>
    

    
    
    
    
    
    
    
    
    
    
           
               <div class="form-group col-md-6">
                 <label for="valuetext">Town/City</label>

                 <input class="form-control" type="text" id="city"  name="city" value="#details.city#" placeholder="Enter City">

                
             </div>           
             
     
         
         
                 
               <div class="form-group col-md-6">
                 <label for="valuetext">Postal Code</label>

                 <input class="form-control" type="text" id="zip"   name="zip" value="#details.zip#" placeholder="Enter Postal Code">

             </div>                      
        
             
      
             </cfoutput>
         
         
                        <div class="form-group col-md-6">
                            <label for="countryid">Country <Cfoutput>[#new_countryid#]</Cfoutput><span class="text-danger">*</span></label>

<select id="countryid" class="form-control" name="new_countryid"  data-parsley-required data-parsley-error-message="Country is required">
    <option value="">--</option>
    <cfoutput query="countries" >
        <option value="#countries.countryid#"   <cfif #countries.countryid# is "#new_countryid#">selected </cfif> >#countries.countryname#</option>
</cfoutput>
</select>
                



                        </div>
        
        

                        <div class="form-group col-md-6">
                            <label for="regionid">State/Region<span class="text-danger">*</span></label>

            <select id="new_regionid" name="new_regionid" class="form-control" >
    <option value="">--</option>

     <cfoutput query="regions" >
         <option value="#regions.regionid#"  data-chained="#regions.countryid#" <cfif #regions.regionid# is "#new_regionid#">selected </cfif>   >#regions.regionname#</option>
</cfoutput>

</select>


                        </div>




         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
    
    
    
            
            
            
            
            
            
            
            
            
            
            
            
<div style="margin-left:25px;">
                <label class="custom-control-label">
                    <input type="checkbox" class="custom-control-input" id="isAuditionModule" value="1" name="new_isAuditionModule" <cfif #isAuditionModule# is "1"> checked </cfif> >
                    <span class="custom-control-label" for="isAuditionModule">Account module activated</span></label>
            </div>
</div>
            
            
            
            
            
            
            
            
            
            
            
            




                        <div class="form-group text-center col-md-12">
                            <button class=" btn btn-primary editable-submit btn-sm waves-effect waves-light" type="submit" style="background-color: ##406e8e; border: ##406e8e;">Update</button>
                        </div>

            


                </form>

     <script>$("#new_regionid").chained("#countryid");</script>
            </div>
        </div>

    </div>

</div>




<script>
    $(document).ready(function() {
        $(".parsley-examples").parsley()
    });
</script>


<script>
    $(document).ready(function() {

        $('#email_address').parsley();

        window.ParsleyValidator.addValidator('checkemail', {
            validateString: function(value) {
                return $.ajax({
                    url: '/include/fetch.php?userID=<Cfoutput>#userid#</cfoutput>',
                    method: "POST",
                    data: {
                        email: value
                    },
                    dataType: "json",
                    success: function(data) {
                        return true;
                    }
                });
            }
        });

    });
</script>









<script>
    $(document).ready(function() {
        $("#remoteAddContact").on("show.bs.modal", function(event) {
            // Place the returned HTML into the selected element
            $(this).find(".modal-body").load("<cfoutput>/include/remoteAddContact.cfm?userid=#userid#&src=account</cfoutput>");
        });
    });
</script>

<cfset modalid="remoteAddContact" />

<cfset modaltitle="Add Contact" />

<cfinclude template="/include/modal.cfm" />





<CFOUTPUT>

    <CFSET CURRENTID=#userContactid# />

</CFOUTPUT>


<cfparam name="ITEMIDD" default="0" />






    <cfset ctaction="view" />

    <cfset teamaction="view" />

    <cfset t2=1 />

</cfif>



<cfif #ctaction# is "deleteitem">

    <cfquery datasource="#dsn#" name="FINDz" maxrows="1">
        SELECT itemid from contactitems WHERE contactid=#deletecontactid# and valuetext = 'My Team'
    </cfquery>

    <cfif #findz.recordcount# is "1">

        <cfset new_itemid=findz.itemid />

        <cfquery datasource="#dsn#" name="update">
            update contactitems_tbl set isdeleted = 1 where itemid = #new_itemid#
        </cfquery>

    </cfif>

</cfif>

<cfinclude template="/include/qry/thrivecartdetails.cfm" />
<cfparam name="currentid" default="0" />
<cfset session.pgrtn="P" />

<cfset pgrtn="P" />







<cfif #devicetype# is "mobile">
    <div class="card">

        <div class="btn-group col-md-12">

            <button type="button" class="btn btn-primary btn-lg dropdown-toggle" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">

                <Cfoutput>#pgname#</Cfoutput>
                <i class="fe-menu"></i>

            </button>
            <div class="dropdown-menu">

                <cfloop query="FindOptions">
                    <cfoutput>
                        <a class="dropdown-item" href="/app/#pgDir#/?new_pgid=#FindOptions.pgid#">#FindOptions.pgname#</a>
                    </cfoutput>
                </cfloop>

            </div>
        </div><!-- /btn-group -->




        <div class="card-body">

            <cfif #pgid# is "121">
                <cfinclude template="/include/mylinks_pane.cfm" />
            </cfif>

            <cfif #pgid# is "122">
                <cfinclude template="/include/myteam_pane.cfm" />
            </cfif>

            <cfif #pgid# is "124">
                <cfinclude template="/include/prefs_pane.cfm" />
            </cfif>

            <cfif #pgid# is "125">
                <cfinclude template="/include/systemprefs_pane.cfm" />
            </cfif>

        </div>
    </div>

</cfif>

<cfif #devicetype# is not "mobile">

    <cfinclude template="/include/tab_check_account.cfm" />

    <cfparam name="tab1_expand" default="false" />
    
    <cfparam name="tab2_expand" default="false" />
    
    <cfparam name="tab3_expand" default="false" />
    
    <cfparam name="tab4_expand" default="false" />
    
    <cfparam name="tab5_expand" default="false" />
    
    <cfparam name="tab6_expand" default="false" />
    
    <cfparam name="tab7_expand" default="false" />
    
    <cfparam name="tab8_expand" default="false" />
    
     <cfparam name="tab9_expand" default="false" />

          <cfparam name="tab0_expand" default="false" />

               <cfparam name="tab10_expand" default="false" />

     

    <cfif #tab1_expand# is "false" and #tab2_expand# is "false" and #tab3_expand# is "false" 
    and #tab4_expand# is "false" and #tab7_expand# is "false"
     and #tab8_expand# is "false" and #tab9_expand# is "false"  
     and #tab0_expand# is "false" and  #tab10_expand# is "false">

        <cfset tab0_expand="true" />

        <cfset t0=1 />


    </cfif>

    <div class="card">
        
        <div class="card-body">  
            
            <ul class="nav nav-pills navtab-bg nav-justified p-1">
                
                <cfoutput>

                  <li class="nav-item"> <a href="##info" data-bs-toggle="tab" aria-expanded="#tab0_expand#" class="nav-link<cfif #tab0_expand# is 'true'> active</cfif>">Info </a>
                    </li>

                    <li class="nav-item"> <a href="##profile" data-bs-toggle="tab" aria-expanded="#tab1_expand#" class="nav-link<cfif #tab1_expand# is 'true'> active</cfif>">Dashboard </a>
                    </li>

                    <li class="nav-item"> <a href="##myteam" data-bs-toggle="tab" aria-expanded="#tab2_expand#" class="nav-link<cfif #tab2_expand# is 'true'> active</cfif>">My Team</a>
                    </li>
                    
                    <li class="nav-item"> <a href="##mybrand" data-bs-toggle="tab" aria-expanded="#tab3_expand#" class="nav-link<cfif #tab3_expand# is 'true'> active</cfif>">Brand Essence</a>
                    </li>
                    
                                        
                    <li class="nav-item"> <a href="##myheadshots" data-bs-toggle="tab" aria-expanded="#tab8_expand#" class="nav-link<cfif #tab8_expand# is 'true'> active</cfif>">Headshots</a>
                    </li>
                    
                         <li class="nav-item"> <a href="##mymaterials" data-bs-toggle="tab" aria-expanded="#tab9_expand#" class="nav-link<cfif #tab9_expand# is 'true'> active</cfif>">Materials</a>
                    </li>

                    <li class="nav-item"> <a href="##pref" data-bs-toggle="tab" aria-expanded="#tab4_expand#" class="nav-link<cfif #tab4_expand# is 'true'> active</cfif>">Preferences</a>
                    </li>

                    <li class="nav-item"> <a href="##systems" data-bs-toggle="tab" aria-expanded="#tab7_expand#" class="nav-link<cfif #tab7_expand# is 'true'> active</cfif>">Systems</a>
                    </li>

                        <li class="nav-item"> <a href="##billing" data-bs-toggle="tab" aria-expanded="#tab10_expand#" class="nav-link<cfif #tab10_expand# is 'true'> active</cfif>">Billing</a>
                    </li>
                 
                 
                    <span class="ml-auto padding-bottom:11px;text-nowrap border border-top-0 !important border-left-0 !important border-right-0 !important" style="border-top:0 !important;border-left:0 !important;border-right:0 !important;">

                    </span>

                </cfoutput>

            </ul>


            <div class="tab-content">

                  <div class="tab-pane<cfif #tab0_expand# is 'true'> show active</cfif>" id="info">
                    
                    <cfinclude template="/include/myinfo_pane.cfm" />
                    
                </div>

                <div class="tab-pane<cfif #tab1_expand# is 'true'> show active</cfif>" id="profile">
                    
                    <cfinclude template="/include/mylinks_pane.cfm" />
                    
                </div>

                <div class="tab-pane<cfif #tab2_expand# is 'true'> show active</cfif>" id="myteam">
                    
                    <cfinclude template="/include/myteam_pane.cfm" />
                    
                </div>
                
                <div class="tab-pane<cfif #tab3_expand# is 'true'> show active</cfif>" id="mybrand">
                    
                    <cfinclude template="/include/mybrand_pane.cfm" />
                    
                </div>
                
                          <div class="tab-pane<cfif #tab8_expand# is 'true'> show active</cfif>" id="myheadshots">
                    
                    <cfinclude template="/include/myheadshots_pane.cfm" />
                    
                </div>
                
                
                                  <div class="tab-pane<cfif #tab9_expand# is 'true'> show active</cfif>" id="mymaterials">
                    
                    <cfinclude template="/include/mymaterials_pane.cfm" />
                    
                </div>
                
                

                <div class="tab-pane<cfif #tab4_expand# is 'true'> show active</cfif>" id="pref">
                    
                    <cfinclude template="/include/prefs_pane.cfm" />
                    
                </div>

                <div class="tab-pane<cfif #tab7_expand# is 'true'> show active</cfif>" id="systems">
                    
                    <cfinclude template="/include/systemprefs_pane.cfm" />

                </div>

                                <div class="tab-pane<cfif #tab10_expand# is 'true'> show active</cfif>" id="billing">
                    
                    <cfinclude template="/include/mybilling_pane.cfm" />

                </div>
    
       

  

        </div>

    </div>


</cfif>
