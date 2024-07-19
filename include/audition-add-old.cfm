<cfparam name="rcontactid" default="0" />
<cfparam name="isdirect" default="0" />




<style>
    #hidden_divs {
        display: none;
    }

    #hidden_divss {
        display: none;
    }

    #hidden_divsss {
        display: none;
    }

    #hidden_divssss {
        display: none;
    }



    .output {
        font: 1rem 'Fira Sans', sans-serif;
    }


    fieldset {
        display: block;
        margin-inline-start: 1px;
        margin-inline-end: 1px;
        padding-block-start: 0.35em;
        padding-inline-start: 0.75em;
        padding-inline-end: 0.75em;
        padding-block-end: 0.625em;
        min-inline-size: min-content;
        border-width: 2px;
        border-style: groove;
        border-color: #ced4da;
        border-style: solid border-image: initial;
    }

</style>

<cfset dbug="N" />

<cfinclude template="/include/remote_load.cfm" />

<cfinclude template="/include/qry/audplatforms_sel.cfm" />

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
    FROM taousers u
    WHERE u.userid = '#userid#'
</cfquery>


<cfinclude template="/include/qry/countries.cfm" />
<cfinclude template="/include/qry/regions.cfm" />
<cfinclude template="/include/qry/cities.cfm" />


<cfif #FindUser.userdefCountry# is not "">
    <cfset valueCountry=FindUser.userdefCountry />
</cfif>


<cfif #FindUser.userdefState# is not "">
    <cfset valuestate=FindUser.userdefState />
</cfif>




<cfquery name="findcountry" datasource="#dsn#">
    select countryid from countries where countryname = '#valueCountry#'
</cfquery>

<cfif #findcountry.recordcount# is "1">
    <cfset new_countryid=findcountry.countryid />
</cfif>

<cfquery name="findregion" datasource="#dsn#">
    select region_id from regions where regionname = '#valuestate#'
</cfquery>

<cfif #findregion.recordcount# is "1">
    <cfset new_region_id=findregion.region_id />
</cfif>


<cfquery name="cat" datasource="#dsn#">
    SELECT c.audcatid,c.audcatname,s.audsubcatid,s.audsubcatname FROM audcategories c INNER JOIN audsubcategories s ON s.audcatid = c.audcatid
    WHERE s.audsubcatid = #new_audsubcatid#
</cfquery>

<cfset new_audcatid=cat.audcatid />

<cfquery name="audroletypes_sel" datasource="#dsn#">
    SELECT audroletypeid AS `id`,audroletype AS `name` FROM audroletypes where audcatid = #cat.audcatid# AND isdeleted IS false
</cfquery>

<cfquery name="audtypes_sel" datasource="#dsn#">
    SELECT audtypeid as id,audtype as name,audcategories FROM audtypes WHERE isdeleted = 0 and audcategories like '%#cat.audcatid#%' ORDER BY audtype
</cfquery>

<cfquery name="casting_types" datasource="#dsn#">
    SELECT tagid AS id,tagname AS name FROM tags_user WHERE iscasting IS TRUE AND userid = #userid# AND isdeleted = 0 ORDER BY tagname
</cfquery>

<cfinclude template="/include/qry/castingdirectors_sel.cfm">


    <cfif #isdirect# is "1">

        <style>
            #hidedirectbooking {
                display: none;
            }

            .input {

                margin: 0 auto;
            }

        </style>

    </cfif>
    <style>
        #hidden_div {
            display: none;
        }

        .input {

            margin: 0 auto;
        }

    </style>

    <div class="row">

        <div class="col-xl-6 col-lg-8 col-md-12">
            <div class="card">

                <div class="card-body">

                    <form method="post" action="/include/audition-add2.cfm" class="parsley-examples" name="event-form" id="form-event" data-parsley-excluded="input[type=button], input[type=submit], input[type=reset], input[type=hidden], [disabled], :hidden" data-parsley-trigger="keyup" data-parsley-validate>

                        <cfoutput>
                            <input type="hidden" name="new_audStepID" value="1">
                            <input type="hidden" name="new_audcatid" value="#cat.audcatid#">
                            <input type="hidden" name="new_audsubcatid" value="#cat.audsubcatid#">
                            <input type="hidden" name="new_userid" value="#session.userid#">
                            <input type="hidden" name="isdirect" value="#isdirect#">
                        </cfoutput>

                        <cfif #isdirect# is "1">
                            <h4 class="col-md-12">Direct Booking</h4>
                        </cfif>

                        <h4 class="col-md-12">
                            <cfoutput>Category: #cat.audcatname# - #cat.audsubcatname#</cfoutput>

                        </h4>
                        <div class="row">

                            <div class="form-group col-md-12">
                                <label for="new_projname">Project Name (Title)<span class="text-danger">*</span></label>
                                <input class="form-control" type="text" id="new_projname" autocomplete="off" required data-parsley-required data-parsley-error-message="Project Name is required" name="new_projname" placeholder="Project Name">
                            </div>

                            <div class="form-group col-md-12">
                                <label for="new_projDescription">Project Description/Logline<span class="text-danger">*</span></label>

                                <input class="form-control" type="text" id="new_projDescription" data-parsley-required data-parsley- name="new_projDescription" error-message="Project Description is required" placeholder="Project Description">

                            </div>

                            <script>
                                function showDivss(divId, element) {
                                    document.getElementById(divId).style.display = element.value == 1 ? 'block' : 'none';
                                }

                            </script>

                            <script>
                                function showDivs(divId, element) {
                                    document.getElementById(divId).style.display = element.value == 2 ? 'block' : 'none';
                                }

                            </script>

                            <script>
                                function showDivsss(divId, element) {
                                    document.getElementById(divId).style.display = element.value == 0 ? 'block' : 'none';
                                }

                            </script>

                            <script>
                                function showDivssss(divId, element) {
                                    document.getElementById(divId).style.display = element.value == 0 ? 'block' : 'none';
                                }

                            </script>

                            <script>
                                function showdirectbooking(divId, element) {
                                    document.getElementById(divId).style.display = element.value == 23 ? 'none' : 'block';
                                }

                            </script>






                            <div id="hidden_divs">
                                <div class="form-group col-md-12">
                                    <label for="new_eventStart">Zoom Link (optional)</label>

                                    <input class="form-control" type="text" id="new_audLocation" autocomplete="off" name="new_audLocation" placeholder="Zoom link">


                                </div>




                                <div class="form-group col-md-12">




                                    <label for="audplatformid">Audition Platform </label>

                                    <select id="audplatformid" name="new_audplatformid" class="form-control">


                                        <option value="">--</option>

                                        <cfoutput query="audplatforms_sel">

                                            <option value="#audplatforms_sel.id#"> #audplatforms_sel.name# </option>

                                        </cfoutput>

                                    </select>






                                </div>




                            </div>
                            <div class="form-group col-md-6 col-sm-12">
                                <label for="new_audrolename">Role Name <span class="text-danger">*</span></label>
                                <input class="form-control" type="text" id="new_audrolename" autocomplete="off" required data-parsley-required data-parsley-error-message="Role Name is required" name="new_audrolename" placeholder="Role Name">
                            </div>


                            <CFIF #new_audcatid# IS "5">
                                <input type="hidden" name="new_audroletypeid" value="33" />

                                <CFELSE>
                                    <div class="form-group col-md-6 col-sm-12">
                                        <label for="new_audroletypeid">Role Type <span class="text-danger">*</span></label>


                                        <select id="new_audroletypeid" name="new_audroletypeid" class="form-control" data-parsley-required data-parsley-error-message="Role Type is required">
                                            <option value="">--</option>

                                            <cfoutput query="audroletypes_sel">
                                                <option value="#audroletypes_sel.id#">#audroletypes_sel.name#</option>
                                            </cfoutput>

                                        </select>
                            </CFif>
                        </div>


                        <div class="form-group col-md-12">

                            <label for="new_contactid">Casting Director </label>

                            <select id="new_contactid" class="form-control" name="new_contactid" onChange="showDivssss('hidden_divssss', this)">
                                <option value="">--</option>
                                <option value="0">***ADD NEW***</option>
                                <cfoutput query="castingdirectors_sel">
                                    <option value="#castingdirectors_sel.id#">#castingdirectors_sel.name#</option>
                                </cfoutput>
                            </select>

                        </div>

                        <div id="hidden_divssss">

                            <div class="row">

                                <fieldset>

                                    <legend>Add New Casting Director</legend>

                                    <div class="form-group col-md-6">

                                        <label for="cdfirstname">Casting Director - First Name<span class="text-danger">*</span></label>

                                        <input class="form-control" type="text" id="cdfirstname" name="cdfirstname" placeholder="Casting Director - First Name" required data-parsley-required data-parsley-error-message=">Casting Director - First Name is required">

                                        <div class="invalid-feedback">
                                            Please enter a >Casting Director - First Name.
                                        </div>

                                    </div>


                                    <div class="form-group col-md-6">

                                        <label for="cdlastname">Casting Director - Last Name<span class="text-danger">*</span></label>

                                        <input class="form-control" type="text" id="cdlastname" name="cdlastname" placeholder="Casting Director - Last Name" required data-parsley-required data-parsley-error-message=">Casting Director - Last Name is required">

                                        <div class="invalid-feedback">
                                            Please enter a Casting Director - First Name.
                                        </div>

                                    </div>

                                    <div class="form-group col-md-6">

                                        <label for="cdtype">Casting Director Role<span class="text-danger">*</span></label>

                                        <select id="cdtype" name="cdtype" class="form-control" data-parsley-required data-parsley-error-message="Casting Director Role is required">

                                            <option value="">--</option>

                                            <cfoutput query="casting_types">

                                                <option value="#casting_types.name#">#casting_types.name#</option>

                                            </cfoutput>

                                        </select>


                                    </div>

                                </fieldset>

                            </div>
                        </div>






                        <style>
                            .field_set {

                                border-color: #ced4da;
                                border-width: 1px;
                            }

                        </style>
                        <fieldset class="answer" id="hidedirectbooking">
                            <legend>Appointment details</legend>




                            <div class="form-group col-md-6">

                                <cfif #audtypes_sel.recordcount# is "1">
                                    <input type="hidden" name="" value="" />
                                    <cfelse>
                                        <label for="audtypeid">Type<span class="text-danger">*</span></label>



                                        <select id="audtypeid" name="new_audtypeid" class="form-control" data-parsley-required data-parsley-error-message="Type is required" onChange="showDivs('hidden_divs', this); showDivss('hidden_divss', this); showdirectbooking('hidedirectbooking', this);">

                                            <option value="">--</option>

                                            <cfoutput query="audtypes_sel">
                                                <option value="#audtypes_sel.id#">#audtypes_sel.name#</option>
                                            </cfoutput>

                                        </select>

                                </cfif>


                            </div>



                            <div class="form-group col-md-6">
                                <label for="new_eventStart">Start Date / Due Date<span class="text-danger">*</span></label>
                                <input id="new_eventStart" class="form-control" autocomplete="off" name="new_eventStart" type="date" data-parsley-required data-parsley-error-message="Start Date is required">
                            </div>

                            <div class="form-group col-md-6">
                                <label for="new_eventStartTime">Start Time / Due Time<span class="text-danger">*</span></label>




                                <select class="form-control" name="new_eventStartTime" autocomplete="off" id="new_eventStartTime" data-parsley-required data-parsley-error-message="Start Time is required">
                                    <option value="">Select a Start Time </option>
                                    <cfoutput>
                                        <option value="07:00" <cfif #timeformat('#userCalStarttime#','hh:mm TT')# is "07:00 AM">Selected</cfif>>07:00 AM</option>
                                        <option value="07:15" <cfif #timeformat('#userCalStarttime#','hh:mm TT')# is "07:15 AM">Selected</cfif>>07:15 AM</option>
                                        <option value="07:30" <cfif #timeformat('#userCalStarttime#','hh:mm TT')# is "07:30 AM">Selected</cfif>>07:30 AM</option>
                                        <option value="07:45" <cfif #timeformat('#userCalStarttime#','hh:mm TT')# is "07:45 AM">Selected</cfif>>07:45 AM</option>
                                        <option value="08:00" <cfif #timeformat('#userCalStarttime#','hh:mm TT')# is "08:00 AM">Selected</cfif>>08:00 AM</option>
                                        <option value="08:15" <cfif #timeformat('#userCalStarttime#','hh:mm TT')# is "08:15 AM">Selected</cfif>>08:15 AM</option>
                                        <option value="08:30" <cfif #timeformat('#userCalStarttime#','hh:mm TT')# is "08:30 AM">Selected</cfif>>08:30 AM</option>
                                        <option value="08:45" <cfif #timeformat('#userCalStarttime#','hh:mm TT')# is "08:45 AM">Selected</cfif>>08:45 AM</option>
                                        <option value="09:00" <cfif #timeformat('#userCalStarttime#','hh:mm TT')# is "09:00 AM">Selected</cfif>>09:00 AM</option>
                                        <option value="09:15" <cfif #timeformat('#userCalStarttime#','hh:mm TT')# is "09:15 AM">Selected</cfif>>09:15 AM</option>
                                        <option value="09:30" <cfif #timeformat('#userCalStarttime#','hh:mm TT')# is "09:30 AM">Selected</cfif>>09:30 AM</option>
                                        <option value="09:45" <cfif #timeformat('#userCalStarttime#','hh:mm TT')# is "09:45 AM">Selected</cfif>>09:45 AM</option>
                                        <option value="10:00" <cfif #timeformat('#userCalStarttime#','hh:mm TT')# is "10:00 AM">Selected</cfif>>10:00 AM</option>
                                        <option value="10:15" <cfif #timeformat('#userCalStarttime#','hh:mm TT')# is "10:15 AM">Selected</cfif>>10:15 AM</option>
                                        <option value="10:30" <cfif #timeformat('#userCalStarttime#','hh:mm TT')# is "10:30 AM">Selected</cfif>>10:30 AM</option>
                                        <option value="10:45" <cfif #timeformat('#userCalStarttime#','hh:mm TT')# is "10:45 AM">Selected</cfif>>10:45 AM</option>
                                        <option value="11:00" <cfif #timeformat('#userCalStarttime#','hh:mm TT')# is "11:00 AM">Selected</cfif>>11:00 AM</option>
                                        <option value="11:15" <cfif #timeformat('#userCalStarttime#','hh:mm TT')# is "11:15 AM">Selected</cfif>>11:15 AM</option>
                                        <option value="11:30" <cfif #timeformat('#userCalStarttime#','hh:mm TT')# is "11:30 AM">Selected</cfif>>11:30 AM</option>
                                        <option value="11:45" <cfif #timeformat('#userCalStarttime#','hh:mm TT')# is "11:45 AM">Selected</cfif>>11:45 AM</option>
                                        <option value="12:00" <cfif #timeformat('#userCalStarttime#','hh:mm TT')# is "12:00 PM">Selected</cfif>>12:00 PM</option>
                                        <option value="12:15" <cfif #timeformat('#userCalStarttime#','hh:mm TT')# is "12:15 PM">Selected</cfif>>12:15 PM</option>
                                        <option value="12:30" <cfif #timeformat('#userCalStarttime#','hh:mm TT')# is "12:30 PM">Selected</cfif>>12:30 PM</option>
                                        <option value="12:45" <cfif #timeformat('#userCalStarttime#','hh:mm TT')# is "12:45 PM">Selected</cfif>>12:45 PM</option>
                                        <option value="13:00" <cfif #timeformat('#userCalStarttime#','hh:mm TT')# is "01:00 PM">Selected</cfif>>01:00 PM</option>
                                        <option value="13:15" <cfif #timeformat('#userCalStarttime#','hh:mm TT')# is "01:15 PM">Selected</cfif>>01:15 PM</option>
                                        <option value="13:30" <cfif #timeformat('#userCalStarttime#','hh:mm TT')# is "01:30 PM">Selected</cfif>>01:30 PM</option>
                                        <option value="13:45" <cfif #timeformat('#userCalStarttime#','hh:mm TT')# is "01:45 PM">Selected</cfif>>01:45 PM</option>
                                        <option value="14:00" <cfif #timeformat('#userCalStarttime#','hh:mm TT')# is "02:00 PM">Selected</cfif>>02:00 PM</option>
                                        <option value="14:15" <cfif #timeformat('#userCalStarttime#','hh:mm TT')# is "02:15 PM">Selected</cfif>>02:15 PM</option>
                                        <option value="14:30" <cfif #timeformat('#userCalStarttime#','hh:mm TT')# is "02:30 PM">Selected</cfif>>02:30 PM</option>
                                        <option value="14:45" <cfif #timeformat('#userCalStarttime#','hh:mm TT')# is "02:45 PM">Selected</cfif>>02:45 PM</option>
                                        <option value="15:00" <cfif #timeformat('#userCalStarttime#','hh:mm TT')# is "03:00 PM">Selected</cfif>>03:00 PM</option>
                                        <option value="15:15" <cfif #timeformat('#userCalStarttime#','hh:mm TT')# is "03:15 PM">Selected</cfif>>03:15 PM</option>
                                        <option value="15:30" <cfif #timeformat('#userCalStarttime#','hh:mm TT')# is "03:30 PM">Selected</cfif>>03:30 PM</option>
                                        <option value="15:45" <cfif #timeformat('#userCalStarttime#','hh:mm TT')# is "03:45 PM">Selected</cfif>>03:45 PM</option>
                                        <option value="16:00" <cfif #timeformat('#userCalStarttime#','hh:mm TT')# is "04:00 PM">Selected</cfif>>04:00 PM</option>
                                        <option value="16:15" <cfif #timeformat('#userCalStarttime#','hh:mm TT')# is "04:15 PM">Selected</cfif>>04:15 PM</option>
                                        <option value="16:30" <cfif #timeformat('#userCalStarttime#','hh:mm TT')# is "04:30 PM">Selected</cfif>>04:30 PM</option>
                                        <option value="16:45" <cfif #timeformat('#userCalStarttime#','hh:mm TT')# is "04:45 PM">Selected</cfif>>04:45 PM</option>
                                        <option value="17:00" <cfif #timeformat('#userCalStarttime#','hh:mm TT')# is "05:00 PM">Selected</cfif>>05:00 PM</option>
                                        <option value="17:15" <cfif #timeformat('#userCalStarttime#','hh:mm TT')# is "05:15 PM">Selected</cfif>>05:15 PM</option>
                                        <option value="17:30" <cfif #timeformat('#userCalStarttime#','hh:mm TT')# is "05:30 PM">Selected</cfif>>05:30 PM</option>
                                        <option value="17:45" <cfif #timeformat('#userCalStarttime#','hh:mm TT')# is "05:45 PM">Selected</cfif>>05:45 PM</option>
                                        <option value="18:00" <cfif #timeformat('#userCalStarttime#','hh:mm TT')# is "06:00 PM">Selected</cfif>>06:00 PM</option>
                                        <option value="18:15" <cfif #timeformat('#userCalStarttime#','hh:mm TT')# is "06:15 PM">Selected</cfif>>06:15 PM</option>
                                        <option value="18:30" <cfif #timeformat('#userCalStarttime#','hh:mm TT')# is "06:30 PM">Selected</cfif>>06:30 PM</option>
                                        <option value="18:45" <cfif #timeformat('#userCalStarttime#','hh:mm TT')# is "06:45 PM">Selected</cfif>>06:45 PM</option>
                                        <option value="19:00" <cfif #timeformat('#userCalStarttime#','hh:mm TT')# is "07:00 PM">Selected</cfif>>07:00 PM</option>
                                        <option value="19:15" <cfif #timeformat('#userCalStarttime#','hh:mm TT')# is "07:15 PM">Selected</cfif>>07:15 PM</option>
                                        <option value="19:30" <cfif #timeformat('#userCalStarttime#','hh:mm TT')# is "07:30 PM">Selected</cfif>>07:30 PM</option>
                                        <option value="19:45" <cfif #timeformat('#userCalStarttime#','hh:mm TT')# is "07:45 PM">Selected</cfif>>07:45 PM</option>
                                        <option value="20:00" <cfif #timeformat('#userCalStarttime#','hh:mm TT')# is "08:00 PM">Selected</cfif>>08:00 PM</option>
                                        <option value="20:15" <cfif #timeformat('#userCalStarttime#','hh:mm TT')# is "08:15 PM">Selected</cfif>>08:15 PM</option>
                                        <option value="20:30" <cfif #timeformat('#userCalStarttime#','hh:mm TT')# is "08:30 PM">Selected</cfif>>08:30 PM</option>
                                        <option value="20:45" <cfif #timeformat('#userCalStarttime#','hh:mm TT')# is "08:45 PM">Selected</cfif>>08:45 PM</option>
                                        <option value="21:00" <cfif #timeformat('#userCalStarttime#','hh:mm TT')# is "09:00 PM">Selected</cfif>>09:00 PM</option>
                                        <option value="21:15" <cfif #timeformat('#userCalStarttime#','hh:mm TT')# is "09:15 PM">Selected</cfif>>09:15 PM</option>
                                        <option value="21:30" <cfif #timeformat('#userCalStarttime#','hh:mm TT')# is "09:30 PM">Selected</cfif>>09:30 PM</option>
                                        <option value="21:45" <cfif #timeformat('#userCalStarttime#','hh:mm TT')# is "09:45 PM">Selected</cfif>>09:45 PM</option>
                                        <option value="22:00" <cfif #timeformat('#userCalStarttime#','hh:mm TT')# is "10:00 PM">Selected</cfif>>10:00 PM</option>
                                        <option value="22:15" <cfif #timeformat('#userCalStarttime#','hh:mm TT')# is "10:15 PM">Selected</cfif>>10:15 PM</option>
                                        <option value="22:30" <cfif #timeformat('#userCalStarttime#','hh:mm TT')# is "10:30 PM">Selected</cfif>>10:30 PM</option>
                                        <option value="22:45" <cfif #timeformat('#userCalStarttime#','hh:mm TT')# is "10:45 PM">Selected</cfif>>10:45 PM</option>
                                        <option value="23:00" <cfif #timeformat('#userCalStarttime#','hh:mm TT')# is "11:00 PM">Selected</cfif>>11:00 PM</option>
                                        <option value="23:15" <cfif #timeformat('#userCalStarttime#','hh:mm TT')# is "11:15 PM">Selected</cfif>>11:15 PM</option>
                                        <option value="23:30" <cfif #timeformat('#userCalStarttime#','hh:mm TT')# is "11:30 PM">Selected</cfif>>11:30 PM</option>
                                        <option value="23:45" <cfif #timeformat('#userCalStarttime#','hh:mm TT')# is "11:45 PM">Selected</cfif>>11:45 PM</option>

                                </select>

                                </cfoutput>

                            </div>

                            <div class="form-group col-md-6">
                                <label for="new_eventStopTime">Duration</label>
                                <select class="form-control" name="new_durid" autocomplete="off" id="new_durid">


                                    <cfoutput query="durations">
                                        <option value="#durations.durid#" <cfif #durations.durid# is "4">selected</cfif>>#durations.durname#</option>
                                    </cfoutput>
                                </select>


                            </div>




                            <div id="hidden_divss">
                                <div class="row">










                                    <div class="form-group col-md-12">
                                        <label for="projName">Location Name<span class="text-danger">*</span></label>
                                        <input class="form-control" type="text" id="eventLocation" name="new_eventLocation" placeholder="Location Name" required data-parsley-required data-parsley-error-message="Location Name is required">

                                        <div class="invalid-feedback">
                                            Please enter a Location Name.
                                        </div>
                                    </div>

                                    <div class="form-group col-md-12">
                                        <label for="projName">Address </label>
                                        <input class="form-control" type="text" id="audlocadd1" name="new_audlocadd1" placeholder="Address" />

                                        <div class="invalid-feedback">
                                            Please enter an address.
                                        </div>
                                    </div>

                                    <div class="form-group col-md-12">
                                        <label for="projName">Extended Address </label>
                                        <input class="form-control" type="text" id="audlocadd2" name="new_audlocadd2" placeholder="APT 101" />

                                        <div class="invalid-feedback">
                                            Please enter an extended address.
                                        </div>
                                    </div>










                                    <div class="form-group col-md-6">
                                        <label for="valuetext">Town/City</label>

                                        <input class="form-control" type="text" id="audcity" name="new_audcity" placeholder="Enter City">


                                    </div>





                                    <div class="form-group col-md-6">
                                        <label for="valuetext">Postal Code</label>

                                        <input class="form-control" type="text" id="audzip" name="new_audzip" placeholder="Enter Postal Code">

                                    </div>






                                    <div class="form-group col-md-6">
                                        <label for="countryid">Country<span class="text-danger">*</span></label>

                                        <select id="countryid" class="form-control" name="countryid" data-parsley-required data-parsley-error-message="Country is required">
                                            <option value="">--</option>
                                            <cfoutput query="countries">
                                                <option value="#countries.countryid#" <cfif #countries.countryid# is "US">selected </cfif> >#countries.countryname#</option>
                                            </cfoutput>
                                        </select>




                                    </div>



                                    <div class="form-group col-md-6">
                                        <label for="region_id">State/Region<span class="text-danger">*</span></label>

                                        <select id="region_id" name="new_region_id" class="form-control">
                                            <option value="">--</option>

                                            <cfoutput query="regions">
                                                <option value="#regions.region_id#" data-chained="#regions.countryid#">#regions.regionname#</option>
                                            </cfoutput>

                                        </select>


                                    </div>










                                </div>


                            </div>




                            <div id="hidden_divsss">
                                <fieldset>
                                    <legend>Add New Location</legend>

                                    <div class="row">
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
                                            FROM taousers u
                                            WHERE u.userid = '#userid#'
                                        </cfquery>



                                        <cfparam name="new_region_id" default="CA">
                                            <cfparam name="new_countryid" default="US">


                                                <cfparam name="valueCountry" default="">
                                                    <cfparam name="valuestate" default="">




                                                        <cfparam name="valuetext" default="">
                                                            <cfinclude template="/include/qry/countries.cfm" />
                                                            <cfinclude template="/include/qry/regions.cfm" />
                                                            <cfinclude template="/include/qry/cities.cfm" />



                                                            <cfif #FindUser.userdefCountry# is not "">
                                                                <cfset valueCountry=FindUser.userdefCountry />
                                                            </cfif>


                                                            <cfif #FindUser.userdefState# is not "">
                                                                <cfset valuestate=FindUser.userdefState />
                                                            </cfif>





                                                            <cfquery name="findcountry" datasource="#dsn#">
                                                                select countryid from countries where countryname = '#valueCountry#'
                                                            </cfquery>

                                                            <cfif #findcountry.recordcount# is "1">
                                                                <cfset new_countryid=findcountry.countryid />
                                                            </cfif>

                                                            <cfquery name="findregion" datasource="#dsn#">
                                                                select region_id from regions where regionname = '#valuestate#'
                                                            </cfquery>

                                                            <cfif #findregion.recordcount# is "1">
                                                                <cfset new_region_id=findregion.region_id />
                                                            </cfif>




                                                            <div class="form-group col-md-12">
                                                                <label for="projName">Location Name<span class="text-danger">*</span></label>
                                                                <input class="form-control" type="text" id="eventLocation" name="new_eventLocation" placeholder="Location Name" required data-parsley-required data-parsley-error-message="Location Name is required">

                                                                <div class="invalid-feedback">
                                                                    Please enter a Location Name.
                                                                </div>
                                                            </div>

                                                            <div class="form-group col-md-12">
                                                                <label for="projName">Address </label>
                                                                <input class="form-control" type="text" id="audlocadd1" name="new_audlocadd1" placeholder="Address" />

                                                                <div class="invalid-feedback">
                                                                    Please enter an address.
                                                                </div>
                                                            </div>

                                                            <div class="form-group col-md-12">
                                                                <label for="projName">Extended Address </label>
                                                                <input class="form-control" type="text" id="audlocadd2" name="new_audlocadd2" placeholder="APT 101" />

                                                                <div class="invalid-feedback">
                                                                    Please enter an extended address.
                                                                </div>
                                                            </div>










                                                            <div class="form-group col-md-6">
                                                                <label for="valuetext">Town/City</label>

                                                                <input class="form-control" type="text" id="audcity" name="new_audcity" placeholder="Enter City">


                                                            </div>





                                                            <div class="form-group col-md-6">
                                                                <label for="valuetext">Postal Code</label>

                                                                <input class="form-control" type="text" id="audzip" name="new_audzip" placeholder="Enter Postal Code">

                                                            </div>





                                                            <div class="form-group col-md-6">
                                                                <label for="countryid">Country<span class="text-danger">*</span></label>

                                                                <select id="countryid" class="form-control" name="countryid" data-parsley-required data-parsley-error-message="Country is required">
                                                                    <option value="">--</option>
                                                                    <cfoutput query="countries">
                                                                        <option value="#countries.countryid#">#countries.countryname#</option>
                                                                    </cfoutput>
                                                                </select>




                                                            </div>



                                                            <div class="form-group col-md-6">
                                                                <label for="region_id">State/Region<span class="text-danger">*</span></label>

                                                                <select id="region_id" name="new_region_id" class="form-control">
                                                                    <option value="">--</option>

                                                                    <cfoutput query="regions">
                                                                        <option value="#regions.region_id#" data-chained="#regions.countryid#">#regions.regionname#</option>
                                                                    </cfoutput>

                                                                </select>


                                                            </div>


                                </fieldset>

                            </div>

                        </fieldset>
                </div>







                <div class="row mt-2">

                    <div class="">
                        <a href="javascript:history.go(-1)"><button type="button" class="btn btn-light mr-1 btn-sm" data-bs-dismiss="modal">Back</button></a>
                        <button type="submit" class="btn btn-primary btn-sm waves-effect waves-light" id="btn-save-event">Add</button>
                    </div>
                </div>
                </form>
            </div>
        </div>

    </div>


    <script>
        $(document).ready(function() {
            $(".parsley-examples").parsley()
        });

    </script>
    <script>
        $("#region_id").chained("#countryid");

    </script>
    <script>
        $("#audtypeid").chained("#audcatid");

    </script>
    <script>
        $("#new_audroletypeid").chained("#audcatid");

    </script>
    <script>
        $("#new_audsubcatid").chained("#audcatid");

    </script>

    <script>
        function showDiv(divId, element) {
            var checked = document.querySelectorAll('input:checked');
            if (checked.length === 0) {
                document.getElementById(divId).style.display = 'none';

            } else {
                document.getElementById(divId).style.display = 'block';
                $("#divId").prop('required', true);
            }
        }

    </script>




    <cfif #isdefined('fsdfds')#>
        <script>
            $('select[name=new_eventStartTime]').on("change", function() {
                var theSelectedIndex = $(this)[0].selectedIndex;
                $.each($('select[name=new_eventStopTime] option'), function() {
                    var endOptionIndex = $(this).index();
                    if (endOptionIndex < theSelectedIndex) {
                        $(this).attr('disabled', 'disabled');
                    } else {
                        $(this).removeAttr('disabled').prop('selected', true);
                        return false;
                    }
                });
            });

        </script>
    </cfif>
