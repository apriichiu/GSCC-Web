
$(document).ready(function() {

    var oTable = $('.datatable').dataTable({
        "bSortClasses" : false,
	"sDom" : 'fltpi',
        "bLengthChange" : true,
        'aaSorting': [[0, 'desc']],
        "aoColumns": [
            {
                'sType': 'html',
                'bSortable':true,
                'bSearchable':true
                
            },{
                'sType': 'html',
                'bSortable':true,
                'bSearchable':true
                
            },{
                'sType': 'html',
                'bSortable':true,
                'bSearchable':true
                
            },{
                'sType': 'html',
                'bSortable':true,
                'bSearchable':true
                
            }
        ]
    });



    var asInitVals = new Array();

    /***************************
      * row highlighting
      ***************************/
    $('.datatable tbody td').bind('mouseenter', function () { $(this).parent().children().each(function(){$(this).addClass('highlighted');}); });
    $('.datatable tbody td').bind('mouseleave', function () { $(this).parent().children().each(function(){$(this).removeClass('highlighted');}); })

    /***************************
      * filters
      ***************************/
    $("tbody input").keyup( function () {
	/* Filter on the column (the index) of this element */
	oTable.fnFilter( this.value, $("tbody input").index(this) );
    } );
    
    
    
    /* Support functions to provide a little bit of 'user friendlyness' to the textboxes in 
     * the footer */

    $("tbody input").each( function (i) {
	asInitVals[i] = this.value;
    } );
    
    $("tbody input").focus( function () {
	if ( this.className == "search_init" )
	{
	    this.className = "";
	    this.value = "";
	}
    } );
    
    $("tbody input").blur( function (i) {
	if ( this.value == "" )
	{
	    this.className = "search_init";
	    this.value = asInitVals[$("tbody input").index(this)];
	}
    } );
} );
