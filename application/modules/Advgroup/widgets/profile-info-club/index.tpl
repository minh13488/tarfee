<div id="club-profile-info-widget">
	<?php $photoUrl = ($this ->group -> getPhotoUrl('thumb.main')) ? $this ->group->getPhotoUrl('thumb.main') : "application/modules/Advgroup/externals/images/nophoto_group_thumb_profile.png" ?>
	<div class="club-photo" style="background-image: url(<?php echo $photoUrl; ?>)">
	</div>
	<div class="club-info-general">
		<div class="club-title">
			<?php echo $this->group->getTitle()?>
		</div>
		<?php if ($this->group->getCountry()) :?>
		<div class="club-country">
			<?php echo $this->group->getCountry()->getTitle()?>
		</div>
		<?php endif;?>
		
		<?php if ($this->group->getProvince()) :?>
		<div class="club-province">
			<?php echo $this->group->getProvince()->getTitle()?>
		</div>
		<?php endif;?>
		
		<?php if ($this->group->getCity()) :?>
		<div class="club-city">
			<?php echo $this->group->getCity()->getTitle()?>
		</div>
		<?php endif;?>
		
		<div class="club-like-count">
			<i class="fa fa-heart"></i>
			<span class="like-count"><?php
        	$rows = $this -> group -> membership() ->getMembers();
			echo count($rows)?></span>
		</div>
	</div>
	<?php if($this->aJoinButton && is_array($this->aJoinButton)):?>
        <?php if (count($this->aJoinButton) == '2'):?>
			<div id="advgroup_widget_cover_invitation_proceed">               				
				<a title="<?php echo $this->aJoinButton[0]['label']; ?>" class='smoothbox <?php echo $this->aJoinButton[0]['class'];?>' href="<?php echo $this->url($this->aJoinButton[0]['params'], $this->aJoinButton[0]['route'], array());?>">
					<?php echo $this -> translate($this->aJoinButton[0]['label']);?>
				</a>
			</div>
			<div id="advgroup_widget_cover_invitation_proceed">               				
				<a title="<?php echo $this->aJoinButton[1]['label']; ?>" class='smoothbox <?php echo $this->aJoinButton[1]['class'];?>' href="<?php echo $this->url($this->aJoinButton[1]['params'], $this->aJoinButton[1]['route'], array());?>">
					<?php echo $this -> translate($this->aJoinButton[0]['label']);?>
				</a>
			</div>
		<?php else:?>
			<div class="tf_btn_action">
            	<a href="<?php echo $this->url($this->aJoinButton['params'], $this->aJoinButton['route'], array());?>" class="<?php echo $this->aJoinButton['class'];?>" title="<?php echo $this->aJoinButton['label']; ?>">
            		<?php echo $this -> translate($this->aJoinButton['label']);?>
            	</a>
			</div>
		<?php endif;?>                
    <?php endif;?>
    <?php if($this -> group -> isOwner($this -> viewer())):?>
    	 <?php echo $this->htmlLink(array('route' => 'group_specific', 'action' => 'edit', 'group_id' => $this -> group->getIdentity()), $this->translate('Edit'), array(
                  'class' => 'club_info_edit'
                )) ?>
	<?php endif;?>
</div>
