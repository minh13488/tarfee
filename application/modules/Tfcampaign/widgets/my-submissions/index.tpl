<h3><?php echo $this -> translate("My submissions");?></h3>

<?php if(count($this -> submitCampaignIds)) :?>
	<?php foreach($this -> submitCampaignIds as $campaign_id) :?>
		<?php $campaign = Engine_Api::_() -> getItem('tfcampaign_campaign', $campaign_id);?>
		<?php if($campaign) :?>
			<?php echo $campaign;?>
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
				<a class="smoothbox" href='<?php echo $this -> url(array('action' => 'list-withdraw', 'campaign_id' => $campaign->getIdentity()), 'tfcampaign_specific' , true)?>'><button><?php echo $this->translate('withdraw')?></button></a>
				<?php if($campaign -> isEditable()) :?>
					<a class="smoothbox" href="<?php echo $this -> url(array('action' => 'edit', 'campaign_id' => $campaign -> getIdentity()), 'tfcampaign_specific' , true);?>"><button><?php echo $this -> translate("remove");?></button></a>
				<?php endif;?>
			<?php endif;?>
		<?php endif;?>
	<?php endforeach;?>
<?php endif;?>
