
<cfinclude template="/include/audition_check.cfm" />
<cfparam name="istab" default="Y" />
<cfparam name="pgaction" default="View" />
 
<cfparam name="new_iscallback" default="0" />
<cfparam name="new_isredirect" default="0" />
<cfparam name="new_ispin" default="0" />
<cfparam name="new_isbooked" default="0" />
<cfquery name="steps" datasource="#dsn#">
    SELECT * FROM audsteps WHERE stepinfo1 IS NOT null
</cfquery>


<cfloop query="steps">
    <Cfoutput>

        <cfset statusfield="is#steps.stepcss#" />


        <div id="StatusConfirm#steps.audstepid#" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true">

            <div class="modal-dialog">

                <div class="modal-content">

                    <div class="modal-header" style="background-color: ##f3f7f9;">

                        <h4 class="modal-title">#steps.audstep#</h4>

<a href="/include/removestatus.cfm?audprojectid=#audprojectid#&STATUSFIELD=#STATUSFIELD#&new_audroleid=#audroleid#&new_audstepid=#steps.audstepid#"><button type="button" class="close" aria-hidden="true"><i class="mdi mdi-close-thick"></i></button>
                        </a>
                    </div>

                    <div class="modal-body">

                        <h4>#steps.stepinfo1#</h4>
                        
                        <BR>
                        
                        <p>#steps.stepinfo2#</p>

                        <cfif #steps.stepinfo4# is not ""> 
                            
                            <p>#steps.stepinfo4#</p>
                            
                            <center>
                                
                                <p><img src="/media-#host#/#steps.audstepid#.png"></p>
                                
                            </center>
                            
                        </cfif>
                        <p>#steps.stepinfo3#</p>

<form action="/include/changestatus.cfm">
    <input type="hidden" value="#audprojectid#" name="audprojectid" />
 
 
    <input type="hidden" value="changestatus" name="pgaction" />
    <input type="hidden" name="NEW_AUDROLEID" value="#audroleid#" />
    <input type="hidden" name="new_audstepid" value="#steps.audstepid#" />
    <input type="submit" class="btn btn-xs btn-primary waves-effect waves-light" value="#steps.stepinfobutton#" />
    <input type="hidden" name="statusfield" value="#statusfield#" />
</form>



                    </div>

                </div>

            </div>

        </div>
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            

            
            
            
            
                    <div id="StatusCancel#steps.audstepid#" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true">

            <div class="modal-dialog">

                <div class="modal-content">

                    <div class="modal-header" style="background-color: red;color:white;">

                        <h4 class="modal-title">Cancel #steps.audstep#</h4>

                        <a href=""> <button type="button" value="Cancel" class="close" aria-hidden="true"><i class="mdi mdi-close-thick"></i></button>
                        </a>
                    </div>

                    <div class="modal-body">

                        <h4>Do you need to cancel your #steps.audstep# status?</h4><BR>
               


                        <form action="/include/changestatus.cfm">
                            <input type="hidden" value="#audprojectid#" name="audprojectid" />
    
                            <input type="hidden" value="cancel" name="pgaction" />
                            <input type="hidden" name="NEW_AUDROLEID" value="#audroleid#" />
                            <input type="hidden" name="new_audstepid" value="#steps.audstepid#" />
                            <input type="submit" class="btn btn-xs waves-effect waves-light" style="background-color:red;color:white;" value="Yes" />
                            <input type="hidden" name="statusfield" value="#statusfield#" />
                        </form>



                    </div>

                </div>

            </div>

        </div>
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
    </Cfoutput>
</cfloop>



<cfquery name="rolecheck" datasource="#dsn#">
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
    r.payrate,
    r.netincome,
    r.buyout,
    i.incometype,
    r.iscallback,
    r.isredirect,
    r.ispin,
    r.isbooked

    FROM audroles r

    LEFT OUTER JOIN audroletypes rt ON ( r.`audRoleTypeID` = rt.audroletypeid )
    LEFT OUTER JOIN auddialects di ON ( r.`audDialectID` = di.auddialectid )
    LEFT OUTER JOIN audsources s on (r.audsourceid = s.audsourceid)
    LEFT OUTER JOIN incometypes i on i.incometypeid = r.incometypeid


    WHERE r.audroleid = #audroleid#
</cfquery>





<cfparam name="NEW_ISREDIRECT" default="0" />

<cfparam name="NEW_ispin" default="0" />

<cfparam name="NEW_Iscallback" default="0" />

<cfparam name="NEW_ISbooked" default="0" />




            
            
            
 
            
            




<cfset NEW_AUDSUBCATID=projectdetails.AUDSUBCATID />

<cfif #isdefined('recid')#>

    <cfset audprojectid=recid />
</cfif>

<cfif #pgaction# is "change">
    <cfoutput>
        <cfset cookie.istab="#new_istab#" />
    </cfoutput>
    <cfset pgaction="view">
</cfif>

<cfif #isdefined('cookie.istab')#>
    <cfoutput>
        <cfset istab="#cookie.istab#" />
    </cfoutput>
</cfif>

<Cfif #detect.ismobile()# is "true">

    <cfset istab="N" />

</Cfif>

    
    


<cfset new_audcatid=numberformat(projectDetails.audcatid) />
<cfset audcatid=numberformat(projectDetails.audcatid) />
<cfinclude template="/include/qry/audunions_sel.cfm" />
    
    
   
            
<cfinclude template="/include/qry/audnetworks_user_sel.cfm" />

    
      
<cfinclude template="/include/qry/audtones_sel.cfm" />    
<cfinclude template="/include/qry/audcontracttypes_sel.cfm" />


<cfinclude template="/include/qry/notesaud.cfm" />
    
    
    
    
    
    
    

    
    
    
    
    
    
  
    
    
    
    
    
    
    
    
    
    
<cfloop query="events">

    <cfquery name="auditionDetails" datasource="#dsn#">
        SELECT
        pr.audprojectid as recid,
        ad.eventid,
        pr.audprojectid,
        ad.audLocation,
  
        ad.eventStart,
        ad.eventStartTime,
        ad.eventStopTime,
        ad.parkingDetails,
        ad.workwithcoach,
        t.audtype,
        s.audstep,
        s.audstepid,
        ad.audroleid,
        ad.trackmileage,
        ad.eventLocation,
        pl.audplatform,
        r.audprojectID,
        pr.audSubCatID,
        ad.audlocid,
        t.islocation,
        ad.audbooktypeid,
        bt.audbooktype,
        cbt.callbacktype,
        cbt.callbacktypeid,
        sub.audcatid,
        ad.audtypeid,
        ad.audlocadd1,
        ad.audzip,
        ad.audlocadd2,
        ad.audcity,
        ad.region_id,
        rg.countryid,
        c.countryname,
        rg.regionname

        FROM audprojects pr

        INNER JOIN audroles r ON pr.audprojectID = r.audprojectID

        LEFT OUTER JOIN events ad ON r.audroleid = ad.audroleid

        LEFT OUTER JOIN audsubcategories sub on sub.audsubcatid = pr.audsubcatid

        LEFT OUTER JOIN audcallbacktypes cbt on cbt.callbacktypeid = ad.callbacktypeid

        LEFT OUTER JOIN audtypes t ON t.audtypeid = ad.audtypeid

        LEFT OUTER JOIN audplatforms pl on pl.audplatformid = ad.audplatformid

        LEFT OUTER JOIN audsteps s ON s.audstepid = ad.audstepid

        LEFT OUTER JOIN audbooktypes bt on bt.audbooktypeid = ad.audbooktypeid

        LEFT OUTER JOIN regions rg on rg.region_id = ad.region_id

        LEFT OUTER JOIN countries c on rg.countryid = c.countryid

        WHERE ad.eventid = #events.eventid#
    </cfquery>

    <cfoutput>


        <div id="auditionDetails_#events.eventid#" class="modal fade" tabindex="-1" aria-labelledby="standard-modalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header" style="background-color: ##f3f7f9;">
                        <h4 class="modal-title" id="standard-modalLabel">Appointment Details</h4>
                        <button type="button" class="close" data-bs-dismiss="modal" aria-hidden="true"><i class="mdi mdi-close-thick"></i></button>
                    </div>
                    <div class="modal-body">



                        <div class="row" style="margin: auto;">



 


                            <Cfif #auditiondetails.eventStart# is not "">
                                <h4 class="px-1 d-flex text-nowrap"> <img src="/media-#host#/dates/#DateFormat('#auditiondetails.eventStart#','yyyy-mm-dd')#.png" style="max-width:75px;" alt="...">

 
                                </h4>

                            </Cfif>




                            <div class="col-md-12 p-1"><strong>Time: </strong>#timeformat(auditiondetails.eventStartTime)# <cfif #auditiondetails.eventStopTime# is not "">- #timeformat(auditiondetails.eventStopTime)#</cfif>
                            </div>

                            <div class="col-md-12 p-1"><strong> Stage: </strong>#auditiondetails.audstep#</div>

                            <cfif #auditionDetails.audstepid# is "2">

                                <div class="col-md-12 p-1"><strong>Callback Type: </strong>#auditionDetails.callbacktype#</div>


                            </cfif>



                            <div class="col-md-12 p-1"><strong> Type: </strong><button type="button" class="btn btn-xs btn-soft-secondary rounded-pill waves-effect">#auditiondetails.audtype#</button></div>



                            <cfif #auditiondetails.audstepid# is "5">


                                <div class="col-md-12 p-1"><strong>Booking Type: </strong>#auditiondetails.audbooktype#</div>

                            </cfif>


                            <cfif #auditiondetails.audtype# is "online">
                                <div class="col-md-12 p-1"><strong> Platform: </strong>#auditiondetails.audplatform#</div>
                            </cfif>



                            <div class="col-md-12 p-1"><strong> Worked with Coach: </strong>
                                <cfif #auditiondetails.workwithcoach# is "1">Yes<cfelse>No</cfif>
                            </div>
                                
                                
                                
                            <cfif #auditiondetails.audtype# is "In Person">
                                <div class="col-md-12 p-1"><strong>Parking Details: </strong>#auditiondetails.parkingdetails#</div>
                            </cfif>

                            <cfif #auditiondetails.audtype# is "In Person">

                                <div class="col-md-12 p-1"><strong> Track Mileage: </strong>
                                    <cfif #auditiondetails.trackmileage# is "1">Yes<cfelse>No</cfif>
                                </div>
                                <cfif #auditiondetails.audtype# is "In Person">
                                    <div class="col-md-12 p-1"><strong>Parking Details: </strong>#auditiondetails.parkingdetails#</div>
                                </cfif>
                            </cfif>





                            <cfif #auditiondetails.islocation# is "true">
                                <div class="col-md-12 p-1"><strong>Location: </strong>#auditionDetails.eventLocation#<cfif #auditionDetails.eventLocation# is not "" and #auditionDetails.audlocadd1# is not "">, #auditionDetails.audlocadd1#</cfif>
                                    <cfif #auditionDetails.audlocadd2# is not "">, #auditionDetails.audlocadd2#</cfif>
                                    <cfif #auditionDetails.audcity# is not "">, #auditionDetails.audcity#</cfif>
                                    <cfif #auditionDetails.regionname# is not ""> , #auditionDetails.regionname#</cfif>
                                    <cfif #auditionDetails.audzip# is not ""> , #auditionDetails.audzip#</cfif>
                                    <cfif #auditionDetails.countryname# is not "" and #auditiondetails.countryname# is not "United States">#auditionDetails.countryname#</cfif>
 



                                </div>
                                <cfelse>
                                    <cfif #auditiondetails.audtype# is "online">
                                        <div class="col-md-12 p-1"><strong>Zoom Link: </strong>#auditiondetails.audLocation# </div>
                                    </cfif>
                            </cfif>

                        </div>
                                
                    </div>

                </div>

            </div>

                    </div>


            <script>
                $(document).ready(function() {
                    $("##auditionupdate_#events.eventid#").on("show.bs.modal", function(event) {
                        // Place the returned HTML into the selected element
                        $(this).find(".modal-body").load("/include/remoteaudupdateform.cfm?secid=#secid#&eventid=#events.eventid#&audcatid=#audcatid#&audprojectid=#audprojectid#&rpgid=175&details_pgid=176&pgdir=audition&userid=#userid#");
                    });
                });
            </script>
            <div id="auditionupdate_#events.eventid#" class="modal fade" tabindex="-1" aria-labelledby="standard-modalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header" style="background-color: ##f3f7f9;">
                            <h4 class="modal-title" id="standard-modalLabel">Appointment Update</h4>
                            <button type="button" class="close" data-bs-dismiss="modal" aria-hidden="true"><i class="mdi mdi-close-thick"></i></button>
                        </div>
                        <div class="modal-body">


                        </div>
                    </div>

                </div>

            </div>

    </cfoutput>

</cfloop>

    
    
    
    
    
    
    
    
    
    
    
    
    


    <cfoutput query="projectdetails">
    

    
                                    <script>
                                        $(document).ready(function() {
                                            $("##remoteDeleteFormAudproject#projectdetails.audprojectid#").on("show.bs.modal", function(event) {
                                                // Place the returned HTML into the selected element
                                                $(this).find(".modal-body").load("/include/remoteDeleteFormAudproject.cfm?audprojectid=#projectdetails.audprojectid#");
                                            });
                                        });

                                    </script>

                                    <div id="remoteDeleteFormAudproject#projectdetails.audprojectid#" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true">

                                        <div class="modal-dialog">

                                            <div class="modal-content">

                                                <div class="modal-header" style="background-color: red;">

                                                    <h4 class="modal-title">Delete Audition Project</h4>

                                                    <button type="button" class="close" data-bs-dismiss="modal" aria-hidden="true"><i class="mdi mdi-close-thick"></i></button>

                                                </div>

                                                <div class="modal-body"></div>

                                            </div>

                                        </div>

                                    </div>


    
    
    </cfoutput>


<cfloop list="2,3,5" index="new_audstepid" delimiters=",">

    <Cfoutput>
        <cfquery name="findstep" datasource="#dsn#">
            select audstep from audsteps where audstepid = #new_audstepid#
        </cfquery>
<script>
            $(document).ready(function() {
                $("##auditionadd_#findstep.audstep#").on("show.bs.modal", function(event) {
                    // Place the returned HTML into the selected element
                    $(this).find(".modal-body").load("/include/remoteaudupdateform.cfm?NEW_AUDSUBCATID=#new_audsubcatid#&audcatid=#audcatid#&pgaction=add&audstepid=#new_audstepid#&secid=#secid#&audprojectid=#audprojectid#&rpgid=184&details_pgid=176&pgdir=audition&userid=#userid#");
                });
            });

        </script>


        <script>
            $(document).ready(function() {
                $("##auditionadd_#findstep.audstep#_cancel").on("show.bs.modal", function(event) {
                    // Place the returned HTML into the selected element
                    $(this).find(".modal-body").load("/include/remoteaudupdateform_cancel.cfm?NEW_AUDSUBCATID=#new_audsubcatid#&audcatid=#audcatid#&pgaction=add&audstepid=#new_audstepid#&secid=#secid#&audprojectid=#audprojectid#&rpgid=184&details_pgid=176&pgdir=audition&userid=#userid#");
                });
            });

        </script>


        <div id="auditionadd_#findstep.audstep#" class="modal fade" tabindex="-1" aria-labelledby="standard-modalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header" style="background-color: ##f3f7f9;">
                        <h4 class="modal-title" id="standard-modalLabel">Appointment Add</h4>
                        <button type="button" class="close" data-bs-dismiss="modal" aria-hidden="true"><i class="mdi mdi-close-thick"></i></button>
                    </div>
                    <div class="modal-body">


                    </div>
                </div>

            </div>

        </div>










    </Cfoutput>


</cfloop>








<script>
    $(document).ready(function() {
        $("#catupdate").on("show.bs.modal", function(event) {
            // Place the returned HTML into the selected element
            $(this).find(".modal-body").load("/include/catupdateform.cfm?AUDPROJECTID=<cfoutput>#audprojectid#</cfoutput>&audcatid=<cfoutput>#projectdetails.audcatid#</cfoutput>&rpgid=184&secid=176&details_pgid=176&pgdir=audition");
        });
    });

</script>
<div id="catupdate" class="modal  fade" tabindex="-1" aria-labelledby="standard-modalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header" style="background-color: #f3f7f9;">
                <h4 class="modal-title" id="standard-modalLabel">Category Update</h4>
                <button type="button" class="close" data-bs-dismiss="modal" aria-hidden="true"><i class="mdi mdi-close-thick"></i></button>
            </div>
            <div class="modal-body">
            </div>
        </div>
    </div>
</div>






<script>
    $(document).ready(function() {
        $("#projectupdate").on("show.bs.modal", function(event) {
            // Place the returned HTML into the selected element
            $(this).find(".modal-body").load("/include/remote_aud_project_update.cfm?<cfoutput>secid=#secid#</cfoutput>&audprojectid=<cfoutput>#projectdetails.audprojectid#</cfoutput>&rpgid=148&pgdir=audition");
        });
    });

</script>
<div id="projectupdate" class="modal fade" tabindex="-1" aria-labelledby="standard-modalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header" style="background-color: #f3f7f9;">
                <h4 class="modal-title" id="standard-modalLabel">Project Update</h4>
                <button type="button" class="close" data-bs-dismiss="modal" aria-hidden="true"><i class="mdi mdi-close-thick"></i></button>
            </div>
            <div class="modal-body">


            </div>
        </div>

    </div>

</div>

<script>
    $(document).ready(function() {
        $("#audlocupdate").on("show.bs.modal", function(event) {
            // Place the returned HTML into the selected element
            $(this).find(".modal-body").load("/include/audlocupdate.cfm?secid=<cfoutput>#secid#</cfoutput>&userid=<cfoutput>#userid#</cfoutput>&audprojectid=<cfoutput>#audprojectid#</cfoutput>");
        });
    });

</script>

<div id="audlocupdate" class="modal  fade" tabindex="-1" aria-labelledby="standard-modalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header" style="background-color: #f3f7f9;">
                <h4 class="modal-title" id="standard-modalLabel">Audition Location Update</h4>
                <button type="button" class="close" data-bs-dismiss="modal" aria-hidden="true"><i class="mdi mdi-close-thick"></i></button>
            </div>
            <div class="modal-body">
            </div>
        </div>
    </div>
</div>

<cfparam name="secid" default="176" />


<form action="/include/rolecheck.cfm">

    <Cfoutput>

        <input type="hidden" name="audroleid" value="#audroleid#" />

        <input type="hidden" name="audprojectid" value="#audprojectid#" />

        <input type="hidden" name="pgaction" value="switchit" />

    </Cfoutput>






    <div class="card h-100 ribbon-box p-1 pb-0 mb-1" style="background-color: #FFFAE8;border-width:thin;border-color:#406E8E;">

        <center>

            <div class="container">

                <div class="row">
                    <cfoutput>










                        <div class="form-switch col-md-3 col-sm-6 col-xs-6">
                            <cfif #projectdetails.isdirect# is "0">

                            <cfquery name="callback_check" datasource="#dsn#" maxrows="1">
                                SELECT * FROM events WHERE audroleid = #audroleid# AND isdeleted = 0 AND audstepid = 2
                            </cfquery>

                            <cfif #rolecheck.iscallback# is "1">

                                <input class="form-check-input form-check-input-callback" type="checkbox" id="new_iscallback" name="new_iscallback" value="1" <cfif #rolecheck.iscallback# is "1"> checked
                            </cfif>

                            <cfif #callback_check.recordcount# is not "0"> onclick="return false;"
                                <cfelse>

                                     data-bs-toggle="modal" data-bs-target="##StatusCancel2" 
                            </cfif> />

                            <cfelse>

                                <input class="form-check-input form-check-input-callback" type="checkbox" data-bs-toggle="modal" data-bs-target="##StatusConfirm2" id="new_iscallback" name="new_iscallback" value="1" <cfif #rolecheck.iscallback# is "1"> checked </cfif>

                                <cfif #callback_check.recordcount# is not "0"> onclick="return false;"</cfif> />

                                </cfif>

                                <label class="form-check-label" for="new_iscallback">Callback </label>

                                <cfif #rolecheck.iscallback# is "1">

                                    <a href="javascript:;" data-bs-remote="true" data-bs-toggle="modal" data-bs-target="##auditionadd_Callback" data-bs-placement="top" title="Add Callback appointment" data-bs-original-title="Add Callback"><i class="fe-plus-circle"></i></a>

                                </cfif>
                                
                            </cfif>

                        </div><!-- end form-check -->










<div class="form-switch col-md-3 col-sm-6 col-xs-6">
<cfif #projectdetails.isdirect# is "0">
<cfquery name="Redirect_check" datasource="#dsn#" maxrows="1">
    SELECT * FROM events WHERE audroleid = #audroleid# AND isdeleted = 0 AND audstepid = 3
</cfquery>

                            <cfif #rolecheck.isRedirect# is "1">

                                <input class="form-check-input form-check-input-Redirect" type="checkbox" id="new_isRedirect" name="new_isRedirect" value="1" <cfif #rolecheck.isRedirect# is "1"> checked
                            </cfif>

                            <cfif #Redirect_check.recordcount# is not "0"> onclick="return false;"
                                <cfelse>
                       
              data-bs-toggle="modal" data-bs-target="##StatusCancel3"  

                            </cfif> />

                            <cfelse>

                                <input class="form-check-input form-check-input-Redirect" type="checkbox" data-bs-toggle="modal" data-bs-target="##StatusConfirm3" id="new_isRedirect" name="new_isRedirect" value="1" <cfif #rolecheck.isRedirect# is "1"> checked </cfif>

                                <cfif #Redirect_check.recordcount# is not "0"> onclick="return false;"</cfif> />

                                </cfif>

                                <label class="form-check-label" for="new_isRedirect">Redirect </label>

                                <cfif #rolecheck.isRedirect# is "1">

                                    <a href="javascript:;" data-bs-remote="true" data-bs-toggle="modal" data-bs-target="##auditionadd_Redirect" data-bs-placement="top" title="Add Redirect appointment" data-bs-original-title="Add Redirect"><i class="fe-plus-circle"></i></a>

                                </cfif>
    </cfif>
    
                        </div><!-- end form-check -->










                        <div class="form-switch col-md-3 col-sm-6 col-xs-6">
<cfif #projectdetails.isdirect# is "0">
                            <cfquery name="Pin_check" datasource="#dsn#">
                                SELECT * FROM events WHERE audroleid = #audroleid# AND isdeleted = 0 AND audstepid = 4
                            </cfquery>

                            <cfif #rolecheck.isPin# is "1">

                                <input class="form-check-input form-check-input-Pin" type="checkbox" id="new_isPin" name="new_isPin" value="1" <cfif #rolecheck.isPin# is "1"> checked
                            </cfif>

                            <cfif #Pin_check.recordcount# is not "0"> onclick="return false;"
                                <cfelse>
 
                      data-bs-toggle="modal" data-bs-target="##StatusCancel4"  

                            </cfif> />

                            <cfelse>

                                <input class="form-check-input form-check-input-Pin" type="checkbox" data-bs-toggle="modal" data-bs-target="##StatusConfirm4" id="new_isPin" name="new_isPin" value="1" <cfif #rolecheck.isPin# is "1"> checked </cfif>

                                <cfif #Pin_check.recordcount# is not "0"> onclick="return false;"</cfif> />

                                </cfif>

                                <label class="form-check-label" for="new_isPin">Pin/Avail </label>

                            </cfif>

                        </div><!-- end form-check -->


                        <div class="form-switch col-md-3 col-sm-6 col-xs-6">

                            <cfquery name="Booked_check" datasource="#dsn#">
                                SELECT * FROM events WHERE audroleid = #audroleid# AND isdeleted = 0 AND audstepid = 5
                            </cfquery>

<cfif #Booked_check.recordcount# is not "0"> 
 <a href="" data-bs-target="##RemoveBook" data-bs-toggle="modal"></cfif>


                            <cfif #rolecheck.isBooked# is "1">

                                <input class="form-check-input form-check-input-Booked" type="checkbox" id="new_isBooked" name="new_isBooked" value="1" <cfif #rolecheck.isBooked# is "1"> checked
                            </cfif>

                            <cfif #Booked_check.recordcount# is not "0"> 
                            
                             disabled="disabled"  
                                <cfelse>

                     data-bs-toggle="modal" data-bs-target="##StatusCancel5" 

                            </cfif> />

                            <cfelse>

                                <input class="form-check-input form-check-input-Booked" type="checkbox" data-bs-toggle="modal" data-bs-target="##StatusConfirm5" id="new_isBooked" name="new_isBooked" value="1" <cfif #rolecheck.isBooked# is "1"> checked </cfif>

                                <cfif #Booked_check.recordcount# is not "0"> onclick="return false;"</cfif> />

                                </cfif>

                                <label class="form-check-label" for="new_isBooked">Booked </label>

                                <cfif #rolecheck.isBooked# is "1">

                                    <a href="javascript:;"  data-bs-remote="true" data-bs-toggle="modal" data-bs-target="##auditionadd_Booking" data-bs-placement="top" title="Add Booked appointment" data-bs-original-title="Add Booked"><i class="fe-plus-circle"></i></a>

                                </cfif>
<cfif #Booked_check.recordcount# is not "0"> </a></cfif>
                        </div><!-- end form-check -->




                    </cfoutput>

                </div>
            </div>

        </center>
    </div>

</form>

<div class="row">


    <div class="col-md-6 col-xs-6 col-xs-12">

        <div class="card h-100 ribbon-box">

            <cfif #roledetails.isbooked# is "1">

                <div class="ribbon-two ribbon-two-success"><span>Booked</span></div>
            </cfif>

            <Center>

                <h4 class="card-header text-nowrap " style="color:white;background-color: #406E8E;margin:0!important;padding:15px!important;">
                    <cfoutput>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

                    
                            Appointments

                        

                    


                    </cfoutput>


                </h4>



            </Center>
            
 

            <div class="card-body">
                
                <cfif #projectdetails.isdirect# is "1">
                    
                           <p>Direct Booking</p> 
                                
                                 <a href="javascript:;" data-bs-remote="true" data-bs-toggle="modal" data-bs-target="#auditionadd_Booking" data-bs-placement="top" title="Add Booking  appointment" data-bs-original-title="Add Booking appointment"><i class="fe-plus-circle"></i> Add booking appointment</a>
                </cfif>

    
                    
                    <cfif #events.recordcount# is "0">
                        
                        <cfoutput>
                                <script>
            $(document).ready(function() {
                $("##auditionadd_audition").on("show.bs.modal", function(event) {
                    // Place the returned HTML into the selected element
                    $(this).find(".modal-body").load("/include/remoteaudupdateform.cfm?NEW_AUDSUBCATID=#new_audsubcatid#&audcatid=#audcatid#&pgaction=add&audstepid=1&secid=#secid#&audprojectid=#audprojectid#&rpgid=184&details_pgid=176&pgdir=audition&userid=#userid#");
                });
            });

        </script>
                            
                            
                                    <div id="auditionadd_audition" class="modal fade" tabindex="-1" aria-labelledby="standard-modalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header" style="background-color: ##f3f7f9;">
                        <h4 class="modal-title" id="standard-modalLabel">Appointment Add</h4>
                        <button type="button" class="close" data-bs-dismiss="modal" aria-hidden="true"><i class="mdi mdi-close-thick"></i></button>
                    </div>
                    <div class="modal-body">


                    </div>
                </div>

            </div>

        </div>




                            
                            
                            
                </cfoutput>        
                        
                        <cfif #projectDetails.isdirect# is "0">
                    
                     <P>You currently have no appointments for this project.</P>   
                        
                        <a href="javascript:;" data-bs-remote="true" data-bs-toggle="modal" data-bs-target="#auditionadd_audition" data-bs-placement="top" title="Add Audition  appointment" data-bs-original-title="Add Audition"><i class="fe-plus-circle"></i> Add appointment</a>
                 
                    </cfif>
                   
 <cfelse>
               
                    <table id="basic-datatable" class="table dt-responsive w-100 table-striped" role="grid">

                        <thead>

                            <cfif (events.CurrentRow MOD 2)>

                                <Cfset rowtype="Odd" />

                            </cfif>

                            <cfif NOT (events.CurrentRow MOD 2)>

                                <Cfset rowtype="Even" />

                            </cfif>

                            <tr class="#rowtype#">
                                <th width="75">Action</th>
                                <th>Date</th>
                                <th>Time</th>
                                <th>Stage</th>
                                <th>Type</th>
                             <th>Assessment</th>
 
                            </tr>

                        </thead>

                        <tbody>

                            <cfloop query="events">

                                <cfoutput>
        <script>
    $(document).ready(function() {
        $("##remoteUpdateAnswer_#events.eventid#").on("show.bs.modal", function(event) {
            // Place the returned HTML into the selected element
            $(this).find(".modal-body").load("/include/remoteassform.cfm?eventid=#events.eventid#&audprojectid=#audprojectid#");
        });
    });

</script>


       <div id="remoteUpdateAnswer_#events.eventid#" class="modal fade" tabindex="-1" aria-labelledby="standard-modalLabel" aria-hidden="true">

            <div class="modal-dialog">

                <div class="modal-content">

                    <div class="modal-header" style="background-color: ##f3f7f9;">

                        <h4 class="modal-title" id="standard-modalLabel"><strong>#events.audstep#: </strong>#dateformat(events.eventStart,'long')#: Personal Assessment</h4>

                        <button type="button" class="close" data-bs-dismiss="modal" aria-hidden="true"><i class="mdi mdi-close-thick"></i>

                        </button>

                    </div>

                    <div class="modal-body">

                    </div>

                </div>

            </div>

        </div>






                                    <script>
                                        $(document).ready(function() {
                                            $("##remoteDeleteAud#events.eventid#").on("show.bs.modal", function(event) {
                                                // Place the returned HTML into the selected element
                                                $(this).find(".modal-body").load("/include/remoteDeleteFormAud.cfm?eventid=#events.eventid#&audprojectid=#audprojectid#&audroleid=#audroleid#&rpgid=175&pgaction=update");
                                            });
                                        });

                                    </script>

                                    <div id="remoteDeleteAud#events.eventid#" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true">

                                        <div class="modal-dialog">

                                            <div class="modal-content">

                                                <div class="modal-header" style="background-color: red;">

                                                    <h4 class="modal-title">Delete Audition</h4>

                                                    <button type="button" class="close" data-bs-dismiss="modal" aria-hidden="true"><i class="mdi mdi-close-thick"></i></button>

                                                </div>

                                                <div class="modal-body"></div>

                                            </div>

                                        </div>

                                    </div>










                                    <tr>

                                        <td style="word-break: break-all;">






                                            <a title="Edit" href="javascript:;" data-bs-remote="true" data-bs-toggle="modal" data-bs-target="##auditionupdate_#events.eventid#">

                                                <i class="mdi mdi-square-edit-outline mr-1"></i>
                                            </a>

                                  

                                            <a title="Delete Audition" href="DeleteModal.cfm?rpgid=175" data-bs-toggle="modal" data-bs-target="##remoteDeleteAud#events.eventid#">

                                                <i class="fe-trash-2"></i>

                                            </a>
<cfif #events.eventid# is not "" and #isdefined('sdfdfsdfdsf')#>
       <a title="Edit" href="/app/appoint/?eventid=#events.eventid#&returnurl=calendar-appoint">

                                                <i class="mdi mdi-calendar mr-1"></i>
                                            </a>

</cfif>


                                        </td>


                                        <td class="dt-nowrap">
                                            <a title="View Details" href="javascript:;" data-bs-remote="true" data-bs-toggle="modal" data-bs-target="##auditionDetails_#events.eventid#"> #DateFormat('#events.eventStart#','mm-dd-yy')#</a>
                                        </td>
                                               <td class="dt-nowrap">
                                                   <a title="View Details" href="javascript:;" data-bs-remote="true" data-bs-toggle="modal" data-bs-target="##auditionDetails_#events.eventid#">  #timeformat(events.eventStartTime,'short')#</a>
                                        </td>

                                        <td class="dt-nowrap">   <a title="View Details" href="javascript:;" data-bs-remote="true" data-bs-toggle="modal" data-bs-target="##auditionDetails_#events.eventid#">#events.audstep#</a></td>

                                        <td  class="dt-nowrap">   <a title="View Details" href="javascript:;" data-bs-remote="true" data-bs-toggle="modal" data-bs-target="##auditionDetails_#events.eventid#">#events.audtype#</a> <cfif #events.workwithcoach# is "1"><BR>(coached)</cfif>    </td>
                                        
 <TD  class="dt-nowrap"><center>
<cfif events.eventstart lte now()>
 <a href="javascript:;" data-bs-remote="true" data-bs-toggle="modal" data-bs-target="##remoteUpdateAnswer_#events.eventid#" toggle="tooltip" data-bs-placement="top" title="Update Answer" data-bs-original-title="Update Answer">

                                                      <i class="mdi mdi-square-edit-outline"></i> 

                                                  </a> 
</cfif>
</center>
                                            </td>


                                    </tr>



                                </cfoutput>

                            </cfloop>

                        </tbody>

                    </table>

     </cfif>



<cfoutput>


 <script>
                                    $(document).ready(function() {
                                        $("##remoteDeleteFormAudproject#audprojectid#").on("show.bs.modal", function(event) {
                                            // Place the returned HTML into the selected element
                                            $(this).find(".modal-body").load("/include/remoteDeleteFormAudproject.cfm?audprojectid=#audprojectid#");
                                        });
                                    });

                                </script>

                                <div id="remoteDeleteFormAudproject#audprojectid#" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true">

                                    <div class="modal-dialog">

                                        <div class="modal-content">

                                            <div class="modal-header" style="background-color: red;">

                                                <h4 class="modal-title">Delete Audition Project</h4>

                                                <button type="button" class="close" data-bs-dismiss="modal" aria-hidden="true"><i class="mdi mdi-close-thick"></i></button>

                                            </div>

                                            <div class="modal-body"></div>

                                        </div>

                                    </div>

                                </div>










             
                       



                            </cfoutput>
                        </div>


         





            </div>
        </div>



    <cfoutput>

        <cfset h5style="font-size:0.875rem;font-weight: 500;text-align:left;margin-bottom:0;" />

    </cfoutput>

    <div class="col-md-6 col-xs-6 col-xs-12">

        <div class="card h-100">


            <Center>

                <h4 class="card-header text-nowrap" style="color:white;background-color: #406E8E;margin:0!important;padding:15px!important;">
                    <cfoutput>Project Details</cfoutput>
                </h4>



            </Center>
            <Cfoutput>
                <div class="card-body">

                    <div class="row" style="margin: auto;">
                        
                       <h4 class="px-1 d-flex text-nowrap">   
                           
                       
                           
                           <span class="ms-auto"> 
                               
                          <a href="javascript:;" data-bs-remote="true" data-bs-toggle="modal" data-bs-target="##projectupdate" data-bs-placement="top" title="Update Project" data-bs-original-title="Update Project">   <i class="mdi mdi-square-edit-outline"></i> </a>
                          
                               
                                </span>
                               
                               

                       </h4>
                        
 
                        <div class="p-1 d-flex text-nowrap"><strong>Project: </strong> #projectdetails.projName# </div>





                        <div class="col-md-12 col-lg-12  col-xl-6 p-1 text-nowrap"><strong>Category: </strong><a href="javascript:;" data-bs-remote="true" data-bs-toggle="modal" data-bs-target="##catupdate" data-bs-placement="top" title="Update Category" data-bs-original-title="Update Category">#projectdetails.audCatName# - #projectdetails.audSubCatName#</a></div>

                        <div class="col-md-12 col-lg-12 p-1 text-nowrap"><strong>Casting Director: </strong>#projectdetails.castingfullname#</div>

                        <cfif #audunions_sel.recordcount# is not "0">
                            <div class="col-md-12 col-lg-12 p-1 text-nowrap"><strong>Union Status: </strong>#projectdetails.unionName#</div>
                        </cfif>
                        <cfif #audcontracttypes_sel.recordcount# is not "0">
                            <div class="col-md-12 col-lg-12 p-1 text-nowrap"><strong>Contract Type: </strong>#projectdetails.contracttype#</div>
                        </cfif>
                        
                        
                        <cfif #audnetworks_user_sel.recordcount# is not "0">
                            <div class="col-md-12 col-lg-12 p-1 text-nowrap"><strong>Network: </strong>#projectdetails.network#</div>
                        </cfif>
           
                        
                        <cfif #audtones_user_sel.recordcount# is not "0">
                            <div class="col-md-12 col-lg-12 p-1 text-nowrap"><strong>Style / Format: </strong>#projectdetails.tone#</div>
                        </cfif>

                        <div class="col-md-12 p-1"><strong>Project Description / Logline: </strong>#projectdetails.projDescription#</div>








                    </div>










                </div>
            </Cfoutput>
        </div>

    </div>

</div>
<p>&nbsp;</p>



<cfif #istab# is "N">

    <div class="card">

        <div class="btn-group col-md-12">

            <button type="button" class="btn btn-primary btn-lg dropdown-toggle" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">

                <Cfoutput>#sec_det.pgtitle#</Cfoutput>
                <i class="fe-menu"></i>

            </button>
            <div class="dropdown-menu">

                <cfloop query="options">
                    <cfoutput>
                        <a class="dropdown-item" href="/app/audition/?audprojectid=#audprojectid#&secid=#options.pgid#">#options.pgtitle#</a>
                    </cfoutput>
                </cfloop>

            </div>
        </div><!-- /btn-group -->




        <div class="card-body">



            <cfif #secid# is "176">
                <cfinclude template="/include/aud_role_pane.cfm" />
            </cfif>


            <cfif #secid# is "175">
                <cfinclude template="/include/aud_rel_pane.cfm" />
            </cfif>

                  <cfif #secid# is "196">
                <cfinclude template="/include/aud_head_pane.cfm" />
            </cfif>

            <cfif #secid# is "177">
                <cfinclude template="/include/aud_mat_pane.cfm" />
            </cfif>

            <cfif #secid# is "178">
                <cfinclude template="/include/aud_notes_pane.cfm" />
            </cfif>

            <cfif #secid# is "179">
                <cfinclude template="/include/aud_ques_pane.cfm" />
            </cfif>

            <cfif #secid# is "180">
                <cfinclude template="/include/aud_call_pane.cfm" />
            </cfif>
            <cfif #roledetails.isbooked# is "1">
                <cfif #secid# is "181">
                    <cfinclude template="/include/aud_book_pane.cfm" />
                </cfif>
            </cfif>
        </div>
    </div>



</cfif>



<cfif #istab# is "Y">

    <cfif #secid# is "176">
        <cfset role_active="active">
            <cfelse>
                <cfset role_active="">
    </cfif>
    <cfif #secid# is "175">
        <cfset rel_active="active">
            <cfelse>
                <cfset rel_active="">
    </cfif>

      <cfif #secid# is "196">
        <cfset head_active="active">
            <cfelse>
                <cfset head_active="">
    </cfif>



    <cfif #secid# is "177">
        <cfset mat_active="active">
            <cfelse>
                <cfset mat_active="">
    </cfif>
    <cfif #secid# is "178">
        <cfset notes_active="active">
            <cfelse>
                <cfset notes_active="">
    </cfif>
    <cfif #secid# is "179">
        <cfset ques_active="active">
            <cfelse>
                <cfset ques_active="">
    </cfif>
    <cfif #secid# is "180">
        <cfset call_active="active">
            <cfelse>
                <cfset call_active="">
    </cfif>
    <cfif #secid# is "181">
        <cfset book_active="active">
            <cfelse>
                <cfset book_active="">
    </cfif>

    <cfif #secid# is "176">
        <cfset role_showactive="show active">
            <cfelse>
                <cfset role_showactive="">
    </cfif>
    <cfif #secid# is "175">
        <cfset rel_showactive="show active">
            <cfelse>
                <cfset rel_showactive="">
    </cfif>

      <cfif #secid# is "196">
        <cfset head_showactive="show active">
            <cfelse>
                <cfset head_showactive="">
    </cfif>



    <cfif #secid# is "177">
        <cfset mat_showactive="show active">
            <cfelse>
                <cfset mat_showactive="">
    </cfif>
    <cfif #secid# is "178">
        <cfset notes_showactive="show active">
            <cfelse>
                <cfset notes_showactive="">
    </cfif>
    <cfif #secid# is "179">
        <cfset ques_showactive="show active">
            <cfelse>
                <cfset ques_showactive="">
    </cfif>
    <cfif #secid# is "180">
        <cfset call_showactive="show active">
            <cfelse>
                <cfset call_showactive="">
    </cfif>
    <cfif #secid# is "181">
        <cfset book_showactive="show active">
            <cfelse>
                <cfset book_showactive="">
    </cfif>



  

    <div class="card" class="p-3">

        <ul class="nav nav-pills navtab-bg nav-justified p-1" role="tablist">


            <li class="nav-item" role="presentation">
                <a href="#role" data-bs-toggle="tab" aria-expanded="true" class="nav-link <Cfoutput>#role_active#</Cfoutput>" role="tab">
                    Role
                </a>
            </li>

            <li class="nav-item" role="presentation">
                <a href="#rel" data-bs-toggle="tab" aria-expanded="false" class="nav-link <Cfoutput>#rel_active#</Cfoutput>" role="tab" tabindex="-1">
                    Relationships
                </a>
            </li>


            <li class="nav-item" role="presentation">
                <a href="#head" data-bs-toggle="tab" aria-expanded="false" class="nav-link <Cfoutput>#head_active#</Cfoutput>" tabindex="-1" role="tab">
                    Headshots
                </a>
            </li>


            <li class="nav-item" role="presentation">
                <a href="#mat" data-bs-toggle="tab" aria-expanded="false" class="nav-link <Cfoutput>#mat_active#</Cfoutput>" tabindex="-1" role="tab">
                    Materials
                </a>
            </li>



            <li class="nav-item" role="presentation">
                <a href="#notes" data-bs-toggle="tab" aria-expanded="false" class="nav-link <Cfoutput>#notes_active#</Cfoutput>" tabindex="-1" role="tab">
                    Notes
                </a>
            </li>
<cfif #isdefined('sdfsdfsdff')#>
            <cfquery name="questions_check" datasource="#dsn#" >
    select *
	 from events e
	 inner join audroles r on r.audroleid = e.audroleid
	 WHERE r.audprojectid = <cfqueryparam cfsqltype="cf_sql_integer" value="#audprojectid#"> 
</cfquery>


     <cfif #questions_check.recordcount# is not "0">
            <li class="nav-item" role="presentation">
                <a href="#ques" data-bs-toggle="tab" aria-expanded="false" class="nav-link <Cfoutput>#ques_active#</Cfoutput>" tabindex="-1" role="tab">
                    Assessment
                </a>
            </li>

            </cfif>
   </cfif>
    
            <cfif #roledetails.isbooked# is "1">
                <li class="nav-item" role="presentation">
                    <a href="#book" data-bs-toggle="tab" aria-expanded="false" class="nav-link <Cfoutput>#book_active#</Cfoutput>" tabindex="-1" role="tab">
                        Booking
                    </a>
                </li>

            </cfif>




        </ul>




        <div class="tab-content p-0">

            <div class="tab-pane <cfoutput>#role_showactive#</cfoutput>" id="role" role="tabpanel">

                <div class="p-3">

                    <cfinclude template="/include/aud_role_pane.cfm" />

                </div>

            </div>

            <div class="tab-pane <cfoutput>#rel_showactive#</cfoutput>" id="rel" role="tabpanel">

                <div class="p-3">

                    <cfinclude template="/include/aud_rel_pane.cfm" />

                </div>

            </div>



       <div class="tab-pane <cfoutput>#head_showactive#</cfoutput>" id="head" role="tabpanel">

                <div class="p-3">

                    <cfinclude template="/include/aud_head_pane.cfm" />

                </div>

            </div>





            <div class="tab-pane <cfoutput>#mat_showactive#</cfoutput>" id="mat" role="tabpanel">

                <div class="p-3">

                    <cfinclude template="/include/aud_mat_pane.cfm" />

                </div>

            </div>


            <div class="tab-pane <cfoutput>#notes_showactive#</cfoutput>" id="notes" role="tabpanel">

                <div class="p-3">

                    <cfinclude template="/include/aud_notes_pane.cfm" />

                </div>

            </div>


<cfif #isdefined('sdfsdfsdff')#>

            <div class="tab-pane <cfoutput>#ques_showactive#</cfoutput>" id="ques" role="tabpanel">

                <div class="p-3">

                    <cfinclude template="/include/aud_ques_pane.cfm" />

                </div>

            </div>
    
</cfif>




            <div class="tab-pane <cfoutput>#call_showactive#</cfoutput>" id="call" role="tabpanel">

                <div class="p-3">

                    <cfinclude template="/include/aud_call_pane.cfm" />

                </div>

            </div>



            <div class="tab-pane <cfoutput>#book_showactive#</cfoutput>" id="book" role="tabpanel">

                <div class="p-3">

                    <cfinclude template="/include/aud_book_pane.cfm" />

                </div>

            </div>










        </div>

                </div>



</cfif>
 <div id="RemoveBook" class="modal fade" tabindex="-1" aria-labelledby="standard-modalLabel" aria-hidden="true">

            <div class="modal-dialog">

                <div class="modal-content">

                    <div class="modal-header" style="background-color: ##f3f7f9;">

                        <h4 class="modal-title" id="standard-modalLabel">Warning</h4>

                   
                        <button type="button" class="close" data-bs-dismiss="modal" aria-hidden="true"><i class="mdi mdi-close-thick"></i>

                        </button>

                    </div>

                    <div class="modal-body">
     <p>You have to remove any booked appointments you have before you can change the booked status of this audition</p>

                    </div>

                </div>

            </div>

        </div>




<script>

document.addEventListener('DOMContentLoaded', function() {
    var bookedCheckbox = document.getElementById('new_isBooked');

    bookedCheckbox.addEventListener('click', function(event) {
        var isBooked = <cfoutput>#rolecheck.isBooked#</cfoutput>;
        var bookedCheckRecordCount = <cfoutput>#Booked_check.recordcount#</cfoutput>;

        if (isBooked === "1" && bookedCheckRecordCount !== 0 && !this.checked) {
            event.preventDefault(); // Prevent unchecking
            $('#RemoveBook').modal('show'); // Show the modal
        }
    });
});
</script>