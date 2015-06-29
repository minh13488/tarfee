<?php 
$row = $this->event->membership()->getRow($this -> viewer());
if($row):
	$rsvp = $row -> rsvp;
	?>
	<a id="rsvp_option_<?php echo $this->event -> getIdentity();?>_2" <?php if($rsvp == 2):?> class="active" <?php else:?> onclick="changeRsvp('<?php echo $this->event -> getIdentity();?>', 2);" <?php endif;?> href="javascript:;"><?php echo $this->translate('attending'); ?></a>
	<a id="rsvp_option_<?php echo $this->event -> getIdentity();?>_0" <?php if($rsvp == 0):?> class="active" <?php else:?> onclick="changeRsvp('<?php echo $this->event -> getIdentity();?>', 0);" <?php endif;?> href="javascript:;"><?php echo $this->translate('not attending'); ?></a>
	<a id="rsvp_option_<?php echo $this->event -> getIdentity();?>_1" <?php if($rsvp == 1):?> class="active" <?php else:?> onclick="changeRsvp('<?php echo $this->event -> getIdentity();?>', 1);" <?php endif;?> href="javascript:;"><?php echo $this->translate('maybe'); ?></a>
<?php else:
	Engine_Api::_()->core()->clearSubject();
	Engine_Api::_()->core()->setSubject($this->event);
	$menu = new Ynevent_Plugin_Menus();
    $aJoinButton = $menu->onMenuInitialize_YneventProfileMember();
	Engine_Api::_()->core()->clearSubject();
	?>
	<?php 
	$action = 'join';
	if (isset($aJoinButton['params']['action'])) 
	{
		$action = $aJoinButton['params']['action'];
	}
	?>
	<a href="<?php echo $this->url($aJoinButton['params'], $aJoinButton['route'], array());?>" class="<?php echo $aJoinButton['class'];?>" title="<?php echo $this -> translate($aJoinButton['label']); ?>">
		<?php echo $action;?>
	</a>
<?php endif;?>

<?php $url = $this -> url(array(
		'module' => 'activity',
		'controller' => 'index',
		'action' => 'share',
		'type' => $this->event -> getType(),
		'id' => $this->event -> getIdentity()),'default', true)?>
<a class="smoothbox" href="<?php echo $url?>"><?php echo $this->translate('share'); ?></a>