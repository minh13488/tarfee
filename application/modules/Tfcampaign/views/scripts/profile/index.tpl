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
<?php if($this -> viewer() -> getIdentity()) :?>
-
<?php echo $this->htmlLink(
    array('route' => 'tfcampaign_specific','action' => 'submit', 'campaign_id' => $campaign->getIdentity()), 
    $this->translate('Submit Player Profile'), 
array('class' => 'smoothbox')) ?>
<?php endif;?>

<!-- meta data -->
<?php if($campaign -> getOwner() -> isSelf($this -> viewer())) :?>
	<?php echo $this -> translate(array("%s submission", "%s submissions", count($this -> submissionPlayers)), count($this -> submissionPlayers));?>
	<?php echo $this -> translate(array("%s view", "%s views", $campaign -> view_count), $campaign -> view_count);?>
<?php endif;?>

<!-- filter -->
<select id="filter-submission">
	<option value="matching"><?php echo $this -> translate("% of matching");?></option>
	<option value="rating"><?php echo $this -> translate("rating");?></option>
	<option value="location"><?php echo $this -> translate("location");?></option>
	<option value="age"><?php echo $this -> translate("age");?></option>
	<option value="gender"><?php echo $this -> translate("gender");?></option>
</select>

<!-- submissionPlayers -->   

<?php if(count($this -> submissionPlayers)) :?>
<h3><?php echo $this -> translate('Submitted Player Cards');?></h3>
<?php foreach($this -> submissionPlayers as $submissionPlayer) :?>
	<?php $player = Engine_Api::_() -> getItem('user_playercard', $submissionPlayer -> player_id);?>
	<?php echo $player -> getOverallRating();?>
	<?php echo $this -> itemPhoto($player);?>
	<?php echo $player;?> - 
	<?php echo $player -> getOwner();?>
	<?php echo $this -> translate("Note");?><?php echo $submissionPlayer -> getTitle();?> 
	<?php echo $this -> translate("Description");?><?php echo $submissionPlayer -> getDescription();?>
	<?php echo $submissionPlayer -> countPercentMatching();?>
<?php endforeach;?>
<?php endif;?>

<script type="text/javascript">
	window.addEvent('domready', function(){
		<?php if($this -> filterType):?>
			$('filter-submission').set('value', '<?php echo $this -> filterType;?>');
		<?php endif;?>
		$('filter-submission').addEvent('change', function(){
			type_id = this.value;
			url = '<?php echo $this -> url(array('id' => $campaign -> getIdentity(), 'slug' => $campaign -> getSlug()), 'tfcampaign_profile',true);?>' + '/sort/' + type_id;
			window.location.assign(url);
		});
	});
</script>










