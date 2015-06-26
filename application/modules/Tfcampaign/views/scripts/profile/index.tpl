<?php $campaign = $this -> campaign;?>
<?php echo $this -> itemPhoto($campaign);?>
<?php echo $campaign;?>
<?php echo $this->viewMore($campaign -> getDescription());?>

<?php echo $this -> translate("Position") ;?>
<?php $position = $campaign -> getPosition();?>
<?php if($position) :?>
	<?php echo $position -> getTitle();?>
<?php endif;?>

<?php echo $this -> translate("Location");?>
<?php echo $campaign -> getLocation();?>
		
<?php echo $this -> translate("Gender") ;?>
<?php echo $campaign -> getGender();?>

<?php echo $this -> translate("Age") ;?>
<?php echo $this -> translate("%s - %s YRS", $campaign -> from_age, $campaign -> to_age);?>

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
<?php echo $this -> translate('Start Date') ;?>: <?php echo (!is_null($startDateObj)) ?  date('M d Y', $startDateObj -> getTimestamp()) : ''; ?>
<?php endif;?>

<?php if(!empty($endDateObj)) :?>
<?php echo $this -> translate('Closing Date') ;?>: <?php echo (!is_null($endDateObj)) ?  date('M d Y', $endDateObj -> getTimestamp()) : ''; ?>
<?php endif;?>

<?php if($this -> viewer() -> getIdentity()) :?>
	<?php $url = $this -> url(array(
	    'module' => 'activity',
	    'controller' => 'index',
	    'action' => 'share',
	    'type' => $campaign -> getType(),
	    'id' => $campaign -> getIdentity(),
	    ),'default', true)
	;?>
	
	<a class="smoothbox" href='<?php echo $url?>'><button><?php echo $this->translate('share')?></button></a>
	
	<?php if($campaign -> isDeletable()) :?>
		<a class="smoothbox" href="<?php echo $this -> url(array('action' => 'delete', 'campaign_id' => $campaign -> getIdentity()), 'tfcampaign_specific' , true);?>"><button><?php echo $this -> translate("remove");?></button></a>
	<?php endif;?>
	<?php if($campaign -> isEditable()) :?>
		<a class="smoothbox" href="<?php echo $this -> url(array('action' => 'edit', 'campaign_id' => $campaign -> getIdentity()), 'tfcampaign_specific' , true);?>"><button><?php echo $this -> translate("remove");?></button></a>
	<?php endif;?>
	
	<?php if($campaign -> allow_submit) :?>
		<?php
			$startDate = date_create($campaign->start_date);
			$endDate = date_create($campaign->end_date);
	        $nowDate = date_create($now);
	        if ($nowDate <= $endDate && $nowDate >= $startDate) :
		?>
			<?php echo $this->htmlLink(
			    array('route' => 'tfcampaign_specific','action' => 'submit', 'campaign_id' => $campaign->getIdentity()), 
			    "<button>".$this->translate('apply')."</button>", 
			array('class' => 'smoothbox')) ?>
		<?php endif;?>
	<?php endif;?>
	
<?php endif;?>

<?php if($this -> viewer() -> getIdentity() && !$this -> viewer() -> isSelf($campaign -> getOwner())) :?>
	<?php 
		$submissionIds = $campaign -> getSubmissionByUser($this -> viewer(), $campaign);
	?>
	<?php if(!count($submissionIds)) :?>
		<?php if($campaign -> allow_submit) :?>
			<?php
				$startDate = date_create($campaign->start_date);
				$endDate = date_create($campaign->end_date);
	            $nowDate = date_create($now);
	            if ($nowDate <= $endDate && $nowDate >= $startDate) :
			?>
				<?php echo $this->htmlLink(
				    array('route' => 'tfcampaign_specific','action' => 'submit', 'campaign_id' => $campaign->getIdentity()), 
				    "<button>".$this->translate('apply')."</button>", 
				array('class' => 'smoothbox')) ?>
			<?php endif;?>
		<?php endif;?>
	<?php else :?>
		<a class="smoothbox" href='<?php echo $this -> url(array('action' => 'list-withdraw', 'campaign_id' => $campaign->getIdentity()), 'tfcampaign_specific' , true)?>'><button><?php echo $this->translate('withdraw')?></button></a>
	<?php endif;?>	
		
	<button data-id="<?php echo $campaign -> getIdentity();?>" onclick="saveCampaign(this);" class="<?php echo ($campaign -> isSaved())? 'campaign-save-active' : ''  ?>">
		<?php echo ($campaign -> isSaved())? $this -> translate('saved') : $this -> translate('save for later'); ?>
	</button>
	
	
<?php endif;?>

<br/><br/>
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
	function saveCampaign(ele){
		var id = ele.get('data-id');
		if(ele.hasClass('campaign-save-active')) {
			ele.removeClass('campaign-save-active');
			ele.innerHTML = "<?php echo $this -> translate('save for later');?>";
		} else {
			ele.addClass('campaign-save-active');
			ele.innerHTML = "<?php echo $this -> translate('saved');?>";
		}
		var url = '<?php echo $this -> url(array('action' => 'save'), 'tfcampaign_general', true) ?>';
		new Request.JSON({
	        url: url,
	        data: {
	            'campaign_id': id,
	        },
	    }).send();
	}
</script>












