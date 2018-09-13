var ProcessSearch = function () {
	
return {
  //main function to initiate the module
  init: function (parametros) {	
	  
	$('#usrRecibeItem, #entregado,#verificado, #insumo').select2({
		theme: "bootstrap"
	});
	
	$('#resultadosdiv').hide();
	
	$('input[name="fechaCompraRange"]').daterangepicker({
	   ranges: {
	     'Hoy': [moment(), moment()],
	 'Ayer': [moment().subtract(1, 'days'), moment().subtract(1, 'days')],
	 'Ultimos 7 Dias': [moment().subtract(6, 'days'), moment()],
	 'Ultimos 30 Dias': [moment().subtract(29, 'days'), moment()],
	 'Este mes': [moment().startOf('month'), moment().endOf('month')],
	 'Mes pasado': [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')]
	   },
	   singleDatePicker: false,
	   startDate: moment().subtract(29, 'days'),
	   maxDate:moment(),
	   locale: {
	       "format": "DD/MM/YYYY",
	   "separator": " - ",
	   "applyLabel": "Aplicar",
	   "cancelLabel": "Cancelar",
	   "fromLabel": "Desde",
	   "toLabel": "Hasta",
	   "customRangeLabel": "Personalizado",
	   "weekLabel": "S",
	   "daysOfWeek": [
	   "Do",
	   "Lu",
	   "Ma",
	   "Mi",
	   "Ju",
	   "Vi",
	   "Sa"
	   ],
	   "monthNames": [
	   "Enero",
	   "Febrero",
	   "Marzo",
	   "Abril",
	   "Mayo",
	   "Junio",
	   "Julio",
	   "Agosto",
	   "Septiembre",
	   "Octubre",
	   "Noviembre",
	   "Diciembre"
	   ],
	   "firstDay": 1
	   },
	});
	
	$('#checkNumero').change(function() {
        if(this.checked) {
        	$("#numRecibo").prop('disabled', false);
        }else{
        	$("#numRecibo").prop('disabled', true);
        }
              
    });
	
	$('#checkDates').change(function() {
        if(this.checked) {
        	$("#fechaCompraRange").prop('disabled', false);
        }else{
        	$("#fechaCompraRange").prop('disabled', true);
        }
              
    });

  $( '#entregas-form' ).validate( {
	    rules: {
	      numRecibo: {
	    	  required: true
	      },
	      usrRecibeItem: {
	    	  required: true
	      },
	      entregado: {
	          required: true
	      },
	      fechaCompraRange: {
	          required: true
	      },
	      verificado: {
	    	  required: true
	      },
	      insumo: {
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
	  $.getJSON(parametros.entregasUrl, $('#entregas-form').serialize(), function(data) {
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
				
				data[row].fechaEntrega==null?d1=null:d1 = (new Date(data[row].fechaEntrega)).yyyymmdd();
				data[row].fechaVerificacion==null?d2=null:d2 = (new Date(data[row].fechaVerificacion)).yyyymmdd();
				data[row].usrRecibeItem==null?usuario=null:usuario = data[row].usrRecibeItem.completeName;
				var d3 = (new Date(data[row].recordDate)).yyyymmdd();
				var viewUrl = parametros.entregasUrl + data[row].idEntrega+'/';
				btnView = '<a title="view" href=' + viewUrl + ' class="btn btn-xs btn-primary" ><i class="fa fa-search"></i></a>';

				table1.row.add([data[row].itemSolicitado.insumo.codigoBrand,
					usuario,d1,data[row].numRecibo,data[row].cantEntregada,d2,data[row].observaciones
					,data[row].pasive,data[row].recordUser,d3,btnView]);
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
