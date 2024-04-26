 <style>
     .exportcontacts, .updatetag, .updatesystem, .addrelationship, .importhistory,.batchdelete,.searchtag, .import {
      color: #fff;
	background-color: #406E8E;
	border-color: #223a4a;
    	position: relative;
	cursor: pointer;
	display: inline-block;
	overflow: hidden;
	-webkit-user-select: none;
	user-select: none;
	-webkit-tap-highlight-color: transparent;
     padding: .25rem .5rem;
	border-radius: .2rem;    
         font-size:.87em;
     } 
     
      
     
     
     
     
      
</style>
<div class="table-responsive" id="<cfoutput>#contacts_table#_container</cfoutput>">
<table id="<cfoutput>#contacts_table#</cfoutput>" class="table display nowrap table-striped dataTable w-100 dtr-inline dt-checkboxes-select dt-responsive"   >
    <thead>
        <tr>   

            <th></th>

            <th>Name</th>
            <th>Tags</th>
  
            <th>Company</th>
            
                      <th>Phone</th>
            <th>Email</th>
        </tr>
    </thead>
    <tfoot>
        <tr>

            <th></th>

            <th>Name</th>
            <th class="min-phone-l">Tags</th>

            <th class="min-phone-l">Company</th>
            <th class="min-phone-l">Phone</th>
            <th class="min-phone-l">Email</th>
        </tr>
    </tfoot>
</table>
</div>

<cfinclude template="/include/qry/imports.cfm" />
   
<cfset userdefRows = userdefRows - 1 />
<script type="text/javascript">
    $(document).ready(function() {
        var table = $('#<cfoutput>#contacts_table#</cfoutput>').DataTable({
            "pageLength": < cfoutput > #userdefRows # < /cfoutput>,
            stateSave: false,
            dom: 'Bfrtip',
              responsive: {
        details: {
            type: 'column'
        }
    },
            
            serverSide: true,
                                                                          
                                                                          
            ajax: {
                url: '/include/contacts_ss.cfm?contacts_table=<cfoutput>#contacts_table#</cfoutput>&userid=<Cfoutput>#session.userid#</cfoutput>&bytag=<Cfoutput>#bytag#</cfoutput>&byimport=<Cfoutput>#byimport#</cfoutput>',
                type: 'post'
            },
  buttons: [
                                                                          
                 {   text: 'Add',            
                className: 'addrelationship',
               action: function (e, node, config){
                $('#remoteAddName').modal('show')
                },
                enabled: true
            },
                      
{       text: 'Search Tag',
                className: 'searchtag',
               action: function (e, node, config){
                $('#exampleModal2').modal('show')
                },
                enabled: true
            },
                 
            {       text: 'Import',
                className: 'import',
                 enabled: true,
                  action: function ( e, dt, button, config ) {
        window.location = '/app/contacts-import/';}
                
      },
                      
     <cfif #imports.recordcount# is not "0">
                      {       text: 'Import History',
                className: 'importhistory',
               action: function (e, node, config){
                $('#exampleModal22').modal('show')
                },
                enabled: true
            },
                      
                  </cfif>      
                      
                    
                        {
                text: 'Delete',
                className: 'batchdelete',
               action: function (e, node, config){
                $('#exampleModaldelete').modal('show')
                },
                enabled: false
            },
                      
                      
                  
                      
            {
                text: 'Add Tag',
                className: 'updatetag',
               action: function (e, node, config){
                $('#exampleModal4').modal('show')
                },
                enabled: false
            },
            {
                text: 'Add System',
                className: 'updatesystem', 
           action: function (e, node, config){
                $('#exampleModal3').modal('show')
                },
                enabled: true
            },
                
                    {
    text: 'Export',
    className: 'exportcontacts', 
    action: function (e, node, config){
        var formexport = $('#myformexport')[0];
        
        // Clear the form first, in case this is not the first time submitting
        $('input[name="idlist"]', formexport).remove();
        
        var rows_selectedexport = table.column(0).checkboxes.selected();

        // Iterate over all selected checkboxes
        $.each(rows_selectedexport, function(index, rowId) {
            // Create a hidden element 
            $(formexport).append(
                $('<input>')
                .attr('type', 'hidden')
                .attr('name', 'idlist')
                .val(rowId)
            );
        });
        
        // Submit the form
        formexport.submit();
    },
    enabled: false
}

    
    
    
        ],


              columnDefs: [{
                targets: 0,
                checkboxes: {
                    selectRow: true
                }
            }],
            select: {
                style: 'multi'
            },
            order: [
                [1, 'asc']
            ],

            language: {
                infoEmpty: "No records available"
            }

        });
    
    
    
        $('#<cfoutput>#contacts_table#</cfoutput>').on('select.dt deselect.dt', function() {
  table.buttons( ['.exportcontacts'] ).enable(
    table.rows( { selected: true } ).indexes().length === 0 ? false : true
  )    
        
        
        
});
    
    
    
    

    $('#<cfoutput>#contacts_table#</cfoutput>').on('select.dt deselect.dt', function() {
  table.buttons( ['.updatetag'] ).enable(
    table.rows( { selected: true } ).indexes().length === 0 ? false : true
  )    
        
        
        
});
    
    
      $('#<cfoutput>#contacts_table#</cfoutput>').on('select.dt deselect.dt', function() {
  table.buttons( ['.batchdelete'] ).enable(
    table.rows( { selected: true } ).indexes().length === 0 ? false : true
  )}); 
    
          $('#<cfoutput>#contacts_table#</cfoutput>').on('select.dt deselect.dt', function() {
  table.buttons( ['.updatesystem'] ).enable(
    table.rows( { selected: true } ).indexes().length === 0 ? false : true
  )}); 
    
    
        
        $('#<cfoutput>#contacts_table#_container</cfoutput>').css( 'display', 'table' );
    
    
         // Handle form submission event 
        $('#meform').on('submit', function(e) {
            var form = this;

            var rows_selected = table.column(0).checkboxes.selected();

            // Iterate over all selected checkboxes
            $.each(rows_selected, function(index, rowId) {
                // Create a hidden element 
                $(form).append(
                    $('<input>')
                    .attr('type', 'hidden')
                    .attr('name', 'idlist')
                    .val(rowId)
                );

            });

        });
    
    

        // Handle form submission event 
        $('#myformsystem').on('submit', function(e) {
            var formsystem = this;

            var rows_selected = table.column(0).checkboxes.selected();

            // Iterate over all selected checkboxes
            $.each(rows_selected, function(index, rowId) {
                // Create a hidden element 
                $(form).append(
                    $('<input>')
                    .attr('type', 'hidden')
                    .attr('name', 'idlist')
                    .val(rowId)
                );

            });

        });
    
    
    
            // Handle form submission event 
        $('#myformdelete').on('submit', function(e) {
            var formdelete = this;

            var rows_selecteddelete = table.column(0).checkboxes.selected();

            // Iterate over all selected checkboxes
            $.each(rows_selecteddelete, function(index, rowId) {
                // Create a hidden element 
                $(formdelete).append(
                    $('<input>')
                    .attr('type', 'hidden')
                    .attr('name', 'idlist')
                    .val(rowId)
                );

            });

        });
    
    
    
    
                // Handle form submission event 
        $('#myformexport').on('submit', function(e) {
            var formexport = this;

            var rows_selectedexport = table.column(0).checkboxes.selected();

            // Iterate over all selected checkboxes
            $.each(rows_selectedexport, function(index, rowId) {
                // Create a hidden element 
                $(formexport).append(
                    $('<input>')
                    .attr('type', 'hidden')
                    .attr('name', 'idlist')
                    .val(rowId)
                );

            });

        });
    
    
    
    
    
    
        
                // Handle form submission event 
        $('#myformtag').on('submit', function(e) {
            var formtag = this;

            var rows_selectedtag = table.column(0).checkboxes.selected();

            // Iterate over all selected checkboxes
            $.each(rows_selectedtag, function(index, rowId) {
                // Create a hidden element 
                $(formtag).append(
                    $('<input>')
                    .attr('type', 'hidden')
                    .attr('name', 'idlist')
                    .val(rowId)
                );

            });

        });
    
    
    
    
                // Handle form submission event 
        $('#myformsystem').on('submit', function(e) {
            var formsystem = this;

            var rows_selectedsystem = table.column(0).checkboxes.selected();

            // Iterate over all selected checkboxes
            $.each(rows_selectedsystem, function(index, rowId) {
                // Create a hidden element 
                $(formsystem).append(
                    $('<input>')
                    .attr('type', 'hidden')
                    .attr('name', 'idlist')
                    .val(rowId)
                );

            });

        });
    
    
    
    
    
    
    
    
    
$('#<cfoutput>#contacts_table#_container</cfoutput>').css( 'display', 'block' );
table.columns.adjust().draw();

        $('#buttonz').click(function() {
            var numChecked = table.column(0).checkboxes.selected();
            $('log').html(numChecked);
        })









    });
    
    
    
    $('#<cfoutput>#contacts_table#_container</cfoutput>').on('click','input[type="Text"]', function(event){
    event.stopPropagation();
    return false;
});
    
    
    
    </script>
 


 
 


<script>
    var countChecked = function() {
        var n = $("input:checked").length; //n now contains the number of checked elements.
        $("#count").text(n + (n === 1 ? " is" : " zijn") + " aangevinkt!"); //show some text
        if (n == 0) {
            $("#batchbutton_<cfoutput>#contacts_table#</cfoutput>:visible").fadeOut(); //if there are none checked, hide only visible elements
        } else {
            $("#batchbutton_<cfoutput>#contacts_table#</cfoutput>:hidden").fadeIn(); //otherwise (some are selected) fadeIn - if the div is hidden.
        }

    };
    countChecked();

    $("input[type=checkbox]").on("click", countChecked);

</script>

 
<cfset script_name_include="/include/#ListLast(GetCurrentTemplatePath(), " \")#" />
<cfinclude template="/include/bigbrotherinclude.cfm" />
