<span><?php echo $this -> total;?></span>

<?php if($this -> viewer() -> isSelf($this -> subject())) :?>
	<a href="<?php echo $this -> url(array('action' => 'create'), 'tfcampaign_general', true);?>">
		<button><?php echo $this -> translate('add more campaign');?></button>
	</a>
<?php endif;?>

<ul>
<?php foreach($this -> campaigns as $campaign) :?>
	<li>
	<?php if($campaign -> photo_id != 0) :?>
		<?php echo $this -> itemPhoto($campaign) ;?>
	<?php endif;?>
	<?php echo $campaign;?>
	<?php echo $campaign -> getDescription();?>
	</li>
<?php endforeach;?>
</ul>

<?php if($this -> total > count($this -> campaigns)) :?>
<!-- view more filter based on user subject --> 
<a href="<?php echo $this -> url(array('action' => 'browse', 'user_id' => $this -> subject() -> getIdentity()), 'tfcampaign_general', true);?>">
		<button><?php echo $this -> translate('view more');?></button>
</a>
<?php endif;?>