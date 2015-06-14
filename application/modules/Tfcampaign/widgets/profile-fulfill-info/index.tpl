<?php
	$campaign = $this -> campaign;
?>

<div id="suggest-error"></div>

<?php if($campaign -> from_age == 0 && $campaign -> from_age == 0) :?>
	<?php echo $this -> translate("Please choose the age limitation");?>
	<label for="from_age"><?php echo $this->translate('From')?></label>
    <select id="from_age" name="from_age">
        <option value=""></option>
        <?php for ($i = 1; $i <= 100; $i++) { ?>
        <option value="<?php echo $i?>"><?php echo $i?></option>
        <?php } ?>    
    </select>
    <label for="to_age"><?php echo $this->translate('to')?></label>
    <select id="to_age" name="to_age">
        <option value=""></option>
        <?php for ($i = 1; $i <= 100; $i++) { ?>
        <option value="<?php echo $i?>"><?php echo $i?></option>
        <?php } ?>
    </select>
<?php endif;?>

<button id="tfcampaing-btn-suggest-save"><?php echo $this -> translate('Save');?></button>

<script type="application/javascript">
	$('tfcampaing-btn-suggest-save').addEvent('click', function(){
		//clear error before check agin
	 	$$('.suggest-campaign-error').destroy();
		var url = '<?php echo $this -> url(array('action' => 'save-suggest', 'campaign_id' => $campaign -> getIdentity()), 'tfcampaign_specific', true);?>'
		var from_age = $('from_age').get('value');
		var to_age = $('to_age').get('value');
		
		if(from_age == "" || to_age == "") {
			var message = "<?php echo $this -> translate('please select age');?>";
	 		var div = new Element('div', {
		       'html': message,
		       'class': 'suggest-campaign-error',
		        styles: {
			        'color': 'red',
			        'font-weight': 'bold',
			    },
		    });
	 		$('suggest-error').grab(div,'before');
	 		return false;
		}
		
		if(from_age != "" && to_age != ""){
	 		if(parseInt(from_age) > parseInt(to_age)) {
	 			var message = "<?php echo $this -> translate('to age must be greater than from age');?>";
		 		var div = new Element('div', {
			       'html': message,
			       'class': 'suggest-campaign-error',
			        styles: {
				        'color': 'red',
				        'font-weight': 'bold',
				    },
			    });
		 		$('suggest-error').grab(div,'before');
		 		return false;
	 		}
	   }
		
		var data = new Object();
		data.type = 'age';
		data.from_age = from_age;
		data.to_age = to_age;
		
		new Request.JSON({
	        url: url,
	        method: 'post',
	        data: data,
	        'onSuccess' : function(responseJSON, responseText)
	        {
	          alert('haha');
	        }
	    }).send();
	});
</script>