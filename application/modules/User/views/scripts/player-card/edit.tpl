<?php echo $this->form->render($this);?>
<script type="text/javascript">
	<?php if(empty($this -> showOther)):?>
		$('relation_other-wrapper').hide();
	<?php endif;?>
	<?php if(empty($this -> showPreferredFoot)):?>
		$('referred_foot-wrapper').hide();
	<?php endif;?>
	<?php if(!$this -> showPosition):?>
		$('position_id-wrapper').hide();
	<?php endif;?>
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
</script>