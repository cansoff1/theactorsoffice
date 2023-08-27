
<style>
.grid-item {
  box-sizing: border-box; /* To make sure padding is included in the width */
  width: calc(25% - 20px); /* Assuming 10px as the total padding + margin */
}
.card {
  margin: 0;
  padding: 0;
}


.small-badge {
  padding: .2em .2em;
  font-size: .65rem;
  line-height: .9;
  border-radius: .2rem;
}

.packery-drop-placeholder {
  outline: 3px dashed #444;
  outline-offset: -6px;
  /* transition position changing */
  -webkit-transition: -webkit-transform 0.2s;
          transition: transform 0.2s;
}

</style>

<cfparam name="batchlist" default="0" />

<cfparam name="NEW_SITETYPEID" default="0" /> 
<div class="packery-grid" data-packery='{ "itemSelector": ".grid-item", "gutter": 10 }'>


<cfloop query="dashboards">
 <cfoutput><div class="card grid-item" data-id="#dashboards.pnid#"></cfoutput>
               
                    <div class="card-header" id="heading_system_<cfoutput>#dashboards.currentrow#</cfoutput>">

                        <h5 class="m-0" style="width:100%'">

                 <a class="text-dark collapsed" data-bs-toggle="collapse" href="#collapse_system_<cfoutput>#dashboards.currentrow#</cfoutput>" aria-expanded="#header_aria_expanded#">

                                <cfoutput>#dashboards.pnTitle# <cfif #dashboards.pntitle# is "Relationship Reminders"> 
                            <span class="badge bg-secondary small-badge">#nots_total#</span> </cfif></cfoutput>  

                            </a>

                        </h5>

                    </div>

          


                        <div class="card-body">

                            <p>
  <cfinclude template="/include/#dashboards.pnFilename#" />

                            </p>

                        </div>

                    </div>

                 
    




</cfloop>
</div>



<script>
// Initialize Packery
var $grid = $('.packery-grid').packery({
  itemSelector: '.grid-item',
  gutter: 10,  // Increasing gutter
   fitWidth: true,  // layout will be centered within parent
  resizable: true,  // container will resize to fit items
    columnWidth: '.grid-item',
  percentPosition: true
});

// Make all items draggable
$grid.find('.grid-item').each( function(i, gridItem) {
  var draggie = new Draggabilly(gridItem);
  $grid.packery( 'bindDraggabillyEvents', draggie );
});

packery.on( 'dragItemPositioned', function( event, draggedItem ) {
    app.tiles.settings.packeryEl.packery();
});
</script>