<?php
	$staticBaseUrl = $this->layout()->staticBaseUrl;
 	$this->headLink()
		 ->prependStylesheet($staticBaseUrl . 'application/modules/Tfcampaign/externals/styles/slider/styles.css')
		 ->prependStylesheet("//ajax.googleapis.com/ajax/libs/jqueryui/1.8.16/themes/base/jquery-ui.css")
		 ;
		
	$this->headScript()
  		 ->appendFile($staticBaseUrl . 'application/modules/Tfcampaign/externals/scripts/jquery.min.js')	
		 ->appendScript('jQuery.noConflict();')
  		 ->appendFile($staticBaseUrl . 'application/modules/Tfcampaign/externals/scripts/jquery-ui.min.js')	
		;	
?>
<div id="form-search-wrapper" style="display:none">
<form method="get" action="">

<?php echo $this -> translate("By age");?>


<div id="w">
  <div id="content">       
    <input type="hidden" name="from_age" id="from_age">
    <input type="hidden" name="to_age" id="to_age">
    <div id="display-from-age">6 <?php echo $this -> translate('yrs') ;?></div>
    <div id="display-to-age">80 <?php echo $this -> translate('yrs') ;?></div>
    <div id="rangeslider"></div>
  </div>
</div>

<?php echo $this -> translate("By date");?>

<p><?php echo $this -> translate('From ');?>  <input type="text" name="start_date_from" id="start_date_from"></p>
<br/>
<p><?php echo $this -> translate('To ');?>  <input type="text" name="start_date_to" id="start_date_to"></p>


<?php echo $this -> translate("Location");?>

<?php
	$countriesAssoc = Engine_Api::_()->getDbTable('locations', 'user')->getLocationsAssoc(0);
	$countriesAssoc = array('0'=>$this -> translate('All')) + $countriesAssoc;
?>

<select id="country_id" name="country_id">
	<?php foreach ($countriesAssoc as $key => $value) :?>
		<option value="<?php echo $key;?>"><?php echo $value;?></option>
	<?php endforeach;?>
</select>

<select id="province_id" name="province_id"></select>
<select id="city_id" name="city_id"></select>

<button type="submit"><?php echo $this -> translate('Filter');?></button>

</form>
</div>
<script type="text/javascript">

jQuery( document ).ready(function() {
	<?php if(!empty($this -> params)) :?>
		 <?php $params = $this -> params;?>
		 
		 <?php if(!empty($params['country_id'])) :?>
		 	jQuery("#country_id").val('<?php echo $params['country_id'];?>');
		 <?php endif;?>
		 
		 <?php if(!empty($params['start_date_from'])) :?>
		 	jQuery("#start_date_from").val('<?php echo $params['start_date_from'];?>');
		 <?php endif;?>
		 
		 <?php if(!empty($params['start_date_to'])) :?>
		 	jQuery("#start_date_to").val('<?php echo $params['start_date_to'];?>');
		 <?php endif;?>
		 
		 <?php if(!empty($params['from_age'])) :?>
		 	jQuery("#from_age").val('<?php echo $params['from_age'];?>');
		 	jQuery('#display-from-age').html('<?php echo $params['from_age']." ".$this -> translate('yrs') ;?>');
		 <?php endif;?>
		 
		 <?php if(!empty($params['to_age'])) :?>
		 	jQuery("#to_age").val('<?php echo $params['to_age'];?>');
		 	jQuery('#display-to-age').html('<?php echo $params['to_age']." ".$this -> translate('yrs') ;?>');
		 <?php endif;?>
		 
		 jQuery("#form-search-wrapper").css("display", "block");
		 
		 <?php 
			if (!empty($params['country_id']) && $params['country_id'] != "0") :
			
				$provincesAssoc = array();
				$country_id = $params['country_id'];
				if ($country_id) 
				{
					$provincesAssoc = Engine_Api::_()->getDbTable('locations', 'user')->getLocationsAssoc($country_id);
					$provincesAssoc = array('0'=>'') + $provincesAssoc;
				}
			?>	
				<?php foreach($provincesAssoc as $key => $value) :?>
					jQuery('#province_id').append(jQuery('<option>', {
					    value: '<?php echo $key;?>',
					    text: '<?php echo $value;?>'
					}));
				<?php endforeach;?>
				<?php if (!empty($params['province_id'])):?>
					jQuery('#province_id').val('<?php echo $params['province_id'];?>');
				<?php endif;?>
			<?php endif;?>
			
			<?php 
			if (!empty($params['province_id'])):
				$citiesAssoc = array();
				$province_id = $params['province_id'];
				if ($province_id) {
					$citiesAssoc = Engine_Api::_()->getDbTable('locations', 'user')->getLocationsAssoc($province_id);
					$citiesAssoc = array('0'=>'') + $citiesAssoc;
				}
			?>	
				<?php foreach($citiesAssoc as $key => $value) :?>
					jQuery('#city_id').append(jQuery('<option>', {
					    value: '<?php echo $key;?>',
					    text: '<?php echo $value;?>'
					}));
				<?php endforeach;?>
				<?php if (!empty($params['city_id'])):?>
					jQuery('#city_id').val('<?php echo $params['city_id'];?>');
				<?php endif;?>
			<?php endif;?>
		
		if ($$('#province_id option').length <= 1)
		{
			$('province_id').hide();
		}
		
		if ($$('#city_id option').length <= 1) 
		{
			$('city_id').hide();
		}
	
	<?php endif;?>
	
	jQuery("#form-search-wrapper").css("display", "block");
	
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
                    	$('province_id').show();
      				}
      				else {
      					$('province_id').empty();
      					$('province_id').hide();
      				}
      				$('city_id').empty();
      				$('city_id').hide();
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
                    	$('city_id').show();
      				}
      				else {
      					$('city_id').empty();
      					$('city_id').hide();
      				}
      			}
      		})
      		makeRequest.send();
		});
	
});

jQuery(function () 
{
	  var fromValue = 6;
	  var toValue = 80;
	  
	  <?php if(!empty($this -> params)) :?>
		 <?php $params = $this -> params;?>
		 
		 <?php if(!empty($params['from_age'])) :?>
		 	fromValue = '<?php echo $params['from_age'];?>';
		 <?php endif;?>
		 
		 <?php if(!empty($params['to_age'])) :?>
		 	toValue = '<?php echo $params['to_age'];?>';
		 <?php endif;?>
		 
	  <?php endif;?>
	  
      jQuery( "#start_date_from" ).datepicker();
	  jQuery( "#start_date_to" ).datepicker();
	  jQuery('#rangeslider').slider({
	    range: true,
	    min: 0,
	    max: 100,
	    values: [ fromValue, toValue ],
	    slide: function( event, ui ) {
	      jQuery('#from_age').val(ui.values[0]);
	      jQuery('#to_age').val( ui.values[1]);
	      jQuery('#display-from-age').html( ui.values[0] + '<?php echo $this -> translate('yrs') ;?>');
	      jQuery('#display-to-age').html(   ui.values[1] + '<?php echo $this -> translate('yrs') ;?>');
	    }
	  });
});
</script>