<h3><?php echo $this->translate('Members who eyed on %s', $this->player)?></h3>
<?php $users = $this->player->getEyeOns();?>
<?php if (count($users)) :?>
<ul class="user-list user-items">
	<?php foreach ($users as $user):?>
	<li class="user-item">
		<div class="user-photo"><?php echo $this->photoItem($user, 'thumb.icon')?></div>
		<div class="user-title"><?php echo $user?></div>
	</li>
	<?php endforeach;?>
</ul>
<?php else: ?>
<div class="tip">
	<span><?php echo $this->translate('No members found!')?></span>
</div>
<?php endif;?>
<button type="button" onclick="parent.Smoothbox.close()"><?php echo $this->translate('Close')?></button>
