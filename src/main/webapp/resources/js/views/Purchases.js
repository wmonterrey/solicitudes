var ProcessPurchase = function () {
	
	var handleDatePickers = function (idioma) {
	    if (jQuery().datepicker) {
	        $('.date-picker').datepicker({
	            language: idioma,
	            autoclose: true
	        });
	        $('body').removeClass("modal-open"); // fix bug when inline picker is used in modal
	    }
	};
	
return {
  //main function to initiate the module
  init: function (parametros) {	 
	  handleDatePickers('es');	
  $('#lugarCompra, #cuenta').select2({
	    theme: "bootstrap",
	    width: '100%'
  });
  
  
  $('#presentacion').select2({
	  	tags:true,
	  	placeholder:parametros.presentacion,
	    theme: "bootstrap",
	    width: '100%'
  });
  
  $('#proveedor').select2({
	  	tags:true,
	  	placeholder:parametros.proveedor,
	    theme: "bootstrap",
	    width: '100%'
});

  $.validator.setDefaults( {
    submitHandler: function () {
      processCompra();
    }
  } );

  $( '#add-shop-form' ).validate( {
    rules: {
    	idInsumo: {
            required: true
        },
        cuenta: {
            required: true
        },
        lugarCompra: {
            required: true
        },
        fechaCompra: {
            required: true
        },
        proveedor: {
            required: true,
            maxlength:255
        },
        numFactura: {
            required: true,
            maxlength:50
        },
        cantComprada: {
            required: true,
            min:1
        },
        presentacion: {
            required: true,
            maxlength:255
        },
        contenidoPresentacion: {
            required: true,
            min:0.01
        },
        totalProducto: {
            required: true
        },
        remCom: {
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
  
  $("#cantComprada").change(
     		function() {
     			$("#totalProducto").val($("#cantComprada").val()*$("#contenidoPresentacion").val());
  });
  
  $("#contenidoPresentacion").change(
   		function() {
   			$("#totalProducto").val($("#cantComprada").val()*$("#contenidoPresentacion").val());
  });
  
  function processCompra(){
	  $.blockUI({ message: parametros.waitmessage });
	    $.post( parametros.saveCompraUrl
	            , $( '#add-shop-form' ).serialize()
	            , function( data )
	            {
	    			compra = JSON.parse(data);
	    			if (compra.idCompra === undefined) {
	    				data = data.replace(/u0027/g,"");
	    				toastr.error(data, parametros.errormessage, {
	    					    closeButton: true,
	    					    progressBar: true,
	    					  });
	    				$.unblockUI();
					}
					else{
						$.blockUI({ message: parametros.successmessage });
						$('#idCompra').val(compra.idCompra);
						setTimeout(function() { 
				            $.unblockUI({ 
				                onUnblock: function(){ window.location.href = parametros.comprasPendUrl; } 
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
