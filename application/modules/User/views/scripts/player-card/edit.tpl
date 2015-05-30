<?php echo $this->form->render($this);?>
<script type="text/javascript">
	function showOther()
	{
		if ($('relation_id').value == 0)
		{
			$('relation_other-wrapper').show();
		}
		else
		{
			$('relation_other-wrapper').hide();
		}
	}
	function subCategories()
	{
		if ($('category_id').value == 2)
		{
			$('referred_foot-wrapper').show();
		}
		else
		{
			$('referred_foot-wrapper').hide();
		}
		
		if ($('category_id').value > 0)
		{
			var cat_id = $('category_id').value;
			var makeRequest = new Request(
			{
				url : "user/player-card/subcategories/cat_id/" + cat_id,
				onComplete : function(respone)
				{
					respone = respone.trim();
					if (respone != "")
					{
						$('position_id-wrapper').show();
						document.getElementById('position_id-element').innerHTML = '<select id= "position_id" name = "position_id"><option value="0" label="" selected= "selected"></option>' + respone + '</select>';
					}
					else
						$('position_id-wrapper').hide();
				}
			})
			makeRequest.send();
		}
		else
		{
			$('position_id-wrapper').hide();
		}
	}
	window.addEvent('domready', function() 
	{
		<?php if(empty($this -> showOther)):?>
			$('relation_other-wrapper').hide();
		<?php endif;?>
		<?php if(empty($this -> showPreferredFoot)):?>
			$('referred_foot-wrapper').hide();
		<?php endif;?>
		<?php if(!$this -> showPosition):?>
			$('position_id-wrapper').hide();
		<?php endif;?>
		
		if ($$('#province_id option').length <= 1)
		{
			$('province_id-wrapper').hide();
		}
		
		if ($$('#city_id option').length <= 1) 
		{
			$('city_id-wrapper').hide();
		}
		
		$('country_id').addEvent('change', function() 
		{
			var id = this.value;
			var makeRequest = new Request({
      			url: "<?php echo $this->url(array('action'=>'sublocations'),'user_general', true)?>/location_id/"+id,
      			onComplete: function (respone){
					respone  = respone.trim();
					var options = Elements.from(respone);
                  	if(options.length > 0) {
                  		var option = new Element('option', {
							'value': '0',
							'text': ''
						})  
                    	$('province_id').empty();
                    	$('province_id').grab(option);  
                    	$('province_id').adopt(options);
      					$('province_id-wrapper').show();
      				}
      				else {
      					$('province_id').empty();
      					$('province_id-wrapper').hide();
      				}
      				$('city_id').empty();
  					$('city_id-wrapper').hide();
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
							'value': '0',
							'text': ''
						})  
                    	$('city_id').empty();
                    	$('city_id').grab(option);
                    	$('city_id').adopt(options);
      					$('city_id-wrapper').show();
      				}
      				else {
      					$('city_id').empty();
      					$('city_id-wrapper').hide();
      				}
      			}
      		})
      		makeRequest.send();
		});
	});
</script>