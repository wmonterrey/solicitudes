var ProcessItem = function () {
	
	
return {
  //main function to initiate the module
  init: function (parametros) {	 
  $('#usrSolicitaItem, #ctrCompra, #estudio, #insumo').select2({
	    theme: "bootstrap",
	    width: '100%'
  });
  
  $('#estudio').select2({
	    theme: "bootstrap",
	    placeholder:parametros.estudio,
	    width: '100%'
  });
  
  $('#presentacion').select2({
	  	tags:true,
	  	placeholder:parametros.presentacion,
	    theme: "bootstrap",
	    width: '100%'
  });

  $.validator.setDefaults( {
    submitHandler: function () {
      processItem();
    }
  } );

  $( '#add-item-form' ).validate( {
    rules: {
    	idSolicitud: {
            required: true
        },
        usrSolicitaItem: {
            required: true
        },
        ctrCompra: {
            required: true
        },
        estudio: {
            required: true
        },
        insumo: {
            required: true
        },
        cantSolicitada: {
            required: true,
            min:1
        },
        cantAprobada: {
            required: true,
            min:1,
            max: function() {
                return parseInt($('#cantSolicitada').val());
            }
        },
        cantAutorizada: {
            required: true,
            min:1,
            max: function() {
                return parseInt($('#cantAprobada').val());
            }
        },
        presentacion: {
            required: true,
            maxlength:255
        },
        contenidoPresentacion: {
            required: true,
            min:0.1
        },
        totalProducto: {
            required: true
        },
        observaciones: {
        	maxlength: 500, required: false
        }
    },
    errorElement: 'em',
    errorPlacement: function ( error, element ) {
      // Add the `help-block` class to the error element
      error.addClass( 'form-control-feedback' );
      if ( element.prop( 'type' ) === 'checkbox' ) {
        error.insertAfter( element.parent( 'label' ) );
      } else {
        error.insertAfter( element );
      }
    },
    highlight: function ( element, errorClass, validClass ) {
      $( element ).addClass( 'form-control-danger' ).removeClass( 'form-control-success' );
      $( element ).parents( '.form-group' ).addClass( 'has-danger' ).removeClass( 'has-success' );
    },
    unhighlight: function (element, errorClass, validClass) {
      $( element ).addClass( 'form-control-success' ).removeClass( 'form-control-danger' );
      $( element ).parents( '.form-group' ).addClass( 'has-success' ).removeClass( 'has-danger' );
    }
  });
  
  $("#cantSolicitada").change(
     		function() {
     			$("#totalProducto").val($("#cantSolicitada").val()*$("#contenidoPresentacion").val());
  });
  
  $("#contenidoPresentacion").change(
   		function() {
   			$("#totalProducto").val($("#cantSolicitada").val()*$("#contenidoPresentacion").val());
  });
  
  function processItem(){
	  $.blockUI({ message: parametros.waitmessage });
	    $.post( parametros.saveItemUrl
	            , $( '#add-item-form' ).serialize()
	            , function( data )
	            {
	    			item = JSON.parse(data);
	    			if (item.idItem === undefined) {
	    				data = data.replace(/u0027/g,"");
	    				toastr.error(data, parametros.errormessage, {
	    					    closeButton: true,
	    					    progressBar: true,
	    					  });
	    				$.unblockUI();
					}
					else{
						$.blockUI({ message: parametros.successmessage });
						$('#idItem').val(item.idItem);
						setTimeout(function() { 
				            $.unblockUI({ 
				                onUnblock: function(){ window.location.href = parametros.solicitudUrl; } 
				            }); 
				        }, 1000); 
					}
	            }
	            , 'text' )
		  		.fail(function(XMLHttpRequest, textStatus, errorThrown) {
		    		alert( "error:" + errorThrown);
		    		$.unblockUI();
		  		});
	}
  
  
  $(document).on('keypress','form input',function(event)
  		{                
  		    event.stopImmediatePropagation();
  		    if( event.which == 13 )
  		    {
  		        event.preventDefault();
  		        var $input = $('form input');
  		        if( $(this).is( $input.last() ) )
  		        {
  		            //Time to submit the form!!!!
  		            //alert( 'Hooray .....' );
  		        }
  		        else
  		        {
  		            $input.eq( $input.index( this ) + 1 ).focus();
  		        }
  		    }
  		});
  }
 };
}();
