<div class="navbar-custom">
    <div class="container-fluid">
        <ul class="list-unstyled topnav-menu float-end mb-0">

            <!--- Search --->
            <li class="d-none d-lg-block">
                 <form class="app-search" id="submitform" action="/include/process.cfm" method="POST">
            <div class="app-search-box dropdown">
                <div class="input-group">
                    <input type="text" class="form-control" name="topsearch" id="autocomplete" placeholder="Search...">
                    <div class="input-group-append">
                        <button class="btn" id="mybtn" type="submit">
                            <i class="fe-search"></i>
                        </button>
                    </div>
                </div>
            </div>
        </form>
                
                
              <script> helpwiseSettings = { widget_id: '65958ef4eb602', align: 'right' } </script>

<script src="https://cdn.helpwise.io/assets/js/livechat.js"></script>  
 
                
                
            </li>
    
            <!--- Mobile Search --->
            <li class="dropdown d-inline-block d-lg-none">
                <a class="nav-link dropdown-toggle arrow-none waves-effect waves-light" data-bs-toggle="dropdown" href="" role="button" aria-haspopup="false" aria-expanded="false">
                    <i class="fe-search noti-icon"></i>
                </a>
                <div class="dropdown-menu dropdown-lg dropdown-menu-end p-0">
                    <form class="p-3" id="submitform_mobile" action="/include/process.cfm" method="POST">
                        <input  type="search" class="form-control" name="topsearch" id="autocomplete_mobile" placeholder="Search..." >
                    </form>
                </div>
            </li>
   <cfif #isdefined('sdfsdfsdf')#>
        <!--- Notifications --->   
         <li class="dropdown notification-list topbar-dropdown">
                <a class="nav-link dropdown-toggle waves-effect waves-light" data-bs-toggle="dropdown" href="" role="button" aria-haspopup="false" aria-expanded="false">
                    <i class="fe-bell noti-icon"></i>
                    <cfif #toastmenu.recordcount# is not "0"><span class="badge bg-danger rounded-circle noti-icon-badge">  <CFOUTPUT>#toastmenu.recordcount#</CFOUTPUT>  </span></cfif>
                </a>
                <div class="dropdown-menu dropdown-menu-end dropdown-lg">
    
                    <!-- item-->
                    <div class="dropdown-item noti-title">
                        <h5 class="m-0">
                            <span class="float-end">
                                <a href="" class="text-dark">
                                    <small>Clear All</small>
                                </a>
                            </span>Notifications</h5>
                    <cfif #toastmenu.recordcount# is not "0">
                        <span class="float-end">
                            <cfoutput>
                                <cfif #cgi.query_string# is "">
                                    <cfset clearlink="#cgi.script_name#?ca=Y" />
                                    <cfelse>
                                        <cfset clearlink="#cgi.script_name#?#cgi.query_string#&ca=Y" />
                                </cfif>
                                <a href="#clearlink#" class="text-dark">
                                    <small>Clear All</small>
                                </a>
                            </cfoutput>
                        </span>
                        <cfelse>
                            <span>0 notifications found.</span>
                    </cfif>
               
                    </div>
               <div class="noti-scroll" data-simplebar>
                <cfloop query="toastmenu">
                    <cfoutput>
                        <cfset timenow="#now()#" />
                        <cfset toasttime="#toastmenu.notiftimestamp#" />
                        <cfset toastdays="#datediff('d','#toasttime#','#timenow#')#" />
                        <cfset toasthours="#datediff('h','#toasttime#','#timenow#')#" />
                        <cfset toastmins="#datediff('n','#toasttime#','#timenow#')#" />
                        <cfif toastdays gt 7>
                            <cfset timetitle="#dateformat(toasttime)#" />
                            <cfelseif toastdays gt 3 and toastdays lt 7>
                                <cfset timetitle="#toastdays# days ago." />
                                <cfelseif toastdays eq 3>
                                    <cfset timetitle="Three days ago." />
                                    <cfelseif toastdays eq 2>
                                        <cfset timetitle="Two days ago." />
                                        <cfelseif toastdays eq 1>
                                            <cfset timetitle="One day ago." />
                                            <cfelseif toastdays lt 1>
                                                <Cfif toasthours gt 3>
                                                    <cfset timetitle="#toasthours# hours ago." />
                                                    <cfelseif toasthours eq 3>
                                                        <cfset timetitle="Three hours ago." />
                                                        <cfelseif toasthours eq 2>
                                                            <cfset timetitle="Two hours ago." />
                                                            <cfelseif toasthours eq 1>
                                                                <cfset timetitle="One hour ago." />
                                                                <cfelseif toasthours lt 1>
                                                                    <cfif toastmins gt 3>
                                                                        <cfset timetitle="#toastmins# mins ago." />
                                                                        <cfelseif toastmins eq 3>
                                                                            <cfset timetitle="Three minutes ago." />
                                                                            <cfelseif toastmins eq 2>
                                                                                <cfset timetitle="Two minutes ago." />
                                                                                <cfelseif toastmins eq 1>
                                                                                    <cfset timetitle="One minute ago." />
                                                                                    <cfelseif toastmins lt 1>
                                                                                        <cfset timetitle="Just now." />
                                                                    </cfif>
                                                </cfif>
                        </cfif>
                        <cfif toastmenu.read eq 1>
                            <cfset activestate="" />
                            <cfelse>
                                <cfset activestate="Active" />
                        </cfif>
                        <cfif #toastmenu.notifurl# contains "?">
                            <cfset full_notifurl="#toastmenu.notifurl#&dn=#toastmenu.id#" />
                            <Cfelse>
                                <cfset full_notifurl="#toastmenu.notifurl#?dn=#toastmenu.id#" />
                        </cfif>

                        <cfif #cgi.query_string# is "">
                            <cfset dellink="#cgi.script_name#?dne=#toastmenu.id#" />
                            <cfelse>
                                <cfset dellink="#cgi.script_name#?#cgi.query_string#&dne=#toastmenu.id#" />
                        </cfif>



                        <a href="#full_notifurl#" class="dropdown-item notify-item #activestate# border-bottom">
                            <div class="notify-icon notify-lg bg-primary" style="margin-top:10px;">
                                <center>#ucase(left(toastmenu.notiftitle,1))#</center>
                            </div>
                            <p class="notify-details<cfif toastmenu.read eq 1> text-muted</cfif>">
                                <cfif #toastmenu.read# is "0"><strong></cfif>#toastmenu.notiftitle#<cfif #toastmenu.read# is "0"></strong></cfif>

                                <cfif #toastmenu.recordname# is not "">
                                    <cfif toastmenu.read eq 1>
                                        <small class="text-muted">#recordname#</small>
                                        <cfelse>
                                            <small>#recordname#</small>
                                    </cfif>

                                </cfif>


                                <cfif toastmenu.read eq 1>
                                    <small class="text-muted">#timetitle#</small>
                                    <cfelse>
                                        <small>#timetitle#</small>
                                </cfif>


                            </p>
                        </a>
                    </cfoutput>
                </cfloop>
            </div>
    
                    <!-- All-->
                    <a href="javascript:void(0);" class="dropdown-item text-center text-primary notify-item notify-all">
                        View all
                        <i class="fe-arrow-right"></i>
                    </a>
    
                </div>
            </li>
       
                                                                    </cfif>                                          
                                                                        
                                                                        
                                                                        
                                                                        
                                                                        
                                                                        
                                                                        
                                                                        
            <!--- Help --->       
            <li class="dropdown d-none d-lg-inline-block topbar-dropdown">
                <a class="nav-link dropdown-toggle arrow-none waves-effect waves-light" data-bs-toggle="dropdown" href="" role="button" aria-haspopup="false" aria-expanded="false">
                    <i class="fe-help-circle noti-icon"></i>
                </a>
                <div class="dropdown-menu dropdown-lg dropdown-menu-end">
    
                    
                         <div class="p-lg-1">
                <div class="row no-gutters">





                    <div class="col">
                        <a class="dropdown-icon-item" href="https://theactorsoffice.helpwise.help/" target="FAQ">
                            <img src="/assets/images/faq.png?ver=3" alt="FAQ">
                            <span>FAQ</span>
                        </a>
                    </div>

                    <div class="col">
                        <a class="dropdown-icon-item" href="https://www.facebook.com/groups/taousercommunity" target="usercommunity">
                            <img src="/assets/images/usercom.png?ver=3" alt="User Community">
                            <span>User Community</span>
                        </a>
                    </div>

                        <cfset thisPath=ExpandPath("*.*") />

    <cfset thisDirectory="#GetDirectoryFromPath(thisPath)#" />

    <cfset thispage="#replace('#thisDirectory#','C:\home\theactorsoffice.com\wwwroot\#host#-subdomain#suffix#\app\','')#" />

    <cfset thispage="#replace('#thispage#','\','')#" />




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
        WHERE p.pgDir = '#trim(thispage)#'
        and p.isdef = 1
</cfquery>

<cfif #FindPage.RecordCount# is "1">


            
<cfif #FindPage.userrole# is "Administrator">
<BR>

<div class="col">
                        <a href="remoteSupportForm.cfm" data-bs-remote="true" data-bs-toggle="modal" data-bs-target="#remoteSupportForm" class="dropdown-icon-item">
                            <img src="/assets/images/feedback.png?ver=3" alt="Feedback">
                            <span>Create a Ticket</span>
                        </a>
                    </div>


</cfif>

</cfif>
      
                 
                    <div class="col">
                        <a class="dropdown-icon-item" href="mailto:support@theactorsoffice.com?subject=I%20Need%20Some%20Support%20with%20TAO">
                            <img src="/assets/images/contact.png?ver=3" alt="Contact Support">
                            <span>Contact Support</span>
                        </a>
                    </div>


                    
                </div>
            </div>
                    
                    
                    
                    
                    
                </div>
            </li>
                                                                        
            <!--- Account --->  
         <li class="dropdown notification-list topbar-dropdown">
                <a class="nav-link dropdown-toggle nav-user me-0 waves-effect waves-light" data-bs-toggle="dropdown" href="#" role="button" aria-haspopup="false" aria-expanded="false">
                     <i class="fe-user noti-icon"></i>
                </a>
                <div class="dropdown-menu dropdown-menu-end profile-dropdown ">
                    <!-- item-->
                    <div class="dropdown-header noti-title">
                        <h6 class="text-overflow m-0">Welcome !</h6>
                    </div>
    
                    <!-- item-->
                            <a href="/app/myaccount/" class="dropdown-item notify-item">
                        <i class="fe-user"></i>
                        <span>My Account</span>
                    </a>
    
   
    
                    <!-- item-->
                    <a href="/app/logout.cfm" class="dropdown-item notify-item">
                        <i class="fe-log-out"></i>
                        <span>Logout</span>
                    </a>
    
                </div>
            </li>
    
                                                                        
                                                                        <!---                                               
            <li class="dropdown notification-list">
                <a href="javascript:void(0);" class="nav-link right-bar-toggle waves-effect waves-light">
                    <i class="fe-settings noti-icon"></i>
                </a>
            </li>
    Settings --->    
                                                                        
        </ul>
    
        <!-- LOGO -->
        <div class="logo-box">
            <a href="/app/" class="logo logo-dark text-center">
                <span class="logo-sm">
                    <img src="/assets/images/logo-sm.png" alt="" height="30">
                    <!-- <span class="logo-lg-text-light">UBold</span> -->
                </span>
                <span class="logo-lg">
                    <img src="/assets/images/logo-sm.png" alt="" height="30">
                    <!-- <span class="logo-lg-text-light">U</span> -->
                </span>
            </a>
    
            <a href="/app/" class="logo logo-light text-center">
                <span class="logo-sm">
                    <img src="/assets/images/logo-sm.png" alt="" height="30">
                </span>
                <span class="logo-lg">
                    <img src="/assets/images/logo-light.png" alt="" height="30">
                </span>
            </a>
        </div>
    
        <ul class="list-unstyled topnav-menu topnav-menu-left m-0">
            <li>
                <button class="button-menu-mobile waves-effect waves-light">
                    <i class="fe-menu"></i>
                </button>
            </li>

            <li>
                <!-- Mobile menu toggle (Horizontal Layout)-->
                <a class="navbar-toggle nav-link" data-bs-toggle="collapse" data-bs-target="#topnav-menu-content">
                    <div class="lines">
                        <span></span>
                        <span></span>
                        <span></span>
                    </div>
                </a>
                <!-- End mobile menu toggle-->
            </li>   
            
        
            
        </ul>
        <div class="clearfix"></div>
    </div>
</div>
<!-- end Topbar -->
                                                            
<cfset script_name_include="/include/#ListLast(GetCurrentTemplatePath(), "\")#" />
            <cfinclude template="/include/bigbrotherinclude.cfm" /> 
