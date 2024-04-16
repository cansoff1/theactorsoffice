<CFINCLUDE template="/include/remote_load.cfm"  />sssss<cfabort>
<script>
    $(document).ready(function() {
        $("#dashboardupdate").on("show.bs.modal", function(event) {
            // Place the returned HTML into the selected element
            $(this).find(".modal-body").load("<cfoutput>/include/dashboardupdate.cfm?userid=#userid#</cfoutput>");
        });
    });
</script> 
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
                        <button type="button" class="close" data-bs-dismiss="modal" aria-hidden="true"><i class="mdi mdi-close-thick"></i></button>
                    </div>
                    <div class="modal-body">
                    </div>
                </div>
            </div>
        </div>

    </cfoutput>
</cfloop>
















<cfset catArea_UCB="U" />

<cfset showbuttons="false" />



<cfinclude template="/include/qry/myteam.cfm" />
<cfinclude template="/include/qry/dashboard.cfm" />

    <cfparam name="tab1_expand" default="false" />
    <cfparam name="tab2_expand" default="false" />
    <cfparam name="tab3_expand" default="false" />
    <cfparam name="tab4_expand" default="false" />
    <cfparam name="tab5_expand" default="false" />
    <cfparam name="tab6_expand" default="false" />
<cfparam name="tab7_expand" default="false" />

<cfset h5style="font-size:0.875rem;font-weight: 500;text-align:left;margin-bottom:0;" />

<div class="card">

    <div class="card-body py-2 px-3 border-bottom border-light">

        <div class="media py-1">
            <A href="/app/image-upload/?ref_pgid=7">
                <figure>
                    <Center><img src="<Cfoutput>#browser_user_avatar_filename#</cfoutput>?ver=<Cfoutput>#rand()#</cfoutput>" class="mr-2 rounded-circle gambar img-responsive img-thumbnail" title="User ID: <cfoutput>#userid#</cfoutput>" style="height:60px;" alt="profile-image" id="item-img-output" />
                        <figcaption style="margin-left:-10px;"><i class="fa fa-camera"></i></figcaption>
                    </Center>

                </figure>
            </A>

            <cfoutput>
                <div class="media-body">
                    <h4 class="mt-0 mb-0">
                        <a href="" class="text-reset">#userFirstName# #userLastName#</a>
                    </h4>
                    <cfset contactid="#userContactid#" />
                    <cfinclude template="/include/qry/profiles.cfm" />
                    <cfinclude template="/include/qry/actinglinks.cfm" />
            </cfoutput>

        </div>

    </div>


    <div class="card-body">

        <ul class="nav nav-tabs">
            <cfoutput>

                <li class="nav-item"> <a href="##profile" data-bs-toggle="tab" aria-expanded="#tab1_expand#" class="nav-link<cfif #tab1_expand# is 'true'> active</cfif>">My Links   </a>
                </li>




                <li class="nav-item"> <a href="##myteam" data-bs-toggle="tab" aria-expanded="#tab2_expand#" class="nav-link<cfif #tab2_expand# is 'true'> active</cfif>">My Team</a>
                </li>

                <li class="nav-item"> <a href="##security" data-bs-toggle="tab" aria-expanded="#tab3_expand#" class="nav-link<cfif #tab3_expand# is 'true'> active</cfif>">Security</a>
                </li>


                <li class="nav-item"> <a href="##preferences" data-bs-toggle="tab" aria-expanded="#tab4_expand#" class="nav-link<cfif #tab4_expand# is 'true'> active</cfif>">Preferences</a>
                </li>
                
                  <li class="nav-item"> <a href="##systems" data-bs-toggle="tab" aria-expanded="#tab7_expand#" class="nav-link<cfif #tab7_expand# is 'true'> active</cfif>">Systems</a>
                </li>

                <li class="nav-item"> <a href="##subscription" data-bs-toggle="tab" aria-expanded="#tab5_expand#" class="nav-link<cfif #tab5_expand# is 'true'> active</cfif>">Billing</a>
                </li>

                <li class="nav-item"> <a href="##integrations" data-bs-toggle="tab" aria-expanded="#tab6_expand#" class="nav-link<cfif #tab6_expand# is 'true'> active</cfif>">Integrations</a>
                </li>
         
            
                        <span class="ml-auto padding-bottom:11px;text-nowrap border border-top-0 !important border-left-0 !important border-right-0 !important" style="border-top:0 !important;border-left:0 !important;border-right:0 !important;">
                  
                        

                    </span>
        
        
                  </cfoutput>
            
        </ul>
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
    
        
    
      
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        

        <div class="tab-content">
            
            <div class="tab-pane<cfif #tab1_expand# is 'true'> show active</cfif>" id="profile">
            <cfoutput>
              <h4>My Links <span style="font-size:14px;"><A style="color: ##406e8e !important;" data-bs-remote="true" data-bs-toggle="modal" data-bs-target="##paneladd" title="Add Custom Panel"><i class="fe-plus-circle"></i></a></span></h4>

</cfoutput>
            
       <div class="row">
 
     <div class="col-xl-12">      
            
             <div id="accordion" class="mb-3">    
            
                 
                    <cfset z=0>
                        
                        
                        
                        
                        
                        
                        
                        
                                <cfloop query="sitetypes">
                   <cfset current_sitetypeid = sitetypes.sitetypeid />                 
                <cfset current_sitetypename = sitetypes.sitetypename />
        
            <cfoutput><cfset z=#z# + 1 /></cfoutput>

             <cfif #z# is "1"><cfoutput><cfparam name="target_id" default="#sitetypes.sitetypeid#"></cfoutput></cfif>


                <cfquery datasource="#dsn#" name="mylinks_user"  >
                    SELECT
                    s.id
                    ,s.sitetypeid
                    ,s.sitename
                    ,s.siteurl
                    ,s.siteicon
                    ,s.sitetypeid
                    ,t.sitetypename
                    ,t.pntitle
                    ,s.ver
                    FROM sitelinks_user s INNER JOIN sitetypes_user t ON t.sitetypeid = s.siteTypeid
                    WHERE s.userid = #session.userid# AND s.sitetypeid = #sitetypes.sitetypeid#
                    ORDER BY s.sitename
                </cfquery>

                <cfquery datasource="#dsn#" name="mylinks_user_del"  >
                    SELECT
                    s.id
                    ,s.sitetypeid
                    ,s.sitename
                    ,s.siteurl
                    ,s.siteicon
                    ,s.sitetypeid
                    ,t.sitetypename
                    ,t.pntitle
                    ,s.ver
                    FROM sitelinks_user_tbl s INNER JOIN sitetypes_user t ON t.sitetypeid = s.siteTypeid
                    WHERE s.userid = #session.userid# AND s.sitetypeid = #sitetypes.sitetypeid# and s.isdeleted = 1 and s.isCustom = 0
                    ORDER BY s.sitename
                </cfquery>
                 
                 
                 
                 
            
                 
                 
                 
                 <cfquery datasource="#dsn#" name="master"  >
                 select * from sitetypes_master where sitetypename = '#current_sitetypename#' order by siteTypeName
                 </cfquery>
                 
                 <cfif #master.recordcount# is "0">
                 <cfset deletable = "Y" >
                     
                     <cfelse>
                         
                    <cfset deletable = "N">
                 
                 </cfif>
                 
                 
                 
                 
                 
                               <cfif #sitetypes.sitetypeid# is "#target_id#">
                    <div class="card mb-1">
                        <div class="card-header" id="<cfoutput>heading#sitetypes.sitetypeid#</cfoutput>">
                            <h5 class="m-0">
                                <a class="text-dark" data-bs-toggle="collapse" href="#collapse<cfoutput>#sitetypes.sitetypeid#</cfoutput>" aria-expanded="true">

                                    <cfoutput>#sitetypes.sitetypename# 
                                       <cfif #mylinks_user.recordcount# is "0" and #deletable# is "y">  
                                                    <A title="Remove #current_sitetypename#" class="pl-1" style="color:red;" href="/include/excludesitetype.cfm?current_sitetypeid=#current_sitetypeid#&target_id=#current_sitetypeid#">
                                                        
                                                        
                                                        <i class="mdi mdi-trash-can-outline"></i></A></cfif>
                                        
                                        
                                        
                                        
                                        <span class="badge badge-success badge-pill float-end">#numberformat(mylinks_user.recordcount)#</span></cfoutput>
                                </a>
                            </h5>
                        </div>
                        
                        
<div id="collapse<cfoutput>#sitetypes.sitetypeid#</cfoutput>" class="collapse show" aria-labelledby="<cfoutput>heading#sitetypes.sitetypeid#</cfoutput>" data-bs-parent="#accordion" style="">


                            <cfelse>
                                
                                <div class="card mb-1">
                                    <div class="card-header" id="<cfoutput>heading#sitetypes.sitetypeid#</cfoutput>">
                                        <h5 class="m-0">
                                            <a class="text-dark collapsed" data-bs-toggle="collapse" href="#collapse<cfoutput>#sitetypes.sitetypeid#</cfoutput>" aria-expanded="false">

                                                <cfoutput>#sitetypes.sitetypename# 
                                                    
                                                    
                                                   <cfif #mylinks_user.recordcount# is "0" and #deletable# is "y">  
                                                    <A title="Remove #current_sitetypename#" class="pl-1" style="color:red;" href="/include/excludesitetype.cfm?current_sitetypeid=#current_sitetypeid#&target_id=#current_sitetypeid#">
                                                        
                                                        
                                                        <i class="mdi mdi-trash-can-outline"></i></A>
                                                    </cfif>
                                                    
                                                    
                                                    
                                                    
                                                    <span class="badge badge-success badge-pill float-end">#numberformat(mylinks_user.recordcount)#</span></cfoutput>
                                            </a>
                                            
                                            
                                            
                                            
                                        </h5>
                                    </div>

                                    <div id="collapse<cfoutput>#sitetypes.sitetypeid#</cfoutput>" class="collapse" aria-labelledby="<cfoutput>heading#sitetypes.sitetypeid#</cfoutput>" data-bs-parent="#accordion" style="">


                </cfif>
                                    
                                    
                                    
                                    
                                    
                    <div class="card-body">

                            <cfoutput><button type="button" class="btn btn-xs btn-primary waves-effect mb-2 waves-light" style="background-color: ##406e8e; border: ##406e8e" href="addlink.cfm" data-bs-remote="true" data-bs-toggle="modal" data-bs-target="##addlink_#sitetypes.sitetypeid#">Add Custom</button></cfoutput>


                                        <div class="row">
                                            
                                            <cfloop query="mylinks_user">
                                                <div class="col-md-6 col-lg-4">
                                                    <cfoutput>
                                                        <h5><a title="Edit" href="updateuserlink.cfm" data-bs-remote="true" data-bs-toggle="modal" data-bs-target="##updatelink_#mylinks_user.id#">
                                                                <img src="/app/assets/images/retina-circular-icons/14/#mylinks_user.siteicon#" width="14px" /> #mylinks_user.sitename# <cfif #mylinks_user.ver# is not ""> (#ver#)</cfif><i class="mdi mdi-square-edit-outline"></i></a> <A title="Remove #mylinks_user.sitename#" class="pl-1" style="color:red;" href="/include/excludelink.cfm?new_id=#mylinks_user.id#&target_id=#sitetypes.sitetypeid#"><i class="mdi mdi-trash-can-outline"></i></A>
                                                        </h5>
                                                    </Cfoutput>

                                                </div>
                                            </cfloop>


                                        </div>



                                        <cfif #mylinks_user_del.recordcount# is not "0">
                                            <form action="/include/linkinclude.cfm">
                                                <cfoutput><input type="hidden" name="target_id" value="#target_id#"></cfoutput>
                                                <h5>Restore:
                                                    <select name="new_id" id="<cfoutput>new_id_#sitetypes.sitetypeid#</cfoutput>" required="" onchange='this.form.submit()'>
                                                        <option value=""></option>
                                                        <cfoutput query="mylinks_user_del">
                                                            <option value="#mylinks_user_del.id#">#mylinks_user_del.sitename#</option>

                                                        </cfoutput>
                                                    </select>


                                                </h5>
                                            </form>
                                        </cfif>

 </div>                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                </div>                
                                    
                                    
                                    
                                    
                                    
                                          </div>
         
                                    
                                    
                  
                 
            
                 </cfloop>
                
              
         
                  
                
                
                
                
         </div>   
                
           </div>
           
                </div>
            
            
            </div>  
            
            <div class="tab-pane<cfif #tab2_expand# is 'true'> show active</cfif>" id="myteam">

                <h4>My Team</h4>

                <p>Add a Team Member from your existing relationships or <a href="remoteAddContact.cfm?src=account" data-bs-remote="true" data-bs-toggle="modal" data-bs-target="#remoteAddContact"><strong>Add</strong></a> a new one.</p>

                <form class="app-search" action="/app/myaccount/" method="POST">
                    <input type="hidden" name="ctaction" value="addmember" />
                    <input type="hidden" name="t2" value="1" />
                    <div class="row" style="margin: auto;">
                        <div class="col-md-2 p-2">Add Team Member:</div>
                        <div class="col-md-3 p-2">
                            <div class="input-group">
                                <input type="text" class="form-control" name="topsearch_myteam" id="autocomplete2" placeholder="Search..." autocomplete="off">
                                <div class="input-group-append">
                                    <button id="mybtns" type="submit" class="btn btn-xs btn-primary waves-effect mb-2 waves-light" style="background-color: #406e8e; border: #406e8e; height: 37px;">
                                        <i class="fe-plus"></i> Add </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>

   
                               <div class="row">
                            
                                     <cfloop query="myteam">
                                         
                                          <cfquery datasource="#dsn#" name="mytags"  >
                            SELECT contactid, itemid,concat(' <span class=\'badge badge-blue\'>',`contactitems`.`valueText`,'</span>') as tag,contactitems.valuetext
                                              
                            FROM contactitems
                            WHERE contactid=#myteam.contactid# AND valuetext <> 'My Team'
                                AND valuecategory = 'Tag' AND valuetext <> 'My Rep Team'
                            ORDER BY concat(' <span class=\'badge badge-blue\'>',`contactitems`.`valueText`,'</span>')
                        </cfquery>
                                              
                                                                    <cfquery datasource="#dsn#" name="Findphone"  >  
                      select contactitems.valueText as phone from contactitems where contactitems.valueCategory = 'Phone' and contactitems.contactID = #myteam.contactid# and contactitems.itemStatus = 'Active' order by contactitems.primary_YN desc limit 1
                        </cfquery>
                        
                        <cfset new_phone = findphone.phone />
                          <cfquery datasource="#dsn#" name="Findemail"  >  
                      select contactitems.valueText as email from contactitems where contactitems.valueCategory = 'Email' and contactitems.contactID = #myteam.contactid# and contactitems.itemStatus = 'Active' order by contactitems.primary_YN desc limit 1
                        </cfquery>
    <cfset new_email = Findemail.email />
                                              
                                              
                                              
                                              <cfoutput>
                                         <div class="col-lg-3">
                                <div class="text-center card-box border border-secondary">
                                    <div class="pt-2 pb-2">
                                        <img src="/media-#host#/users/#session.userid#/contacts/#myteam.contactid#/avatar.jpg?ver=#rand()#" class="rounded-circle img-thumbnail avatar-xl" alt="profile-image">

                                        <h4 class="mt-3"><A href="/app/contact/?contactid=#myteam.contactid#">#myteam.contactname#</A></h4>
                                        
                                        
                                        
                                        <h5 >       <cfloop query="mytags">
                                <cfoutput>#mytags.valuetext#</cfoutput>
                            </cfloop></h5>
                                        <p class="small mt-2">
                                            
                                         
                                            
                                            <span> #new_phone# &nbsp;</span> 
                                        
                                        <BR>
                                         <span> #new_email#  &nbsp;</span>
                                        </p>
                                        
                                            
                                            
                                                     <a href="/app/myaccount/?ctaction=deleteitem&amp;deletecontactid=#myteam.contactid#" title="Remove from team" style="padding-left:10px;color:dimgrey;">
                                    <span>
                                        <i class="fe-trash-2 font-10 text-muted"></i>
                                    </span>
                                </a>
                                            
                                            
                                            
                                     <!-- end row-->
</cfoutput>
                                    </div> <!-- end .padding -->
                                </div> <!-- end card-box-->
                            </div> 
                            </cfloop>
                                              </div>
                                         
                                           <h4>Team Share</h4>
<cfoutput>
                <p>You can share with your team using the team share link:  <strong><a href="https://#host#.theactorsoffice.com/share/?u=#u#" target="U"   title="View Teamshare" data-bs-original-title="View Teamshare"  >https://#host#.theactorsoffice.com/share/?u=#u#</a></strong>
                <BR>If you click on the button you will  
see your report. </p>
                </cfoutput>
                        
            </div>
           
            
            
            
            
            
            
            
            
                      
            <div class="tab-pane<cfif #tab3_expand# is 'true'> show active</cfif>" id="security">
            
            
	    <h4>Account & Security   <span style="font-size:14px;"> <a title="Edit" href="" data-bs-toggle="modal" data-bs-target="#remoteUpdateAccount">
	      <i class="mdi mdi-square-edit-outline"></i>
	    </a></span></h4>
	









	    <div class="row" style="margin: auto;">
	        <cfoutput>
	            <div class="col-md-2 p-2"><strong>First Name</strong></div>
	            <div class="col-md-10 p-2">#userfirstname#</div>

	            <div class="col-md-2 p-2"><strong>Last Name</strong></div>
	            <div class="col-md-10 p-2">#userlastname#</div>

	            <div class="col-md-2 p-2"><strong>Avatar Name</strong></div>
	            <div class="col-md-10 p-2">#useravatarname#</div>

	            <div class="col-md-2 p-2"><strong>Email</strong></div>
	            <div class="col-md-10 p-2">#userEmail#</div>



	        </cfoutput>
	    </div>
            
            </div>
            
            <div class="tab-pane<cfif #tab4_expand# is 'true'> show active</cfif>" id="preferences">
            
             <h4>Preferences</h4>





	    <h5>
	        Default Settings <a title="Edit" href="" title="Update calendar setings" data-bs-toggle="modal" data-bs-target="#updatecal"><i class="mdi mdi-square-edit-outline"></i></a>

	    </h5>




	    <div class="row" style="margin: auto;">

	        <div class="col-md-2 p-2"><strong>Start time:</strong></div>
	        <div class="col-md-10 p-2">
	            <cfoutput> <a href="" title="Start time for your Calendar Day" data-bs-toggle="modal" data-bs-target="##updatecal">#details.calstarttime#</a></cfoutput>
	        </div>


	        <div class="col-md-2 p-2"><strong>End time:</strong></div>
	        <div class="col-md-10 p-2">
	            <cfoutput><a href="" title="End time for your Calendar Day" data-bs-toggle="modal" data-bs-target="##updatecal">#details.calendtime#</a></cfoutput>
	        </div>


	    </div>

	    <div class="row" style="margin: auto;">

	        <div class="col-md-2 p-2"><strong>Rows Per Page:</strong></div>
	        <div class="col-md-10 p-2">
	            <cfoutput> <a href="" title="Default Rows for Relationships Table" data-bs-toggle="modal" data-bs-target="##updatecal">#details.defRows#</a></cfoutput>
	        </div>


	        <div class="col-md-2 p-2"><strong>Default Country:</strong></div>
	        <div class="col-md-10 p-2">
	            <cfoutput> <a href="" title="Default Country for your Contacts" data-bs-toggle="modal" data-bs-target="##updatecal">#details.defCountry#</a></cfoutput>
	        </div>


	        <div class="col-md-2 p-2"><strong>Default State:</strong></div>
	        <div class="col-md-10 p-2">
	            <cfoutput> <a href="" title="Default State for your Contacts" data-bs-toggle="modal" data-bs-target="##updatecal">#details.defState#</a></cfoutput>
	        </div>





	        <div class="col-md-2 p-2"><strong>Time Zone:</strong></div>
	        <div class="col-md-10 p-2">
	            <cfoutput> <a href="" title="Default State for your Contacts" data-bs-toggle="modal" data-bs-target="##updatecal">#details.tzid#</a></cfoutput>
	        </div>

	    </div>
                
                
                
                
                
<h5>
    My Newsletter


    <a title="Edit" href="" title="Update calendar setings" data-bs-toggle="modal" data-bs-target="#updatenewsletter"><i class="mdi mdi-square-edit-outline"></i></a>




</h5>





<div class="row" style="margin: auto;">

    <div class="col-md-2 p-2"><strong>Newsletter?</strong></div>
    <div class="col-md-10 p-2">

        <a title="Edit" href="" title="Update calendar setings" data-bs-toggle="modal" data-bs-target="#updatenewsletter">



            <cfif #details.nletter_yn# is "Y">Yes<cfelse>No</cfif>


        </a>
    </div>

    <div class="col-md-2 p-2"><strong>Newsletter Link</strong></div>
    <div class="col-md-10 p-2">

        <cfif #details.nletter_yn# is "Y">

            <cfif #details.nletter_link# is not "">

                <cfif #left('#details.nletter_link#','4')# is "http">
                    <cfoutput>
                        <cfset new_nletter_link="#details.nletter_link#" />
                    </cfoutput>
                    <cfelse>


                        <cfoutput>
                            <cfset new_nletter_link="http://#details.nletter_link#" />
                        </cfoutput>


                </cfif>
                <cfoutput>
                    <A HREF="#new_nletter_link#" target="external">#details.nletter_link#</A>
                </cfoutput>
                <cfelse> <i>Please add your newsletter link. </i>
            </cfif>


        </cfif>



    </div>

</div>






<h5>
    Dashboard Preferences

</h5>

<div class="row" style="margin: auto;">

    <div class="col-md-2 p-2"><a title="Edit" href="dashboardupdate.cfm" data-bs-remote="true" data-bs-toggle="modal" data-bs-target="#dashboardupdate"><strong>Dashboard panels</strong></a></div>
    <div class="col-md-10 p-2">

        <cfloop query="dashboards">
            <cfoutput><span class="badge badge-secondary">
                    #dashboards.pntitle#</span> </Cfoutput>
        </cfloop>
        <a title="Edit" href="dashboardupdate.cfm" data-bs-remote="true" data-bs-toggle="modal" data-bs-target="#dashboardupdate"><i class="mdi mdi-square-edit-outline"></i></a>
    </div>

</div>


                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
            
            </div>
                    
                    
                    
  
            <div class="tab-pane<cfif #tab5_expand# is 'true'> show active</cfif>" id="subscription">
            
             <h4>Billing </h4>

	    <div class="row" style="margin: auto;">
 
                
                
                
                
                
                <cfoutput query="thrivecartdetails">
	            <div class="col-md-2 p-2"><strong>Invoice ID</strong></div>
	            <div class="col-md-10 p-2">#invoiceid#</div>
                 <div class="col-md-2 p-2"><strong>Purchase Date</strong></div>
	            <div class="col-md-10 p-2">#dateformat(purchasedate)#</div>
                    <div class="col-md-2 p-2"><strong>Trial End Date</strong></div>
	            <div class="col-md-10 p-2">#dateformat(trialenddate)#</div>

                
	            <div class="col-md-2 p-2"><strong>Product</strong></div>
	            <div class="col-md-10 p-2">#baseproductlabel#</div>
                
                 <div class="col-md-2 p-2"><strong>Plan</strong></div>
	            <div class="col-md-10 p-2">#planname#</div>
                    
                    </cfoutput>
<cfif #isdefined('sfddsf')#>
	            <div class="col-md-2 p-2"><a href="">
	                    <button type="button" class="btn btn-xs btn-primary waves-effect mb-2 waves-light" style="background-color: ##406e8e; border: ##406e8e">Upgrade</button></a></div>
</cfif>

 
	    </div>

            </div>
                
            <div class="tab-pane<cfif #tab6_expand# is 'true'> show active</cfif>" id="integrations">
             <h4>Integrations</h4>

	    <p>Coming Soon!</p>
            
            </div>    
        
        
        
        
        
        
        
        
        
        
                    <div class="tab-pane<cfif #tab7_expand# is 'true'> show active</cfif>" id="systems">
             <h4>Systems - Customization</h4>
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
 <cfquery datasource="#dsn#" name="mysystems"  >
     SELECT * FROM fusystems order by FIELD(systemid,5,6,1,2,3,4)
 </cfquery>


 <div class="row">

     <div class="col-xl-12">

         <div id="accordion_systems" class="mb-3">


             <cfset y=0>




   <cfparam name="target_id_system" default="0">


                   
 


                 <cfloop query="mysystems">


                     <cfquery datasource="#dsn#" name="action_user"  >
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
                         WHERE a.systemID = '#mysystems.systemid#'
                         and au.userid = #session.userid#
                         ORDER BY a.actionNo
                     </cfquery>


                     <cfquery datasource="#dsn#" name="action_user_del"  >
                         SELECT
                         au.id
                         ,s.systemID
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

                         INNER JOIN actionusers_tbl au on au.actionid = a.actionid
                         WHERE a.systemID = #mysystems.systemid#
                         and au.userid = #session.userid#
                         and au.isdeleted = 1
                         ORDER BY a.actionNo
                     </cfquery>


                 
                          
                   




                     <cfif #mysystems.systemid# is "#target_id_system#">
                         <div class="card mb-1">
                             <div class="card-header" id="<cfoutput>heading_system_#mysystems.systemid#</cfoutput>">
                                 <h5 class="m-0">
                                     <a class="text-dark" data-bs-toggle="collapse" href="#collapse_system_<cfoutput>#mysystems.systemid#</cfoutput>" aria-expanded="true">

                                         <cfoutput>#mysystems.systemname# <span class="badge badge-success badge-pill float-end">#numberformat(action_user.recordcount)#</span></cfoutput>
                                     </a>
                                 </h5>
                             </div>


                             <div id="collapse_system_<cfoutput>#mysystems.systemid#</cfoutput>" class="collapse show" aria-labelledby="<cfoutput>heading_system_#mysystems.systemid#</cfoutput>" data-bs-parent="#accordion_systems" style="">


                                 <cfelse>

                                     <div class="card mb-1">
                                         <div class="card-header" id="<cfoutput>heading_system_#mysystems.systemid#</cfoutput>">
                                             <h5 class="m-0">
                                                 <a class="text-dark text-dark collapsed" data-bs-toggle="collapse" href="#collapse_system_<cfoutput>#mysystems.systemid#</cfoutput>" aria-expanded="false">

                                                     <cfoutput>#mysystems.systemname# <span class="badge badge-success badge-pill float-end">#numberformat(action_user.recordcount)#</span></cfoutput>
                                                 </a>
                                             </h5>
                                         </div>

                                         <div id="collapse_system_<cfoutput>#mysystems.systemid#</cfoutput>" class="collapse" aria-labelledby="<cfoutput>heading_system_#mysystems.systemid#</cfoutput>" data-bs-parent="#accordion_systems" style="">


                     </cfif>





                     <div class="card-body">

<p><cfoutput>#mysystems.systemdescript#</cfoutput></p>
                         
                                   <cfoutput><A href="/include/restoreaction.cfm?target_id_system=#mysystems.systemid#"><button type="button" class="btn btn-xs btn-primary waves-effect mb-2 waves-light" style="background-color: ##406e8e; border: ##406e8e" >Restore to Default</button></a></cfoutput>


 
                         <div class="row">

                             <cfloop query="action_user">
                                 <div class="col-md-12">
                                     <cfoutput>
                                         <h5><a title="Edit" href="updateactionlink.cfm" data-bs-remote="true" data-bs-toggle="modal" data-bs-target="##updateaction_#action_user.id#">

                                                 #action_user.currentrow# - #action_user.actiontitle#





                                                 <i class="mdi mdi-square-edit-outline"></i></a>
                                         </h5>

                                         <p>#action_user.actiondetails#.<BR><cfif #action_user.actiondaysno# is "0">Starts <strong>immediately</strong><cfelse>Starts in <strong>#action_user.actiondaysno# day<cfif #action_user.actiondaysno# is not "1">s</cfif></strong></cfif><cfif #numberformat(action_user.actiondaysrecurring)# is not "0">, repeating every <strong>#action_user.actiondaysrecurring# days</strong></cfif>.
                                             
                                             
                                             
                                             &nbsp;&nbsp; &nbsp;<A title="Remove Action No #action_user.actionno#" class="pl-1" style="color:red;" href="/include/excludeaction.cfm?new_id=#action_user.id#&target_id_system=#mysystems.systemid#"><i class="mdi mdi-trash-can-outline"></i></A></p>
                                 </div>

                               
 

                                 </Cfoutput>






                             </cfloop>


                         </div>



                         <cfif #action_user_del.recordcount# is not "0">
                             <form action="/include/includeaction.cfm">
                                 <cfoutput><input type="hidden" name="target_id_system" value="#mysystems.systemid#"></cfoutput>
                                 <h5>Restore:
                                     <select name="new_id" id="<cfoutput>new_id_system_#mysystems.systemid#</cfoutput>" required="" onchange='this.form.submit()'>
                                         <option value=""></option>
                                         <cfoutput query="action_user_del">
                                             <option value="#action_user_del.id#">#action_user_del.actiontitle#</option>

                                         </cfoutput>
                                     </select>


                                 </h5>
                             </form>
                         </cfif>

                     </div>








         </div>





     </div>






     </cfloop>








 </div>
               
                                   
                                   
                                   
                                   
                                   
                                   
                                   
                                   
                                   
                                   
                                   
                                   
                                   
                                   
                                   
                                   
                                   
                                   
                                   
                                   
                                   
                                   
                                   
                                   
                                   
                                   
                                   

	    
                        
                        
                        
                        
                        
                        
                        
                        
                        
            
            </div>    
        
        
        
        
        
        
        
        
        
        

        </div>



                 
                 
                 
                 
                 
                 

<cfquery datasource="#dsn#" name="jsons_myteam"  >
    SELECT col1 from contacts_ss WHERE userid = #session.userid# and col1 not like '%#chr(34)#%'
</cfquery>

        <script>
        $('#eventStopTime').timepicker({
	'minTime': '1:00am',
	'maxTime': '11:30pm',
	'showDuration': true
});
        
        </script> 


 

<cfset script_name_include="/include/#ListLast(GetCurrentTemplatePath(), "\")#" /><cfinclude template="/include/bigbrotherinclude.cfm" /> 
