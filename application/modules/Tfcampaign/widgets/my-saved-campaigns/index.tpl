<h3><?php echo $this -> translate("Saved campaigns");?></h3>

<?php if(count($this -> saveRows)) :?>
	<?php foreach($this -> saveRows as $saveRow) :?>
		<?php $campaign = Engine_Api::_() -> getItem('tfcampaign_campaign', $saveRow -> campaign_id);?>
		<?php if($campaign) :?>
			<?php echo $campaign;?>
		<?php endif;?>
	<?php endforeach;?>
<?php endif;?>