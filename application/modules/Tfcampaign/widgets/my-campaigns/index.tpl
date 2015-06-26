<h3><?php echo $this -> translate("My campaigns");?></h3>

<?php if(count($this -> ownCampaigns)) :?>
	<?php foreach($this -> ownCampaigns as $campaign) :?>
		<?php echo $campaign;?>
		<?php echo $campaign -> getTotalSubmission();?>
		
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
		<?php endif;?>
		<br/><br/>
	<?php endforeach;?>
<?php endif;?>