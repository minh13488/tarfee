<?php $player = $this -> playerCard;
$params = array();
$params['owner_type'] = $player -> getType();
$params['owner_id'] = $player -> getIdentity();
$mappingTable = Engine_Api::_()->getDbTable('mappings', 'user');
$totalVideo = $mappingTable -> getTotalVideo($params);
$totalComment = Engine_Api::_() -> getDbtable('comments', 'yncomment') -> comments($player) -> getCommentCount();
$totalLike = Engine_Api::_() -> getDbtable('likes', 'yncomment') -> likes($player) -> getLikeCount(); 
$totalDislike = Engine_Api::_() -> getDbtable('dislikes', 'yncomment') -> getDislikeCount($player);
$totalUnsure = Engine_Api::_() -> getDbtable('unsures', 'yncomment') -> getUnsureCount($player);
$eyeons = $player->getEyeOns();
$countryName = '';
$provinceName = '';
$cityName = '';
if($player ->country_id && $country = Engine_Api::_() -> getItem('user_location', $player ->country_id))
{
	$countryName = $country -> getTitle();
}
if($player ->province_id && $province = Engine_Api::_() -> getItem('user_location', $player ->province_id))
{
	$provinceName = $province -> getTitle();
}
if($player ->city_id && $city = Engine_Api::_() -> getItem('user_location', $player ->city_id))
{
	$cityName = $city -> getTitle();
}
?>
<div style="margin-bottom: 15px; overflow: hidden">
	<div style="width: 285px; float: left">
		<div>
			<?php echo $this -> itemPhoto($player, 'thumb.profile');?>
		</div>
		<div style="font-weight: bold">
			<a href="<?php echo $player -> getHref()?>"><?php echo $this -> string() -> truncate($player -> first_name.' '.$player -> last_name, 50)?></a>
		</div>
		<div class="tarfee_sport_type_position">
			<?php if($player -> getSport()):?>
				<?php echo $this -> itemPhoto($player -> getSport(), 'thumb.icon');?>
				<span title="<?php echo $player -> getSport() -> getTitle();?>" class="player-title"><?php echo $player -> getSport() -> getTitle();?></span>
			<?php endif;?>
			<?php if($player -> getPosition()):?>
				<span title="<?php echo $player -> getPosition() -> getTitle();?>" class="player-position">
					<?php echo $player -> getPosition() -> getTitle();?>
				</span>
			<?php endif;?>
			<!-- Gender -->
			<?php if (($player->gender) == 1){
					echo '<i class="fa fa-mars"></i>';
				}else{
					echo '<i class="fa fa-venus"></i>';
				}

				?>
			<!-- referred_foot -->
			<?php $referred_foot = $player -> referred_foot;
			if($referred_foot == 1)
			{
				echo $this -> translate('Left');
			}
			elseif($referred_foot == 0) {
				echo $this -> translate('Right');
			}
			else {
				echo $this -> translate('Both');
			}
			?>
			
		</div
		<div class="tarfee_infomation_player">
			<p>
				<?php echo  $this->locale()->toDate($player -> birth_date);?> 
			</p>
			<p>
				<?php if($cityName) echo $cityName; else echo $provinceName; if($countryName) echo ', '.$countryName;?>
			</p>
			<p>
				<?php 
					$laguages = json_decode($player -> languages);
					$arr_tmp = array();
					if($laguages)
					{
						foreach ($laguages as $lang_id) 
						{
							$langTb =  Engine_Api::_() -> getDbTable('languages', 'user');
							$lang = $langTb -> fetchRow($langTb ->select()->where('language_id = ?', $lang_id));
							if($lang)
								$arr_tmp[] = $lang -> title;
						}
					}
					echo implode(' | ', $arr_tmp);
				?>
			</p>
		</div>
		<div class="playercard_statistics">
			<ul>
				 <li>
			        <span><?php echo $this->translate(array('%s video', '%s videos', $totalVideo), $totalVideo) ?></span>
			      </li>
			       <li>
			        <span><?php echo $this->translate(array('%s comment', '%s comments', $totalComment), $totalComment) ?></span>
			      </li>
			       <li>
			        <span><?php echo $this->translate(array('%s like', '%s likes', $totalLike), $totalLike) ?></span>
			      </li>
			       <li>
			        <span><?php echo $this->translate(array('%s dislike', '%s dislikes', $totalDislike), $totalDislike) ?></span>
			      </li>
			      <li>
			      	<?php $url = $this->url(array('action'=>'view-eye-on', 'player_id'=>$player->getIdentity()), 'user_playercard' , true)?>
			        <span><a href="<?php echo $url?>" class="smoothbox"><?php echo $this->translate('%s eye on', count($eyeons)) ?></a></span>
			      </li>
			</ul>
		</div>
		<div class="user_rating">
			<?php $overRallRating = $player -> rating;?>
			<div class="user_rating" title="<?php echo $overRallRating;?>">
				<?php for ($x = 1; $x <= $overRallRating; $x++): ?>
			        <span class="rating_star_generic"><i class="fa fa-star"></i></span>&nbsp;
			    <?php endfor; ?>
			    <?php if ((round($overRallRating) - $overRallRating) > 0): $x ++; ?>
			        <span class="rating_star_generic"><i class="fa fa-star-half-o"></i></span>&nbsp;
			    <?php endif; ?>
			    <?php if ($x <= 5) :?>
			        <?php for (; $x <= 5; $x++ ) : ?>
			            <span class="rating_star_generic"><i class="fa fa-star-o"></i></span>&nbsp;
			        <?php endfor; ?>
			    <?php endif; ?>
			</div>
		</div>
		<div style="font-weight: bold">
			<?php if($this -> viewer() -> getIdentity()):?>
			<?php echo $this->htmlLink(array(
	            'route' => 'messages_general',
	            'action' => 'compose',
	            'to' => $player -> getOwner() ->getIdentity()
	        ), '<i class="fa fa-envelope-o"></i>'. $this -> translate('Message'), array(
	            'class' => 'smoothbox'
	        ));
			?>
			<?php endif;?>
			<!-- Add addthis share-->
			<script type="text/javascript" src="//s7.addthis.com/js/300/addthis_widget.js#pubid=ra-558fa99deeb4735f" async="async"></script>
			<div class="addthis_sharing_toolbox"></div>
			<!--
			<?php echo $this->htmlLink(array(
	            'route' => 'default',
	            'module' => 'activity',
	            'controller' => 'index',
				'action' => 'share',
				'type' => 'user_playercard',
				'id' => $player -> getIdentity(),
	        ), '<i class="fa fa-share-square-o"></i>'. $this -> translate('Share'), array(
	            'class' => 'smoothbox'
	        ));
			?>
			-->
		</div>
		 <div class="playercard_options">
	    	<?php 
	    	if($this -> viewer() -> getIdentity() && $player -> getOwner() -> getIdentity() == $this -> viewer() -> getIdentity())
			{
	        	echo $this->htmlLink(array(
		            'route' => 'user_extended',
		            'controller' => 'player-card',
		            'action' => 'edit',
		            'id' => $player->playercard_id,
		        ), '<i class="fa fa-pencil"></i>'.$this->translate('Edit'), array(
		            'class' => 'buttonlink'
		        ));
	    		echo $this->htmlLink(array(
		            'route' => 'user_extended',
		            'controller' => 'player-card',
		            'action' => 'crop-photo',
		            'id' => $player->playercard_id,
		        ), '<i class="fa fa-pencil"></i>'.$this->translate('Crop Photo'), array(
		            'class' => 'buttonlink smoothbox'
		        ));
				
				echo $this->htmlLink(array(
				'route' => 'video_general',
					'action' => 'create',
					'parent_type' =>'user_playercard',
					'subject_id' =>  $player->playercard_id,
				), '<i class="fa fa-plus-square"></i>'.$this->translate('Add Video'), array(
				'class' => 'buttonlink'
				)) ;
				echo $this->htmlLink(array(
		            'route' => 'user_extended',
		            'controller' => 'player-card',
		            'action' => 'delete',
		            'id' => $player->playercard_id,
		        ), '<i class="fa fa-trash-o"></i>'.$this->translate('Delete'), array(
		            'class' => 'buttonlink smoothbox'
		        ));
		    }
			?>
	    </div>
	</div>
	<div style="float: left">
		<?php $videoTable = Engine_Api::_()->getItemTable('video');
		$playercardVideos = $videoTable -> fetchAll($mappingTable -> getVideosSelect($params));?>
		<?php if(count($playercardVideos)):?>
			<ul style="border: 5px solid #eaeaea;" class="videos_browse">
			 <?php foreach ($playercardVideos as $item): ?>
		            <?php
		            echo $this->partial('_player_video_listing.tpl', 'user', array(
		                'video' => $item,
		                'player' => $player,
		            ));
		            ?>
			<?php endforeach; ?>
			</ul>
		<?php endif;?>
	</div>
</div>


<script type="text/javascript">
	window.addEvent('domready', function(){
		$$('.user-library-item-action').addEvent('outerClick', function(){
	    	if ( this.hasClass('open-submenu') ) {
	    		this.removeClass('open-submenu');	
	    	}
	    });
	
		$$('.user-library-item-action').addEvent('click', function(){
			if ( this.hasClass('open-submenu') ) {
	    		this.removeClass('open-submenu');	
	    	} else {
	    		$$('.open-submenu').removeClass('open-submenu');
	    		this.addClass('open-submenu');
	    	}  
			
			if($('global_footer').getStyle('margin-top') != "0px") {
				$('global_footer').setStyle('margin-top', '');
			} else {
				$('global_footer').setStyle('margin-top', '60px');	
			}
		});
		 
		 $$('.user-library-close-box').addEvent('click', function(){
		 	var parent = this.getParent().getParent().getParent();
			parent.removeClass('open-submenu');				
		});
		
				
  	});	
</script>