<div id="club-profile-info-widget">
	<?php $photoUrl = ($this ->group -> getPhotoUrl('thumb.profile')) ? $this ->group->getPhotoUrl('thumb.profile') : "application/modules/Advgroup/externals/images/nophoto_group_thumb_profile.png" ?>
	<?php $url = $this->url(array('controller' => 'index','action'=>'more-info', 'club_id'=> $this -> group->getIdentity()), 'group_extended' , true)?>
	<div class="club-photo" style="background-image: url(<?php echo $photoUrl; ?>)">
		<?php if($this -> group -> isOwner($this -> viewer()) && $this -> group -> photo_id):?>
			<span class = "edit-photo-btn">
				<?php echo $this->htmlLink(array(
			            'route' => 'group_specific',
			            'action' => 'crop-photo',
			            'group_id' => $this -> group -> group_id,
			        ), '<i class="fa fa-crop"></i> '.$this->translate('Crop Photo'), array(
			            'class' => 'tf-icon-dropdown smoothbox'
			        ));?>
			</span>
		<?php endif;?>
	</div>
	<div class="club-info-general">
		<div class="club-title">
			<a href="<?php echo $url?>" class="smoothbox">
				<?php echo $this->group->getTitle()?>
			</a>
		</div>
		
		<?php 
			$establishDateObj = null;
			if (!is_null($this->group->establish_date) && !empty($this->group->establish_date) && $this->group->establish_date  != '0000-00-00') 
			{
				$establishDateObj = new Zend_Date(strtotime($this->group->establish_date));	
			}
			if( $this->viewer() && $this->viewer()->getIdentity() ) 
			{
				$tz = $this->viewer()->timezone;
				if (!is_null($establishDateObj))
				{
					$establishDateObj->setTimezone($tz);
				}
		    }
		?>
		<?php if(!empty($establishDateObj)) :?>
			<div class="club-establish">
				<?php echo (!is_null($establishDateObj)) ?  date('d M, Y', $establishDateObj -> getTimestamp()) : ''; ?>
			</div>
		<?php endif;?>
		<?php if ($this->group->getCountry()) :?>
		<div class="club-country">
			<?php echo $this->group->getCountry()->getTitle()?>
			<?php if ($this->group->getCity()) :?>
				<?php echo ", ".$this->group->getCity()->getTitle()?>
			<?php endif;?>
		</div>
		<?php endif;?>
		<!--
		<?php if ($this->group->getProvince()) :?>
		<div class="club-province">
			<?php echo $this->group->getProvince()->getTitle()?>
		</div>
		<?php endif;?>
		-->
		
		<div class="club-like-count">
			<i class="fa fa-heart"></i>
			<span class="like-count">
				<?php $rows = $this -> group -> membership() ->getMembers();?>
				<?php $url = $this->url(array('controller' => 'index','action'=>'view-fan', 'club_id'=> $this -> group->getIdentity()), 'group_extended' , true)?>
				<?php if(count($rows)):?>		
				<a href="<?php echo $url?>" class="smoothbox">
					<?php echo $this -> translate("Fans")." (".count($rows).")";?>
				</a>
				<?php else:?>
					<?php echo $this -> translate("Fans")." (".count($rows).")";?>
				<?php endif;?>
			</span>
		</div>
	</div>
	<?php if($this->aJoinButton && is_array($this->aJoinButton)):?>
        <?php if (count($this->aJoinButton) == '2'):?>
				<a title="<?php echo $this->aJoinButton[0]['label']; ?>" class='smoothbox club_info_edit <?php echo $this->aJoinButton[0]['class'];?>' href="<?php echo $this->url($this->aJoinButton[0]['params'], $this->aJoinButton[0]['route'], array());?>">
					<?php echo $this -> translate($this->aJoinButton[0]['label']);?>
				</a>
				<a title="<?php echo $this->aJoinButton[1]['label']; ?>" class='smoothbox club_info_edit <?php echo $this->aJoinButton[1]['class'];?>' href="<?php echo $this->url($this->aJoinButton[1]['params'], $this->aJoinButton[1]['route'], array());?>">
					<?php echo $this -> translate($this->aJoinButton[0]['label']);?>
				</a>
		<?php else:?>
        	<a href="<?php echo $this->url($this->aJoinButton['params'], $this->aJoinButton['route'], array());?>" class="club_info_edit <?php echo $this->aJoinButton['class'];?>" title="<?php echo $this->aJoinButton['label']; ?>">
        		<?php echo $this -> translate($this->aJoinButton['label']);?>
        	</a>
		<?php endif;?>                
    <?php endif;?>
    <?php if($this -> group -> isOwner($this -> viewer())):?>
    	 <?php echo $this->htmlLink(array('route' => 'group_specific', 'action' => 'edit', 'group_id' => $this -> group->getIdentity()), $this->translate('Edit'), array(
                  'class' => 'club_info_edit', 'style' => 'margin-bottom:1px'
                )) ?>
         <?php echo $this->htmlLink(array('route' => 'group_specific', 'action' => 'delete', 'group_id' => $this -> group->getIdentity()), $this->translate('Delete'), array(
                  'class' => 'club_info_edit smoothbox'
                )) ?>
	<?php endif;?>
	<?php if (Engine_Api::_()->ynfbpp()->_allowMessage($this->viewer(), $this->group -> getOwner())) :?>
            <?php echo $this->htmlLink(array(
                'route' => 'messages_general',
                'action' => 'compose',
                'to' => $this->group -> getOwner() ->getIdentity()
            ), $this -> translate("Send Message"), array(
                'class' => 'club_info_edit smoothbox', 
                'style' => 'margin-top:1px',
                'title' => $this -> translate("Send Message")
            ));
            ?>
         <?php elseif (Engine_Api::_()->ynfbpp()->_allowMail($this->viewer(), $this->group -> getOwner())) :?>
            <?php echo $this->htmlLink(array(
                'route' => 'user_general',
                'action' => 'in-mail',
                'to' =>  $this->group -> getOwner() ->getIdentity()
            ), $this -> translate("Send Email"), array(
                'class' => 'smoothbox club_info_edit', 
                'style' => 'margin-top:1px',
                'title' => $this -> translate("Send Email")
            ));
            ?>
	<?php endif;?>
</div>
