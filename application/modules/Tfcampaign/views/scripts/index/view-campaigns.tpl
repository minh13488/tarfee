<h1><?php echo $this -> translate("My Campaigns");?></h1>

<?php if(count($this -> ownCampaigns)) :?>
	<?php foreach($this -> ownCampaigns as $campaign) :?>
		<?php echo $this -> itemPhoto($campaign);?>
		<?php echo $campaign;?>
	<?php endforeach;?>
<?php endif;?>

<h1><?php echo $this -> translate("Saved Campaigns");?></h1>

<?php if(count($this -> saveRows)) :?>
	<?php foreach($this -> saveRows as $saveRow) :?>
		<?php $campaign = Engine_Api::_() -> getItem('tfcampaign_campaign', $saveRow -> campaign_id);?>
		<?php if($campaign) :?>
			<?php echo $this -> itemPhoto($campaign);?>
			<?php echo $campaign;?>
		<?php endif;?>
	<?php endforeach;?>
<?php endif;?>

<h1><?php echo $this -> translate("Submited Campaigns");?></h1>

<?php if(count($this -> submitCampaignIds)) :?>
	<?php foreach($this -> submitCampaignIds as $campaign_id) :?>
		<?php $campaign = Engine_Api::_() -> getItem('tfcampaign_campaign', $campaign_id);?>
		<?php if($campaign) :?>
			<?php echo $this -> itemPhoto($campaign);?>
			<?php echo $campaign;?>
		<?php endif;?>
	<?php endforeach;?>
<?php endif;?>

