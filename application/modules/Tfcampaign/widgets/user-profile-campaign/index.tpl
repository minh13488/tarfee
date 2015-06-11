<span class="tarfee_total_items"><?php echo $this -> total;?></span>

<?php if($this -> viewer() -> isSelf($this -> subject())) :?>
	<div class="btn-add-more">
		<a href="<?php echo $this -> url(array('action' => 'create'), 'tfcampaign_general', true);?>">
			<?php echo $this -> translate('add more campaign');?>
		</a>
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
	</li>
<?php endforeach;?>
</ul>

<?php if($this -> total > count($this -> campaigns)) :?>
<!-- view more filter based on user subject --> 
<a href="<?php echo $this -> url(array('action' => 'browse', 'user_id' => $this -> subject() -> getIdentity()), 'tfcampaign_general', true);?>">
		<button><?php echo $this -> translate('view more');?></button>
</a>
<?php endif;?>