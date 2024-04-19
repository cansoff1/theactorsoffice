<cfparam name="pgaction" default="view" />
<cfparam name="oldverid" default="0" />



 
    <cfoutput>
        <script>
            $(document).ready(function() {
                $("##remoteticketupdate").on("show.bs.modal", function(event) {
                    // Place the returned HTML into the selected element
                    $(this).find(".modal-body").load("/include/remoteticketupdate.cfm?id=#recid#");
                });
            });

        </script>
    </cfoutput>


    <cfoutput>
        <div id="remoteticketupdate" class="modal fade" tabindex="-1" aria-labelledby="standard-modalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header" style="background-color: ##f3f7f9;">
                        <h4 class="modal-title" id="standard-modalLabel">Ticket Information</h4>
                        <button type="button" class="close" data-bs-dismiss="modal" aria-hidden="true"><i class="mdi mdi-close-thick"></i></button>
                    </div>
                    <div class="modal-body">
                    </div>
                </div>
            </div>
        </div>

    </cfoutput>
 







<script src="/app/assets/js/jquery.bootstrap-touchspin.js"></script>   
<cfset pgcol = 3 />
           



<cfif #pgaction# is "view">
 
<div class="row">
    <div class="col-12">
        <div class="card">
            <div class="card-body">
                <h4 class="header-title"><cfoutput> #pgHeading# for No. #details.recid#: #details.recordname#</cfoutput><cfif #isdefined('hh')#><span class="small right" > <cfoutput>(#pgid#) </cfoutput></span></cfif></h4>
                
                
                
                 <div class="d-flex justify-content-between">
                     
                         <cfif #oldverid# is "0">
                             <cfset backloc = "/app/admin-support/" />
                             <cfelse>
                            <cfoutput>     <cfset backloc = "/app/version/?recid=#oldverid#" />   </Cfoutput>
                        </cfif>

    <div class="float-left">
    
        <A HREF="<cfoutput>#backloc#</cfoutput>" style="background-color: #406e8e; border: #406e8e;margin-bottom: 10px;" class="btn btn-xs btn-primary waves-effect mb-2 waves-light">

    Back </A>
            
           

    </div>
	
    <div class="dropdown float-end">

        <A HREF="<cfoutput>/app/admin-support-update/?recid=#recid#</cfoutput>" style="background-color: #406e8e; border: #406e8e;margin-bottom: 10px;" class="btn btn-xs btn-primary waves-effect mb-2 waves-light">

    Update </A>

    </div>
    
    </div>
            
            
<div class="row">
    
    <cfset n = 0 />
    
    
    <cfoutput query="details">
 

       
        <h5 class="col-md-12">Ticket Information</h5>
        
                 <div class="col-md-3">
             <p class="mt-2 mb-0 font-weight-bold">Name</p>
             <div class="media">
                 <div class="media-body">
                     <div class="mt-0 font-size-12">
                         #details.ticketname#
                     </div>
                 </div>
             </div>
         </div>
        
           
         <div class="col-md-3">
             <p class="mt-2 mb-0 font-weight-bold">Page</p>
             <div class="media">
                 <div class="media-body">
                     <div class="mt-0 font-size-12">
                         #details.pgname#
                     </div>
                 </div>
             </div>
         </div>
        
        
                 <div class="col-md-3">
             <p class="mt-2 mb-0 font-weight-bold">Username</p>
             <div class="media">
                 <div class="media-body">
                     <div class="mt-0 font-size-12">
                         #details.username#
                     </div>
                 </div>
             </div>
         </div>
        
        
        
        
                 <div class="col-md-3">
             <p class="mt-2 mb-0 font-weight-bold">Created</p>
             <div class="media">
                 <div class="media-body">
                     <div class="mt-0 font-size-12">
                         #dateformat(createddate,'mm/dd/yyyy')# at #timeformat(createddate)# 
                     </div>
                 </div>
             </div>
         </div>
                                            

                                      

                    
    
        
        
        
    
    
         <div class="col-md-3">
             <p class="mt-2 mb-0 font-weight-bold">Status</p>
             <div class="media">
                 <div class="media-body">
                     <div class="mt-0 font-size-12">
                         #details.ticketstatus#
                     </div>
                 </div>
             </div>
         </div>

        
                 <div class="col-md-3">
             <p class="mt-2 mb-0 font-weight-bold">Type</p>
             <div class="media">
                 <div class="media-body">
                     <div class="mt-0 font-size-12">
                         #details.tickettype#
                     </div>
                 </div>
             </div>
         </div>
        
        
        
                 <div class="col-md-3">
             <p class="mt-2 mb-0 font-weight-bold">Environment</p>
             <div class="media">
                 <div class="media-body">
                     <div class="mt-0 font-size-12">
                         <cfif #details.environ# is "D" ><span style="color:red;">Development</span><cfelse>Production</cfif>
                     </div>
                 </div>
             </div>
         </div>
        
        
        
        
                 <div class="col-md-3">
             <p class="mt-2 mb-0 font-weight-bold">Priority</p>
             <div class="media">
                 <div class="media-body">
                     <div class="mt-0 font-size-12">
                         #details.ticketpriority#
                     </div>
                 </div>
             </div>
         </div>   
                     
                     
                <cfif #details.ticketdetails# is not "">            
                 <div class="col-md-12">
             <p class="mt-2 mb-0 font-weight-bold">Details</p>
             <div class="media">
                 <div class="media-body">
                     <div class="mt-0 font-size-12">
                           #details.ticketdetails#
                     </div>
                 </div>
             </div>
         </div>   
                    
                    </cfif> 
                     
                     
                     
               <cfif #details.ticketresponse# is not "">      
                     
                                     <div class="col-md-12">
             <p class="mt-2 mb-0 font-weight-bold">Developer Response</p>
             <div class="media">
                 <div class="media-body">
                     <div class="mt-0 font-size-12">
                         #details.ticketresponse#
                     </div>
                 </div>
             </div>
         </div>      
        
             </cfif>       
        
        
           <div class="col-md-12">
         <p>&nbsp;</p>
                     </div>
        
                     <h5 class="col-md-12">Progress & Execution</h5>
        
        
        
        
        
        
        
        
        
   
                                      

                    
    
        
        
        
    
 

        
                 <div class="col-md-3">
             <p class="mt-2 mb-0 font-weight-bold">Est. Hours</p>
             <div class="media">
                 <div class="media-body">
                     <div class="mt-0 font-size-12">
                         <cfif #details.esthours# is not "">#details.esthours#<cfelse>Unknown</cfif>
                     </div>
                 </div>
             </div>
         </div>
                     
                                          
 
                     
                      <div class="col-md-3">
             <p class="mt-2 mb-0 font-weight-bold">Assigned Release.</p>
             <div class="media">
                 <div class="media-body">
                     <div class="mt-0 font-size-12">
                         
                       <cfif #details.verid# is not "">
                    #details.major#.#details.minor#.#details.patch#.#details.version#     
                    </cfif>
                         
                         
                     </div>
                 </div>
             </div>
         </div>    
                     
                     
        
                            <div class="col-md-3">
             <p class="mt-2 mb-0 font-weight-bold">Est. Release Date</p>
             <div class="media">
                 <div class="media-body">
                     <div class="mt-0 font-size-12">
                      <cfif #details.releasedate# is not "">#dateformat(details.releasedate,'mm-dd-yyyy')#</cfif>
                     </div>
                 </div>
             </div>
         </div> 
                     
                     
                     
                     
        
                 <div class="col-md-3">
             <p class="mt-2 mb-0 font-weight-bold">Implementation Date</p>
             <div class="media">
                 <div class="media-body">
                     <div class="mt-0 font-size-12">
                         <cfif #details.ticketCompletedDate# is not "">#dateformat(details.ticketCompletedDate,'mm-dd-yyyy')#</cfif>
                     </div>
                 </div>
             </div>
         </div>
        
      

    
                       
       
   
        
                
                       <div class="col-md-6">
             <p class="mt-2 mb-0 font-weight-bold">Patch Note (Displays to users in Release History)</p>
             <div class="media">
                 <div class="media-body">
                     <div class="mt-0 font-size-12">
                         #details.patchNote#
                     </div>
                 </div>
             </div>
         </div>      
    
                                <cfif #details.testingscript# is not "">
                       <div class="col-md-12">
             <p class="mt-2 mb-0 font-weight-bold">Testing Script</p>
             <div class="media">
                 <div class="media-body">
                     <div class="mt-0 font-size-12">
                         #details.testingscript#
                     </div>
                 </div>
             </div>
         </div>      
                     
             </cfif>        
                     
                     
                   <cfif #details.customtestpagename# is not "">
                       <div class="col-md-3">
             <p class="mt-2 mb-0 font-weight-bold">Custom Test Page Name (Optional)</p>
             <div class="media">
                 <div class="media-body">
                     <div class="mt-0 font-size-12">
                         #details.customtestpagename#
                     </div>
                 </div>
             </div>
         </div>    
             </cfif>        
                     
                  <cfif #details.customtestpagelink# is not "">                     
                    <div class="col-md-3">
             <p class="mt-2 mb-0 font-weight-bold">Custom Test Page Link (Optional)</p>
             <div class="media">
                 <div class="media-body">
                     <div class="mt-0 font-size-12">
                 <a href="#details.customtestpagelink#" target="test" >#details.customtestpagelink#</a>
                     </div>
                 </div>
             </div>
         </div>    
                     </cfif>    
                     
             <div class="col-md-12"><form action="/include/ticket_email_client.cfm">
                 <input type="submit" value="Email Client" />
                 
                 <input type="hidden" name="recid" value="#recid#" />
                 </form></div>        
                     
                     
    </Cfoutput>
    
    
               							
                               
                                        
                                        
                </div>
            </div>
        </div>
    </div>
</div>      
            
            
<cfinclude template="/include/qry/ticketlog.cfm" />            
            
               <style>
.wrapit {

    /* css-3 */
    white-space: -o-pre-wrap; 
    word-wrap: break-word;
    white-space: pre-wrap; 
    white-space: -moz-pre-wrap; 
    white-space: -pre-wrap; 

}
   </style>
      

<div class="row">
    <div class="col-12">
        <div class="card">
            <div class="card-body">
                <h4 class="header-title">Ticket Log</h4>
                <p class="text-muted font-13 mb-4">
                </p>
                <table id="basic-datatable" class="table dt-responsive nowrap w-100 table-striped" role="grid">
                    <thead>
                        <cfloop query="results"  endrow="1">
                            <cfoutput>
                                <cfif (Results.CurrentRow MOD 2) >
                                    <Cfset rowtype="Odd" />
                                    <cfelse>
                                        <Cfset rowtype="Even" />
                                </cfif>


                                <tr class="#rowtype#">
                               
            
                                    <th>#head2#</th>
                             <th>#head5#</th> 
                                    <th>#head4#</th>
                              
                        
                    
                                </tr>
                            </cfoutput>
                        </cfloop>
                    </thead>
                    <tbody>
                        <cfloop query="results">



                                    <cfoutput>
 

                                            <tr>
                                                
                                     
                                  
                                                     <td nowrap="nowrap">#datetimeformat("#results.col2#","short")#</td>
                     <td nowrap="nowrap">#results.col5#</td> 
                                                
                                       
                                                <td class="wrapit">#results.col1# #results.col4#</td>
                                         
                                            
                                            </tr>
                                        
                                      
                                        
                                        
                                        
                                        
                                        
                                        
                                            
                                    </cfoutput>
                        </cfloop>
                        
                
										</tbody>
										</table>
										</div>
										<!-- end card body-->
        </div> <!-- end card -->
    </div><!-- end col-->
</div>



            
            
            
            
            
            
            
            
            </cfif>	
         
                        
             

<cfset script_name_include="/include/#ListLast(GetCurrentTemplatePath(), "\")#" /><cfinclude template="/include/bigbrotherinclude.cfm" /> 
