<cfscript>
	/**
	 * MIT License
	 * ===========
	 *
	 * Permission is hereby granted, free of charge, to any person obtaining
	 * a copy of this software and associated documentation files (the
	 * "Software"), to deal in the Software without restriction, including
	 * without limitation the rights to use, copy, modify, merge, publish,
	 * distribute, sublicense, and/or sell copies of the Software, and to
	 * permit persons to whom the Software is furnished to do so, subject to
	 * the following conditions:
	 *
	 * The above copyright notice and this permission notice shall be included
	 * in all copies or substantial portions of the Software.
	 *
	 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
	 * OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
	 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
	 * IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
	 * CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
	 * TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
	 * SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
	 *
	 * -----------------------------------------------------------------------
	 * The demo is running all the Mobile_Detect's internal methods.
	 * Here you can spot detections errors instantly.
	 * -----------------------------------------------------------------------
	 *
	 * @author      Giancarlo Gomez <giancarlo.gomez@gmail.com>
	 * @license     MIT License https://github.com/GiancarloGomez/ColdFusion-MobileDetect/blob/master/LICENSE.md
	 */

	param name="url.regex" default="";

	detect 		= new MobileDetect();
	version 	= detect.getVersion();
	deviceType 	= detect.isMobile() ? (detect.isTablet() ? "tablet" : "phone") : "computer";
	repoUrl 	= "https://github.com/GiancarloGomez/ColdFusion-MobileDetect/";
	// set detection type
	detect.setDetectionType(url.dt ?: "mobile");
</cfscript>
    <cfparam name="devicetype" default="Unknown" />
    <Cfif #detect.ismobile()# is "true">
        
        <cfset devicetype="Mobile" />

        <cfelseif #detect.isTablet()# is "true">

            <cfset devicetype="Tablet" />

            <cfelse>

                <cfset devicetype="Desktop" />
    </cfif>
    

    <!DOCTYPE html>

<cfinclude template="/include/pgload.cfm" />
<cfinclude template="/include/qry/menuitems.cfm">
    
    <cfset rev = "1.9.7" />
    
    
    <html lang="en">

    <head>
        <cfoutput>
            <meta charset="utf-8" />
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <meta http-equiv="X-UA-Compatible" content="IE=edge" />
            <title>#appName# | #pgTitle#</title>
            <meta content="#appDescription#" name="description" />
            <meta content="#appAuthor#" name="author" />
            <meta name="robots" content="noindex">
        </cfoutput>


<cfloop query="FindLinksT">
<cfoutput>
<cfif "#findlinkst.linktype#" is "script">
<script src="#findlinkst.linkurl#?ver=#rev#.4"></script>
<cfelseif "#findlinkst.linktype#" is "script_include">

<cfinclude template="#findlinkst.linkurl#?ver=#rev#.4">

<cfelse>
<link href="#findlinkst.linkurl#?ver=#rev#.3" <cfif #findlinkst.rel# is not "">rel="#rel#" </cfif>type="text/css" <cfif #findlinkst.hrefid# is not "">id="#findlinkst.hrefid#"</cfif> />
</cfif>
</cfoutput>
</cfloop>
 
<cfset currentURL = cgi.server_name />
<cfset host = ListFirst(currentURL, ".") />
<cfif #host# is "app">
    <cfset hostcolor = "##406E8E" />
</cfif>
<cfif #host# is "dev">
    <cfset hostcolor = "##8b0000" />
</cfif>
<cfif #host# is "uat">
    <cfset hostcolor = "purple" />
</cfif>
<style>
body.authentication-bg {
    background-color: <cfoutput>#hostcolor#</cfoutput>;
	background-size: cover;
	background-position: center
}
    .navbar-custom {
	background-color: <cfoutput>#hostcolor#</cfoutput>;
	
}
    
    
</style>



<cfif NOT #isdefined('asddfdfs')#>
<script type="text/javascript">
  var helpwiseSettings = {
    widget_id: '65958ef4eb602',
    align: 'right'
  };
</script>
</cfif>

   </head>

    <!-- body start -->

    <body style="overflow-y: scroll!important;" >
        <!-- Begin page -->
        <div id="wrapper">
            <!-- Topbar Start -->
            <cfinclude template="/include/topbar.cfm" />
            <!-- end Topbar -->
            <!-- ========== Left Sidebar Start ========== -->
            <cfinclude template="/include/leftbar.cfm" />
            <!-- Left Sidebar End -->
            <!-- ============================================================== -->
            <!-- Start Page Content here -->
            <!-- ============================================================== -->
            <div class="content-page">
                <div class="content">
                    <!-- Start Content-->
                    <div class="container-fluid">
                        <!-- start page title -->
                        <div class="row">
                         <cfif #pgid# is "17599999">
                            <cfinclude template="/include/core_title_175.cfm" /> 
                            <CFELSE> 
                             <cfinclude template="/include/core_title.cfm" /> 
                            </cfif>   
                           
                            
                      </div>
                        <!-- end page title -->
                        
      <script>
                         
$('#menu a').click(function (e) {
   e.preventDefault();
   $(this).parent().removeClass('active');
});
                        </script>
                        
                            
                            
                            
        
                    
                         <cfif #pgFilename# is not "">

                        <cfinclude template="/include/#pgFilename#" />

                    </cfif>                
                     
                    </div> <!-- container -->
                </div> <!-- content -->
                <!-- Footer Start -->
                <cfinclude template="/include/footer.cfm" />
                <!-- end Footer -->
            </div>
            <!-- ============================================================== -->
            <!-- End Page content -->
            <!-- ============================================================== -->
        </div>
        <!-- END wrapper -->
        <!--- cfinclude template="/include/rightbar.cfm" --->


 
<cfloop query="FindLinksB">
    <cfoutput>
        <cfif "#findlinksb.linktype#" is "script">
<script src="#findlinksb.linkurl#?ver=#rand()#"></script>
            <cfelseif "#findlinksb.linktype#" is "script_include">
                <cfinclude template="#findlinksb.linkurl#">
                    <cfelse>
<link href="#findlinksb.linkurl#?rev=#rev#.5" <cfif #findlinksb.rel# is not ""> rel="#findlinksb.rel#"
        </cfif> type="text/css" <cfif #findlinksb.hrefid# is not "">id="#findlinksb.hrefid#"</cfif> />
        </cfif>

</cfoutput>

</cfloop>
           
                    <cfparam name="pgdir" default="">
                <cfparam name="pgid" default="0" />
                <script>
                    $(document).ready(function() {
                        $("#remoteSupportForm").on("show.bs.modal", function(event) {
                            // Place the returned HTML into the selected element
                            $(this).find(".modal-body").load("/include/RemoteSupportForm.cfm<cfoutput>?pgid=#pgid#&pgdir=#pgdir#&qstring=#cgi.query_string#&userrole=#userrole#</cfoutput>");
                        });
                    });
                </script>

                <div id="remoteSupportForm" class="modal fade " tabindex="-1" role="dialog" aria-labelledby="standard-modalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header" style="background-color: #f3f7f9;">
                                <h4 class="modal-title" id="standard-modalLabel">Support Center</h4>
                                <button type="button" class="close" data-bs-dismiss="modal" aria-hidden="false"></button>
                            </div>
                            <div class="modal-body">
                            </div>
                        </div>
                    </div>
                </div>


        <script>
            $("#remoteSupportForm").draggable({
                handle: ".modal-header"
            });
        </script>

    </body>

    </html>
        
        <cfset script_name_include="/include/#ListLast(GetCurrentTemplatePath(), "\")#" /><cfinclude template="/include/bigbrotherinclude.cfm" /> 