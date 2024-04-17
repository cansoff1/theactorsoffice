<cfparam name="ctaction" default="view" />
 
<cfparam name="defCountry" default="" />

<cfparam name="usercontactid" default="30" />

<cfset cookie.userid=userid />

<cfset session.pgrtn="P" />

<cfset pgrtn="P" />

<cfinclude template="/include/remote_load.cfm" />

<cfinclude template="/include/tab_check_account.cfm" />

<cfinclude template="/include/qry/sitetypes.cfm" />

<cfinclude template="/include/qry/timezones.cfm" />

<cfinclude template="/include/qry/thrivecartdetails.cfm" />


<cfquery datasource="#dsn#" name="details">
    SELECT tzid,defRows,calstarttime,calendtime,avatarname,userfirstname,userlastname,useremail,nletter_yn,nletter_link FROM taousers WHERE userid = #userid#
</cfquery>

<cfquery datasource="#dsn#" name="mylinks">
    SELECT
    s.id
    ,s.sitetypeid
    ,s.sitename
    ,s.siteurl
    ,s.siteicon
    ,s.sitetypeid
    ,t.sitetypename
    ,t.pntitle
    FROM sitelinks_user s INNER JOIN sitetypes_user t ON t.sitetypeid = s.siteTypeid
    WHERE s.userid = #userid#
    ORDER BY s.sitename
</cfquery>

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

<div id="remoteUpdateAccount" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="standard-modalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header" style="background-color: #f3f7f9;">
                <h4 class="modal-title" id="standard-modalLabel">Account & Security</h4>
                <button type="button" class="close" data-bs-dismiss="modal" aria-hidden="true"><i class="mdi mdi-close-thick"></i></button>
            </div>
            <div class="modal-body">


                <cfparam name="t1" default="0" />

                <cfparam name="t2" default="0" />

                <cfparam name="t3" default="0" />

                <cfparam name="t4" default="0" />

                <cfparam name="t5" default="0" />

                <cfparam name="t6" default="0" />


                <form action="/app/myaccount/" method="post" class="parsley-examples" id="account" data-parsley-excluded="input[type=button], input[type=submit], input[type=reset], input[type=hidden], [disabled], :hidden" data-parsley-trigger="keyup" data-parsley-validate>


                    <cfoutput>
                        <input type="hidden" name="ctaction" value="update" />
                        <input type="hidden" name="t3" value="1" />
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


                            <input class="form-control" name="new_useremail" value="#details.useremail#" data-parsley-type="email" id="email_address" data-parsley-required data-parsley-trigger="focusout" data-parsley-checkemail data-parsley-checkemail-message="Email Address already Exists" placeholder="Enter your email">


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

<cfif #ctaction# is "update">

    <cfquery datasource="#dsn#" name="update">
        update taousers
        set userfirstname = '#new_userfirstname#'
        ,userlastname = '#new_userlastname#'
        ,avatarname = '#new_avatarname#'
        ,useremail = '#new_useremail#'
        where userid = #userid#
    </cfquery>

    <cfset ctaction="view" />

    <Cflocation url="/app/myaccount/?t3=1" />

</cfif>

<cfif #ctaction# is "addmember">

    <cfquery datasource="#dsn#" name="FINDK" maxrows="1">
        SELECT CONTACTID from contacts_ss WHERE userid = #userid# and col1 = '#topsearch_myteam#'
    </cfquery>

    <cfif #findK.recordcount# is "1">

        <cfset new_contactid=findk.contactid />

        <cfquery datasource="#dsn#" name="insert">
            INSERT INTO contactitems (contactid,valuetype,valuecategory,valuetext,itemstatus, primary_yn)
            VALUES (#new_contactid#,'Tags','Tag','My Team','Active', 'Y')
        </cfquery>

    </cfif>

    <cfset ctaction="view" />

    <cfset teamaction="view" />

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

    <cfset ctaction="view" />

    <cfset tab2_expand="true" />

    <cfset tab1_expand="false" />

    <cfset teamaction="view" />

</cfif>

<cfif #ctaction# is "update_newsletter">

    <cfquery datasource="#dsn#" name="update">
        update taousers
        set nletter_link = '#new_nletter_link#'
        ,nletter_yn = '#new_nletter_yn#'
        where userid = #userid#
    </cfquery>

    <cfset ctaction="view" />

</cfif>

<cfif #ctaction# is "update_cal">

    <Cfif #calendtime# is "00:00:00">

        <cfset calendtime="23:59:59" />

    </cfif>

    <cfquery datasource="#dsn#" name="update">
        update taousers
        set calstarttime =
        <cfqueryparam cfsqltype="cf_sql_time" value="#calstarttime#" />
        ,calendtime =
        <cfqueryparam cfsqltype="cf_sql_time" value="#calendtime#" />
        ,defRows =
        <cfqueryparam cfsqltype="cf_sql_integer" value="#defRows#" />
        ,defCountry =
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#defCountry#" />
        ,defState =
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#defState#" />
        where userid = #userid#
    </cfquery>

    <cfset ctaction="view" />

    <Cflocation url="/app/myaccount/?t4=1" />

</cfif>

<script>
    $(document).ready(function() {
        $("#actinglinksupdate").on("show.bs.modal", function(event) {
            // Place the returned HTML into the selected element
            $(this).find(".modal-body").load("<cfoutput>/include/actinglinksupdate.cfm?userid=#userid#</cfoutput>");
        });
    });
</script>

<script>
    $(document).ready(function() {
        $("#dashboardupdate").on("show.bs.modal", function(event) {
            // Place the returned HTML into the selected element
            $(this).find(".modal-body").load("<cfoutput>/include/dashboardupdate.cfm?userid=#userid#</cfoutput>");
        });
    });
</script>

<script>
    $(document).ready(function() {
        $("#actinglinksupdate").on("show.bs.modal", function(event) {
            // Place the returned HTML into the selected element
            $(this).find(".modal-body").load("<cfoutput>/include/actinglinksupdate.cfm?userid=#userid#</cfoutput>");
        });
    });
</script>

<script>
    $(document).ready(function() {
        $("#dashboardupdate").on("show.bs.modal", function(event) {
            // Place the returned HTML into the selected element
            $(this).find(".modal-body").load("<cfoutput>/include/dashboardupdate.cfm?userid=#userid#</cfoutput>");
        });
    });
</script>

<script>
    $(document).ready(function() {
        $("#addprofile").on("show.bs.modal", function(event) {
            // Place the returned HTML into the selected element
            $(this).find(".modal-body").load("<cfoutput>/include/remoteprofileAdd.cfm?userContactid=#userContactid#&userid=#userid#</cfoutput>");
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

<cfset modalid = "remoteAddContact" />

<cfset modaltitle = "remoteAddContact" />

<cfinclude template="/include/modal.cfm" />


<cfset modalid = "actinglinksupdate" />

<cfset modaltitle = "Acting Links" />

<cfinclude template="/include/modal.cfm" />


<cfset modalid = "paneladd" />

<cfset modaltitle = "Custom Panel Add" />

<cfinclude template="/include/modal.cfm" />

<cfset modalid = "dashboardupdate" />

<cfset modaltitle = "Dashboard Peferences" />
 
<cfinclude template="/include/modal.cfm" />

<cfoutput>

    <script>
        $(document).ready(function() {
            $("##paneladd").on("show.bs.modal", function(event) {
                // Place the returned HTML into the selected element
                $(this).find(".modal-body").load("/include/remotePanelAdd.cfm?userid=#userid#");
            });
        });
    </script>

</cfoutput>

<cfloop query="sitetypes">

    <cfoutput>

        <script>
            $(document).ready(function() {
                $("##addlink_#sitetypes.sitetypeid#").on("show.bs.modal", function(event) {
                    // Place the returned HTML into the selected element
                    $(this).find(".modal-body").load("/include/remotelinkAdd.cfm?new_sitetypeid=#sitetypes.sitetypeid#&userid=#userid#");
                });
            });
        </script>

    </cfoutput>


    <cfoutput>

        <div id="addlink_#sitetypes.sitetypeid#" class="modal fade" tabindex="-1" aria-labelledby="standard-modalLabel" aria-hidden="true">

            <div class="modal-dialog">

                <div class="modal-content">

                    <div class="modal-header" style="background-color: ##f3f7f9;">

                        <h4 class="modal-title" id="standard-modalLabel">Add Custom #sitetypes.sitetypename# Link</h4>

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

<cfloop query="mylinks">

    <cfoutput>

        <script>
            $(document).ready(function() {
                $("##updatelink_#mylinks.id#").on("show.bs.modal", function(event) {
                    // Place the returned HTML into the selected element
                    $(this).find(".modal-body").load("/include/remotelinkUpdate.cfm?id=#mylinks.id#");
                });
            });
        </script>

    </cfoutput>

    <cfoutput>

        <div id="updatelink_#mylinks.id#" class="modal fade" tabindex="-1" aria-labelledby="standard-modalLabel" aria-hidden="true">

            <div class="modal-dialog">

                <div class="modal-content">

                    <div class="modal-header" style="background-color: ##f3f7f9;">

                        <h4 class="modal-title" id="standard-modalLabel">#mylinks.sitetypename# Link Update</h4>

                        <button type="button" class="close" data-bs-dismiss="modal" aria-hidden="true">

                            <i class="mdi mdi-close-thick"></i>

                        </button>

                    </div>

                    <div class="modal-body">

                    </div>

                </div>

            </div>

        </div>

    </cfoutput>

</cfloop>

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

<cfoutput>

    <div id="addprofile" class="modal fade" tabindex="-1" aria-labelledby="standard-modalLabel" aria-hidden="true">

        <div class="modal-dialog">

            <div class="modal-content">

                <div class="modal-header" style="background-color: ##f3f7f9;">

                    <h4 class="modal-title" id="standard-modalLabel">Profile Link</h4>

                    <button type="button" class="close" data-bs-dismiss="modal" aria-hidden="true"><i class="mdi mdi-close-thick"></i>

                    </button>

                </div>

                <div class="modal-body">

                </div>

            </div>

        </div>

    </div>

</cfoutput>

<CFOUTPUT>

    <CFSET CURRENTID=#userContactid# />

</CFOUTPUT>

<cfinclude template="/include/qry/itemsall.cfm" />

<cfinclude template="/include/qry/tagsvalid.cfm" />

<cfset catArea_UCB="U" />

<cfinclude template="/include/qry/categories.cfm" />

<cfif #ctaction# is "deleteitem">

    <cfquery datasource="#dsn#" name="del"> update contactitems set isDeleted = 1 where itemid = #itemidd# and contactid = #currentid#
    </cfquery>

    <cfset ctaction="update" />

</cfif>

<cfif #ctaction# is "update">

    <cfquery datasource="#dsn#" name="del"> update contactitems set isDeleted = 1 where contactid = #currentid# and itemstatus = 'Pending'
    </cfquery>

    <CFLOOP QUERY="categories">

        <cfquery datasource="#dsn#" name="Find"> Select itemid from contactitems where contactid = #currentid# and valueCategory = '#categories.valuecategory#' and itemStatus = 'Pending'
        </cfquery>

        <cfif #Find.recordcount# is "0">

            <cfquery datasource="#dsn#" name="Insert"> INSERT INTO contactitems (contactID,valueType,valuecategory,itemStatus) VALUES (#currentid#,'#categories.valueTypeDef#','#categories.valuecategory#','Pending')
            </cfquery>

        </cfif>

    </CFLOOP>

    <cfset ctaction="view" />

</cfif>

<cfquery datasource="#dsn#" name="usercontact">
    select contactid from taousers where userid = #userid#
</cfquery>

<cfset currentid=usercontact.contactid />

<div class="row" style="margin: auto;">

    <div class="col-md-12">


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

                <form action="/app/myaccount/" method="post" class="parsley-examples" data-parsley-excluded="input[type=button], input[type=submit], input[type=reset], input[type=hidden], [disabled], :hidden" data-parsley-trigger="keyup" data-parsley-validate id="preferences">

                    <div class="row" />

                    <cfoutput>

                        <input type="hidden" name="ctaction" value="update_cal" />

                        <input type="hidden" name="t4" value="1" />

                        <div class="form-group col-md-6">

                            <label for="eventTypeName">Start Time<span class="text-danger">*</span></label>

                            <input class="form-control" id="calstarttime" value="#details.calstarttime#" type="time" name="calstarttime" data-parsley-required data-parsley-error-message="Start Time is required" />

                        </div>

                        <div class="form-group col-md-6">

                            <label for="eventTypeName">End Time<span class="text-danger">*</span></label>

                            <input class="form-control" id="calendtime" value="#details.calendtime#" type="time" name="calendtime" data-parsley-required data-parsley-error-message="End Time is required" />

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

                        <div class="form-group col-md-6">

                            <label for="eventTypeName">Default Country<span class="text-danger">*</span></label>

                            <input class="form-control" id="defcountry" value="#details.defcountry#" type="text" name="defcountry" data-parsley-required data-parsley-error-message="Country is required">

                        </div>

                        <div class="form-group col-md-6">

                            <label for="eventTypeName">Default State<span class="text-danger">*</span></label>

                            <input class="form-control" id="defstate" value="#details.defstate#" type="text" name="defstate" data-parsley-required data-parsley-error-message="State is required" />

                        </div>

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







<div id="updatenewsletter" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="standard-modalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header" style="background-color: ##f3f7f9;">
                <h4 class="modal-title" id="standard-modalLabel">Newsletter Update</h4>
                <button type="button" class="close" data-bs-dismiss="modal" aria-hidden="true"><i class="mdi mdi-close-thick"></i></button>
            </div>
            <div class="modal-body">




                <form action="/app/myaccount/" method="post" class="parsley-examples" validate id="newsletter" data-parsley-excluded="input[type=button], input[type=submit], input[type=reset], input[type=hidden], [disabled], :hidden" data-parsley-trigger="keyup" data-parsley-validate>



                    <div class="row" />



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




    <cfset script_name_include="/include/#ListLast(GetCurrentTemplatePath(), " \")#" />
    <cfinclude template="/include/bigbrotherinclude.cfm" />