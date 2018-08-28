var ProcessSearch = function () {
	
return {
  //main function to initiate the module
  init: function (parametros) {	
	  
	  $('#resultadosdiv').hide();  
	  
	$('#tipoInsumo').select2({
		theme: "bootstrap"
	});

	$('#checkFiltro').change(function() {
        if(this.checked) {
        	$("#paramFiltrar").prop('disabled', false);
        }else{
        	$("#paramFiltrar").prop('disabled', true);
        }
              
    });
	

  $( '#insumos-form' ).validate( {
	    rules: {
	      paramFiltrar: {
	    	  required: true
	      },
	      tipoSolicitud: {
	    	  required: true
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
	    },
        submitHandler: function (form) {
            processReport();
        }
	  });
  
  Date.prototype.yyyymmdd = function() {         
      
      var yyyy = this.getFullYear().toString();                                    
      var mm = (this.getMonth()+1).toString(); // getMonth() is zero-based         
      var dd  = this.getDate().toString();             
                          
      return yyyy + '-' + (mm[1]?mm:"0"+mm[0]) + '-' + (dd[1]?dd:"0"+dd[0]);
 };
	  
  function processReport(){
	  $.blockUI({ message: parametros.waitmessage });
	  $.getJSON(parametros.insumosUrl, $('#insumos-form').serialize(), function(data) {
		  var table1 = $('#resultados').DataTable({
	          "oLanguage": {
	              "sUrl": parametros.dataTablesLang
	          },
	          "bFilter": true, 
	          "bInfo": true, 
	          "bPaginate": true, 
	          "bDestroy": true,
	          "responsive": true
	      });
		  table1.clear().draw();
		if (data == ''){
			toastr.info(data, parametros.noResults, {
				closeButton: true,
				progressBar: true,
			 });
		}
		else{
			for (var row in data) {
				var d = new Date(data[row].recordDate);
				var viewUrl = parametros.insumosUrl + data[row].idInsumo+'/';
				btnView = '<a title="view" href=' + viewUrl + ' class="btn btn-xs btn-primary" ><i class="fa fa-search"></i></a>';
				codeString = '<a title="viewlink" href=' + viewUrl + '>'+data[row].codigoBrand+'</a>';
				table1.row.add([codeString,data[row].casaBrand,data[row].nombreInsumoEn, data[row].nombreInsumoEs,
					data[row].codigoDistribuidor,
					data[row].casaDistribuidor,data[row].codigoLocal,data[row].tipoInsumo,data[row].undMedida,data[row].nivelAdvertencia,
					data[row].pasive,data[row].recordUser,d.yyyymmdd(),btnView]);
			}
			$('#resultadosdiv').show();
		}
	})
	.fail(function() {
	    alert( "error" );
	    $.unblockUI();
	});
	$.unblockUI();
  }
  }
 };
}();
