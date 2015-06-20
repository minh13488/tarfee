<div id="like_unsure_dislike_<?php echo $this -> video -> getIdentity()?>">
	<?php if(!Engine_Api::_()->getDbtable('likes', 'core')->isLike($this->video, $this->viewer())):?>
		<a id="like_video_<?php echo $this->video->getIdentity() ?>" style="display:inline-block;" href="javascript:void(0);" onclick="video_like('<?php echo $this->video->getIdentity() ?>', 'like')">
			<i class="fa fa-thumbs-up ynfontawesome"></i> <?php echo $this->translate('Like') ?>
		</a>
	<?php else:?>
		<a id="unlike_video_<?php echo $this->video->getIdentity() ?>" style="display:inline-block; color: #2A6496" href="javascript:void(0);" onclick="video_like('<?php echo $this->video->getIdentity() ?>', 'unlike')">
			<i class="fa fa-thumbs-up ynfontawesome"></i> <?php echo $this->translate('Like') ?>
		</a>
	<?php endif;?>
	 &nbsp;&middot;&nbsp; 
	<?php if(Engine_Api::_()->getDbtable('unsures', 'yncomment')->getUnsure($this->video, $this->viewer())):?>
		<a id="undounsure_video_<?php echo $this->video->getIdentity() ?>" style="display:inline-block; color: #2A6496" href="javascript:void(0);" onclick="video_like('<?php echo $this->video->getIdentity() ?>', 'undounsure')">
			<i class="fa fa-meh-o ynfontawesome"></i> <?php echo $this->translate('Unsure') ?>
		</a>
		<?php else :?>
		<a id="unsure_video_<?php echo $this->video->getIdentity() ?>" style="display:inline-block;" href="javascript:void(0);" onclick="video_like('<?php echo $this->video->getIdentity() ?>', 'unsure')">
			<i class="fa fa-meh-o ynfontawesome"></i> <?php echo $this->translate('Unsure') ?>
		</a>
		<?php endif;?>
	 &nbsp;&middot;&nbsp; 
	<?php if(Engine_Api::_()->getDbtable('dislikes', 'yncomment')->getDislike($this->video, $this->viewer())):?>
	<a id="undislike_video_<?php echo $this->video->getIdentity() ?>" style="display:inline-block; color: #2A6496" href="javascript:void(0);" onclick="video_like('<?php echo $this->video->getIdentity() ?>', 'undislike')">
		<i class="fa fa-thumbs-down ynfontawesome"></i> <?php echo $this->translate('Dislike') ?>
	</a>
	<?php else :?>
	<a id="dislike_video_<?php echo $this->video->getIdentity() ?>" style="display:inline-block;" href="javascript:void(0);" onclick="video_like('<?php echo $this->video->getIdentity() ?>', 'dislike')">
		<i class="fa fa-thumbs-down ynfontawesome"></i> <?php echo $this->translate('Dislike') ?>
	</a>
	<?php endif;?>
</div>