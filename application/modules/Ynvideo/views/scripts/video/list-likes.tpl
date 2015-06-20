<?php if(!Engine_Api::_()->getDbtable('likes', 'core')->isLike($this->video, $this->viewer())):?>
	<a style="display:inline-block;" href="javascript:void(0);" onclick="video_like('<?php echo $this->video->getIdentity() ?>')">
		<i class="fa fa-thumbs-up ynfontawesome"></i> <?php echo $this->translate('Like') ?>
	</a>
<?php else:?>
	<a style="display:inline-block; color: #2A6496" href="javascript:void(0);" onclick="video_unlike('<?php echo $this->video->getIdentity() ?>')">
		<i class="fa fa-thumbs-up ynfontawesome"></i> <?php echo $this->translate('Like') ?>
	</a>
<?php endif;?>
 &nbsp;&middot;&nbsp; 
<?php if(Engine_Api::_()->getDbtable('unsures', 'yncomment')->getUnsure($this->video, $this->viewer())):?>
	<a style="display:inline-block; color: #2A6496" href="javascript:void(0);" onclick="video_undounsure('<?php echo $this->video->getIdentity() ?>')">
		<i class="fa fa-meh-o ynfontawesome"></i> <?php echo $this->translate('Unsure') ?>
	</a>
	<?php else :?>
	<a style="display:inline-block;" href="javascript:void(0);" onclick="video_unsure('<?php echo $this->video->getIdentity() ?>')">
		<i class="fa fa-meh-o ynfontawesome"></i> <?php echo $this->translate('Unsure') ?>
	</a>
	<?php endif;?>
 &nbsp;&middot;&nbsp; 
<?php if(Engine_Api::_()->getDbtable('dislikes', 'yncomment')->getDislike($this->video, $this->viewer())):?>
<a style="display:inline-block; color: #2A6496" href="javascript:void(0);" onclick="video_undounlike('<?php echo $this->video->getIdentity() ?>')">
	<i class="fa fa-thumbs-down ynfontawesome"></i> <?php echo $this->translate('Dislike') ?>
</a>
<?php else :?>
<a style="display:inline-block;" href="javascript:void(0);" onclick="video_unlike('<?php echo $this->video->getIdentity() ?>')">
	<i class="fa fa-thumbs-down ynfontawesome"></i> <?php echo $this->translate('Dislike') ?>
</a>
<?php endif;?>