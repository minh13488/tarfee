
<div class="tarfee-popup-close"><i class="fa fa-times fa-lg"></i></div>
 <?php echo $this->form->render($this) ?>
<script type="text/javascript">
	$$('.tarfee-popup-close').addEvent('click',function(){parent.Smoothbox.close()});
	window.addEvent('domready', function() 
	{
		$('country_id').addEvent('change', function() 
		{
			var id = this.value;
			var makeRequest = new Request({
      			url: "<?php echo $this->url(array('action'=>'sublocations'),'user_general', true)?>/location_id/"+id,
      			onComplete: function (respone){
					respone  = respone.trim();
					var options = Elements.from(respone);
                  	if(options.length > 0) 
                  	{
                  		var option = new Element('option', {
							'value': '',
							'text': ''
						})  
                    	$('province_id').empty();
                    	$('province_id').grab(option);  
                    	$('province_id').adopt(options);
      					$('province_id-wrapper').show();
      				}
      				else {
      					$('province_id').empty();
      				}
      				$('city_id').empty();
      			}
      		})
      		makeRequest.send();
		});
		
		$('province_id').addEvent('change', function() 
		{
			var id = this.value;
			var makeRequest = new Request({
      			url: "<?php echo $this->url(array('action'=>'sublocations'),'user_general', true)?>/location_id/"+id,
      			onComplete: function (respone){
					respone  = respone.trim();
					var options = Elements.from(respone);
                  	if(options.length > 0) {
                  		var option = new Element('option', {
							'value': '',
							'text': ''
						})  
                    	$('city_id').empty();
                    	$('city_id').grab(option);
                    	$('city_id').adopt(options);
      					$('city_id-wrapper').show();
      				}
      				else {
      					$('city_id').empty();
      				}
      			}
      		})
      		makeRequest.send();
		});
	});
</script>