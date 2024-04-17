<script>
function unlock(){
    document.getElementById('buttonSubmit').removeAttribute("disabled");
}
</script>
<cfinclude template="/include/qry/auditionsimport.cfm" />

<cfparam name="step" default="1" />

<cfif #isdefined('uploadid')#>
   <CFINCLUDE template="/include/remote_load.cfm" />
    
    <cfquery datasource="#dsn#" name="upload_details"      >
    select audprojectid from auditionsimport where uploadid = #uploadid# and status = 'Added'
    </cfquery>
    
    <cfset conlist = valuelist(upload_details.audprojectid) />
  




    


    <cfquery datasource="#dsn#" name="results"      >
    SELECT ai.id,
p.audprojectid AS recid
,ai.uploadid
    ,p.audprojectid
,r.audroleid
,st.audstep
,st.stepcss
,r.iscallback
,r.isredirect
,ca.audcatname   
,r.ispin
,r.isbooked
,st.stepcss
,'Date/Time' AS head1
,'Project' AS head2
,'Category' as head3
,'Role' AS head4
,'Source' as head5
,'Import Status' as head6
,ai.projdate AS col1
,ai.projdate as col1b
,ai.projname AS col2
,ai.audcatname as col3
,ai.audrolename as col4
,ai.audsource AS col5
,concat(ai.cdfirstname," ", ai.cdlastname) as contactname
,ai.audsubcatname

,CASE
WHEN ai.callback_yn = "y" THEN 'Callback'
WHEN ai.redirect_yn = "y" THEN 'Redirect'
WHEN ai.pin_yn = "y" THEN 'Pin'
WHEN ai.booked_yn = "y" THEN 'Book'
ELSE 'Audition'
END AS col6a,
        ai.`status` as col6
 FROM auditionsimport ai

 left join audprojects p ON  p.audprojectID = ai.audprojectID
    
    LEFT join audroles r on p.audprojectID = r.audprojectID
 
 LEFT JOIN events a ON r.audroleid = a.audroleid 
 
 LEFT JOIN audsources s ON s.audSourceID = r.audSourceID
 LEFT JOIN contactdetails c ON c.contactID = p.contactid
 LEFT JOIN contactdetails c2 ON c2.contactID = r.contactid
 LEFT JOIN audroletypes rt ON rt.audroletypeid = r.audroletypeid
 LEFT JOIN audsteps st ON st.audstepid = a.audstepid
LEFT join audsubcategories sc on sc.audsubcatid = p.audsubcatid
    LEFT join audcategories ca on ca.audcatid = sc.audcatid
 
    LEFT JOIN audcontacts_auditions_xref x on x.audprojectid = p.audprojectid
    
    left join contactdetails c3 on c3.contactid = x.contactid

  WHERE ai.uploadid = <Cfqueryparam value="#uploadid#" cfsqltype="CF_SQL_INTEGER" />

</cfquery>

                   <div class="row">

    <div class="col-12">

        <div class="card">

            <div class="card-body">

                <h4 class="header-title">

                  Events imported <span class="small right"></span>

                </h4>

                <div class="d-flex justify-content-between">

                    <div class="float-left">


                        <cfoutput>

                            <p>#results.recordcount# events were imported. Click on a name to view details.

                            </p>

                        </cfoutput>

                    </div>

                </div>

 
  <table id="basic-datatable" class="table display dt-responsive nowrap w-100 table-striped" role="grid">
                    <thead>
                        <cfoutput query="results" maxrows="1">

                            <cfif (Results.CurrentRow MOD 2)>
                                <Cfset rowtype="Odd" />
                                <cfelse>
                                    <Cfset rowtype="Even" />
                            </cfif>


                            <tr class="#rowtype#">
                                <th>#head1#</th>
                                <th>#head2#</th>
                                <th>#head3#</th>
                                <th>#head4#</th>
                                <th>#head5#</th>
                                     <th>#head6#</th>

                            </tr>
                        </cfoutput>
                    </thead>
                    <tbody>
                        <cfloop query="results">

   <cfquery datasource="#dsn#" name="errs"      >
        select error_msg FROM auditionsimport_error WHERE id = #results.id#
            </cfquery>
                  <Cfset err_list = valuelist(errs.error_msg) />  

                            <cfoutput>

 

                                <cfset cur_link="/app/audition/?audprojectid=#results.audprojectid#" />



                                <tr role="row">
                                    <td>

                                        <a href="#cur_link#" class="text-body font-weight-semibold">

                                            
                                            <cfset myDateTime = results.col1b> <!--- replace now() with your datetime field --->

<cfset myFormattedDateTime = DateFormat(myDateTime, "mm/dd/yyyy") & " " & TimeFormat(myDateTime, "hh:mm:ss tt")>

 #myFormattedDateTime# 

    
    

                                        </a>
                                    </td>
                                    <td>
                                    <cfif #results.audprojectid# is not "">
                                    <A href="#cur_link#">#col2#</A>
                                    <cfelse>
#col2#
                                    </cfif>
                                    </td>
                                    <td>#col3#</td>
                                    <td>#col4#</td>
                                    <td>#col5#</td>
                                    <td>
                                    <Cfif #col6# is "invalid">

                                    <A href="" title="#err_list#"><font color="red">Invalid <i class="fe-search"></i></A>
                                    <Cfelse>
                                    #col6#
                                    </cfif>
                                    </td>

                                </tr>
                            </cfoutput>
                        </cfloop>
                    </tbody>
                </table>
     
            </div></div></div></div>

<cfelse>

    
    
                  <div class="row">

    <div class="col-12">

        <div class="card">

            <div class="card-body">
                
                
                
 
<h5>Step One: Import Template</h5>    
          
<p>Download the <A href="/include/auditionimporttemplates.xlsx" target="new"><strong><i class="fe-upload"></i> Import Template</strong></A> to copy and paste all the events you'd like to import. <strong>Imports must be in this format.</strong></p>
        
        
             <cfif #isdefined('dsfdsfdfs')#>
<A href="/include/Sample.xlsx" target="new"><button  class="btn btn-xs btn-primary waves-effect mb-2 waves-light" >Download</button></A>    </cfif>
 
 
<p></p><p></p><p></p><p></p>

    <h5>Step Two: Upload Template</h5>   
    <p>Once you've populated and saved the Import Template as an .xlsx file, select the file and upload.</p>
                        
                        
                        
                        

                <form action="/include/upload_audition.cfm" method="post" enctype="multipart/form-data" id="upload" >
    
    <cfoutput>

    <input type="hidden" name="userid" value="#userid#" />

    </cfoutput>


    <input name="file" onchange="unlock();" type="file"  />
<p></p><p></p><p></p>
    <input type="submit" value="Upload" class="btn btn-xs btn-primary waves-effect mb-2 waves-light" style="background-color: #406e8e; border: #406e8e" id="buttonSubmit" disabled >
                                        
</form>   
               
            
               
               
                        
                        
                        
                        
                  
 

<div class="dropzone-previews mt-3" id="file-previews"></div>  
 

</cfif>




        </div></div>    
                        
                        
                   <div class="row">

    <div class="col-12">

        <div class="card">

            <div class="card-body">

                <h4 class="header-title">

                    Import History <span class="small right"></span>

                </h4>

                <div class="d-flex justify-content-between">

                    <div class="float-left">
<cfinclude template="/include/qry/auditionsimport.cfm" />

                        <cfoutput>

                            <p> You have <strong>#imports.recordcount#</strong> imports.

                            </p>

                        </cfoutput>

                    </div>

                </div>




                <table id="basic-datatable" class="table dt-responsive nowrap w-100 table-striped" role="grid">
                    <thead>



                        <tr class="#rowtype#">
                            <th width="50">Total Import</th>
                            <th>Batch ID</th>
                            <th>Date</th>
                            <th>Time</th>
            
                        </tr>


                    </thead>

                    <tbody>
                        <cfloop query="imports">



                            <cfoutput>



                                <TR>
                                    <TD><a title="View" href="/app/auditions/?byimport=#imports.uploadid#">#imports.total_adds#</i></a></TD>
                                    <TD>#imports.uploadid#</TD>
                                    <TD>#dateformat(imports.timestamp)#</TD>
                                    <TD>#timeformat(imports.timestamp)#</TD>
                                
                                </TR>

                            </cfoutput>

                        </cfloop>

                    </tbody>
                </table>

            </div>
        </div>



                       </div>
                       
                      </div>






        <script>
            $(document).ready(function() {
                $("#basic-datatable").DataTable({


                    "pageLength": 100,
                    responsive: true,
                    language: {
                        paginate: {
                            previous: "<i class='mdi mdi-chevron-left'>",
                            next: "<i class='mdi mdi-chevron-right'>"
                        }
                    },
                    drawCallback: function() {
                        $(".dataTables_paginate > .pagination").addClass("pagination-rounded")
                    }
                });
                var a = $("#datatable-buttons").DataTable({
                    lengthChange: !1,
                    buttons: [{
                        extend: "copy",
                        className: "btn-light"
                    }, {
                        extend: "print",
                        className: "btn-light"
                    }, {
                        extend: "pdf",
                        className: "btn-light"
                    }],
                    language: {
                        paginate: {
                            previous: "<i class='mdi mdi-chevron-left'>",
                            next: "<i class='mdi mdi-chevron-right'>"
                        }
                    },
                    drawCallback: function() {
                        $(".dataTables_paginate > .pagination").addClass("pagination-rounded")
                    }
                });

            });

        </script>

        
        
        
        
        
     
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
