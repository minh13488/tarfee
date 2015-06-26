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
	<?php if($campaign -> allow_submit) :?>
		<?php
			$startDate = date_create($campaign->start_date);
			$endDate = date_create($campaign->end_date);
	        $nowDate = date_create($now);
	        if ($nowDate <= $endDate && $nowDate >= $startDate) :
		?>
			<?php echo $this->htmlLink(
			    array('route' => 'tfcampaign_specific','action' => 'submit', 'campaign_id' => $campaign->getIdentity()), 
			    $this->translate('Submit Player Profile'), 
			array('class' => 'smoothbox')) ?>
		<?php endif;?>
	<?php endif;?>
-
<span class="<?php echo ($campaign -> isSaved())? 'campaign-save-active' : ''  ?>" id="tfcampaign-campaign-save"><i class="fa fa-floppy-o"></i></span>

<!-- meta data -->
<?php if($campaign -> getOwner() -> isSelf($this -> viewer())) :?>
<h1><?php echo $this -> translate('Meta Data');?></h1>	
	<br/>
	<?php echo $this -> translate(array("%s submission", "%s submissions", count($this -> submissionPlayers)), count($this -> submissionPlayers));?>
	<br/>
	<?php echo $this -> translate(array("%s view", "%s views", $campaign -> view_count), $campaign -> view_count);?>
	<br/>
	<?php
		$submissionPlayers = $this -> submissionPlayers;
		$submissionTotalCount = 0;
		$submissionValidCount = 0;
		$percentageMatch = 0;
		foreach($submissionPlayers as $submissionPlayer) {
			$submissionTotalCount++;
			$percentagePlayer = $submissionPlayer -> countPercentMatching();
			if($percentagePlayer >= $campaign -> percentage) {
				$submissionValidCount++;
			}
		}
		if($submissionTotalCount > 0){
			$percentageMatch =  round(($submissionValidCount/$submissionTotalCount), 2) * 100;
		} else {
			$percentageMatch = 0;
		}
		echo $this -> translate("%s of submitted player cards that match the campaign preferences", $percentageMatch."%");
	?>
	<br/>
	<?php
		$submissionTotalCount = 0;
		$submissionValidCount = 0;
		$percentageMatch = 0;
		$tablePlayer = Engine_Api::_() -> getItemTable('user_playercard');
		$players = $tablePlayer -> getAllPlayers();
		foreach($players as $player) {
			$submissionTotalCount++;
			if($player -> countPercentMatching($campaign) >= $campaign -> percentage){
				$submissionValidCount++;
			}
		}
		if($submissionTotalCount > 0){
			$percentageMatch =  round(($submissionValidCount/$submissionTotalCount), 2) * 100;
		} else {
			$percentageMatch = 0;
		}
		echo $this -> translate("%s of player cards that match the campaign preferences", $percentageMatch."%");
	?>
	
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












