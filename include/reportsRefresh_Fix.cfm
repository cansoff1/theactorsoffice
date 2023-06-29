<cfparam name="new_rangeid" default="1" />

<cfparam name="anchortag" default="" />

<cfparam name="customstart" default="" />

<cfparam name="customend" default="" />

<cfparam name="new_audcatid" default="1" />

<cfparam name="refreshdata_yn" default="N" />

<CFINCLUDE template="/include/remote_load.cfm" />

         <cfquery datasource="#dsn#" name="x">
SELECT DISTINCT userid FROM events WHERE userid NOT IN (
SELECT distinct i.userid
FROM reportitems i 
INNER JOIN reports_user ru 
ON ru.ID = i.id
WHERE i.userid = ru.userid)
</cfquery>


<Cfloop query="x">
    
    <cfset new_userid = x.userid />

      <cfset i=0 />

        <cfquery datasource="#dsn#" name="delete_all">
            DELETE from reportitems
            where userid = #new_userid#
        </cfquery>



<cfquery datasource="#dsn#" name="rangeselected">
    SELECT
    rangeid,
    rangename,
    rangestart,
    rangeend
    FROM reportranges where rangeid = #new_rangeid#
</cfquery>

<cfoutput>
        <cfset new_rangestart="#dateformat('#rangeselected.rangestart#','YYYY-MM-dd')#" />
    <cfset new_rangeend="#dateformat('#rangeselected.rangeend#','YYYY-MM-dd')#" />
</cfoutput>


<cfquery datasource="#dsn#" name="report_10">
    SELECT count(p.audprojectID) as totals,
    'Number of Callbacks' as label,
    'Auditions' as itemDataset
    FROM audprojects p
    INNER join audroles r on p.audprojectID = r.audprojectID
    WHERE r.isdeleted IS FALSE
    AND p.isDeleted IS FALSE
    AND r.iscallback = 1
    AND p.userid = #new_userid#
    AND p.projdate >= <cfqueryparam cfsqltype="cf_sql_date" value="#rangeselected.rangestart#" /> 
    AND p.projdate <= <cfqueryparam cfsqltype="cf_sql_date" value="#rangeselected.rangeend#" />
</cfquery>

  
        <cfloop query="report_10">

            <cfoutput>
                
                <cfset i=#i# + 1 />
                
                <cfset new_reportid="10" />
                
                <cfset new_label="#report_10.label#" />
                
                <cfset new_itemValueInt="#report_10.totals#" />
                
                <cfset new_itemDataset="#report_10.itemDataset#" />
                
            </cfoutput>
            
            <cfinclude template="/include/Insert_ReportItem.cfm" />

        </cfloop>
    
        <cfset i=0 />

        <cfquery datasource="#dsn#" name="report_4_loop">
            SELECT audstepid, 4 as new_reportid,audtypeid AS NEW_audtypeid, audtype, audtype as new_label,audstep AS new_itemDataset
            from audtypes, audsteps
            WHERE audstepid IN (1,2)
            ORDER BY audtypes.audtype, audsteps.audstep
        </cfquery>

        <Cfloop query="report_4_loop">

            <cfoutput>
                
                <cfset i=#i# + 1 />
                
            </cfoutput>

            <cfquery datasource="#dsn#" name="findid">
                SELECT r.ID as new_iD
                FROM reports_user r
                WHERE r.userid = #new_userid# and r.reportid = #new_reportid#
            </cfquery>

            <cfoutput>

                
                <cfif #findid.recordcount# is "1">
                <cfset new_ID=#findid.new_id# />
                <cfelse>
                    
                    <cfset new_ID=#findid.new_id# />
                
                </cfif>
                
                
          
                
             </cfoutput>
           
            <cfquery datasource="#dsn#" name="Insert_ReportItems" result="result">
                INSERT INTO `reportitems` (
                `itemLabel`, 
                `itemOrderNo`, 
                `itemValueInt`, 
                `ID`, 
                `itemDataset`, 
                `userid`)
                VALUES (
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#report_4_loop.new_label#" />,
                <cfqueryparam cfsqltype="cf_sql_integer" value="#i#" />, 
               <cfqueryparam cfsqltype="cf_sql_integer" value="0" />, 
                <cfqueryparam cfsqltype="cf_sql_integer" value="0" />,
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#report_4_loop.new_itemDataSet#" />, 
                <cfqueryparam cfsqltype="cf_sql_integer" value="#int(userid)#" />
                );
            </cfquery>

            <cfset new_itemid=result.GENERATEDKEY />

            <cfquery datasource="#dsn#" name="Findit">
                SELECT
                count(r.audroleid) as totals
                from
                audtypes t
                left join events a on a.audtypeid = t.audtypeid
                left join audroles r on a.audroleid = r.audroleid
                left join audprojects p on p.audprojectid = r.audprojectid
                LEFT JOIN audsteps st ON st.audstepid = a.audstepid
                WHERE a.isDeleted = 0
                AND p.isdeleted = 0
                and a.audstepid = #report_4_loop.audstepid#
                and t.audtypeid = #report_4_loop.new_audtypeid#
    AND p.projdate >= <cfqueryparam cfsqltype="cf_sql_date" value="#rangeselected.rangestart#" /> 
    AND p.projdate <= <cfqueryparam cfsqltype="cf_sql_date" value="#rangeselected.rangeend#" />
AND p.userid=#new_userid# 
</cfquery>

<cfif #findit.recordcount# is "0">

    <cfset new_itemvalueint=0 />

                        <cfelse>

                            <cfoutput>
                                
                                <cfset new_itemvalueint=#int(FindIt.totals)# />
                                
                            </cfoutput>
                            
                    </cfif>
    
                    <cfquery datasource="#dsn#" name="update">
                        update reportitems set itemValueInt =
                        <cfqueryparam cfsqltype="cf_sql_integer" value="#new_itemvalueint#" />
                        where itemid =
                        <cfqueryparam cfsqltype="cf_sql_integer" value="#new_itemid#" />
                    </cfquery>

        </Cfloop>

        <cfquery datasource="#dsn#" name="report_11">
            SELECT count(p.audprojectID) as totals,
            'Number of Redirects' as label,
            'Auditions' as itemDataset
            FROM audprojects p
            INNER join audroles r on p.audprojectID = r.audprojectID
            WHERE r.isdeleted IS FALSE
            AND p.isDeleted IS FALSE
            AND r.isredirect = 1
            AND p.userid = #new_userid#
    AND p.projdate >= <cfqueryparam cfsqltype="cf_sql_date" value="#rangeselected.rangestart#" /> 
    AND p.projdate <= <cfqueryparam cfsqltype="cf_sql_date" value="#rangeselected.rangeend#" />
        </cfquery>

                <cfset i=0 />

                <cfloop query="report_11">

                    <cfoutput>
                        
                        <cfset i=#i# + 1 />
                        
                        <cfset new_reportid="11" />
                        
                        <cfset new_label="#report_11.label#" />
                        
                        <cfset new_itemValueInt="#report_11.totals#" />
                        
                        <cfset new_itemDataset="#report_11.itemDataset#" />
                        
                    </cfoutput>

                    <cfinclude template="/include/Insert_ReportItem.cfm" />

                </cfloop>

                <cfquery datasource="#dsn#" name="report_12">
                    SELECT count(p.audprojectID) as totals,
                    'Number of Pins/Avails' as label,
                    'Auditions' as itemDataset
                    FROM audprojects p
                    INNER join audroles r on p.audprojectID = r.audprojectID
                    WHERE r.isdeleted IS FALSE
                    AND p.isDeleted IS FALSE
                    AND r.ispin = 1
                    AND p.userid = #new_userid#
    AND p.projdate >= <cfqueryparam cfsqltype="cf_sql_date" value="#rangeselected.rangestart#" /> 
    AND p.projdate <= <cfqueryparam cfsqltype="cf_sql_date" value="#rangeselected.rangeend#" />
                </cfquery>

                        <cfset i=0 />

                        <cfloop query="report_12">

                            <cfoutput>
                                
                                <cfset i=#i# + 1 />
                                
                                <cfset new_reportid="12" />
                                
                                <cfset new_label="#report_12.label#" />
                                
                                <cfset new_itemValueInt="#report_12.totals#" />
                                
                                <cfset new_itemDataset="#report_12.itemDataset#" />
                                
                            </cfoutput>

                            <cfinclude template="/include/Insert_ReportItem.cfm" />

                        </cfloop>

                        <cfquery datasource="#dsn#" name="report_17">
                            SELECT count(p.audprojectID) as totals,
                            'Number of Auditions' as label,
                            'Auditions' as itemDataset
                            FROM audprojects p
                            INNER join audroles r on p.audprojectID = r.audprojectID
                            WHERE r.isdeleted IS FALSE
                            AND p.isDeleted IS FALSE
                            AND p.userid = #new_userid#
    AND p.projdate >= <cfqueryparam cfsqltype="cf_sql_date" value="#rangeselected.rangestart#" /> 
    AND p.projdate <= <cfqueryparam cfsqltype="cf_sql_date" value="#rangeselected.rangeend#" />
                        </cfquery>

                                <cfset i=0 />

                                <cfloop query="report_17">

                                    <cfoutput>
                                        
                                        <cfset i=#i# + 1 />
                                        
                                        <cfset new_reportid="17" />
                                        
                                        <cfset new_label="#report_17.label#" />
                                        
                                        <cfset new_itemValueInt="#report_17.totals#" />
                                        
                                        <cfset new_itemDataset="#report_17.itemDataset#" />
                                        
                                    </cfoutput>

                                    <cfinclude template="/include/Insert_ReportItem.cfm" />

                                </cfloop>

                                <cfquery datasource="#dsn#" name="report_13">
                                    SELECT count(p.audprojectID) as totals,
                                    'Number of Bookings' as label,
                                    'Auditions' as itemDataset
                                    FROM audprojects p
                                    INNER join audroles r on p.audprojectID = r.audprojectID
                                    WHERE r.isdeleted IS FALSE
                                    AND p.isDeleted IS FALSE
                                    AND r.isbooked = 1
                                    AND p.userid = #new_userid#
    AND p.projdate >= <cfqueryparam cfsqltype="cf_sql_date" value="#rangeselected.rangestart#" /> 
    AND p.projdate <= <cfqueryparam cfsqltype="cf_sql_date" value="#rangeselected.rangeend#" />
                                </cfquery>

                                        <cfset i=0 />

                                        <cfloop query="report_13">

                                            <cfoutput>
                                                
                                                <cfset i=#i# + 1 />
                                                
                                                <cfset new_reportid="13" />
                                                
                                                <cfset new_label="#report_13.label#" />
                                                
                                                <cfset new_itemValueInt="#report_13.totals#" />
                                                
                                                <cfset new_itemDataset="#report_13.itemDataset#" />
                                                
                                            </cfoutput>

                                            <cfinclude template="/include/Insert_ReportItem.cfm" />

                                        </cfloop>

                                        <cfquery datasource="#dsn#" name="report_3">
                                            SELECT
                                            count(p.audprojectid) as totals,
                                            c.audcatname as label,
                                            'Auditions' as itemDataset
                                            FROM audprojects p
                                            INNER join audroles r on p.audprojectID = r.audprojectID
                                            INNER JOIN audroletypes rt ON rt.audroletypeid = r.audroletypeid
                                            INNER JOIN audcategories c ON c.audCatId = rt.audcatid

                                            WHERE r.isdeleted IS FALSE
                                            AND p.isDeleted IS FALSE

                                            AND p.userid = #new_userid#
    AND p.projdate >= <cfqueryparam cfsqltype="cf_sql_date" value="#rangeselected.rangestart#" /> 
    AND p.projdate <= <cfqueryparam cfsqltype="cf_sql_date" value="#rangeselected.rangeend#" />
                                                                           
                                            GROUP BY c.audcatname ORDER BY c.audcatname
                                        </cfquery>

                                                <cfset i=0 />

                                                <cfloop query="report_3">

                                                    <cfoutput>
                                                        <cfset i=#i# + 1 />
                                                        <cfset new_reportid="3" />
                                                        <cfset new_label="#report_3.label#" />
                                                        <cfset new_itemValueInt="#report_3.totals#" />
                                                        <cfset new_itemDataset="#report_3.itemDataset#" />
                                                    </cfoutput>

                                                    <cfinclude template="/include/Insert_ReportItem.cfm" />

                                                </cfloop>

                                                <cfquery datasource="#dsn#" name="report_5">
                                                    SELECT
                                                    count(p.audprojectid) as totals,
                                                    e.essencename as label,
                                                    'Auditions' as itemDataset
                                                    FROM audprojects p
                                                    INNER join audroles r on p.audprojectID = r.audprojectID
                                                    INNER JOIN audessences_audtion_xref x ON x.audroleid = r.audroleid
                                                    INNER join essences e on e.essenceid = x.essenceid
                                                    WHERE r.isdeleted IS FALSE
                                                    AND p.isDeleted IS FALSE
                                                    AND p.userid = #new_userid#
    AND p.projdate >= <cfqueryparam cfsqltype="cf_sql_date" value="#rangeselected.rangestart#" /> 
    AND p.projdate <= <cfqueryparam cfsqltype="cf_sql_date" value="#rangeselected.rangeend#" />
                                                GROUP BY e.essencename ORDER BY e.essencename 
                                               </cfquery>


                                                        <cfset i=0 />

                                                        <cfloop query="report_5">

                                                            <cfoutput>
                                                                <cfset i=#i# + 1 />
                                                                <cfset new_reportid="5" />
                                                                <cfset new_label="#report_5.label#" />
                                                                <cfset new_itemValueInt="#report_5.totals#" />
                                                                <cfset new_itemDataset="#report_5.itemDataset#" />
                                                            </cfoutput>

                                                            <cfinclude template="/include/Insert_ReportItem.cfm" />

                                                        </cfloop>


                                                        <cfquery datasource="#dsn#" name="report_6">
                                                            SELECT
                                                            count(p.audprojectid) as totals,
                                                            s.audsource as label,
                                                            'Auditions' as itemDataset


                                                            FROM audprojects p

                                                            INNER join audroles r on p.audprojectID = r.audprojectID

                                                            INNER JOIN audsources s ON s.audsourceid = r.audsourceid

                                                            WHERE r.isdeleted IS FALSE
                                                            AND p.isDeleted IS FALSE
                                                            AND p.projdate >= <cfqueryparam cfsqltype="cf_sql_date" value="#rangeselected.rangestart#" /> 
                                                            AND p.projdate <= <cfqueryparam cfsqltype="cf_sql_date" value="#rangeselected.rangeend#" />
                                                            AND p.userid=#new_userid# 
                                                            GROUP BY s.audsource ORDER BY s.audsource 
                                                            </cfquery>



                                                                <cfset i=0 />

                                                                <cfloop query="report_6">

                                                                    <cfoutput>
                                                                        <cfset i=#i# + 1 />
                                                                        <cfset new_reportid="6" />
                                                                        <cfset new_label="#report_6.label#" />
                                                                        <cfset new_itemValueInt="#report_6.totals#" />
                                                                        <cfset new_itemDataset="#report_6.itemDataset#" />
                                                                    </cfoutput>

                                                                    <cfinclude template="/include/Insert_ReportItem.cfm" />

                                                                </cfloop>

                                                                <cfquery datasource="#dsn#" name="report_7">
                                                                    SELECT
                                                                    count(p.audprojectid) as totals,
                                                                    rt.audroletype as label,
                                                                    'Auditions' as itemDataset


                                                                    FROM audprojects p

                                                                    INNER join audroles r on p.audprojectID = r.audprojectID

                                                                    INNER JOIN audroletypes rt ON r.audroletypeid = rt.audroletypeid
                                                                    INNER join audsubcategories s on s.audsubcatid = p.audsubcatid
                                                                    WHERE r.isdeleted IS FALSE
                                                                    AND p.isDeleted IS FALSE
                                                                   AND p.userid = #new_userid#
                                                                    AND p.projdate >= <cfqueryparam cfsqltype="cf_sql_date" value="#rangeselected.rangestart#" /> 
                                                                    AND p.projdate <= <cfqueryparam cfsqltype="cf_sql_date" value="#rangeselected.rangeend#" /> 
                                                                    and s.audcatid=#new_audcatid# 
                                                                    GROUP BY rt.audroletype 
                                                                    having rt.audroletype <> 'N/A'
                                                                        ORDER BY rt.audroletype
                                                                </cfquery>

                                                                <cfset i=0 />

                                                                <cfloop query="report_7">

                                                                    <cfoutput>
                                                                        <cfset i=#i# + 1 />
                                                                        <cfset new_reportid="7" />
                                                                        <cfset new_label="#report_7.label#" />
                                                                        <cfset new_itemValueInt="#report_7.totals#" />
                                                                        <cfset new_itemDataset="#report_7.itemDataset#" />
                                                                    </cfoutput>

                                                                    <cfinclude template="/include/Insert_ReportItem.cfm" />

                                                                </cfloop>

                                                                <cfquery datasource="#dsn#" name="report_8">
                                                                    SELECT
                                                                    count(x.audprojectid) AS totals,
                                                                    m.medianame AS label,
                                                                    s.audcatid,
                                                                    'Auditions' as itemDataset
                                                                    FROM audmedia m
                                                                    inner join audmedia_auditions_xref x on x.mediaid = m.mediaid
                                                                    INNER JOIN audmediatypes t ON t.mediaTypeID = m.mediatypeid

                                                                    INNER JOIN audprojects p ON p.audprojectID = x.audprojectid
                                                                    INNER join audsubcategories s on s.audsubcatid = p.audsubcatid
                                                                    LEFT JOIN exttypes e on e.mediaext = m.mediaext
                                                                    WHERE m.isdeleted IS false and x.audprojectid <> 0 AND p.userid = #new_userid#
                                                                        AND s.audcatid =#new_audcatid#
                                                                        AND p.projdate >= <cfqueryparam cfsqltype="cf_sql_date" value="#rangeselected.rangestart#" /> 
    AND p.projdate <= <cfqueryparam cfsqltype="cf_sql_date" value="#rangeselected.rangeend#" />
                                                                        GROUP BY m.medianame, t.mediatype,s.audcatid
                                                                        HAVING t.mediatype = 'Headshot'
                                                                        ORDER BY m.medianame;
                                                                </cfquery>

                                                                <cfset i=0 />

                                                                <cfloop query="report_8">

                                                                    <cfoutput>
                                                                        <cfset i=#i# + 1 />
                                                                        <cfset new_reportid="8" />
                                                                        <cfset new_label="#report_8.label#" />
                                                                        <cfset new_itemValueInt="#report_8.totals#" />
                                                                        <cfset new_itemDataset="#report_8.itemDataset#" />
                                                                    </cfoutput>

                                                                    <cfinclude template="/include/Insert_ReportItem.cfm" />

                                                                </cfloop>

                                                                <cfquery datasource="#dsn#" name="report_9">
                                                                    SELECT
                                                                    count(r.audroleid) as totals,
                                                                    a.rangename as label,
                                                                    'Auditions' as itemDataset


                                                                    FROM audprojects p
                                                                    INNER join audroles r on p.audprojectID = r.audprojectID

                                                                    INNER JOIN audageranges_audtion_xref x ON x.audroleid = r.audroleid
                                                                    inner join audageranges a on a.rangeid = x.rangeid

                                                                    WHERE r.isdeleted IS FALSE
                                                                    AND p.isDeleted IS FALSE
    AND p.projdate >= <cfqueryparam cfsqltype="cf_sql_date" value="#rangeselected.rangestart#" /> 
    AND p.projdate <= <cfqueryparam cfsqltype="cf_sql_date" value="#rangeselected.rangeend#" />
                                                                    
                                                                    
                                                                    AND p.userid=#new_userid# GROUP BY a.rangename having a.rangename <> 'Unknown'
                                                                        ORDER BY a.rangename
                                                                </cfquery>


                                                                <cfset i=0 />

                                                                <cfloop query="report_9">

                                                                    <cfoutput>
                                                                        <cfset i=#i# + 1 />
                                                                        <cfset new_reportid="9" />
                                                                        <cfset new_label="#report_9.label#" />
                                                                        <cfset new_itemValueInt="#report_9.totals#" />
                                                                        <cfset new_itemDataset="#report_9.itemDataset#" />
                                                                    </cfoutput>

                                                                    <cfinclude template="/include/Insert_ReportItem.cfm" />

                                                                </cfloop>



                                                                <cfquery datasource="#dsn#" name="report_2">
                                                                    SELECT
                                                                    count(r.audroleid) as totals,
                                                                    g.audgenre as label,
                                                                    'Auditions' as itemDataset


                                                                    FROM audprojects p

                                                                    INNER join audroles r on p.audprojectID = r.audprojectID
                                                                    INNER join audsubcategories s on s.audsubcatid = p.audsubcatid
                                                                    INNER JOIN audgenres_audition_xref x ON x.audroleid = r.audroleid
                                                                    inner join audgenres g on g.audgenreid = x.audgenreid

                                                                    WHERE r.isdeleted IS FALSE
                                                                    AND p.isDeleted IS FALSE
    AND p.projdate >= <cfqueryparam cfsqltype="cf_sql_date" value="#rangeselected.rangestart#" /> 
    AND p.projdate <= <cfqueryparam cfsqltype="cf_sql_date" value="#rangeselected.rangeend#" />
                                                                                                   
                                                                    AND p.userid=#new_userid# and s.audcatid=#new_audcatid# 
                                                                    GROUP BY g.audgenre 
                                                                    ORDER BY g.audgenre 
                                                                    </cfquery>






                                                                        <cfset i=0 />

                                                                        <cfloop query="report_2">

                                                                            <cfoutput>
                                                                                <cfset i=#i# + 1 />
                                                                                <cfset new_reportid="2" />
                                                                                <cfset new_label="#report_2.label#" />
                                                                                <cfset new_itemValueInt="#report_2.totals#" />
                                                                                <cfset new_itemDataset="#report_2.itemDataset#" />
                                                                            </cfoutput>

                                                                            <cfinclude template="/include/Insert_ReportItem.cfm" />

                                                                        </cfloop>

                                                       
                                                                    
                       
    </Cfloop>
                                                  