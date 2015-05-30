<ul class='group_members'>
	<?php foreach( $this->followers as $follower_id ): ?>
	<?php $member = Engine_Api::_() -> getItem('user', $follower_id);?>
	<?php if($member -> getIdentity()) :?>
	<li>
		<div class="content">
			<div class="photo">
				<a href="<?php echo $member->getHref() ?>">
					<?php echo $this -> itemPhoto($member);?>			
				</a>				
			</div>
			<div class='group_members_body'>
				<div class="title">
					<strong><?php echo $this->htmlLink($member->getHref(), $member->getTitle()); ?> </strong>
				</div>
			</div>
		</div>
	</li>
	<?php endif;?>
	<?php endforeach;?>
</ul>
	