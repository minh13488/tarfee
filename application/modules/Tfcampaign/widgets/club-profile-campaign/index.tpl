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
			<div class="tf_btn_action">
				<a class="smoothbox tf_button_action" href='<?php echo $url?>'><i class="fa fa-exchange fa-lg"></i></a>
			</div>
		<?php endif;?>	
		<?php if($this -> viewer() -> getIdentity()) :?>
			<?php if($campaign -> isEditable()) :?>
				<div class="tf_btn_action">
					<a class="smoothbox tf_button_action" href="<?php echo $this -> url(array('action' => 'edit', 'campaign_id' => $campaign -> getIdentity()), 'tfcampaign_specific' , true);?>"><i class="fa fa-pencil-square-o fa-lg"></i></a>
				</div>
			<?php endif;?>
			<?php if($campaign -> isDeletable()) :?>
				<div class="tf_btn_action">
					<a class="smoothbox tf_button_action" href="<?php echo $this -> url(array('action' => 'delete', 'campaign_id' => $campaign -> getIdentity()), 'tfcampaign_specific' , true);?>"><i class="fa fa-trash-o fa-lg"></i></a>
				</div>
				<?php endif;?>
				
		<?php endif;?>
	</li>
<?php endforeach;?>
</ul>
