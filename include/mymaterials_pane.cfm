<cfparam name="materials" default="" />
<cfoutput>
    <script>
        $(document).ready(function() {
        $("##remoteaddMaterial").on("show.bs.modal", function(event) {
        // Place the returned HTML into the selected element
        $(this).find(".modal-body").load("/include/remoteaddMaterial.cfm?userid=#userid#&src=account&new_isshare=1");
        });
        });
    </script>
</cfoutput>

<cfset modalid = "remoteaddMaterial"/>

<cfset modaltitle = "Add Material"/>

<cfinclude template="/include/modal.cfm"/>

<cfset modalid = "remoteDeleteaudmedia"/>

<cfset modaltitle = "Delete Material"/>

<cfset modalid = "remoteupdatematerial"/>

<cfset modaltitle = "Update Material"/>

<cfinclude template="/include/modal.cfm"/>

<cfinclude template="/include/qry/materials_sel.cfm"/>

<div id="mymaterialshelp" class="modal  fade" tabindex="-1" aria-labelledby="standard-modalLabel" aria-hidden="true">
           <div class="modal-dialog">
               <div class="modal-content">
                   <div class="modal-header" style="background-color: #f3f7f9;">
                       <h4 class="modal-title" id="standard-modalLabel">My Materials</h4> <button type="button" class="close" data-bs-dismiss="modal" aria-hidden="true"><i class="mdi mdi-close-thick"></i>

                    </button>   </div>

                   <div class="modal-body">
                       
<p>There are times when you submit your own monologues, songs, or sides as your audition.</p> 
<p>To add materials in your repertoire to TAO, go to My Account and then Materials. </p>

<p>Once added, they will appear in this list so you can easily add them to any of your auditions.</p> 
                                        
                                
                                                      </div>
               </div>
           </div>
       </div> 


<cfoutput>

    <h4 class="p-1 d-flex">
        My Materials     &nbsp; &nbsp;        <a href="" title="click for details" data-bs-toggle="modal" data-bs-target="##mymaterialshelp">  
                            <i class="fe-info font-14 mr-1"></i>

                        </a>
        <span class="ms-auto text-muted">
            <a href="javascript:;" data-bs-remote="true" data-bs-toggle="modal" 
               data-bs-target="##matupdate" data-bs-placement="top" title="Update Materials" 
               data-bs-original-title="Update Materials">
            </a>
        </span>
    </h4>
    
</cfoutput>

<cfset i = 0/>

<cfoutput>

    <div class="col-md-12 col-lg-12 col-xl-12 p-1 d-flex">
        <center>
        
            <a data-bs-remote="true" data-bs-toggle="modal" data-bs-target="##remoteaddMaterial" 
               data-bs-placement="top" title="Add media" data-bs-original-title="Add material" 
               class="btn btn-xs btn-primary waves-effect waves-light">
                Add Material
            </a>
        </center>
    </div>
    
</cfoutput>
<div class="row pt-3 pb-3">










    <table id="basic-datatable" class="table dt-responsive nowrap w-100 table-striped" role="grid">
                    <thead>
                    




                     


                                <tr class="#rowtype#">
                                    <th width="50">Action </th>
                                    <th>Type</th>
                                    <th>Name</th>
                                    <th>Filename</th>
                     
                                    <th>URL</th>
                                    <th>Created</th>
                                          <th>Audition</th>
                                </tr>
                      
                
                    <tbody>
  
                    








    <cfloop query="headshots_sel">

    <cfquery name="events" datasource="#dsn#" >
    SELECT distinct p.audprojectid FROM audprojects p 
INNER JOIN audmedia_auditions_xref x ON p.audprojectID = x.audprojectid
WHERE p.isdeleted = 0
AND x.mediaid = #mediaid#
</cfquery>

 <cfset materials = ValueList(events.audprojectid)>


<CFINCLUDE template="/include/remote_load.cfm" />



    
        <cfoutput>
        
            <script>
                $(document).ready(function() {
                $("##remoteDeleteaudmedia#headshots_sel.mediaid#").on("show.bs.modal", function(event) {
                // Place the returned HTML into the selected element
                $(this).find(".modal-body").load("/include/remoteDeleteaudmedia.cfm?mediaid=#headshots_sel.mediaid#&secid=196");
                });
                });
            </script>
            
            <div id="remoteDeleteaudmedia#headshots_sel.mediaid#" class="modal fade" tabindex="-1" 
                 role="dialog" aria-hidden="true">
            
                <div class="modal-dialog">
                
                    <div class="modal-content">
                    
                        <div class="modal-header" style="background-color: red;">
                        
                            <h4 class="modal-title">
                                Delete Material
                            </h4>
                            
                            <button type="button" class="close" data-bs-dismiss="modal" 
                                    aria-hidden="true">
                                <i class="mdi mdi-close-thick">
                                </i>
                            </button>
                        </div>
                        
                        <div class="modal-body">
                        </div>
                    </div>
                </div>
            </div>






     <script>
                $(document).ready(function() {
                $("##remoteupdatematerial#headshots_sel.mediaid#").on("show.bs.modal", function(event) {
                // Place the returned HTML into the selected element
                $(this).find(".modal-body").load("/include/remoteupdatematerial.cfm?src=account&mediaid=#headshots_sel.mediaid#");
                });
                });
            </script>
            
            <div id="remoteupdatematerial#headshots_sel.mediaid#" class="modal fade" tabindex="-1" 
                 role="dialog" aria-hidden="true">
            
                <div class="modal-dialog">
                
                    <div class="modal-content">
                    
                        <div class="modal-header" >
                        
                            <h4 class="modal-title">
                                Update Material
                            </h4>
                            
                            <button type="button" class="close" data-bs-dismiss="modal" 
                                    aria-hidden="true">
                                <i class="mdi mdi-close-thick">
                                </i>
                            </button>
                        </div>
                        
                        <div class="modal-body">
                        </div>
                    </div>
                </div>
            </div>







               <tr role="row">

                        <td>

<a title="Edit"  data-bs-toggle="modal" data-bs-target="##remoteupdatematerial#headshots_sel.mediaid#">

                                <i class="mdi mdi-square-edit-outline"></i>

                            </a>

<cfif #events.recordcount# is "0"> 

<a class="pt-0" data-bs-remote="true" data-bs-toggle="modal" data-bs-target="##remoteDeleteaudmedia#headshots_sel.mediaid#" data-bs-placement="top" title="Delete media" data-bs-original-title="Delete media"><i class="mdi mdi-trash-can-outline"></i>
                        </a>
</cfif>


 



                        </td>






                        <td class="text-nowrap">

                        #headshots_sel.mediaType#
                           
                        </td>



                        <td class="text-nowrap">

                        #headshots_sel.mediaName#
                           
                        </td>



      <td class="text-nowrap">

                        <a href="##" id="downloadLink_#headshots_sel.mediaid#" style="text-decoration: underline; color: blue;">#headshots_sel.mediaFilename#</a>


                






                           
                        </td>

 


   <td class="text-nowrap">
<cfif #headshots_sel.mediaurl# is not "">
                        <A href="#headshots_sel.mediaurl#" target="new" style="text-decoration: underline; color: blue;" >#headshots_sel.mediaurl#</a>

                        </cfif>
                        </td>








                        <td class="text-nowrap">#dateformat('#headshots_sel.mediacreated#','m-d-YYYY')#<BR />#timeformat('#headshots_sel.mediacreated#','medium')#</td>


      <td class="text-nowrap">
<cfif #numberformat(events.recordcount)# is not "0">
 <a style="text-decoration: underline; color: blue;" href="/app/auditions/?materials=#materials#">#numberformat(events.recordcount)#</a>

<cfelse>

0

</cfif>
                     
                           
                        </td>

                    </tr>




<script type="text/javascript">
    document.getElementById('downloadLink_#headshots_sel.mediaid#').addEventListener('click', function(e) {
        e.preventDefault();
        
        // Variables that you want to pass
        const host = '#host#';
        const userid = '#userid#';
        const mediafilename = '#headshots_sel.mediafilename#';

        window.location.href = '/include/mediadownload.cfm?host=' + host + '&userid=' + userid + '&mediafilename=' + mediafilename;
    });
</script>

            
   
        </cfoutput>
            
    </cfloop>

    
                    </tbody>

                </table>


</div>