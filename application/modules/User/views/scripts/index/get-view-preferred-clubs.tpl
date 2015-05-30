<?php foreach($this -> groupMappings as $groupMapping) :?>
	<?php 
		$group_id = $groupMapping -> group_id;
		$group = Engine_Api::_() -> getItem('group', $group_id);
	?>
	<?php if($group) :?>
		<?php echo $group;?>
		<?php echo $this -> itemPhoto($group, 'thumb.icon');?>
	<?php endif;?>
<?php endforeach;?>
