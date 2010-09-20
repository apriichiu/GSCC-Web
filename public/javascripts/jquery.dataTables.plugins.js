
$(document).ready(function() {


// $('.datatable').dataTable({
//                   "oLanguage": {
//                     "sSearch": "Search",
                    
//                     "sProcessing": 'Processing'
//                   },
//                   "sPaginationType": "full_numbers",
//                   "iDisplayLength": 2,
//                   "bProcessing": true,
//                   "bServerSide": false,
//                   "bLengthChange": false,
//                   "bStateSave": true,
//                   "bFilter": true,
//                   "bAutoWidth": true,
//                   "bSortClasses" : false,
//                   'aaSorting': [[0, 'desc']],
                  
//                   "aoColumns": [
//               			{
//                   'sType': 'html',
//                   'bSortable':true,
//                   'bSearchable':true
                  
//                   },{
//                   'sType': 'html',
//                   'bSortable':true,
//                   'bSearchable':true
                  
//                   },{
//                   'sType': 'html',
//                   'bSortable':true,
//                   'bSearchable':true
                  
//                   },{
//                   'sType': 'html',
//                   'bSortable':true,
//                   'bSearchable':true
                  
//                   },{
//                   'sType': 'string',
//                   'bSortable':false,
//                   'bSearchable':false
//                   ,'sClass':'last'
//                   }
//               				],
              		
//                   "fnServerData": function ( sSource, aoData, fnCallback ) {
//                     aoData.push(  );
//                     $.getJSON( sSource, aoData, function (json) {
//               				fnCallback(json);
//               			} );
//                   }
//                 });
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
                
            },{
                'sType': 'string',
                'bSortable':false,
                'bSearchable':false
                ,'sClass':'last'
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
