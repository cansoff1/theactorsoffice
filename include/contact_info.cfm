<CFINCLUDE template="/include/remote_load.cfm" />

<cfinclude template="/include/qry/countries.cfm" />
<cfinclude template="/include/qry/regions.cfm" />

<cfparam name="recid" default="0" />

<cfparam name="t2" default="0" />

<cfset dbugz = "N" />

<cfparam name="t1" default="1" />

<cfparam name="t2" default="0" />

<cfparam name="t3" default="0" />

<cfparam name="t4" default="0" />

<cfif #t1# is not "0">
<Cfif t1 + t2 + t3 + t4 eq 2>
    <cfset t1 = 0 />
</Cfif>
</cfif>

<cfparam name="contact_expand" default="true" />

<cfparam name="appointments_expand" default="false" />

<cfparam name="notes_expand" default="false" />

<cfparam name="relationship_expand" default="false" />


<cfset contact_expand="false" />

<cfset appointments_expand="false" />

<cfset notes_expand="false" />

<cfset relationship_expand="false" />


<cfsavecontent variable = "varcheck"><Cfoutput>
T1: #t1#<BR>
T2: #t2#<BR>
T3: #t3#<BR>
T4: #t4#<BR>
</Cfoutput></cfsavecontent>
    
          <cfif #dbugz# is "Y">
              <cfoutput>varcheck:#varcheck#<BR></cfoutput> <cfoutput>t1:#t1#<BR></cfoutput>
    </cfif>

<cfif t1 eq 1>
      <cfif #dbugz# is "Y">
              <cfoutput>t1:#t1#<BR></cfoutput>
    </cfif>
    <cfset contact_expand = "true" />

<cfelseif t2 eq 1>
    
    <cfset appointments_expand = "true" />
    
<cfelseif t3 eq 1>
    
    <cfset notes_expand = "true" />
    
<cfelseif t4 eq 1> 
    
    <cfset relationship_expand = "true" />

</cfif>
    
    <cfif t1 + t2 + t3 + t4 eq 0><cfset t1 = 1 /></cfif>
    
    <cfsavecontent variable = "varif"><Cfoutput>
IF: if #t1# is "0" and #t2# is "0" and #t3# is "0" and #t4# is "0"<BR>
</Cfoutput></cfsavecontent>
        
    
    <cfoutput>
    <cfif #t1# is "0" and #t2# is "0" and #t3# is "0" and #t4# is "0" ><cfset contact_expand = "true" /></cfif>
    </cfoutput>
        
        <cfsavecontent variable = "varafter"><Cfoutput>
T1: #t1#<BR>
T2: #t2#<BR>
T3: #t3#<BR>
T4: #t4#<BR>
</Cfoutput></cfsavecontent>
    
      <cfif #dbugz# is "Y">
            <Cfoutput> varif:#varif#<BR>varafter:#varafter#
             <p>notes_expand: #notes_expand#</p>
          <p>contact_expand: #contact_expand#</p></Cfoutput>
 
            </cfif>      


<cfset script_name_include="/include/#ListLast(GetCurrentTemplatePath(), "\")#" /><cfinclude template="/include/bigbrotherinclude.cfm" /> 
 
          
          <cfif #devicetype# is "mobile">
<cfif #t2# is "1">

<Cflocation url="/app/contact/?contactid=#contactid#&new_pgid=119" />
    
</cfif>

<cfparam name="t3" default="0" />

<cfif #t3# is "1">

<Cflocation url="/app/contact/?contactid=#contactid#&new_pgid=118" />
    
</cfif>

<cfparam name="t4" default="0" />

<cfif #t4# is "1">

<Cflocation url="/app/contact/?contactid=#contactid#&new_pgid=120" />
    
</cfif>
</cfif>

<cfparam name="dbug" default="N" />

<cfparam name="newendlink" default="" />

<cfparam name="contact_expand" default="true" />

<cfparam name="emaillink" default="unknown" />

<cfparam name="newactionlinkURL" default="" />

<cfparam name="updatenoteid" default="0" />

<cfparam name="pgtype" default="add" />

<cfparam name="ctaction" default="view" />

<cfparam name="pfaction" default="view" />

<cfparam name="status_active" default="Y" />

<cfparam name="status_completed" default="N" />

<cfparam name="status_future" default="N" />

<cfset currentid=contactid />

<cfset session.currentpage="/app/contact/?contactid=#currentid#" />

<cfif isdefined('cookie.status_active')>

    <cfset status_active=cookie.status_active />

</cfif>

<cfif isdefined('cookie.status_completed')>

    <cfset status_completed=cookie.status_completed />

</cfif>

<cfif isdefined('cookie.status_future')>

    <cfset status_future=cookie.status_future />

</cfif>

<cfset rpgid=36 />



<cfinclude template="/include/modalRemoteNewForm.cfm" />

<cfinclude template="/include/qry/contacts.cfm" />

<cfinclude template="/include/qry/categories.cfm" />

<cfinclude template="/include/qry/items.cfm" />

<cfinclude template="/include/qry/notesContact.cfm" />

<cfinclude template="/include/qry/SystemsContact.cfm" />

<cfinclude template="/include/qry/tagsContact.cfm" />

<cfinclude template="/include/qry/profiles.cfm" />

<cfinclude template="/include/qry/actinglinks.cfm" />

<cfinclude template="/include/qry/sysactive.cfm" />

<cfinclude template="/include/qry/notsall.cfm" />

<cfinclude template="/include/qry/events.cfm" />

<cfinclude template="/include/qry/systemNotificationsActive.cfm" />

<cfinclude template="/include/qry/SystemsActiveContact.cfm" />

<cfinclude template="/include/qry/ru.cfm" />

<cfinclude template="/include/qry/emailcheck.cfm" />

<cfinclude template="/include/qry/phonecheck.cfm" />

<cfinclude template="/include/qry/rels.cfm" />

<cfinclude template="/include/qry/ActiveCategories.cfm" />
          
<cfinclude template="/include/qry/findcompany.cfm" />

<cfif #details.contactphoto# is not "">

    <cfset browser_contact_avatar_filename=details.contactphoto />

</cfif>


            
   
   
        
        
        <cfparam name="status_active_check" default="" />

<cfparam name="status_completed_check" default="" />

<cfparam name="status_future_check" default="" />

<cfparam name="relationship_expand_check" default="" />

<cfif #status_active# is "Y">

    <cfset status_active_check="checked" />

</cfif>

<cfif #status_completed# is "Y">

    <cfset status_completed_check="checked" />

</cfif>

<cfif #status_future# is "Y">

    <cfset status_future_check="checked" />


</cfif>

<cfif #relationship_expand# is "true">

    <cfset relationship_expand_check="show active" />
</cfif>
        
        
        
        
    
    
    


<script>
    $(document).ready(function() {
        $("#remoteUpdateSUID0").on("show.bs.modal", function(event) {
            // Place the returned HTML into the selected element
            $(this).find(".modal-body").load("<cfoutput>/include/remoteUpdateSUID.cfm?suid=0&contactid=#currentid#</cfoutput>");
        });
    });
</script>

<div id="remoteUpdateSUID0" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true">

    <div class="modal-dialog">

        <div class="modal-content">

            <div class="modal-header">

                <h4 class="modal-title">

                    <cfoutput>Relationship System</cfoutput>

                </h4>

                <button type="button" class="close" data-bs-dismiss="modal" aria-hidden="true"><i class="mdi mdi-close-thick"></i></button>

            </div>

            <div class="modal-body">

            </div>

        </div>

    </div>

</div>
<cfloop query="ru">

    <script>
        $(document).ready(function() {
            $("#remoteUpdate<cfoutput>SUID#ru.suid#</cfoutput>").on("show.bs.modal", function(event) {
                // Place the returned HTML into the selected element
                $(this).find(".modal-body").load("<cfoutput>/include/remoteUpdateSUID.cfm?suid=#ru.suid#&contactid=#currentid#</cfoutput>");
            });
        });
    </script>

    <div id="remoteUpdate<cfoutput>SUID#ru.suid#</cfoutput>" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true">

        <div class="modal-dialog">

            <div class="modal-content">

                <div class="modal-header">

                    <h4 class="modal-title">Update <cfoutput>Relationship System</cfoutput>

                    </h4>

                    <button type="button" class="close" data-bs-dismiss="modal" aria-hidden="true"><i class="mdi mdi-close-thick"></i></button>

                </div>

                <div class="modal-body">

                </div>

            </div>

        </div>

    </div>

</cfloop>


<cfquery datasource="#dsn#" name="cu">
    SELECT i.itemid, c.catid, c.valuecategory FROM contactitems i INNER JOIN itemcategory c ON c.valuecategory = i.valuecategory WHERE contactid = #currentid#
</cfquery>

<cfloop query="cu">

    <script>
        $(document).ready(function() {
            $("#remoteUpdate<cfoutput>C#cu.itemid#</cfoutput>").on("show.bs.modal", function(event) {
                // Place the returned HTML into the selected element
                $(this).find(".modal-body").load("<cfoutput>/include/remoteUpdateC.cfm?itemid=#cu.itemid#</cfoutput>");
            });
        });
    </script>

    <div id="remoteUpdate<cfoutput>C#cu.itemid#</cfoutput>" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true">

        <div class="modal-dialog">

            <div class="modal-content">

                <div class="modal-header">

                    <h4 class="modal-title">

                        Update <cfoutput>#cu.valueCategory# Form</cfoutput>

                    </h4>

                    <button type="button" class="close" data-bs-dismiss="modal" aria-hidden="true">

                        <i class="mdi mdi-close-thick"></i>

                    </button>

                </div>

                <div class="modal-body">

                </div>

            </div>

        </div>

    </div>

</cfloop>

<cfloop query="sysactive">

    <cfoutput>

        <div id="action#sysactive.suid#-modal" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true">

            <div class="modal-dialog">

                <div class="modal-content">

                    <div class="modal-header">

                        <h4 class="modal-title">#sysactive.recordname#</h4>

                        <button type="button" class="close" data-bs-dismiss="modal" aria-hidden="true">x</button>

                    </div>

                    <div class="modal-body">

                        <h5>Description</h5>

                        <p>#sysactive.systemdescript#</p>

                        <p><strong>Start Date:</strong> #dateformat(sysactive.sustartdate)#</p>

                        <cfif #sysactive.suenddate# is not "">

                            <p><strong>Completed:</strong> #dateformat(sysactive.suenddate)#</p>

                        </cfif>

                    </div>

                </div>

            </div>

        </div>

        <script>
            $(document).ready(function() {
                $("##remoteDeleteForm#sysActive.suid#").on("show.bs.modal", function(event) {
                    // Place the returned HTML into the selected element
                    $(this).find(".modal-body").load("/include/remoteDeleteForm.cfm?recid=#sysActive.suid#&rpgid=40&pgaction=update&contactid=#currentid#&pgdir=contact&t4=1");
                });
            });
        </script>

        <div id="remoteDeleteForm#sysActive.suid#" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true">

            <div class="modal-dialog">

                <div class="modal-content">

                    <div class="modal-header" style="background-color: red;">

                        <h4 class="modal-title">Follow Up System</h4>

                        <button type="button" class="close" data-bs-dismiss="modal" aria-hidden="true"><i class="mdi mdi-close-thick"></i></button>

                    </div>

                    <div class="modal-body"></div>

                </div>

            </div>

        </div>

    </cfoutput>

</cfloop>


<cfquery datasource="#dsn#" name="c">
    SELECT * FROM itemcategory
</cfquery>

<cfloop query="c">

<cfif #catid# is "2">


<script>
$(document).ready(function(){
    // Function to populate the states based on selected country
    function populateRegions(countryid) {
        var regionSelect = $('#regionid');
        regionSelect.empty();
        regionSelect.append('<option value="">--</option>');
        $.each(regions, function(index, region) {
            if(region.countryid == countryid) {
                regionSelect.append('<option value="' + region.regionid + '">' + region.regionname + '</option>');
            }
        });
    }

    // Event listener for country select change
    $(document).on('change', '#countryid', function() {
        var selectedCountryId = $(this).val();
        populateRegions(selectedCountryId);
    });

    // Initialize the regions based on the pre-selected country if any
    var initialCountryId = $('#countryid').val();
    if(initialCountryId) {
        populateRegions(initialCountryId);
    }
});

// Load remoteAddName modal content
$(document).ready(function() {
    $("#remoteAddName").on("show.bs.modal", function(event) {
        var modal = $(this);
        modal.find(".modal-body").load("/include/remoteAddName.cfm", function() {
            // Store the regions data in a variable
            var regions = [
                <cfoutput query="regions">
                {countryid: '#regions.countryid#', regionid: '#regions.regionid#', regionname: '#regions.regionname#'}<cfif regions.currentRow neq regions.recordCount>,</cfif>
                </cfoutput>
            ];

            // Initialize the regions based on the pre-selected country if any
            var initialCountryId = $('#countryid').val();
            if(initialCountryId) {
                populateRegions(initialCountryId);
            }
        });
    });
});
</script>





    <script>
    $(document).ready(function() {
         $("#remoteAdd<cfoutput>C#c.catid#</cfoutput>").on("show.bs.modal", function(event) {
            // Load the content into the modal body
            $(this).find(".modal-body").load("<cfoutput>/include/remoteAddC.cfm?catid=#c.catid#&userid=#session.userid#&contactid=#currentid#</cfoutput>", function() {
                // After loading content, initialize the chained selects

               
            });
        });
    });
</script>

</cfif>



    <div id="remoteAdd<cfoutput>C#c.catid#</cfoutput>" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true">

        <div class="modal-dialog">

            <div class="modal-content">

                <div class="modal-header">

                    <h4 class="modal-title">New <cfoutput>#c.valueCategory# Form</cfoutput>

                    </h4>

                    <button type="button" class="close" data-bs-dismiss="modal" aria-hidden="true"><i class="mdi mdi-close-thick"></i></button>

                </div>

                <div class="modal-body">

                </div>

            </div>

        </div>

    </div>

</cfloop>


<script>
    $(document).ready(function() {
        $("#remoteUpdateTag").on("show.bs.modal", function(event) {
            // Place the returned HTML into the selected element
            $(this).find(".modal-body").load("<cfoutput>/include/remoteUpdateTag.cfm?contactid=#currentid#</cfoutput>");
        });
    });
</script>

<div id="remoteUpdateTag" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true">

    <div class="modal-dialog">

        <div class="modal-content">

            <div class="modal-header">

                <h4 class="modal-title">Update Tags</h4>

                <button type="button" class="close" data-bs-dismiss="modal" aria-hidden="true"><i class="mdi mdi-close-thick"></i></button>

            </div>

            <div class="modal-body">

            </div>

        </div>

    </div>

</div>


<script>
    $(document).ready(function() {
        $("#remoteNewForm").on("show.bs.modal", function(event) {
            // Place the returned HTML into the selected element
            $(this).find(".modal-body").load("<cfoutput>/include/RemoteNewForm.cfm?rpgid=36&pgid=3&t2=1&pgdir=#pgdir#&contactid=#contactid#</cfoutput>");
        });
    });
</script>


<div id="showmaint" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true">

    <div class="modal-dialog modal-sm">

        <div class="modal-content modal-filled bg-success">

            <div class="modal-body p-4">

                <div class="text-center">

                    <i class="dripicons-checkmark h1 text-white"></i>

                    <h4 class="mt-2 text-white">Follow-up System Completed!</h4>

                    <p class="mt-3 text-white">

                        <cfoutput>#details.recordname#</cfoutput> has been automatically placed into a maintenance list system.

                    </p>

                    <button type="button" class="btn btn-light my-2" data-bs-dismiss="modal">Continue</button>

                </div>

            </div>

        </div>

    </div>

</div>

<script>
    $(document).ready(function() {
        $("#remoteUploadForm").on("show.bs.modal", function(event) {
            // Place the returned HTML into the selected element
            $(this).find(".modal-body").load("/include/remoteUploadForm.cfm");
        });
    });

</script>

<Cfoutput>
          <script>
                        $(document).ready(function() {
                            $("##remoteDeleteForm#currentid#").on("show.bs.modal", function(event) {
                                // Place the returned HTML into the selected element
                                $(this).find(".modal-body").load("/include/remoteDeleteForm.cfm?recid=#currentid#&rpgid=#pgid#&pgaction=update&pgdir=#pgdir#");
                            });
                        });
                    </script>
    

    <div id="remoteDeleteForm#currentid#" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true">

        <div class="modal-dialog">

            <div class="modal-content">

                <div class="modal-header" style="background-color: red;">

                    <h4 class="modal-title">#compname#</h4>

                    <button type="button" class="close" data-bs-dismiss="modal" aria-hidden="true"><i class="mdi mdi-close-thick"></i></button>

                </div>

                <div class="modal-body">

                </div>

            </div>

        </div>

    </div>

</Cfoutput>



<script>
    $(document).ready(function() {
        $("#remoteUpdateName").on("show.bs.modal", function(event) {
            // Place the returned HTML into the selected element
            $(this).find(".modal-body").load("<cfoutput>/include/remoteUpdateName.cfm?contactid=#currentid#&userid=#session.userid#</cfoutput>");
        });
    });

</script>

<div id="remoteUpdateName" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true">

    <div class="modal-dialog">

        <div class="modal-content">

            <div class="modal-header">

                <h4 class="modal-title">Contact Details</h4>

                <button type="button" class="close" data-bs-dismiss="modal" aria-hidden="true"><i class="mdi mdi-close-thick"></i></button>

            </div>

            <div class="modal-body">

            </div>

        </div>

    </div>

</div>


<cfloop query="sysactive">

    <cfinclude template="/include/qry/notsActive.cfm" />

    <cfloop query="notsactive">

        <cfoutput>

            <div id="action#notsActive.actionid#-modal" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true">

                <div class="modal-dialog">

                    <div class="modal-content">

                        <div class="modal-header">

                            <h4 class="modal-title">#notsActive.actiontitle#</h4>

                            <button type="button" class="close" data-bs-dismiss="modal" aria-hidden="true">x</button>

                        </div>

                        <div class="modal-body">

                            <h5>#notsActive.actiondetails#</h5>

                            <p>#notsActive.actionInfo#</p>

                            <cfif #notsActive.actionLinkID# is "2">

                                <cfset newactionlinkURL="mailto:#emaillink#" />

                                <cfif #emailcheck.recordcount# is "1">

                                    <cfset emaillink="#emailcheck.email#" />

                                </cfif>

                            </cfif>

                            <cfif #notsActive.actionLinkID# is "6">

                                <cfset newendlink="#details.contactfullname#" />

                                <cfset newactionlinkURL="#notsactive.ActionLinkURL##newendlink#+acting" />

                            </cfif>

                            <cfif #notsActive.actionLinkID# is not "6" and #notsActive.actionLinkID# is not "2" and #notsActive.actionLinkID# is not "0">

                                <cfset newendlink="#notsactive.endlink#" />

                                <cfset newactionlinkURL="#notsactive.ActionLinkURL#?contactid=#currentid##newendlink#" />

                            </cfif>

                            <p>
                                <center>

                                    <a href="#newActionLinkURL#" target="#notsactive.targetlink#" class="btn btn-xs btn-primary" style="background-color: ##406e8e; border: ##406e8e;">#notsactive.BtnName#</a>

                                </center>

                            </p>

                        </div>

                    </div>

                </div>

            </div>
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
                   <div id="actionconfirm#notsActive.actionid#-modal" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true">

                <div class="modal-dialog">

                    <div class="modal-content">

                        <div class="modal-header">

                            <h4 class="modal-title">#notsActive.actiontitle# Completed</h4>

                            <button type="button" class="close" data-bs-dismiss="modal" aria-hidden="true">x</button>

                        </div>

                        <div class="modal-body">

                        <center>   <h5>Looks like you completed this reminder. Congratulations!</h5></center> 
<p>&nbsp;</p>
                       <center>   <h5>Click confirm and we'll close it out and add the next reminder</h5></center> 
<p>&nbsp;</p>
                            <p>
                                <center>

                                    <a href="/include/complete_not.cfm?contactid=#currentid#&systemid=#notsActive.systemID#&userid=#userid#&actionid=#actionid#&status_active=#status_active#&status_completed=#status_completed#&status_future=#status_future#&notid=#notsactive.notid#"   class="btn btn-xs btn-primary" style="background-color: ##406e8e; border: ##406e8e;">Confirm</a>

                                </center>

                            </p>

                        </div>

                    </div>

                </div>

            </div>

        </cfoutput>

    </cfloop>

</cfloop>



<div class="row" style="width:100%;
  margin:0;
  padding:0;
  display:flex;">

    <div class="col-md-6 col-sm-6 col-xs-12">

        <div class="card h-100" >

            <cfset tool_button = "btn-xl text-secondary px-1" />
            
            <cfoutput>
                                        <script>
                                $(document).ready(function() {
                                    $("##remoteDeleteForm#recid#").on("show.bs.modal", function(event) {
                                        // Place the returned HTML into the selected element
                                        $(this).find(".modal-body").load("/include/remoteDeleteForm.cfm?recid=#contactid#&rpgid=#3#&pgaction=update&pgdir=#pgdir#");
                                    });
                                });

                            </script>
            
            </cfoutput>

       
                <h4 class="card-card-header text-center text-white text-nowrap py-0" style="background-color: #406E8E;margin:0!important;padding:15px!important;" >
                    <cfoutput>#details.fullname#</cfoutput>
                </h4>
                <div class="py-1 px-3 flex text-center font-22">
                            

                        <cfif #emailcheck.recordcount# is "1">

                            <cfoutput>

                                <Cfset email="#emailcheck.email#" />

                                <a href="mailto:#email#" class="<cfoutput>#tool_button#</cfoutput>" data-bs- data-bs-placement="top" title="" data-bs-original-title="Email">

                                    <i class="fe-mail"></i>

                                </a>

                            </cfoutput>

                        </cfif>

                        <cfif #phonecheck.recordcount# is "1">

                            <Cfset phonenumber=phonecheck.phonenumber />

                            <cfinclude template="/include/formatPhoneNumber.cfm" />

                            <cfoutput>

                                <a href="tel:#anchorPhoneNumber#" class="<cfoutput>#tool_button#</cfoutput>" data-bs- data-bs-placement="top" title="" data-bs-original-title="Voice Call">

                                    <i class="fe-phone-call"></i>

                                </a>

                            </cfoutput>

                        </cfif>

                        <a href="/app/appoint-add/?returnurl=contact&rcontactid=<cfoutput>#currentid#</cfoutput>" class="<cfoutput>#tool_button#</cfoutput>" title="Add" data-bs-original-title="Add Appointment">

                            <i class="fe-calendar"></i>

                        </a>
                    
                    
              
                
                </div>
                
                




                
                
 
            <div class="card-body">

                
                    <p class="card-text">

<cfoutput> 
<cfset contact_avatar_filename = "C:\home\theactorsoffice.com\media-#host#\users\#userid#\contacts\#currentid#\avatar.jpg" />

                        </cfoutput>

                        <A href="/app/image-upload-contact/?contactid=<cfoutput>#contactid#&ref_pgid=3</cfoutput>">

                            <figure>

                                <cfif  isimagefile(contact_avatar_filename)>

                                    <centeR><img src="<Cfoutput>#browser_contact_avatar_filename#</cfoutput>?ver=<Cfoutput>#rand()#</cfoutput>" class="mr-3 rounded-circle gambar img-responsive img-thumbnail" style="max-width:180px;width:100%" alt="profile-image" id="item-img-output" />      </centeR>
                                    <CFELSE>
                                        <center><img src="/media-<Cfoutput>#host#</cfoutput>/defaults/avatar.jpg" class="mr-3 rounded-circle gambar img-responsive img-thumbnail" style="max-width:120px;width:100%;" alt="profile-image" id="item-img-output" /></center>
                                </CFIF>




                            </figure>

                        </A>
<cfloop query="findcompany">
<cfoutput><center>#valueCompany#</center></cfoutput>
</cfloop>
                
          

            </div>
        </div>

    </div>


    <cfoutput>

        <cfset fileExist="#FileExists(browser_contact_avatar_filename)#" />

        <Cfset recid=#currentid# />

        <cfset h5style="font-size:0.875rem;font-weight: 500;text-align:left;margin-bottom:0;" />

    </cfoutput>

    <div class="col-md-6 col-sm-6 col-xs-12">

        <div class="card h-100">

      <h4 class="card-card-header text-center text-white text-nowrap py-0" style="background-color: #406E8E;margin:0!important;padding:15px!important;" >
                   Relationship Info
                </h4>
            
            
            
            
            <cfoutput>
                         <h4 class="px-3 d-flex text-nowrap">

                 

                           <span class="ms-auto">

                          <a href="javascript:;" data-bs-remote="true" data-bs-toggle="modal" data-bs-target="##remoteUpdateName" data-bs-placement="top" title="Update Contact" data-bs-original-title="Update Contact"> <i class="mdi mdi-square-edit-outline"></i> </a>

                           </span>

                       </h4>
            
            
            </cfoutput>
            
            
            
            
            <cfif #isdefined('dsfdsf')#>
            
                <div class="py-1 px-3 flex font-22">
                            

            
                    
                        <cfoutput>
                            
                            
                            
                                  <a href="javascript:;" data-bs-remote="true" data-bs-toggle="modal" data-bs-target="##remoteUpdateName" data-bs-placement="top" title="Update Contact" data-bs-original-title="Update Contact">
                                      
                                      <i class="mdi mdi-square-edit-outline"></i>
                                      
                            </a>



                            <a class="#tool_button#" href="javascript:;" data-bs-toggle="modal" data-bs-target="##remoteDeleteForm#contactid#" title="Delete Relationship">

                                <i class="fe-trash-2"></i>
 
                            </a>

                        </cfoutput>
                
                </div>
                
            
            
            
            
            </cfif>
            
            
            
            
            
            
            
            
            
            

            <div class="card-body">

          



                <p class="mt-1 mb-0 py-1 text-muted font-14">

                    <cfloop query="tagscontact">

                        <cfoutput>

                            <a href="javascript:;" data-bs-remote="true" data-bs-toggle="modal" data-bs-target="##remoteUpdateTag" data-bs-placement="top" title="Update Tag" data-bs-original-title="Update Tag">#tagscontact.valuetext#</a>

                        </cfoutput>

                    </cfloop>
             
                    <cfif #tagscontact.recordcount# is "0">

                        <a href="javascript:;" data-bs-remote="true" data-bs-toggle="modal" data-bs-target="#remoteUpdateTag" data-bs-placement="top" title="Update Tag" data-bs-original-title="Update Tag">Add a Tag</a>

                    </cfif>

                    <cfif #tagscontact.recordcount# is not "0">

                        <a href="javascript:;" data-bs-remote="true" data-bs-toggle="modal" data-bs-target="#remoteUpdateTag" data-bs-placement="bottom" title="Update Tag" data-bs-original-title="Update Tag"><small><i class="fe-plus-circle"></i></small></a>

                    </cfif>

                </p>




                     
     <p class="mt-1 mb-0 text-muted py-1 font-14">
                            <cfoutput><strong>Gender Pronoun:</strong>    <cfif #details.contactpronoun# is not "">#details.contactpronoun#  </cfif></cfoutput>
                            </p>
                      



                <p class="mt-1 mb-0 text-muted py-1 font-14">  


                    <cfoutput> 
                        <strong>Birthday:</strong>

                        <a href="javascript:;" data-bs-remote="true" data-bs-toggle="modal" data-bs-target="##remoteUpdateName" data-bs-placement="top" title="Update Contact" data-bs-original-title="Update Contact">

                            <cfif #details.contactBirthday# is not "">

                                #month(details.contactbirthday)#/#day(details.contactbirthday)#

                            </cfif>

                            <cfif #details.contactBirthday# is "">

                                Add Birthday

                            </cfif>

                        </a>
                    </cfoutput>
                </p>


        

                    <cfset meetingdate="#dateformat('#details.contactmeetingdate#','short')#" />

                    <p class="mt-1 mb-0 text-muted py-1 font-14">
                        <cfoutput>

                            <strong>Initial Meeting:</strong>

                            <a href="javascript:;" data-bs-remote="true" data-bs-toggle="modal" data-bs-target="##remoteUpdateName" data-bs-placement="top" title="Update Contact" data-bs-original-title="Update Contact">#meetingdate#</a>

                            <cfif #details.contactmeetingloc# is not "">

                                <a href="javascript:;" data-bs-remote="true" data-bs-toggle="modal" data-bs-target="##remoteUpdateName" data-bs-placement="top" title="Update Contact" data-bs-original-title="Update Contact">(#details.contactmeetingloc#)</a>

                            </cfif>
                        </cfoutput>
                    </p>

         


 

                  

                        <p class="mt-1 mb-0 text-muted py-1 font-14">

                            <strong>Referred By:</strong> <cfif #details.refer_contact_id# is not "">  <cfif #refer_details.recordcount# is "1"><cfoutput>#refer_details.fullName#</cfoutput>  </cfif></cfif>
                        </p>

                  

           


              










                    <cfif #details.newsletter_yn# is "Y" or #details.googlealert_yn# is "Y" or #details.socialmedia_yn# is "Y">

                        <p class="mt-1 mb-0 text-muted py-1  font-14">

                            <cfif #details.newsletter_yn# is "Y">

                                <span class="badge badge-outline-blue rounded-pill"> &#10004; Newsletter</span>

                            </cfif>

                            <cfif #details.googlealert_yn# is "Y">

                                <span class="badge badge-outline-blue rounded-pill"> &#10004; Google Alert</span>

                            </cfif>

                            <cfif #details.socialmedia_yn# is "Y">

                                <span class="badge badge-outline-blue rounded-pill"> &#10004; Followed - Social Media</span>

                            </cfif>

                        </p>

                    </cfif>

                    <cfif #profiles.recordcount# is not "0">

                        <p class="mt-1 mb-0 text-muted font-18">

                            <cfloop query="profiles">

                                <cfoutput>

                                    <a href="#profiles.valuetext#" class="text-white font-14 py-1 ps-o me-2   d-inline-block" data-bs- data-bs-placement="top" title="" target="#profiles.valuetext#" data-bs-original-title="#profiles.valuetype#">
<cfif #profiles.typeicon# is "">
                   <img src="/app/assets/images/retina-circular-icons/14/customlink.png" title="#profiles.valuetext#"  width="32px" />                           
                                        
    
    <cfelse>
          <img src="/app/assets/images/retina-circular-icons/14/#profiles.typeicon#" title="#profiles.valuetext#"  width="32px" />
                                        
                                        </cfif>
                                  

                                    </a>

                                </Cfoutput>

                            </cfloop>

                        </p>

                    </cfif>


                    



<cfloop query="inactivecategories">
 
    <cfif #catid# is "0">

                  <div class="flexit">

                      <div class="contact-info-section" style="margin-top: 35px;position: relative;padding-left: 50px;">

                          <cfoutput>

                              <cfif #rels.recordcount# is not "0">

                                  <i class="fe-users font-26" style="position: absolute;left: 0;top: 0;"></i>

                              </cfif>
                              <!--- end if rels.recordcount is not 0 --->

                              <cfif #rels.recordcount# is "0">

                                  <i class="fe-users text-muted font-weight-lighter font-26" style="position: absolute;left: 0;top: 0;"></i>

                              </cfif>
                              <!--- end if rels.recordcount is 0 --->

                          </cfoutput>

                          <cfoutput query="rels">

                              <h5 style="#h5style#">

                                  <a href="javascript:;" data-bs-remote="true" data-bs-toggle="modal" data-bs-target="##remoteUpdateSUID#rels.suid#" data-bs-placement="top" title="Relationship System" data-bs-original-title="Relationship System">#rels.SystemType#


                                  </a>

                              </h5>

                              <div class="font-13 text-uppercase mb-1" style="text-align:left;">

                                  #rels.systemscope#

                              </div>

                          </cfoutput>

                          <cfif #rels.recordcount# is "0">



                              <h5 class="text-muted font-weight-lighter">

                                  <a href="javascript:;" data-bs-remote="true" data-bs-toggle="modal" data-bs-target="#remoteUpdateSUID0" data-bs-placement="top" title="Relationship" data-bs-original-title="Relationship ">Add Relationship System

                                  </a>

                              </h5>

                              <div class="font-13 text-uppercase mb-1" style="text-align:left;">

                                  None

                              </div>





                          </cfif>
                          <!--- end if rels.recordcount is 0 --->

                      </div>

                  </div>

              </cfif>

</cfloop>



            </div>
        </div>

    </div>

</div>
<p>&nbsp;</p>
 


<cfif #devicetype# is "mobile">

    <div class="card">

        <div class="btn-group py-0 col-md-12">

            <button type="button" class="btn btn-primary btn-lg dropdown-toggle" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">

                <Cfoutput>#pgname#</Cfoutput>
                <i class="fe-menu"></i>

            </button>
            <div class="dropdown-menu">

                <cfloop query="FindOptions">
                    <cfoutput>
                        <a class="dropdown-item" href="/app/#pgDir#/?contactid=#contactid#&new_pgid=#FindOptions.pgid#">#FindOptions.pgname#</a>
                    </cfoutput>
                </cfloop>

            </div>
        </div><!-- /btn-group -->




        <div class="card-body">

            <cfif #pgid# is "117">
                <cfinclude template="/include/contact_pane.cfm" />
            </cfif>

            <cfif #pgid# is "118">
                <cfinclude template="/include/notes_relationship_pane.cfm" />
            </cfif>

            <cfif #pgid# is "119">
                <cfinclude template="/include/appointments_pane.cfm" />
            </cfif>

            <cfif #pgid# is "120">
                <cfinclude template="/include/reminder_pane.cfm" />
            </cfif>

        </div>
    </div>

 
<cfelse>
            
                
                
                
                
                
                
                
                
                      
                
                
                
                
                
                
                
                
           
            
        <cfif #contact_expand# is "true">
        
            <cfset contact_active = "show active" />
            
        </cfif>
            
            
        <cfif #contact_expand# is not "true">
        
            <cfset contact_active = "" />
            
        </cfif>
            
        <cfif #appointments_expand# is "true">
        
            <cfset appointments_active = "show active" />
            
        </cfif>
            
            
        <cfif #appointments_expand# is not "true">
        
            <cfset appointments_active = "" />
            
        </cfif>
            
        <cfif #notes_expand# is "true">
        
            <cfset notes_active = "show active" />
            
        </cfif>
            
            
        <cfif #notes_expand# is not "true">
        
            <cfset notes_active = "" />
            
        </cfif>
                
                
                
                

        
        
        <cfparam name="status_active_check" default="" />

<cfparam name="status_completed_check" default="" />

<cfparam name="status_future_check" default="" />

<cfparam name="relationship_expand_check" default="" />

<cfif #status_active# is "Y">

    <cfset status_active_check="checked" />

</cfif>

<cfif #status_completed# is "Y">

    <cfset status_completed_check="checked" />

</cfif>

<cfif #status_future# is "Y">

    <cfset status_future_check="checked" />


</cfif>


        
        
        <div class="card">
    
        <div class="card-body">
     <ul class="nav nav-pills navtab-bg nav-justified p-1" role="tablist">
      <li class="nav-item">

                <a href="#contact" data-bs-toggle="tab" aria-expanded="false" class="nav-link<cfif #contact_expand# is 'true'> active</cfif>">Contact details</a>

            </li>

            <li class="nav-item">

                <a href="#notes" data-bs-toggle="tab" aria-expanded="<cfoutput>#notes_expand#</cfoutput>" class="nav-link<cfif #notes_expand# is "true"> active</cfif>">Notes

                    <cfif notesContact.recordcount neq 0>

                        <span class="badge  badge-primary badge-pill">

                            <cfoutput>(#numberformat(notesContact.recordcount)#)</cfoutput>

                        </span>

                    </cfif>

                </a>

            </li>

            <li class="nav-item">

                <a href="#appointments" data-bs-toggle="tab" aria-expanded="<cfoutput>#appointments_expand#</cfoutput>" class="nav-link<cfif #appointments_expand# is 'true'> active</cfif>">Appointments

                    <cfif eventresults.recordcount neq 0>

                        <span class="badge  badge-primary badge-pill">

                            <cfoutput>(#numberformat(eventresults.recordcount)#)</cfoutput>

                        </span>

                    </cfif>

                </a>

            </li>

            <li class="nav-item">

                    <a href="#relationship" data-bs-toggle="tab" aria-expanded="<cfoutput>#relationship_expand#</cfoutput>" class="nav-link<cfif #relationship_expand# is 'true'> active</cfif>">Relationship reminders</a>

                </li>
    </ul>
    
    
                   <div class="tab-content">
            
            
            <div class="tab-pane <Cfoutput>#contact_active#</cfoutput>" id="contact">
              <cfinclude template="/include/contact_pane.cfm" />
                
            </div>
            
            <div class="tab-pane<cfif #notes_expand# is "true"> show active</cfif>" id="notes">
                <cfinclude template="/include/notes_relationship_pane.cfm" />
                
            </div>
            
            <div class="tab-pane <Cfoutput>#appointments_active#</cfoutput>" id="appointments">
                  <cfinclude template="/include/appointments_pane.cfm" />
                
            </div>
            
            <div class="tab-pane <Cfoutput>#relationship_expand_check#</cfoutput>" id="relationship">
                <cfinclude template="/include/reminder_pane.cfm" />
                
            </div>
            
            
        </div>
    
    </div>
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    </div>
    
    
    
</cfif>





<cfset script_name_include="/include/#ListLast(GetCurrentTemplatePath(), " \")#" />




<cfinclude template="/include/bigbrotherinclude.cfm" />
