<cfparam name="pgaction" default="view" />
<cfparam name="old_callbacktypeid" default="0" />

<cfinclude template="/include/remote_load.cfm" />
<cfinclude template="/include/qry/durations.cfm" />
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
    ,u.defCountry
    ,u.defState
    ,u.calstarttime
    ,u.calendtime
    ,u.avatarname
    ,u.contactid AS userContactID
    ,u.tzid
    ,t.tzname
    ,u.customerid
    ,left(u.passwordhash,10) as U
    ,u.viewtypeid, u.add1, u.add2, u.city, u.regionid, u.zip


    FROM taousers u
    LEFT join timezones t on t.tzid = u.tzid
    WHERE u.userid = #cookie.userid#
</cfquery>

<cfset usercalstarttime=FindUser.calstarttime />










<cfset dbug="N" />



<cfinclude template="/include/qry/audplatforms_user_sel.cfm" />

<cfquery name="projectDetails" datasource="#dsn#">
    SELECT
    proj.`audprojectID`,
    r.audroleid,
    proj.`projName`,
    proj.projDescription,
    cat.`audCatName`,
    cat.audcatid,
    subcat.`audSubCatName`,
    subcat.audsubcatid,
    proj.contactid,
    ct.contracttype,
    ton.tone,
    net.network,
    un.`unionName`,
    c.recordname as castingFullName
    FROM audprojects proj
    INNER JOIN audroles r on r.audprojectid = proj.audprojectid
    LEFT OUTER JOIN audcontracttypes ct ON ( proj.`contractTypeID` = ct.contracttypeid )
    LEFT OUTER JOIN audsubcategories subcat ON ( proj.`audSubCatID` = subcat.`audSubCatId` )
    LEFT OUTER JOIN audcategories cat ON ( subcat.`audCatId` = cat.`audCatId` )
    LEFT OUTER JOIN audtones ton ON ( proj.`toneID` = ton.toneid )
    LEFT OUTER JOIN audnetworks net ON ( proj.`networkID` = net.networkid )
    LEFT OUTER JOIN contactdetails c on c.contactid = proj.contactid
    LEFT OUTER JOIN audunions un ON ( proj.`unionID` = un.`unionID` )
    WHERE proj.audprojectID = #audprojectID#
</cfquery>

<cfset audroleid=projectDetails.audroleid />

<cfquery name="roleDetails" datasource="#dsn#">
    SELECT
    r.`audroleid`,
    r.audprojectid,
    r.auddialectid,
    r.`audRoleName`,
    r.`charDescription`,
    r.`holdStartDate`,
    r.`holdEndDate`,
    rt.audroletype,
    r.audroletypeid,
    di.auddialect,
    s.audsource,
    r.audsourceid,
    r.contactid,
    r.payrate,
    r.netincome,
    r.buyout,
    i.incometype,
    r.iscallback,
    r.isredirect,
    r.ispin,
    r.isbooked,
    c.recordname as contactname,
    p.paycycleid,
    p.paycyclename

    FROM audroles r

    LEFT OUTER JOIN audroletypes rt ON ( r.`audRoleTypeID` = rt.audroletypeid )
    LEFT OUTER JOIN auddialects di ON ( r.`audDialectID` = di.auddialectid )
    LEFT OUTER JOIN audsources s on (r.audsourceid = s.audsourceid)
    LEFT OUTER JOIN incometypes i on i.incometypeid = r.incometypeid
    LEFT OUTER JOIN contactdetails c on c.contactid = r.contactid
    LEFT OUTER join audpaycycles p on p.paycycleid = r.paycycleid
    WHERE r.audroleid = #audroleid#
</cfquery>


<Cfoutput>
    <cfset NEW_AUDSUBCATID="#projectDetails.audsubcatid#" />

</Cfoutput>
<cfif #new_audsubcatid# is "">

    <cfset new_audsubcatid="0" />
</cfif>


<cfquery name="cat" datasource="#dsn#">
    SELECT c.audcatid,c.audcatname,s.audsubcatid,s.audsubcatname FROM audcategories c INNER JOIN audsubcategories s ON s.audcatid = c.audcatid
    WHERE s.audsubcatid = #new_audsubcatid#
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
    FROM taousers u
    WHERE u.userid = '#userid#'
</cfquery>

<cfif #new_audsubcatid# is "">
    <cfset new_audsubcatid=0 />
</cfif>

<cfquery name="cat" datasource="#dsn#">
    SELECT c.audcatid,c.audcatname,s.audsubcatid,s.audsubcatname FROM audcategories c INNER JOIN audsubcategories s ON s.audcatid = c.audcatid
    WHERE s.audsubcatid = #new_audsubcatid#
</cfquery>




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










    <cfif #pgaction# is "add">


        <cfset new_audroleid=roleDetails.audroleid />

        <cfset new_userid=userid />

        <cfset new_audstepid=audstepid />



        <cfparam name="new_durid" default="0" />

        <cfparam name="new_userid" default="" />

        <cfparam name="new_audRoleID" default="" />

        <cfparam name="new_audTypeID" default="" />

        <cfparam name="new_audLocation" default="" />

        <cfparam name="new_audlocid" default="" />

        <cfparam name="new_eventStart" default="" />

        <cfparam name="new_eventStartTime" default="" />

        <cfparam name="new_eventStopTime" default="" />

        <cfparam name="new_audplatformid" default="4" />

        <cfparam name="new_audStepID" default="1" />

        <cfparam name="new_parkingDetails" default="" />

        <cfparam name="new_workwithcoach" default="0" />

        <cfparam name="new_isDeleted" default="0" />

        <cfparam name="new_trackmileage" default="0" />



        <cfquery name="auditions_ins" datasource="#dsn#" result="rez">

            INSERT INTO events_tbl (

            userid,

            audRoleID,

            audTypeID,

            audLocation,

            eventStart,

            eventStartTime,

            eventStopTime,

            audplatformID,

            audStepID,

            parkingDetails,

            workwithcoach,

            trackmileage,

            audlocid,

            isdeleted)


            VALUES (

            <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#new_userid#" null="#NOT len(trim(new_userid))#" />,

            <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#new_audRoleID#" null="#NOT len(trim(new_audRoleID))#" />,

            <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#new_audTypeID#" null="#NOT len(trim(new_audTypeID))#" />,

            <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#new_audLocation#" maxlength="500" null="#NOT len(trim(new_audLocation))#" />,

            <cfqueryparam cfsqltype="CF_SQL_DATE" value="#new_eventStart#" null="#NOT len(trim(new_eventStart))#" />,

            <cfqueryparam cfsqltype="CF_SQL_TIME" value="#new_eventStartTime#" null="#NOT len(trim(new_eventStartTime))#" />,

            <cfqueryparam cfsqltype="CF_SQL_TIME" value="#new_eventStopTime#" null="#NOT len(trim(new_eventStopTime))#" />,

            <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#new_audplatformid#" null="#NOT len(trim(new_audplatformid))#" />,

            <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#new_audStepID#" null="#NOT len(trim(new_audStepID))#" />,

            <cfqueryparam cfsqltype="CF_SQL_LONGVARCHAR" value="#new_parkingDetails#" null="#NOT len(trim(new_parkingDetails))#" />,

            <cfqueryparam cfsqltype="CF_SQL_BIT" value="#new_workwithcoach#" null="#NOT len(trim(new_workwithcoach))#" />,

            <cfqueryparam cfsqltype="CF_SQL_BIT" value="#new_trackmileage#" null="#NOT len(trim(new_trackmileage))#" />,


            <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#new_audlocid#" null="#NOT len(trim(new_audlocid))#" />,

            <cfqueryparam cfsqltype="CF_SQL_BIT" value="1" />

            );
        </cfquery>




        <cfset eventid=rez.GENERATEDKEY />


    </cfif>
    <cfset dbug="N" />






    <cfquery name="aud_det" datasource="#dsn#">
        SELECT ad.eventid,a4.`audroleid`, a.`projName`, a.`projDescription`, ad.`eventStartTime`, ad.`eventStopTime`, ad.`eventStart`, a1.`network`, a2.`audSubCatName`, a2.`audSubCatName`,
        a3.`unionName`,a2.audsubcatid,ad.audlocid,

        a4.`audRoleName`, a4.`charDescription`, a4.`holdStartDate`, a4.`holdEndDate`,
        a5.`audroletype`, a6.`auddialect`, c.`audcatid`, t.`audtypeid`, ad.`workwithcoach`,
        ad.`audstepid`, ad.`audlocation`, ad.`parkingdetails`, ad.`audroleid`,
        ad.`audplatformid`, ad.`trackmileage`, t.`audtype`,step.audstep,t.islocation,ad.audbooktypeid,
        ad.eventLocation,ad.audlocadd1,ad.audzip,ad.audlocadd2,ad.audcity,ad.regionid,r.countryid,
        truncate(hour(TIMEDIFF(ad.eventStopTime, ad.eventStartTime)),2) +

        truncate(minute(TIMEDIFF(ad.eventStopTime, ad.eventStartTime)),2)/60 AS new_durhours
        FROM audprojects a

        LEFT OUTER JOIN audnetworks a1 ON ( a.`networkID` = a1.networkid )
        INNER JOIN audsubcategories a2 ON ( a.`audSubCatID` = a2.`audSubCatId` )
        INNER JOIN audcategories c on c.audcatid = a2.audcatid
        LEFT OUTER JOIN audunions a3 ON ( a.`unionID` = a3.`unionID` )
        INNER JOIN audroles a4 ON ( a.`audprojectID` = a4.`audprojectID` )
        INNER JOIN events_tbl ad on (ad.`audroleid` = a4.`audroleid`)
        LEFT outer JOIN audsteps step on step.audstepid = ad.audstepid

        LEFT OUTER JOIN audroletypes a5 ON ( a4.`audRoleTypeID` = a5.audroletypeid )
        LEFT OUTER JOIN auddialects a6 ON ( a4.`audDialectID` = a6.auddialectid )
        LEFT JOIN audtypes t ON t.audtypeid = ad.audtypeid

        LEFT OUTER JOIN regions r on r.regionid = ad.regionid


        WHERE ad.eventid = #eventid#
    </cfquery>

    <Cfoutput>
        <cfparam name="new_regionid" default="#aud_det.regionid#">
            <cfparam name="new_countryid" default="#aud_det.countryid#">

    </Cfoutput>



    <cfparam name="valuetext" default="">
        <cfinclude template="/include/qry/countries.cfm" />
        <cfinclude template="/include/qry/regions.cfm" />
        <cfinclude template="/include/qry/cities.cfm" />


        </div>


        <cfif #aud_det.new_durhours# is "">

            <cfset new_durhours=1 />


            <Cfelse>

                <cfset new_durhours=aud_det.new_durhours />
        </cfif>




        <cfquery name="findd" datasource="#dsn#">
            select durid as new_durid from mtgdurations

            where durhours = #new_durhours#
        </cfquery>

        <cfif #findd.recordcount# is "1">

            <cfset new_durid=findd.new_durid />
            
            <cfelse>
                
                    <cfset new_durid=0 />

        </cfif>

        <style>
            
             <Cfif #aud_det.audtypeid# is not "1">#hiddenDiv_1 {
            display: none;
        }
            </cfif>
            
                   <Cfif #aud_det.audtypeid# is not "2">#hiddenDiv_2 {
            display: none;
        }
            </cfif>
            
            
            
            
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



        <cfset new_audcatid=aud_det.audcatid />

        <cfquery name="audtypes_sel" datasource="#dsn#">
            SELECT audtypeid as id,audtype as name,audcategories FROM audtypes WHERE isdeleted = 0

            <cfif #new_audcatid# is not "">
                and audcategories like '%#new_audcatid#%'
            </cfif>

        </cfquery>



        <cfquery name="audsteps_sel" datasource="#dsn#">
            SELECT audstepid as id,audstep as NAME
            FROM audsteps
            WHERE isdeleted = 0
            ORDER BY audstep
        </cfquery>

        <cfinclude template="/include/qry/audplatforms_sel.cfm" />

        <cfset dbug="N" />

        <script src="/app/assets/js/jquery.chained.js"></script>




        <h4>
            <cfoutput>#aud_det.audstep# appointment</cfoutput>
        </h4>

        <form method="post" action="/include/remoteaudupdateform2.cfm" class="parsley-examples" name="event-form" id="form-event" data-parsley-excluded="input[type=button], input[type=submit], input[type=reset], input[type=hidden], [disabled], :hidden" data-parsley-trigger="keyup" data-parsley-validate>

            <div class="row">

                <cfoutput>

                    <input type="hidden" name="audprojectid" value="#audprojectid#">

                    <input type="hidden" name="new_eventid" value="#eventid#">

                    <input type="hidden" name="eventid" value="#eventid#">

                    <input type="hidden" name="new_audStepID" value="#aud_det.audstepid#">

                    <input type="hidden" name="new_audcatid" value="#aud_det.audcatid#">

                    <input type="hidden" name="new_audsubcatid" value="#aud_det.audsubcatid#">

                    <input type="hidden" name="new_userid" value="#session.userid#">

                    <input type="hidden" name="secid" value="#secid#">

                    <input type="hidden" name="new_audRoleID" value="#aud_det.audroleid#">

                </cfoutput>

                <div class="form-group col-md-12">

                    <label for="audplatformid">

                        <cfoutput>Category: #cat.audcatname# - #cat.audsubcatname#</cfoutput>

                    </label>

                </div>

                <Cfoutput>

                    <div class="form-group col-md-6">

                        <label for="new_eventStart">Start Date / Due Date<span class="text-danger">*</span></label>

                        <input id="new_eventStart" class="form-control" autocomplete="off" name="new_eventStart" type="date" data-parsley-required data-parsley-error-message="Start Date is required" value="#aud_det.eventStart#">

                    </div>


                </Cfoutput>

                <div class="form-group col-md-6">

                    <label for="new_eventStartTime">Start Time / Due Time<span class="text-danger">*</span></label>

                    <select class="form-control" name="new_eventStartTime" autocomplete="off" id="new_eventStartTime" data-parsley-required data-parsley-error-message="Start Time is required">

                        <cfif #timeformat(aud_det.eventStartTime,'HH:MM')# is not "">
                            <option value="">Select a Start/Due Time</option>
                            <option value="00:00" <cfif #timeformat(aud_det.eventStartTime,'HH:MM')# is "00:00"> selected
                        </cfif> >12:00 AM</option>
                        <option value="00:15" <cfif #timeformat(aud_det.eventStartTime,'HH:MM')# is "00:15"> selected </cfif> >12:15 AM</option>
                        <option value="00:30" <cfif #timeformat(aud_det.eventStartTime,'HH:MM')# is "00:30"> selected </cfif> >12:30 AM</option>
                        <option value="00:45" <cfif #timeformat(aud_det.eventStartTime,'HH:MM')# is "00:45"> selected </cfif> >12:45 AM</option>
                        <option value="01:00" <cfif #timeformat(aud_det.eventStartTime,'HH:MM')# is "01:00"> selected </cfif> >01:00 AM</option>
                        <option value="01:15" <cfif #timeformat(aud_det.eventStartTime,'HH:MM')# is "01:15"> selected </cfif> >01:15 AM</option>
                        <option value="01:30" <cfif #timeformat(aud_det.eventStartTime,'HH:MM')# is "01:30"> selected </cfif> >01:30 AM</option>
                        <option value="01:45" <cfif #timeformat(aud_det.eventStartTime,'HH:MM')# is "01:45"> selected </cfif> >01:45 AM</option>
                        <option value="02:00" <cfif #timeformat(aud_det.eventStartTime,'HH:MM')# is "02:00"> selected </cfif> >02:00 AM</option>
                        <option value="02:15" <cfif #timeformat(aud_det.eventStartTime,'HH:MM')# is "02:15"> selected </cfif> >02:15 AM</option>
                        <option value="02:30" <cfif #timeformat(aud_det.eventStartTime,'HH:MM')# is "02:30"> selected </cfif> >02:30 AM</option>
                        <option value="02:45" <cfif #timeformat(aud_det.eventStartTime,'HH:MM')# is "02:45"> selected </cfif> >02:45 AM</option>
                        <option value="03:00" <cfif #timeformat(aud_det.eventStartTime,'HH:MM')# is "03:00"> selected </cfif> >03:00 AM</option>
                        <option value="03:15" <cfif #timeformat(aud_det.eventStartTime,'HH:MM')# is "03:15"> selected </cfif> >03:15 AM</option>
                        <option value="03:30" <cfif #timeformat(aud_det.eventStartTime,'HH:MM')# is "03:30"> selected </cfif> >03:30 AM</option>
                        <option value="03:45" <cfif #timeformat(aud_det.eventStartTime,'HH:MM')# is "03:45"> selected </cfif> >03:45 AM</option>
                        <option value="04:00" <cfif #timeformat(aud_det.eventStartTime,'HH:MM')# is "04:00"> selected </cfif> >04:00 AM</option>
                        <option value="04:15" <cfif #timeformat(aud_det.eventStartTime,'HH:MM')# is "04:15"> selected </cfif> >04:15 AM</option>
                        <option value="04:30" <cfif #timeformat(aud_det.eventStartTime,'HH:MM')# is "04:30"> selected </cfif> >04:30 AM</option>
                        <option value="04:45" <cfif #timeformat(aud_det.eventStartTime,'HH:MM')# is "04:45"> selected </cfif> >04:45 AM</option>
                        <option value="05:00" <cfif #timeformat(aud_det.eventStartTime,'HH:MM')# is "05:00"> selected </cfif> >05:00 AM</option>
                        <option value="05:15" <cfif #timeformat(aud_det.eventStartTime,'HH:MM')# is "05:15"> selected </cfif> >05:15 AM</option>
                        <option value="05:30" <cfif #timeformat(aud_det.eventStartTime,'HH:MM')# is "05:30"> selected </cfif> >05:30 AM</option>
                        <option value="05:45" <cfif #timeformat(aud_det.eventStartTime,'HH:MM')# is "05:45"> selected </cfif> >05:45 AM</option>
                        <option value="06:00" <cfif #timeformat(aud_det.eventStartTime,'HH:MM')# is "06:00"> selected </cfif> >06:00 AM</option>
                        <option value="06:15" <cfif #timeformat(aud_det.eventStartTime,'HH:MM')# is "06:15"> selected </cfif> >06:15 AM</option>
                        <option value="06:30" <cfif #timeformat(aud_det.eventStartTime,'HH:MM')# is "06:30"> selected </cfif> >06:30 AM</option>
                        <option value="06:45" <cfif #timeformat(aud_det.eventStartTime,'HH:MM')# is "06:45"> selected </cfif> >06:45 AM</option>
                        <option value="07:00" <cfif #timeformat(aud_det.eventStartTime,'HH:MM')# is "07:00"> selected </cfif> >07:00 AM</option>
                        <option value="07:15" <cfif #timeformat(aud_det.eventStartTime,'HH:MM')# is "07:15"> selected </cfif> >07:15 AM</option>
                        <option value="07:30" <cfif #timeformat(aud_det.eventStartTime,'HH:MM')# is "07:30"> selected </cfif> >07:30 AM</option>
                        <option value="07:45" <cfif #timeformat(aud_det.eventStartTime,'HH:MM')# is "07:45"> selected </cfif> >07:45 AM</option>
                        <option value="08:00" <cfif #timeformat(aud_det.eventStartTime,'HH:MM')# is "08:00"> selected </cfif> >08:00 AM</option>
                        <option value="08:15" <cfif #timeformat(aud_det.eventStartTime,'HH:MM')# is "08:15"> selected </cfif> >08:15 AM</option>
                        <option value="08:30" <cfif #timeformat(aud_det.eventStartTime,'HH:MM')# is "08:30"> selected </cfif> >08:30 AM</option>
                        <option value="08:45" <cfif #timeformat(aud_det.eventStartTime,'HH:MM')# is "08:45"> selected </cfif> >08:45 AM</option>
                        <option value="09:00" <cfif #timeformat(aud_det.eventStartTime,'HH:MM')# is "09:00"> selected </cfif> >09:00 AM</option>
                        <option value="09:15" <cfif #timeformat(aud_det.eventStartTime,'HH:MM')# is "09:15"> selected </cfif> >09:15 AM</option>
                        <option value="09:30" <cfif #timeformat(aud_det.eventStartTime,'HH:MM')# is "09:30"> selected </cfif> >09:30 AM</option>
                        <option value="09:45" <cfif #timeformat(aud_det.eventStartTime,'HH:MM')# is "09:45"> selected </cfif> >09:45 AM</option>
                        <option value="10:00" <cfif #timeformat(aud_det.eventStartTime,'HH:MM')# is "10:00"> selected </cfif> >10:00 AM</option>
                        <option value="10:15" <cfif #timeformat(aud_det.eventStartTime,'HH:MM')# is "10:15"> selected </cfif> >10:15 AM</option>
                        <option value="10:30" <cfif #timeformat(aud_det.eventStartTime,'HH:MM')# is "10:30"> selected </cfif> >10:30 AM</option>
                        <option value="10:45" <cfif #timeformat(aud_det.eventStartTime,'HH:MM')# is "10:45"> selected </cfif> >10:45 AM</option>
                        <option value="11:00" <cfif #timeformat(aud_det.eventStartTime,'HH:MM')# is "11:00"> selected </cfif> >11:00 AM</option>
                        <option value="11:15" <cfif #timeformat(aud_det.eventStartTime,'HH:MM')# is "11:15"> selected </cfif> >11:15 AM</option>
                        <option value="11:30" <cfif #timeformat(aud_det.eventStartTime,'HH:MM')# is "11:30"> selected </cfif> >11:30 AM</option>
                        <option value="11:45" <cfif #timeformat(aud_det.eventStartTime,'HH:MM')# is "11:45"> selected </cfif> >11:45 AM</option>
                        <option value="12:00" <cfif #timeformat(aud_det.eventStartTime,'HH:MM')# is "12:00"> selected </cfif> >12:00 PM</option>
                        <option value="12:15" <cfif #timeformat(aud_det.eventStartTime,'HH:MM')# is "12:15"> selected </cfif> >12:15 PM</option>
                        <option value="12:30" <cfif #timeformat(aud_det.eventStartTime,'HH:MM')# is "12:30"> selected </cfif> >12:30 PM</option>
                        <option value="12:45" <cfif #timeformat(aud_det.eventStartTime,'HH:MM')# is "12:45"> selected </cfif> >12:45 PM</option>
                        <option value="13:00" <cfif #timeformat(aud_det.eventStartTime,'HH:MM')# is "13:00"> selected </cfif> >01:00 PM</option>
                        <option value="13:15" <cfif #timeformat(aud_det.eventStartTime,'HH:MM')# is "13:15"> selected </cfif> >01:15 PM</option>
                        <option value="13:30" <cfif #timeformat(aud_det.eventStartTime,'HH:MM')# is "13:30"> selected </cfif> >01:30 PM</option>
                        <option value="13:45" <cfif #timeformat(aud_det.eventStartTime,'HH:MM')# is "13:45"> selected </cfif> >01:45 PM</option>
                        <option value="14:00" <cfif #timeformat(aud_det.eventStartTime,'HH:MM')# is "14:00"> selected </cfif> >02:00 PM</option>
                        <option value="14:15" <cfif #timeformat(aud_det.eventStartTime,'HH:MM')# is "14:15"> selected </cfif> >02:15 PM</option>
                        <option value="14:30" <cfif #timeformat(aud_det.eventStartTime,'HH:MM')# is "14:30"> selected </cfif> >02:30 PM</option>
                        <option value="14:45" <cfif #timeformat(aud_det.eventStartTime,'HH:MM')# is "14:45"> selected </cfif> >02:45 PM</option>
                        <option value="15:00" <cfif #timeformat(aud_det.eventStartTime,'HH:MM')# is "15:00"> selected </cfif> >03:00 PM</option>
                        <option value="15:15" <cfif #timeformat(aud_det.eventStartTime,'HH:MM')# is "15:15"> selected </cfif> >03:15 PM</option>
                        <option value="15:30" <cfif #timeformat(aud_det.eventStartTime,'HH:MM')# is "15:30"> selected </cfif> >03:30 PM</option>
                        <option value="15:45" <cfif #timeformat(aud_det.eventStartTime,'HH:MM')# is "15:45"> selected </cfif> >03:45 PM</option>
                        <option value="16:00" <cfif #timeformat(aud_det.eventStartTime,'HH:MM')# is "16:00"> selected </cfif> >04:00 PM</option>
                        <option value="16:15" <cfif #timeformat(aud_det.eventStartTime,'HH:MM')# is "16:15"> selected </cfif> >04:15 PM</option>
                        <option value="16:30" <cfif #timeformat(aud_det.eventStartTime,'HH:MM')# is "16:30"> selected </cfif> >04:30 PM</option>
                        <option value="16:45" <cfif #timeformat(aud_det.eventStartTime,'HH:MM')# is "16:45"> selected </cfif> >04:45 PM</option>
                        <option value="17:00" <cfif #timeformat(aud_det.eventStartTime,'HH:MM')# is "17:00"> selected </cfif> >05:00 PM</option>
                        <option value="17:15" <cfif #timeformat(aud_det.eventStartTime,'HH:MM')# is "17:15"> selected </cfif> >05:15 PM</option>
                        <option value="17:30" <cfif #timeformat(aud_det.eventStartTime,'HH:MM')# is "17:30"> selected </cfif> >05:30 PM</option>
                        <option value="17:45" <cfif #timeformat(aud_det.eventStartTime,'HH:MM')# is "17:45"> selected </cfif> >05:45 PM</option>
                        <option value="18:00" <cfif #timeformat(aud_det.eventStartTime,'HH:MM')# is "18:00"> selected </cfif> >06:00 PM</option>
                        <option value="18:15" <cfif #timeformat(aud_det.eventStartTime,'HH:MM')# is "18:15"> selected </cfif> >06:15 PM</option>
                        <option value="18:30" <cfif #timeformat(aud_det.eventStartTime,'HH:MM')# is "18:30"> selected </cfif> >06:30 PM</option>
                        <option value="18:45" <cfif #timeformat(aud_det.eventStartTime,'HH:MM')# is "18:45"> selected </cfif> >06:45 PM</option>
                        <option value="19:00" <cfif #timeformat(aud_det.eventStartTime,'HH:MM')# is "19:00"> selected </cfif> >07:00 PM</option>
                        <option value="19:15" <cfif #timeformat(aud_det.eventStartTime,'HH:MM')# is "19:15"> selected </cfif> >07:15 PM</option>
                        <option value="19:30" <cfif #timeformat(aud_det.eventStartTime,'HH:MM')# is "19:30"> selected </cfif> >07:30 PM</option>
                        <option value="19:45" <cfif #timeformat(aud_det.eventStartTime,'HH:MM')# is "19:45"> selected </cfif> >07:45 PM</option>
                        <option value="20:00" <cfif #timeformat(aud_det.eventStartTime,'HH:MM')# is "20:00"> selected </cfif> >08:00 PM</option>
                        <option value="20:15" <cfif #timeformat(aud_det.eventStartTime,'HH:MM')# is "20:15"> selected </cfif> >08:15 PM</option>
                        <option value="20:30" <cfif #timeformat(aud_det.eventStartTime,'HH:MM')# is "20:30"> selected </cfif> >08:30 PM</option>
                        <option value="20:45" <cfif #timeformat(aud_det.eventStartTime,'HH:MM')# is "20:45"> selected </cfif> >08:45 PM</option>
                        <option value="21:00" <cfif #timeformat(aud_det.eventStartTime,'HH:MM')# is "21:00"> selected </cfif> >09:00 PM</option>
                        <option value="21:15" <cfif #timeformat(aud_det.eventStartTime,'HH:MM')# is "21:15"> selected </cfif> >09:15 PM</option>
                        <option value="21:30" <cfif #timeformat(aud_det.eventStartTime,'HH:MM')# is "21:30"> selected </cfif> >09:30 PM</option>
                        <option value="21:45" <cfif #timeformat(aud_det.eventStartTime,'HH:MM')# is "21:45"> selected </cfif> >09:45 PM</option>
                        <option value="22:00" <cfif #timeformat(aud_det.eventStartTime,'HH:MM')# is "22:00"> selected </cfif> >10:00 PM</option>
                        <option value="22:15" <cfif #timeformat(aud_det.eventStartTime,'HH:MM')# is "22:15"> selected </cfif> >10:15 PM</option>
                        <option value="22:30" <cfif #timeformat(aud_det.eventStartTime,'HH:MM')# is "22:30"> selected </cfif> >10:30 PM</option>
                        <option value="22:45" <cfif #timeformat(aud_det.eventStartTime,'HH:MM')# is "22:45"> selected </cfif> >10:45 PM</option>
                        <option value="23:00" <cfif #timeformat(aud_det.eventStartTime,'HH:MM')# is "23:00"> selected </cfif> >11:00 PM</option>
                        <option value="23:15" <cfif #timeformat(aud_det.eventStartTime,'HH:MM')# is "23:15"> selected </cfif> >11:15 PM</option>
                        <option value="23:30" <cfif #timeformat(aud_det.eventStartTime,'HH:MM')# is "23:30"> selected </cfif> >11:30 PM</option>
                        <option value="23:45" <cfif #timeformat(aud_det.eventStartTime,'HH:MM')# is "23:45"> selected </cfif> >11:45 PM</option>



                        <cfelse>

                            <option value="">Select a Start Time</option>
                            <option value="00:00" <cfif #timeformat('#userCalStarttime#','hh:mm TT')# is "00:00"> selected </cfif> >12:00 AM</option>
                            <option value="00:15" <cfif #timeformat('#userCalStarttime#','hh:mm TT')# is "00:15"> selected </cfif> >12:15 AM</option>
                            <option value="00:30" <cfif #timeformat('#userCalStarttime#','hh:mm TT')# is "00:30"> selected </cfif> >12:30 AM</option>
                            <option value="00:45" <cfif #timeformat('#userCalStarttime#','hh:mm TT')# is "00:45"> selected </cfif> >12:45 AM</option>
                            <option value="01:00" <cfif #timeformat('#userCalStarttime#','hh:mm TT')# is "01:00"> selected </cfif> >01:00 AM</option>
                            <option value="01:15" <cfif #timeformat('#userCalStarttime#','hh:mm TT')# is "01:15"> selected </cfif> >01:15 AM</option>
                            <option value="01:30" <cfif #timeformat('#userCalStarttime#','hh:mm TT')# is "01:30"> selected </cfif> >01:30 AM</option>
                            <option value="01:45" <cfif #timeformat('#userCalStarttime#','hh:mm TT')# is "01:45"> selected </cfif> >01:45 AM</option>
                            <option value="02:00" <cfif #timeformat('#userCalStarttime#','hh:mm TT')# is "02:00"> selected </cfif> >02:00 AM</option>
                            <option value="02:15" <cfif #timeformat('#userCalStarttime#','hh:mm TT')# is "02:15"> selected </cfif> >02:15 AM</option>
                            <option value="02:30" <cfif #timeformat('#userCalStarttime#','hh:mm TT')# is "02:30"> selected </cfif> >02:30 AM</option>
                            <option value="02:45" <cfif #timeformat('#userCalStarttime#','hh:mm TT')# is "02:45"> selected </cfif> >02:45 AM</option>
                            <option value="03:00" <cfif #timeformat('#userCalStarttime#','hh:mm TT')# is "03:00"> selected </cfif> >03:00 AM</option>
                            <option value="03:15" <cfif #timeformat('#userCalStarttime#','hh:mm TT')# is "03:15"> selected </cfif> >03:15 AM</option>
                            <option value="03:30" <cfif #timeformat('#userCalStarttime#','hh:mm TT')# is "03:30"> selected </cfif> >03:30 AM</option>
                            <option value="03:45" <cfif #timeformat('#userCalStarttime#','hh:mm TT')# is "03:45"> selected </cfif> >03:45 AM</option>
                            <option value="04:00" <cfif #timeformat('#userCalStarttime#','hh:mm TT')# is "04:00"> selected </cfif> >04:00 AM</option>
                            <option value="04:15" <cfif #timeformat('#userCalStarttime#','hh:mm TT')# is "04:15"> selected </cfif> >04:15 AM</option>
                            <option value="04:30" <cfif #timeformat('#userCalStarttime#','hh:mm TT')# is "04:30"> selected </cfif> >04:30 AM</option>
                            <option value="04:45" <cfif #timeformat('#userCalStarttime#','hh:mm TT')# is "04:45"> selected </cfif> >04:45 AM</option>
                            <option value="05:00" <cfif #timeformat('#userCalStarttime#','hh:mm TT')# is "05:00"> selected </cfif> >05:00 AM</option>
                            <option value="05:15" <cfif #timeformat('#userCalStarttime#','hh:mm TT')# is "05:15"> selected </cfif> >05:15 AM</option>
                            <option value="05:30" <cfif #timeformat('#userCalStarttime#','hh:mm TT')# is "05:30"> selected </cfif> >05:30 AM</option>
                            <option value="05:45" <cfif #timeformat('#userCalStarttime#','hh:mm TT')# is "05:45"> selected </cfif> >05:45 AM</option>
                            <option value="06:00" <cfif #timeformat('#userCalStarttime#','hh:mm TT')# is "06:00"> selected </cfif> >06:00 AM</option>
                            <option value="06:15" <cfif #timeformat('#userCalStarttime#','hh:mm TT')# is "06:15"> selected </cfif> >06:15 AM</option>
                            <option value="06:30" <cfif #timeformat('#userCalStarttime#','hh:mm TT')# is "06:30"> selected </cfif> >06:30 AM</option>
                            <option value="06:45" <cfif #timeformat('#userCalStarttime#','hh:mm TT')# is "06:45"> selected </cfif> >06:45 AM</option>
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
                            </cfif>

                    </select>


                </div>



                <div class="form-group col-md-6">
                    <label for="new_eventStopTime">Duration</label>
                    <select class="form-control" name="new_durid" autocomplete="off" id="new_durid">
                        <cfoutput query="durations">
                            <option value="#durations.durid#" <cfif #durations.durid# is "#new_durid#"> selected </cfif> >#durations.durname#</option>
                        </cfoutput>
                    </select>
                </div>




                <cfif #aud_det.audstepid# is "2">
                    <cfinclude template="/include/qry/audcallbacktypes_sel.cfm" />

                    <div class="form-group col-md-6 col-sm-12">
                        <label for="audtypeid">Callback Type<span class="text-danger">*</span>.</label>

                        <select id="NEW_CALLBACKTYPEID" name="NEW_CALLBACKTYPEID" class="form-control" data-parsley-required data-parsley-error-message="Callback Type is required">

                            <cfoutput query="audcallbacktypes_sel_def">
                                <option value="#audcallbacktypes_sel_def.id#">#audcallbacktypes_sel_def.name#</option>
                            </cfoutput>
                            <cfoutput query="audcallbacktypes_sel">

                                <cfif #audcallbacktypes_sel.id# is "#old_callbacktypeid#">
                                    <option value="#audcallbacktypes_sel.id#" Selected> #audcallbacktypes_sel.name#</option>

                                </cfif>

                                <cfif #audcallbacktypes_sel.id# is not "#old_callbacktypeid#">
                                    <option value="#audcallbacktypes_sel.id#"> #audcallbacktypes_sel.name#</option>

                                </cfif>

                            </cfoutput>

                        </select>


                    </div>

                    <cfelse>

                        <cfoutput>
                            <input type="hidden" name="new_callbacktypeid" value="#old_callbacktypeid#" />
                        </cfoutput>
                </cfif>










                <div class="form-group col-md-12">
                    <label for="audtypeid">Type<span class="text-danger">*</span></label>

                    <select id="audtypeid" name="new_audtypeid" class="form-control" data-parsley-required data-parsley-error-message="Type is required">



                        <option value="">--</option>

                        <cfoutput query="audtypes_sel">
                            <option value="#audtypes_sel.id#" <cfif #audtypes_sel.id# is "#aud_det.audtypeid#"> selected </cfif> >#audtypes_sel.name#</option>
                        </cfoutput>

                    </select>


                </div>










                <cfif #aud_det.audstepid# is "5">
                    <cfquery name="audbooktypes_sel" datasource="#dsn#">
                        SELECT audbooktypeid as id,audbooktype as name FROM audbooktypes WHERE isdeleted = 0 and audbooktypeid <> 0


                    </cfquery>

                    <div class="form-group col-md-6 col-sm-12">
                        <label for="audtypeid">Booking Type<span class="text-danger">*</span></label>

                        <select id="audbooktypeid" name="new_audbooktypeid" class="form-control" data-parsley-required data-parsley-error-message="Booking Type is required">
                            <option value="0">--</option>

                            <cfoutput query="audbooktypes_sel">
                                <option value="#audbooktypes_sel.id#" <cfif #audbooktypes_sel.id# is "#aud_det.audbooktypeid#"> Selected
                </cfif> > #audbooktypes_sel.name#</option>
                </cfoutput>

                </select>






                </cfif>










                <div id="hiddenDiv_1">






                    <Cfoutput>



                        <div class="form-group col-md-12">
                            <label for="new_parkingDetails">Parking Details</label>
                            <input class="form-control" type="text" id="new_parkingDetails" autocomplete="off" value="#aud_det.parkingDetails#" name="new_parkingDetails" placeholder="Parking details">
                        </div>

                        <div class="form-group col-md-12">
                            <div class="custom-group custom-checkbox">

                                <div style="margin-left:25px;">
                                    <label class="custom-control-label">
                                        <input type="checkbox" name="new_trackmileage" class="custom-control-input" id="trackmileage" value="1" <cfif #aud_det.trackmileage# is "1"> checked </cfif>
                                        name="new_trackmileage">
                                        <span class="custom-control-label" for="trackmileage">Track Mileage</span></label>
                                </div>
                            </div>
                        </div>

                    </Cfoutput>








                    <Cfoutput>

                        <div class="form-group col-md-12">
                            <label for="projName">Location Name<span class="text-danger">*</span></label>
                            <input class="form-control" type="text" id="eventLocation" name="new_eventLocation" value="#aud_det.eventLocation#" placeholder="Location Name" required data-parsley-required data-parsley-error-message="Location Name is required">

                            <div class="invalid-feedback">
                                Please enter a Location Name.
                            </div>
                        </div>

                        <div class="form-group col-md-12">
                            <label for="projName">Address </label>
                            <input class="form-control" type="text" id="audlocadd1" name="new_audlocadd1" value="#aud_det.audlocadd1#" placeholder="Address" />

                            <div class="invalid-feedback">
                                Please enter an address.
                            </div>
                        </div>

                        <div class="form-group col-md-12">
                            <label for="projName">Extended Address </label>
                            <input class="form-control" type="text" id="audlocadd2" name="new_audlocadd2" value="#aud_det.audlocadd2#" placeholder="APT 101" />

                            <div class="invalid-feedback">
                                Please enter an extended address.
                            </div>
                        </div>










                        <div class="form-group col-md-6">
                            <label for="valuetext">Town/City</label>

                            <input class="form-control" type="text" id="audcity" name="new_audcity" value="#aud_det.audcity#" placeholder="Enter City">


                        </div>





                        <div class="form-group col-md-6">
                            <label for="valuetext">Postal Code</label>

                            <input class="form-control" type="text" id="audzip" name="new_audzip" value="#aud_det.audzip#" placeholder="Enter Postal Code">

                        </div>



                    </cfoutput>


                    <cfif #new_countryid# is "">
                        <cfset new_countryid="US" />
                    </cfif>

                    <cfif #new_regionid# is "">
                        <cfset new_regionid="CA" />
                    </cfif>

                    <div class="form-group col-md-6">
                        <label for="regionid">State/Region<span class="text-danger">*</span></label>

                        <select id="regionid" name="new_regionid" class="form-control">
                            <option value="">--</option>

                            <cfoutput query="regions">
                                <option value="#regions.regionid#" data-chained="#regions.countryid#" <cfif #regions.regionid# is "#new_regionid#">selected </cfif> >#regions.regionname#</option>
                            </cfoutput>

                        </select>


                    </div>



                    <div class="form-group col-md-6">
                        <label for="countryid">Country<span class="text-danger">*</span></label>

                        <select id="countryid" class="form-control" name="countryid" data-parsley-required data-parsley-error-message="Country is required">
                            <option value="">--</option>
                            <cfoutput query="countries">
                                <option value="#countries.countryid#" <cfif #countries.countryid# is "#new_countryid#">selected </cfif> >#countries.countryname#</option>
                            </cfoutput>
                        </select>

                    </div>

                </div>


                <div id="hiddenDiv_2">

                    <Cfoutput>
                        <div class="form-group col-md-12">
                            <label for="new_eventStart">Platform URL (optional)</label>
                            <input class="form-control" type="text" id="new_audLocation" autocomplete="off" name="new_audLocation" placeholder="Zoom link">
                        </div>
                        <input type="hidden" name="old_audPlatformid" value="#aud_det.audplatformid#" />
                               
                               </Cfoutput>

                        <div class="form-group col-md-12">

                            <label for="audplatformid">Audition Platform </label>

                            <select id="audplatformid" name="new_audplatformid" class="form-control" onchange="if (this.value=='CustomPlatform'){this.form['CustomPlatform'].style.visibility='visible',this.form['CustomPlatform'].required=true} else {this.form['CustomPlatform'].style.visibility='hidden',this.form['CustomPlatform'].required=false};">

                                <option value="">--</option>
                                <option value="CustomPlatform">***ADD CUSTOM</option>
                                <cfoutput query="audplatforms_user_sel">
                                    <option value="#audplatforms_user_sel.id#" <cfif #audplatforms_user_sel.id# is "#aud_det.audplatformid#"> selected </cfif> > #audplatforms_user_sel.name# </option>
                                </cfoutput>
                            </select>

                        </div>


                        <div class="form-group col-md-6" id="CustomPlatforms" style="visibility:hidden;"> <label for="CustomPlatform">Custom Platform</label>
                            <input class="form-control"  type="text" id="CustomPlatform" name="CustomPlatform" value="" placeholder="Enter a Custom Platform">
                        </div>


                </div>

                <cfoutput>

                    <div class="form-group col-md-12">
                        
                        <div class="custom-group custom-checkbox">

                            <div style="margin-left:25px;">
                                
                                <label class="custom-control-label">
                                    
                                    <input type="checkbox" class="custom-control-input" id="workwithcoach" value="1" 
                                           <cfif #aud_det.workwithcoach# is "1"> checked </cfif> name="new_workwithcoach">
                                    <span class="custom-control-label" for="workwithcoach">Worked with Coach</span></label>
                            </div>
                        
                        </div>
                    
                    </div>

                </cfoutput>

           <div class="form-group col-md-12">

               <button type="submit" class="btn btn-primary btn-sm waves-effect waves-light" id="btn-save-event">Add</button>

           </div>

            </div>
        </form>
        <script>
            $("#regionidx").chained("#countryidx");

        </script>




        <script>
            $(document).ready(function() {
                $(".parsley-examples").parsley()
            });

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






        <script>
            // First, let's get references to the select element and the two hidden divs
            const selectEl = document.getElementById('audtypeid');
            const hiddenDiv1 = document.getElementById('hiddenDiv_1');
            const hiddenDiv2 = document.getElementById('hiddenDiv_2');

            // Set the initial state of the divs based on the initial selected value
            if (selectEl.value === '1') {
                hiddenDiv1.style.display = 'block';
            } else if (selectEl.value === '2') {
                hiddenDiv2.style.display = 'block';
            } else {
                hiddenDiv1.style.display = 'none';
                hiddenDiv2.style.display = 'none';
            }

            // Now, let's add an event listener to the select element
            selectEl.addEventListener('change', function() {
                // Get the selected value
                const selectedValue = selectEl.value;

                // Show/hide the divs based on the selected value
                if (selectedValue === '1') {
                    hiddenDiv1.style.display = 'block';
                    hiddenDiv2.style.display = 'none';
                } else if (selectedValue === '2') {
                    hiddenDiv1.style.display = 'none';
                    hiddenDiv2.style.display = 'block';
                             } else if (selectedValue === '22') {
                    hiddenDiv1.style.display = 'none';
                    hiddenDiv2.style.display = 'block';
                } else if (selectedValue === '3') {
                    hiddenDiv1.style.display = 'none';
                    hiddenDiv2.style.display = 'none';
                }
            });

        </script>





        <script>
            $("#regionid").chained("#countryid");

        </script>
        <script src="/app/assets/js/libs/parsleyjs/parsley.min.js"></script>
