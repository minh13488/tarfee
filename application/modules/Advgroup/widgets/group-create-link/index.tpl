
<?php if($this -> isOwner) :?>
	<?php if($this -> canCreate) :?>
		<a href="<?php echo $this -> url(array('action' => 'create'), 'group_general' ,true);?>">
			<button><?php echo $this -> translate('Create Club');?></button>
		</a>
	<?php endif;?>
<?php endif;?>

<?php if(isset($this -> group) && $this -> group -> getIdentity()) :?>
	<a href="<?php echo $this -> group -> getHref();?>">
		<button><?php echo $this -> translate('View Club');?></button>
	</a>
<?php endif;?>
