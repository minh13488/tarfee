<?php 
$row = $this->event->membership()->getRow($this -> viewer());
if($row):
	$rsvp = $row -> rsvp;
	?>
	<a id="rsvp_option_<?php echo $this->event -> getIdentity();?>_2" <?php if($rsvp == 2):?> class="active" <?php else:?> onclick="changeRsvp('<?php echo $this->event -> getIdentity();?>', 2);" <?php endif;?> href="javascript:;"><?php echo $this->translate('attending'); ?></a>
	<a id="rsvp_option_<?php echo $this->event -> getIdentity();?>_0" <?php if($rsvp == 0):?> class="active" <?php else:?> onclick="changeRsvp('<?php echo $this->event -> getIdentity();?>', 0);" <?php endif;?> href="javascript:;"><?php echo $this->translate('not attending'); ?></a>
	<a id="rsvp_option_<?php echo $this->event -> getIdentity();?>_1" <?php if($rsvp == 1):?> class="active" <?php else:?> onclick="changeRsvp('<?php echo $this->event -> getIdentity();?>', 1);" <?php endif;?> href="javascript:;"><?php echo $this->translate('maybe'); ?></a>
<?php endif;?>

<?php $url = $this -> url(array(
		'module' => 'activity',
		'controller' => 'index',
		'action' => 'share',
		'type' => $this->event -> getType(),
		'id' => $this->event -> getIdentity()),'default', true)?>
<a class="smoothbox" href="<?php echo $url?>"><?php echo $this->translate('share'); ?></a>