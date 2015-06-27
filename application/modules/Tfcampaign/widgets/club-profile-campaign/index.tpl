<span class="tarfee_total_items"><?php echo $this -> total;?></span>
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
		
		<?php if($this->subject->isOwner($this->viewer())) :?>
			<?php $url = $this -> url(array(
			    'action' => 'create',
			    'club_id' => $this->subject->getIdentity(),
			    ),'tfcampaign_general', true)
			;?>
			
			<a class="smoothbox" href='<?php echo $url?>'><button><?php echo $this->translate('Add more campaign')?></button></a>
		<?php endif;?>
		
		<?php if($this -> viewer() -> getIdentity() && Engine_Api::_()->user()->canTransfer($campaign)) :?>
			<?php $url = $this -> url(array(
			    'action' => 'transfer-item',
			    'subject' => $campaign -> getGuid(),
			    ),'user_general', true)
			;?>
			
			<a class="smoothbox" href='<?php echo $url?>'><button><?php echo $this->translate('transfer')?></button></a>
		<?php endif;?>	
	</li>
<?php endforeach;?>
</ul>
<!--
<?php if($this -> total > count($this -> campaigns)) :?>

<a href="<?php echo $this -> url(array('action' => 'browse', 'user_id' => $this -> subject() -> getIdentity()), 'tfcampaign_general', true);?>">
		<button><?php echo $this -> translate('view more');?></button>
</a>
<?php endif;?>
<div>
	<a class="icon_event_viewall" href="<?php echo $this -> url(array('action' => 'view-campaigns'), 'tfcampaign_general', true);?>">
		<?php echo $this -> translate('view campaigns');?>
	</a>
</div>
-->