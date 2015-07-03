<?php 
$row = $this->event->membership()->getRow($this -> viewer());
$functionName = 'changeRsvp';
if($this -> widget)
{
	$functionName = $this -> widget;
}
if($row):
	$rsvp = $row -> rsvp;
	?>
	<a id="rsvp_option_<?php echo $this->event -> getIdentity();?>_2" <?php if($rsvp == 2):?> class="active" <?php else:?> onclick="<?php echo $functionName?>('<?php echo $this->event -> getIdentity();?>', 2);" <?php endif;?> href="javascript:;"><?php echo $this->translate('attending'); ?></a>
	<a id="rsvp_option_<?php echo $this->event -> getIdentity();?>_0" <?php if($rsvp == 0):?> class="active" <?php else:?> onclick="<?php echo $functionName?>('<?php echo $this->event -> getIdentity();?>', 0);" <?php endif;?> href="javascript:;"><?php echo $this->translate('not attending'); ?></a>
	<a id="rsvp_option_<?php echo $this->event -> getIdentity();?>_1" <?php if($rsvp == 1):?> class="active" <?php else:?> onclick="<?php echo $functionName?>('<?php echo $this->event -> getIdentity();?>', 1);" <?php endif;?> href="javascript:;"><?php echo $this->translate('maybe'); ?></a>
<?php else:
	$param = array();
	if ($this->event -> membership() -> isResourceApprovalRequired())
	{
		$param = array(
			'label' => 'request invite',
			'controller' => 'member',
			'action' => 'request',
		);
	}  
	else
	{
		$param = array(
			'label' => 'join',
			'controller' => 'member',
			'action' => 'join',
		);
	}
	if($param):
		?>
		<a href="<?php echo $this->url($param, 'event_extended', true);?>" class="" title="<?php echo $this -> translate($param['label']); ?>">
			<?php echo  $this -> translate($param['label']);?>
		</a>
	<?php endif;?>
<?php endif;?>
<!--
<?php $url = $this -> url(array(
		'module' => 'socialpublisher',
		'controller' => 'index',
		'action' => 'share',
		'resource_type' => $this->event -> getType(),
		'resource_id' => $this->event -> getIdentity()),'default', true)?>
		<a class="smoothbox" href="<?php echo $url?>"><?php echo $this->translate('share'); ?></a> -->
