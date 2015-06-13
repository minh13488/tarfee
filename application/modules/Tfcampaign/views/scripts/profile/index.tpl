<?php $campaign = $this -> campaign;?>
<?php echo $this -> itemPhoto($campaign);?>
<h3><?php echo $campaign;?></h3>
<p><?php echo $campaign -> getDescription();?></p>
<?php 
	$endDateObj = null;
	$startDateObj = null;
	if (!is_null($campaign->start_date) && !empty($campaign->start_date) && $campaign->start_date) 
	{
		$startDateObj = new Zend_Date(strtotime($campaign->start_date));	
	}
	if (!is_null($campaign->end_date) && !empty($campaign->end_date) && $campaign->end_date) 
	{
		$endDateObj = new Zend_Date(strtotime($campaign->end_date));	
	}
	if( $this->viewer() && $this->viewer()->getIdentity() ) {
		$tz = $this->viewer()->timezone;
		if (!is_null($endDateObj))
		{
			$endDateObj->setTimezone($tz);
		}
		if (!is_null($startDateObj))
		{
			$startDateObj->setTimezone($tz);
		}
    }
?>

<?php if(!empty($startDateObj)) :?>
(<i><?php echo $this -> translate('Start At') ;?>: <?php echo (!is_null($startDateObj)) ?  date('M d Y', $startDateObj -> getTimestamp()) : ''; ?></i>)
<?php endif;?>
<?php if(!empty($endDateObj)) :?>
(<i><?php echo $this -> translate('End At') ;?>: <?php echo (!is_null($endDateObj)) ?  date('M d Y', $endDateObj -> getTimestamp()) : ''; ?></i>)
<?php endif;?>
<br/>
<!-- Preferences -->
<?php echo $this -> translate("Campaign Preferences");?>
<ul>
	<?php
		$from_age = $campaign -> from_age;
		$to_age = $campaign -> to_age;
	?>
	<?php if($from_age && $to_age) :?>
		<li><?php echo $this -> translate("From %s To %s", $from_age, $to_age);?></li>
	<?php elseif($from_age) :?>
		<li><?php echo $this -> translate("Minimum age is %s", $from_age);?></li>
	<?php elseif($to_age) :?>
		<li><?php echo $this -> translate("Maximum age is %s", $to_age);?></li>
	<?php endif;?>
</ul>	

<!-- manage button -->

<?php if($campaign -> isEditable()) :?>
<?php echo $this->htmlLink(
    array('route' => 'tfcampaign_specific','action' => 'edit', 'campaign_id' => $campaign->getIdentity()), 
    $this->translate('Edit'), 
    array('class' => '')) ?>
   <?php endif;?>
  
<?php if($campaign -> isDeletable()) :?>
 -
<?php echo $this->htmlLink(
    array('route' => 'tfcampaign_specific','action' => 'delete', 'campaign_id' => $campaign->getIdentity()), 
    $this->translate('Delete'), 
    array('class' => 'smoothbox')) ?>
<?php endif;?>
<?php if($this -> viewer() -> getIdentity() && !$this -> viewer() -> isSelf($campaign -> getOwner())) :?>
-
<?php echo $this->htmlLink(
    array('route' => 'tfcampaign_specific','action' => 'submit', 'campaign_id' => $campaign->getIdentity()), 
    $this->translate('Submit Player Profile'), 
array('class' => 'smoothbox')) ?>
-
<span class="<?php echo ($campaign -> isSaved())? 'campaign-save-active' : ''  ?>" id="tfcampaign-campaign-save"><i class="fa fa-floppy-o"></i></span>
<?php endif;?>

<!-- meta data -->
<?php if($campaign -> getOwner() -> isSelf($this -> viewer())) :?>
	<?php echo $this -> translate(array("%s submission", "%s submissions", count($this -> submissionPlayers)), count($this -> submissionPlayers));?>
	<?php echo $this -> translate(array("%s view", "%s views", $campaign -> view_count), $campaign -> view_count);?>
<?php endif;?>

<script type="text/javascript">
	window.addEvent('domready', function(){
		<?php if($this -> viewer() -> getIdentity() && !$this -> viewer() -> isSelf($campaign -> getOwner())) :?>
		$('tfcampaign-campaign-save').addEvent('click', function(){
			if(this.hasClass('campaign-save-active')) {
				this.removeClass('campaign-save-active');
			} else {
				this.addClass('campaign-save-active');
			}
			var url = '<?php echo $this -> url(array('action' => 'save', 'campaign_id' => $campaign -> getIdentity()), 'tfcampaign_specific', true) ?>';
			new Request.JSON({
		        url: url,
		        data: {
		            'campaign_id': '<?php echo $campaign -> getIdentity() ?>',
		        },
		    }).send();
		});
		<?php endif;?>
	});
</script>












