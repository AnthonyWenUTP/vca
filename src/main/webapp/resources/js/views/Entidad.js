var ProcessEntity = function () {
	
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
	  
	  handleDatePickers("es");

  $.validator.setDefaults( {
    submitHandler: function () {
    	$('#datesForm').modal('hide');
    	processEntidad();
    }
  } );
  
  jQuery.validator.addMethod("noSpace", function(value, element) { 
		  return value.indexOf(" ") < 0 && value != ""; 
	}, "Invalid");
  $( '#add-form' ).validate( {
    rules: {
      code: {
    	minlength: 2,
        maxlength: 15,
        noSpace:true,
        required: true
      },
      name: {
    	  minlength: 3,
          maxlength: 500,
          required: true
      },
      area: {
          required: true
      },
      district: {
          required: true
      },
      latitude: {
          required: true,
          min:parseFloat(parametros.latitudMinima),
          max:parseFloat(parametros.latitudMaxima)
      },
      zoom:{
    	  required: true,
    	  min:0,
    	  max:18
      },
      longitude: {
          required: true,
          min:parseFloat(parametros.longitudMinima),
          max:parseFloat(parametros.longitudMaxima)
      },
      population: {
          required: false,
          min:1,
          max:125000
      },
      pattern: {
          maxlength: 750,
          required: true,
      },
      obs: {
          maxlength: 750,
          required: false
      },
      value: {
          maxlength: 250,
          required: true
      },
      info: {
          maxlength: 750,
          required: false
      },
      obs: {
          maxlength: 750,
          required: false
      },
      clave: {
    	  minlength: 3,
          maxlength: 500,
          required: true
      },
      local: {
          required: true
      },
      tipo: {
          required: true
      },
      status: {
          required: true
      },
      visitType: {
          required: true
      },
      visitDate: {
          required: true
      },
      fisDate: {
          required: true
          
      },
      mxDate: {
          required: true
      },
      dateValue: {
          required: true
      },
      size:{
    	  required: true,
    	  min:0,
    	  max:2000
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
      $( element ).addClass( 'form-control-danger alert-danger' ).removeClass( 'form-control-success' );
      $( element ).parents( '.form-group' ).addClass( 'alert-danger' ).removeClass( 'has-success' );
    },
    unhighlight: function (element, errorClass, validClass) {
      $( element ).addClass( 'form-control-success' ).removeClass( 'form-control-danger alert-danger' );
      $( element ).parents( '.form-group' ).addClass( 'has-success' ).removeClass( 'alert-danger' );
    }
  });
  
  function processEntidad(){
	  $.blockUI({ message: parametros.waitmessage });
	    $.post( parametros.saveUrl
	            , $( '#add-form' ).serialize()
	            , function( data )
	            {
	    			entidad = JSON.parse(data);
	    			if (entidad.ident === undefined) {
	    				data = data.replace(/u0027/g,"");
	    				toastr.error(data, parametros.errormessage, {
	    					    closeButton: true,
	    					    progressBar: true,
	    					  });
	    				$.unblockUI();
					}
					else{
						$.blockUI({ message: parametros.successmessage });
						$('#ident').val(entidad.ident);
						setTimeout(function() { 
				            $.unblockUI({ 
				                onUnblock: function(){ window.location.href = parametros.listUrl; } 
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
  		        	processEntidad();
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
