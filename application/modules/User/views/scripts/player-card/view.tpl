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

<div class="tf-player-detail">
	<div class="tf-player-detail-info">
	
		<div class="tf-player-name">
			<a href="<?php echo $player -> getHref()?>"><?php echo $this -> string() -> truncate($player -> first_name.' '.$player -> last_name, 50)?></a>
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


		<div class="tf-player-content clearfix">
			<div class="tf-player-description">
				<span class="label">Year of Birth</span>
				<span class="value"><?php echo date("Y", strtotime($player -> birth_date));?></span>
			</div>

			<div class="tf-player-description">
				<span class="label">Location</span>
				<span class="value"><?php if($cityName) echo $cityName; else echo $provinceName; if($countryName) echo ', '.$countryName;?></span>
			</div>


			<div class="tf-player-description">
				<span class="label">Gender</span>	

				<?php if (($player->gender) == 1){
						echo "<span class='value'>";
						echo $this -> translate("Male");
						echo "</span>";
					}else{
						echo "<span class='value'>";
						echo $this -> translate("Female");
						echo "</span>";
					}

				?>
			</div>

			<div class="tf-player-description">
				<span class="label">Language</span>			
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
					echo "<span class='value'>";
					echo implode(' | ', $arr_tmp);
					echo "</span>";
				?>

			</div>

		</div>


		<div class="tf-player-thumb">
			<?php $photoUrl = ($player -> getPhotoUrl('thumb.main')) ? $player->getPhotoUrl('thumb.main') : "application/modules/User/externals/images/nophoto_playercard_thumb_profile.png" ?>
			<span style="background-image:url(<?php echo $photoUrl; ?>)"></span>
		</div>


		<div class="tf-sport-type-position">
			<?php if($player -> getSport()):?>

			<span class="player-title">
				<?php echo $this -> itemPhoto($player -> getSport(), 'thumb.icon');?>

				<span title="<?php echo $player -> getSport() -> getTitle();?>">
					<?php echo $player -> getSport() -> getTitle();?>
				</span>

			</span>

			<?php endif;?>

			<?php if($player -> getPosition()):?>
				<span title="<?php echo $player -> getPosition() -> getTitle();?>" class="player-position">
					<?php echo $player -> getPosition() -> getTitle();?>
				</span>
			<?php endif;?>
			<!-- Gender -->


			<span class="player-foot">
				<!-- referred_foot -->
				<?php $referred_foot = $player -> referred_foot;
				if($referred_foot == 1)
				{
					echo $this -> translate('Left Foot');
				}
				elseif($referred_foot == 0) {
					echo $this -> translate('Right Foot');
				}
				else {
					echo $this -> translate('Both');
				}
				?>
			</span>
		</div>
		
		<div class="tf-player-infomation-detail">
			
			<div class="tf-player-owner">
			 	<?php echo $this->translate('By') ?>
	        	<?php echo $this->htmlLink($player -> getOwner()->getHref(), $player -> getOwner() ->getTitle()) ?>
	     	</div>
		</div>

	
		<ul class="playercard_statistics">
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
				<?php if(count($eyeons)):?>	
					<span><a href="<?php echo $url?>" class="smoothbox"><?php echo $this->translate('%s eye on', count($eyeons)) ?></a></span>	
				<?php else:?>
					<span><a href="javascript:;" class=""><?php echo $this->translate('%s eye on', count($eyeons)) ?></a></span>
				<?php endif;?>
		    </li>
		</ul>


		<div class="tf-player-detail-button">
			 <?php if (Engine_Api::_()->ynfbpp()->_allowMessage($this->viewer(), $player -> getOwner())) :?>
	         	 <div>
	                <?php echo $this->htmlLink(array(
	                    'route' => 'messages_general',
	                    'action' => 'compose',
	                    'to' => $player -> getOwner() ->getIdentity()
	                ), '<span class="profile_inbox_button"><i class="fa fa-comments"></i></span>', array(
	                    'class' => 'smoothbox', 'title' => $this -> translate("Message")
	                ));
	                ?>
	             </div>
	             <?php elseif (Engine_Api::_()->ynfbpp()->_allowMail($this->viewer(), $player -> getOwner())) :?>
	         	 <div>
	                <?php echo $this->htmlLink(array(
	                    'route' => 'user_general',
	                    'action' => 'in-mail',
	                    'to' => $player -> getOwner() ->getIdentity()
	                ), '<span class="profile_inbox_button"><i class="fa fa-envelope"></i></span>', array(
	                    'class' => 'smoothbox', 'title' => $this -> translate("Email")
	                ));
	                ?>
	             </div>
	         <?php endif;?>

	    	<div title="<?php echo $this -> translate("Keep eye on")?>" id="user_eyeon_<?php echo $player -> getIdentity()?>">
	    		<?php if($player->isEyeOn()): ?>              
	        	<a class="actions_generic" href="javascript:void(0);" onclick="removeEyeOn('<?php echo $player->getIdentity() ?>')">
	        		<?php echo $this->translate("keep eye on") ?>
	    		</a>
	    		<?php else: ?>
	        	<a class="actions_generic" href="javascript:void(0);" onclick="addEyeOn('<?php echo $player->getIdentity() ?>')">
	    			<?php echo $this->translate("keep eye on") ?>
	        	</a>
	    		<?php endif; ?>
			</div>

			<?php $url = $this->url(array('module'=> 'core', 'controller' => 'report', 'action' => 'create', 'subject' => $player->getGuid()),'default', true);?>
			<div title="<?php echo $this -> translate('Report')?>">
				<a class="actions_generic smoothbox" href="<?php echo $url?>">
					<?php echo $this -> translate('report')?>
				</a>
			</div>

	 		<div class="playercard_options">
	 			<span class="tf-player-dropdown actions_generic"><?php echo $this->translate("settings") ?></span>

	 			<div class="box-dropdown">
			    	<?php 
			    	if($this -> viewer() -> getIdentity() && $player -> getOwner() -> getIdentity() == $this -> viewer() -> getIdentity())
					{
			        	echo $this->htmlLink(array(
				            'route' => 'user_extended',
				            'controller' => 'player-card',
				            'action' => 'edit',
				            'id' => $player->playercard_id,
				        ), '<i class="fa fa-pencil"></i>'.$this->translate('Edit'), array(
				            'class' => 'tf-icon-dropdown'
				        ));
			    		echo $this->htmlLink(array(
				            'route' => 'user_extended',
				            'controller' => 'player-card',
				            'action' => 'crop-photo',
				            'id' => $player->playercard_id,
				        ), '<i class="fa fa-crop"></i>'.$this->translate('Crop Photo'), array(
				            'class' => 'tf-icon-dropdown smoothbox'
				        ));
						
						echo $this->htmlLink(array(
						'route' => 'video_general',
							'action' => 'create',
							'parent_type' =>'user_playercard',
							'subject_id' =>  $player->playercard_id,
						), '<i class="fa fa-plus-square"></i>'.$this->translate('Add Video'), array(
						'class' => 'tf-icon-dropdown'
						)) ;

						echo $this->htmlLink(array(
							'route' => 'user_photo',
							'controller' => 'upload',
							'id' => $player->playercard_id,
							'type' => $player->getType(),
							'tab' => 724
						), '<i class="fa fa-camera"></i>'.$this->translate('Add Photos'), array(
						'class' => 'tf-icon-dropdown smoothbox', 'title' => $this -> translate('Add Photos')
						));


						echo $this->htmlLink(array(
				            'route' => 'user_extended',
				            'controller' => 'player-card',
				            'action' => 'delete',
				            'id' => $player->playercard_id,
				        ), '<i class="fa fa-trash-o"></i>'.$this->translate('Delete'), array(
				            'class' => 'tf-icon-dropdown smoothbox'
				        ));
				    }
					?>
				</div>
		    </div>

			<div class="tf-addthis"> 
				<!-- Add addthis share-->
				<script type="text/javascript" src="//s7.addthis.com/js/300/addthis_widget.js#pubid=ra-558fa99deeb4735f" async="async"></script>
				<div class="addthis_sharing_toolbox"></div>
			</div>

		</div>


	</div>

	<div class="tfplayer_videos">
		<?php $videoTable = Engine_Api::_()->getItemTable('video');
		$playercardVideos = $videoTable -> fetchAll($mappingTable -> getVideosSelect($params));?>
		<?php if(count($playercardVideos)):?>
			<ul class="videos_browse tf-player-detail-list-video">
		 	<?php foreach ($playercardVideos as $item): ?>
				<li>
		           <div class="ynvideo_thumb_wrapper video_thumb_wrapper">
					    <?php
					    if ($item->photo_id) {
					        echo $this->htmlLink($item->getPopupHref(), $this->itemPhoto($item, 'thumb.large'), array('class'=>'smoothbox'));
					    } else {
					        echo '<img alt="" src="' . $this->escape($this->layout()->staticBaseUrl) . 'application/modules/Ynvideo/externals/images/video.png">';
					    }
					    ?>
					    
					</div>
					<div class="video-title">
						<?php echo $this->htmlLink($item->getPopupHref(), $item->getTitle(), array('class'=>'smoothbox'))?>
					</div>
					<div class="video-statistic-rating">
						<div class="video-statistic">
							<span> 
								<?php echo $this->translate(array('%s view','%s views', $item->view_count), $item->view_count)?>
							</span>
							
							<?php $commentCount = $item->comments()->getCommentCount(); ?>
							<span><?php echo $this->translate(array('%s comment','%s comments', $commentCount), $commentCount)?></span>
							
						</div>
					
						<?php 
					    	echo $this->partial('_video_rating_big.tpl', 'ynvideo', array('video' => $item));
						?>
					</div>
					<?php if($this -> viewer() -> getIdentity()):?>
					    <div id="favorite_<?php echo $item-> getIdentity()?>" class="tf_btn_action">
					        <?php if($item-> hasFavorite()):?>
					            <a href="javascript:;" class="tf_button_action" title="<?php echo $this->translate('Unfavorite')?>" style="background:#ff6633;color: #fff" onclick="unfavorite_video(<?php echo $item-> getIdentity()?>)">
					                <i class="fa fa-heart fa-lg"></i>
					            </a>
					        <?php else:?>   
					            <a href="javascript:;" class="tf_button_action" title="<?php echo $this->translate('Favorite')?>" onclick="favorite_video(<?php echo $item-> getIdentity()?>)">
					                <i class="fa fa-heart-o fa-lg"></i>
					            </a>
					        <?php endif;?>  
					    </div>
					<?php endif;?>
					<?php if($item -> isOwner($this->viewer())) :?>
					<div class="tf_btn_action">
					<?php
						echo $this->htmlLink(array(
							'route' => 'video_general',
							'action' => 'edit',
							'video_id' => $item->video_id,
							'parent_type' =>'user_playercard',
							'subject_id' =>  $player->playercard_id,
							'tab' => 724
					    ), '<i class="fa fa-pencil-square-o fa-lg"></i>', array('class' => 'tf_button_action'));
					?>
				    </div>
				    <div class="tf_btn_action">
					<?php
						echo $this->htmlLink(array(
					 	        'route' => 'video_general', 
					         	'action' => 'delete', 
					         	'video_id' => $item->video_id, 
					         	'format' => 'smoothbox'), 
					         	'<i class="fa fa-trash-o fa-lg"></i>', array('class' => 'tf_button_action smoothbox'
					     ));
					?>
					</div>
					<?php endif;?>
				</li>
			<?php endforeach; ?>
			</ul>
		<?php endif;?>
	</div>
</div>

<script type="text/javascript">
   var unfavorite_video = function(videoId)
   {
   	   var obj = document.getElementById('favorite_' + videoId);
   	   obj.innerHTML = '<a href="javascript:;" class="tf_button_action" style="background:#ff6633; color: #fff"><img width="16" src="application/modules/Yncomment/externals/images/loading.gif" alt="Loading" /></a>';
   	   var url = '<?php echo $this -> url(array('action' => 'remove-favorite'), 'video_favorite', true)?>';
       var request = new Request.JSON({
            'method' : 'post',
            'url' :  url,
            'data' : {
                'video_id' : videoId
            },
            'onComplete':function(responseObject)
            {  
                obj.innerHTML = '<a href="javascript:;" class="tf_button_action" title="<?php echo $this->translate("Favourite")?>" onclick="favorite_video('+videoId+')">' + '<i class="fa fa-heart-o"></i>' + '</a>';
            }
        });
        request.send();  
   } 
   var favorite_video = function(videoId)
   {
   	   var obj = document.getElementById('favorite_' + videoId);
   	   obj.innerHTML = '<a href="javascript:;" class="tf_button_action" ><img width="16" src="application/modules/Yncomment/externals/images/loading.gif" alt="Loading" /></a>';
   	   var url = '<?php echo $this -> url(array('action' => 'add-favorite'), 'video_favorite', true)?>';
       var request = new Request.JSON({
            'method' : 'post',
            'url' :  url,
            'data' : {
                'video_id' : videoId
            },
            'onComplete':function(responseObject)
            {  
                obj.innerHTML = '<a href="javascript:;" class="tf_button_action" style="background:#ff6633;color: #fff" title="<?php echo $this->translate("Unfavourite")?>" onclick="unfavorite_video('+videoId+')">' + '<i class="fa fa-heart"></i>' + '</a>';
            }
        });
        request.send();  
   }
   
 function addEyeOn(itemId) 
{
    $('user_eyeon_'+itemId).set('html', '<a class="actions_generic" href="javascript:void(0);"><span><i class="fa fa fa-spinner fa-pulse"></i></span></a>');
    new Request.JSON({
        'url': '<?php echo $this->url(array('action'=>'add-eye-on'),'user_playercard', true)?>',
        'method': 'post',
        'data' : {
            'id' : itemId
        },
        'onSuccess': function(responseJSON, responseText) {
            if (responseJSON.status == true) {
                html = '<a class="actions_generic eye-on" href="javascript:void(0);" onclick="removeEyeOn('+itemId+')"><span><i class="fa fa-eye-slash"></i></span></a>';
                $('user_eyeon_'+itemId).set('html', html);
            }
            else {
                alert(responseJSON.message);
            }            
        }
    }).send();
}

function removeEyeOn(itemId){
	$('user_eyeon_'+itemId).set('html', '<a class="actions_generic" href="javascript:void(0);"><span><i class="fa fa fa-spinner fa-pulse"></i></span></a>');
    new Request.JSON({
        'url': '<?php echo $this->url(array('action'=>'remove-eye-on'),'user_playercard', true)?>',
        'method': 'post',
        'data' : {
            'id' : itemId
        },
        'onSuccess': function(responseJSON, responseText) {
            if (responseJSON.status == true) {
                html = '<a class="actions_generic" href="javascript:void(0);" onclick="addEyeOn('+itemId+')"><span><i class="fa fa-eye"></i></span></a>';
                $('user_eyeon_'+itemId).set('html', html);
            }
            else {
                alert(responseJSON.message);
            }            
        }
    }).send();
}
</script>
