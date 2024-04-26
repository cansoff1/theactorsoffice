<cfset dbug="n" />
 
<cfparam name="idlist" default="0" />

<Cfif not #isdefined('session.idlist')#>
<cfset session.idlist = idlist />

</cfif>

 <cfif #idlist# is "0" and #session.idlist# is not "0">
 <cfset idlist = session.idlist />

 </cfif>
<cfoutput>idlist: #idlist#</cfoutput><cfabort>
 <CFINCLUDE template="/include/remote_load.cfm" />




 

<cfquery name="BatchDetails"  datasource="#dsn#"  >
SELECT contactid,recordname FROM contactdetails  d 
    


WHERE d.contactid IN (#idlist#)
</cfquery>
            




   <Cfset currentStartDate=dateFormat(Now(),'yyyy-mm-dd') />


<cfparam name="contact_expand" default="true" />


<cfif #idlist# is "0">
    <Cfoutput>
    <cflocation url="/app/contacts/?bulk_no=0&idlist=#idlist#" />
</Cfoutput>
</cfif>


<cfparam name="contactcheckvisible" default="false" />

<cfparam name="maintenance_expand" default="false" />

<cfparam name="bytag" default="" />

<cfparam name="target_expand" default="false" />

<cfparam name="followup_expand" default="false" />

<cfparam name="all_expand" default="false" />

<cfparam name="pgaction" default="view" />

<cfparam name="systemID" default="0" />

<cfinclude template="/include/qry/lastupdates.cfm" />

<cfset session.idlist=idlist />

<cfset no_deleted=0 />

<cfset no_skipped=0 />

<cfset no_added=0 />

<cfloop query="BatchDetails">

    <cfif #dbug# is "Y">
        <cfoutput>
            <h2>Contact: #batchdetails.recordname# (#batchdetails.contactid#) </h2>
        </cfoutput>
    </cfif>

    <cfset new_contactid=BatchDetails.contactid />

    <cfset new_systemtype=new_systemtype />



    <Cfset new_suStartDate=dateFormat(Now(),'yyyy-mm-dd') />

    <Cfset new_currentStartDate=dateFormat(Now(),'yyyy-mm-dd') />

    <cfquery datasource="#dsn#" name="FindScope" maxrows="1">
        SELECT d.contactid
        FROM tags_user tu
        INNER JOIN taousers u ON u.userid = tu.userid
        INNER JOIN contactdetails d ON d.userid = u.userid
        INNER JOIN contactitems i ON i.contactID = d.contactid
        WHERE i.valuecategory = 'Tag'
        AND i.valuetype = 'Tags'
        AND tu.tagtype = 'C'
        and tu.tagname  = i.valuetext
        AND d.contactid = #new_contactid#
    </cfquery>



    <cfif #findscope.recordcount# is "1">

        <cfset new_systemscope="Casting Director" />

             <cfif #dbug# is "Y">

            <cfoutput>
            <h4>#new_systemtype# -  Casting Director</h4>
            </cfoutput>

        </cfif>


        <cfelse>

            <cfset new_systemscope="Industry" />

            <cfif #dbug# is "Y">

            <cfoutput>
            <h4>#new_systemtype# -  Industry</h4>
            </cfoutput>

        </cfif>
           

    </cfif>

    <cfquery datasource="#dsn#" name="FindSystem" maxrows="1">
        Select systemid from fusystems WHERE systemtype =
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#new_systemtype#" />
        AND SystemScope =
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#new_systemscope#" />
    </cfquery>

    <cfif #findsystem.recordcount# is "1">

        <cfset new_systemid=findsystem.systemid />

        <cfif #dbug# is "Y">

            <cfoutput>
                <p>new_systemid: #findsystem.systemid#</p>
            </cfoutput>

        </cfif>


        <cfquery datasource="#dsn#" name="FindActive">
            SELECT fc.suID
            FROM fusystemusers fc
            WHERE fc.contactID = #new_contactid#
            AND fc.suStatus = 'Active'
        </cfquery>


        <cfif #keeplist# is "skip">

            <cfif #dbug# is "Y">

                <cfoutput>
                    <p>keeplist: skip</p>
                    <p>Number of active systems for #batchdetails.recordname#: #findactive.recordcount#</p>
                </cfoutput>

            </cfif>



            <cfif #findactive.recordcount# is "0">

                <cfif #dbug# is "Y">

                    <p>Since the number of active systems is zero, add a new system.</p>

                </cfif>



                <cfinclude template="/include/AddSystemToContact.cfm" />
                
                
            <cfelse>
                
                <cfoutput>
                
                <cfset no_skipped = #no_skipped# + 1 />
                    
                </cfoutput>
                
                <cfif #dbug# is "Y">
                    <cfoutput>

                    <p>Skipping because it already has #findactive.recordcount# active system(s) </p>
                    <p>Total skipped: #no_skipped#</p>
                        
                    </cfoutput>
                    
                </cfif>
                
                

            </cfif>

        </cfif>

        <cfif #keeplist# is "replace">

            <!--- Check if the contact already has this system type active --->

            <cfquery datasource="#dsn#" name="findsame">
                select * from fusystemusers_tbl
                where contactid = #new_contactid#
                and sustatus = 'Active'
                and isdeleted = 0
                and systemid = #new_systemid#
            </cfquery>

            <cfif #dbug# is "Y">

                <cfoutput>
                    <p>keeplist: replace
                    <BR>Number of active identical systems of this same type: #findsame.recordcount#</p>
                </cfoutput>

            </cfif>

            <!--- If it doesn't already have this identical type --->

            <cfif #findsame.recordcount# is "0">

                <cfif #dbug# is "Y">

                    <p>Since the number of identical systems is zero, just delete any active systems.</p>

                </cfif>

                <!--- Delete all of the contact's systems that are currently active  --->
                <cfquery datasource="#dsn#" name="delete" result="resultqryUpdateCell">
                    UPDATE fusystemusers_tbl
                    set isdeleted = 1
                    ,sunotes = 'Deleted via batch update'
                    WHERE contactID = #new_contactid#
                    AND suStatus = 'Active'
                    and isdeleted = 0
                </cfquery>

                <!--- resultsqryUpdateCell is the total systems deleted  --->

                <!--- add resultsqryUpdateCell to the current delete count  --->

                <cfoutput>
                    <cfset no_deleted=#no_deleted# + #resultqryUpdateCell.RecordCount# />
                </cfoutput>

                <cfif #dbug# is "Y">
                    <cfoutput>
                        <p>Total contact system's deleted: #resultqryUpdateCell.RecordCount#</p>
                        <p>no_deleted: #no_deleted#</p>

                    </cfoutput>
                </cfif>
                
                 <cfif #dbug# is "Y">

                    <p>Add a new system.</p>

                </cfif>



                <cfinclude template="/include/AddSystemToContact.cfm" />
                

                <!--- If it DOES already has this system type active, let's skip it --->

                <cfelse>

                    <!--- no_skipped is the total systems skipped  --->

                    <!--- add 1 to the current skipped count  --->

                    <cfoutput>
                        <cfset no_skipped=#no_skipped# + 1 />
                    </cfoutput>


                    <cfif #dbug# is "Y">
                        <cfoutput>
                            <p>System skipped</p>
                            <p>no_skipped: #no_skipped#</p>
                        </cfoutput>
                    </cfif>




            </cfif>



        </cfif>


        <cfelse>
    <p>Aborted</p>
            
                       <cfif #dbug# is "Y">
                        <cfoutput>
                            <p>Aborted - No System Found!!!</p>
                      
                           </cfoutput>
                    </cfif>
            
   

    </cfif>

</cfloop>










<cfoutput><P>ID LIST: #session.idlist#<BR>System: #new_systemtype#<BR>KEEPLIST: #keeplist#</P>
    <p>no_skipped: #no_skipped#<BR>no_deleted: #no_deleted#<BR>no_added: #no_added#</p>
    
    
 
    </cfoutput>

<cfset script_name_include="/include/#ListLast(GetCurrentTemplatePath(), " \")#" />
<cfinclude template="/include/bigbrotherinclude.cfm" />

<cfset session.pgaction="bulk" />

<cfif #dbug# is "N">

    <cflocation url="/app/contacts/?bt=system&d=#no_deleted#&s=#no_skipped#&a=#no_added#&t=#new_systemtype#" />

</cfif>
