var ProcessInsumo = function () {
	
return {
  //main function to initiate the module
  init: function (parametros) {	
  $('#tipoInsumo,#undMedida').select2({
	    theme: "bootstrap",
	    width: '100%'
  });

  $('#casaBrand').select2({
	  	tags:true,
	  	placeholder:parametros.casaBrand,
	    theme: "bootstrap",
	    width: '100%'
  });
  
  $('#codigoLocal').select2({
	  	tags:true,
	  	placeholder:parametros.codigoLocal,
	    theme: "bootstrap",
	    width: '100%'
  });
  
  $('#casaDistribuidor').select2({
	  	tags:true,
	  	placeholder:parametros.casaDistribuidor,
	    theme: "bootstrap",
	    width: '100%'
  });
  
  $.validator.setDefaults( {
    submitHandler: function () {
      processInsumo();
    }
  } );

  $( '#add-insumo-form' ).validate( {
    rules: {
    	tipoInsumo: {
            required: true
        },
        nombreInsumoEs: {
        	maxlength: 250, required: true
        },
        nombreInsumoEn: {
        	maxlength: 250, required: true
        },
        codigoBrand: {
        	maxlength: 100, required: true
        },
        casaBrand: {
        	maxlength: 250, required: true
        },
        codigoDistribuidor: {
        	maxlength: 100, required: false
        },
        casaDistribuidor: {
        	maxlength: 250, required: false
        },
        codigoLocal: {
        	maxlength: 100, required: true
        },
        undMedida: {
            required: true
        },
        nivelAdvertencia: {
            required: true,
            min:0
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
  
  function processInsumo(){
	  $.blockUI({ message: parametros.waitmessage });
	    $.post( parametros.saveInsumoUrl
	            , $( '#add-insumo-form' ).serialize()
	            , function( data )
	            {
	    			insumo = JSON.parse(data);
	    			if (insumo.idInsumo === undefined) {
	    				data = data.replace(/u0027/g,"");
	    				toastr.error(data, parametros.errormessage, {
	    					    closeButton: true,
	    					    progressBar: true,
	    					  });
	    				$.unblockUI();
					}
					else{
						$.blockUI({ message: parametros.successmessage });
						$('#idInsumo').val(insumo.idInsumo);
						setTimeout(function() { 
				            $.unblockUI({ 
				                onUnblock: function(){ window.location.href = parametros.insumosUrl + insumo.idInsumo + '/'; } 
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
