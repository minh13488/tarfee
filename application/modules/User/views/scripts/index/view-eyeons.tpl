<div style="width: 600px; height: 400px">
	<h3><?php echo $this->translate('Players who %s has eyed on', $this->player)?></h3>
	<?php $players = $this->user->getEyeOns();?>
	<?php if (count($players)) :?>
	<ul class="player-list player-items" style="min-height: 330px">
		<?php foreach ($players as $player):?>
		<li class="player-item">
			<div class="player-photo"><?php echo $this->itemPhoto($player, 'thumb.icon')?></div>
			<div class="player-title"><?php echo $player?></div>
		</li>
		<?php endforeach;?>
	</ul>
	<?php else: ?>
	<div class="tip">
		<span><?php echo $this->translate('No players found!')?></span>
	</div>
	<?php endif;?>
	<button type="button" onclick="parent.Smoothbox.close()"><?php echo $this->translate('Close')?></button>
</div>