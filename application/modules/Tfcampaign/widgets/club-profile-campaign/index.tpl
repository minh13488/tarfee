<?php if($this->subject->isOwner($this->viewer())) :?>
	<?php $url = $this -> url(array(
	    'action' => 'create',
	    'club_id' => $this->subject->getIdentity(),
	    ),'tfcampaign_general', true)
	;?>
	<div class="group_album_options">
		<a class="smoothbox tf_button_action" href='<?php echo $url?>'><?php echo $this->translate('Add Scout')?></a>
	</div>
<?php endif;?>
<ul class="tfcampaign_list">
<?php foreach($this -> campaigns as $campaign) :?>
	<li>
		<?php if($campaign -> photo_id != 0) :?>
			<?php echo $this -> itemPhoto($campaign) ;?>
		<?php endif;?>
		<div class="tfcampaign_title"><?php echo $campaign;?></div>
		
		<div class="tfcampaign_description">
			<?php echo $campaign -> getDescription();?>
		</div>
		<?php if($this -> viewer() -> getIdentity() && Engine_Api::_()->user()->canTransfer($campaign)) :?>
			<?php $url = $this -> url(array(
			    'action' => 'transfer-item',
			    'subject' => $campaign -> getGuid(),
			    ),'user_general', true)
			;?>
			<a class="smoothbox" href='<?php echo $url?>'><button><?php echo $this->translate('transfer')?></button></a>
		<?php endif;?>	
		<?php if($this -> viewer() -> getIdentity()) :?>
			<?php if($campaign -> isDeletable()) :?>
					<a class="smoothbox" href="<?php echo $this -> url(array('action' => 'delete', 'campaign_id' => $campaign -> getIdentity()), 'tfcampaign_specific' , true);?>"><button><?php echo $this -> translate("remove");?></button></a>
				<?php endif;?>
				
				<?php if($campaign -> isEditable()) :?>
					<a class="smoothbox" href="<?php echo $this -> url(array('action' => 'edit', 'campaign_id' => $campaign -> getIdentity()), 'tfcampaign_specific' , true);?>"><button><?php echo $this -> translate("edit");?></button></a>
				<?php endif;?>
		<?php endif;?>
	</li>
<?php endforeach;?>
</ul>
