<div id='profile_photo'>
	<?php $photoUrl = $this->subject() -> getPhotoUrl('thumb.profile');?>
	<!--
	<div class="options">
		<a href="">
			<span></span>
		</a>
	</div>
	-->
	<div class="avatar">
		<span>
			<a href="">
				<span alt="" class="thumb_profile_stroke" style="">
					<span alt="" class="thumb_profile_innershadow" style="">
						<span alt="" class="thumb_profile" style="background-image:url(<?php echo $photoUrl?>)"></span>
					</span>
				</span>
			</a>
		</span>
	</div>
	<div class="nickname">
		<span><?php echo $this->subject() -> getTitle()?></span>
	</div>
	<div class="user_rating">
		<span class="rating_star_generic rating_star_big"></span>
		<span class="rating_star_generic rating_star_big"></span>
		<span class="rating_star_generic rating_star_big"></span>
		<span class="rating_star_generic rating_star_big"></span>
		<span class="rating_star_generic rating_star_big_disabled"></span>
	</div>
	<div class="actions">
		<div>
		<a href=""><span class="actions_generic messaging"></span></a>
		<a href=""><span class="actions_generic sharing"></span></a>
		<a href=""><span class="actions_generic like"></span></a>
		</div>
	</div>
</div>
<div class="follow">
	<a href=""><img src="application/modules/User/externals/images/follow.png"/>
	<?php 
	$viewer = Engine_Api::_()->user()->getViewer();
    $subject = Engine_Api::_()->core()->getSubject();
	if( null === $subjectRow ) 
	{
        // Follow
        echo $this->htmlLink(array(
	        'route' => 'user_extended',
	        'controller' => 'friends',
	        'action' => 'add',
	        'user_id' => $subject->getIdentity(),
	        'rev' => true
	    ), '<img src="application/modules/User/externals/images/follow.png"/>', array(
	        'class' => 'smoothbox'
	    ));
    }
	else {
		// Follow
        echo $this->htmlLink(array(
	        'route' => 'user_extended',
	        'controller' => 'friends',
	        'action' => 'remove',
	        'user_id' => $subject->getIdentity(),
	        'rev' => true
	    ), '<img src="application/modules/User/externals/images/unfollow.png"/>', array(
	        'class' => 'smoothbox'
	    ));
	} 
	?>
</div>
<div class="leftmenu">
	<ul>
		<hr/>
		<li class="">
			<a href="">Profile</a>
			<a href="<?php echo $subject -> getHref();?>"><?php echo $this -> translate('Profile')?></a>
		</li>
		<hr/>
		<li class="">
			<a href="">Media</a>
		</li>
		<hr/>
		<li class="">
			<a href="">Players</a>
		</li>
		<hr/>
		<li class="">
			<a href="">This</a>
		</li>
		<hr/>
		<li class="">
			<a href="">Section</a>
		</li>
		<hr/>
	</ul>
</div>