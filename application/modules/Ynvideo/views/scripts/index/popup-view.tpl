<?php if( ($this->video->type == 3) && $this->video_location):
  $this->headScript()
      ->appendFile($this->layout()->staticBaseUrl . 'externals/flowplayer/flashembed-1.0.1.pack.js');
  ?>
  <script type='text/javascript'>
    en4.core.runonce.add(function() {
      flashembed("video_embed", {
        src: "<?php echo $this->layout()->staticBaseUrl ?>externals/flowplayer/flowplayer-3.1.5.swf",
        width: 480,
        height: 386,
        wmode: 'transparent'
      }, {
        config: {
          clip: {
            url: "<?php echo $this->video_location;?>",
            autoPlay: false,
            duration: "<?php echo $this->video->duration ?>",
            autoBuffering: true
          },
          plugins: {
            controls: {
              background: '#000000',
              bufferColor: '#333333',
              progressColor: '#444444',
              buttonColor: '#444444',
              buttonOverColor: '#666666'
            }
          },
          canvas: {
            backgroundColor:'#000000'
          }
        }
      });
    });
    
  </script>
<?php endif ?>
<?php
if (!$this->video || $this->video->status != 1):?>
	<div class = 'tip'>
		<span>
   			<?php echo $this->translate('The video you are looking for does not exist or has not been processed yet.'); ?>
   		</span>
  </div>
   <?php return; // Do no render the rest of the script in this mode
endif;
?>
<script type="text/javascript">
    en4.core.runonce.add(function() {
        var pre_rate = <?php echo $this->video->rating; ?>;
        var rated = '<?php echo $this->rated; ?>';
        var video_id = <?php echo $this->video->video_id; ?>;
        var total_votes = <?php echo $this->rating_count; ?>;
        var viewer = <?php echo $this->viewer_id; ?>;
		<?php if($this -> video -> parent_type != "user_playercard") :?>
			var rating_over = window.rating_over = function(rating) {
	            if( rated == 1 ) {
	                $('rating_text').innerHTML = "<?php echo $this->translate('you already rated'); ?>";
	            } else if( viewer == 0 ) {
	                $('rating_text').innerHTML = "<?php echo $this->translate('please login to rate'); ?>";
	            } else {
	                $('rating_text').innerHTML = "<?php echo $this->translate('click to rate'); ?>";
	                for(var x=1; x<=5; x++) {
	                    if(x <= rating) {
	                        $('rate_'+x).set('class', 'fa fa-star');
	                    } else {
	                        $('rate_'+x).set('class', 'fa fa-star-o');
	                    }
	                }
	            }
	        }
	
	        var rating_out = window.rating_out = function() {
	            $('rating_text').innerHTML = en4.core.language.translate(['%s rating', '%s ratings', total_votes], total_votes);
	            
	            if (pre_rate != 0){
	                set_rating();
	            }
	            else {
	                for(var x=1; x<=5; x++) 
	                {
	                    $('rate_'+x).set('class', 'fa fa-star-o');
	                }
	            }
	        }
	
	        var set_rating = window.set_rating = function() {
	            var rating = pre_rate;
	            $('rating_text').innerHTML = en4.core.language.translate(['%s rating', '%s ratings', total_votes], total_votes);
	            for(var x=1; x<=parseInt(rating); x++) {
	                $('rate_'+x).set('class', 'fa fa-star');
	            }
	
	            for(var x=parseInt(rating)+1; x<=5; x++) {
	                $('rate_'+x).set('class', 'fa fa-star-o');
	            }
	
	            var remainder = Math.round(rating)-rating;
	            if (remainder <= 0.5 && remainder !=0){
	                var last = parseInt(rating)+1;
	                $('rate_'+last).set('class', 'fa-star-half-o');
	            }
	        }
	
	        var rate = window.rate = function(rating) {
	            $('rating_text').innerHTML = "<?php echo $this->translate('Thanks for rating!'); ?>";
	            for(var x=1; x<=5; x++) {
	                $('rate_'+x).set('onclick', '');
	            }
	            (new Request.JSON({
	                'format': 'json',
	                'url' : '<?php echo $this->url(array('action' => 'rate'), 'video_general', true) ?>',
	                'data' : {
	                    'format' : 'json',
	                    'rating' : rating,
	                    'video_id': video_id
	                },
	                'onRequest' : function(){
	                    rated = 1;
	                    total_votes = total_votes+1;
	                    pre_rate = (pre_rate+rating)/total_votes;
	                    set_rating();
	                },
	                'onSuccess' : function(responseJSON, responseText)
	                {
	                	var total = responseJSON[0].total;
	                	total_votes = responseJSON[0].total;
	                	$('rating_text').innerHTML = en4.core.language.translate(['%s rating', '%s ratings', total_votes], total_votes);
	                }
	            })).send();
	
	        }
	        
		<?php endif;?>
        set_rating();
    });
</script>

<div style="width: 1170px;">
	<div class="ynvideo_popup_close"><i class="fa fa-times"></i></div>
	<div class="ynvideo_video_view_headline">
        <div class="ynvideo_author">
            <?php echo $this->translate('Posted by') ?>

            <?php
            $poster = $this->video->getOwner();
	            if ($poster) {
	                echo $this->htmlLink($poster, $poster->getTitle());
	            }
            ?>
        </div>

	    <?php if($this -> viewer() -> getIdentity()):?>
	    	<?php $url = $this->url(array('module'=> 'core', 'controller' => 'report', 'action' => 'create', 'subject' => $this -> video ->getGuid()),'default', true);?>
			<div class="yn_video_popup_btn"><a class="smoothbox" href="<?php echo $url?>"><?php echo $this -> translate("Report"); ?></a></div>
			<?php $url = $this->url(array('module'=> 'activity', 'controller' => 'index', 'action' => 'share', 'type' => 'video', 'id' => $this->video->getIdentity(),),'default', true);?>
			<div class="yn_video_popup_btn"><a class="smoothbox" href="<?php echo $url?>"><?php echo $this -> translate("Share"); ?></a></div>
			<div id="favorite_<?php echo $this->video -> getIdentity()?>" class="yn_video_popup_btn">
				<?php if($this->video -> hasFavorite()):?>
					<a href="javascript:;" onclick="unfavorite_video(<?php echo $this->video -> getIdentity()?>)"><?php echo '<i class="fa fa-heart-o"></i>&nbsp;'.$this->translate('unfavorite')?></a>
				<?php else:?>	
					<a href="javascript:;" style="background:#ff6633; color: #fff" onclick="favorite_video(<?php echo $this->video -> getIdentity()?>)"><?php echo '<i class="fa fa-heart"></i>&nbsp;'.$this->translate('favorite')?></a>
				<?php endif;?>	
			</div>
			<script type="text/javascript">
			   var unfavorite_video = function(videoId)
			   {
			   	   var obj = document.getElementById('favorite_' + videoId);
			   	   obj.innerHTML = '<a herf="javascript:void(0);"><img width="16" src="application/modules/Yncomment/externals/images/loading.gif" alt="Loading" /></a>';
			   	   var url = '<?php echo $this -> url(array('action' => 'remove-favorite'), 'video_favorite', true)?>';
			       var request = new Request.JSON({
			            'method' : 'post',
			            'url' :  url,
			            'data' : {
			                'video_id' : videoId
			            },
			            'onComplete':function(responseObject)
			            {  
			                obj.innerHTML = '<a href="javascript:;" style="background:#ff6633;color:#fff" onclick="favorite_video('+videoId+')">' + '<?php echo '<i class="fa fa-heart"></i>&nbsp;'.$this->translate("favourite")?>' + '</a>';
			            }
			        });
			        request.send();  
			   } 
			   var favorite_video = function(videoId)
			   {
			   	   var obj = document.getElementById('favorite_' + videoId);
			   	   obj.innerHTML = '<a href="javascript:void(0);"><img width="16" src="application/modules/Yncomment/externals/images/loading.gif" alt="Loading" /></a>';
			   	   var url = '<?php echo $this -> url(array('action' => 'add-favorite'), 'video_favorite', true)?>';
			       var request = new Request.JSON({
			            'method' : 'post',
			            'url' :  url,
			            'data' : {
			                'video_id' : videoId
			            },
			            'onComplete':function(responseObject)
			            {  
			                obj.innerHTML = '<a href="javascript:;" onclick="unfavorite_video('+videoId+')">' + '<?php echo '<i class="fa fa-heart-o"></i>&nbsp;'.$this->translate("unfavourite")?>' + '</a>';
			            }
			        });
			        request.send();  
			   }
			</script>   
		<?php endif; ?>
	</div>
	<div class="video_view video_view_container">
		<div class="ynvideo_popup_left"> 

		    <?php if ($this->video->type == Ynvideo_Plugin_Factory::getUploadedType() || $this->video->type == Ynvideo_Plugin_Factory::getVideoURLType()): 
		    	if($this-> video_location1 || $this->video->type == Ynvideo_Plugin_Factory::getVideoURLType()):
					if($this->video->type == Ynvideo_Plugin_Factory::getVideoURLType())
					{
						$this-> video_location1 = $this-> video_location;
					}
		    	?> 

		      	<span class="view_html5_player">
		      		<img class = "thumb_video" src ="<?php echo $this-> video -> getPhotoUrl("thumb.large");?>"/>
			      	<video id="my_video" class="video-js vjs-default-skin" controls
						 preload="auto"  poster="<?php echo $this-> video -> getPhotoUrl("thumb.large");?>"
						 data-setup="{}">
			        	<source src="<?php echo $this-> video_location1;?>" type='video/mp4'>
					</video> 
				</span>	
		    <?php 
				else:?>
					<div id="video_embed" class="video_embed"> </div>
				<?php		
					endif;
		    else: ?>
		        <div class="video_embed">
		            <?php
		           	 	echo $this->videoEmbedded;
		            ?>
		        </div>
		    <?php endif; ?>

		    <div class="ynvideo_video_view_description ynvideo_video_show_less" style="height: auto;" id="ynvideo_video">
		    	<div class="yn_video_popup_info">
		    		<div class="yn_video_info_left">
				        <div class="ynvideo_video_view_title">
				            <?php echo htmlspecialchars($this->video->getTitle()) ?>
				        </div>

			        	<?php if($this->video->description):?>
			        		<div class="ynvideo_video_view_desc">
			            		<p><?php echo $this->video->description; ?></p>
			        		</div>
			            <?php endif;?>


			            <div class="video_date" style="display: none;">
			                <?php 
			                echo $this->translate('Posted') ?>
			                <?php echo $this->timestamp($this->video->creation_date) ?>
			                 <?php echo $this->translate(array('%s favorite', '%s favorites', $this->video->favorite_count), $this->locale()->toNumber($this->video->favorite_count)) ?>
			            </div>
			             <div class="video-statistic">
					        <span><?php echo $this->translate(array('%s view','%s views', $this->video->view_count), $this->video->view_count)?></span>
					        <?php $commentCount = $this->video->comments()->getCommentCount(); ?>
					        <span><?php echo $this->translate(array('%s comment','%s comments', $commentCount), $commentCount)?></span>
					    </div>
		    		</div>


		            
		            <?php if($this -> video -> parent_type != "user_playercard") :?>
		             <div id="video_rating" class="rating ynvideo_rating" onmouseout="rating_out();">
		                <span id="rate_1" class="fa fa-star" <?php if (!$this->rated && $this->viewer_id): ?>onclick="rate(1);"<?php endif; ?> onmouseover="rating_over(1);"></span>
		                <span id="rate_2" class="fa fa-star" <?php if (!$this->rated && $this->viewer_id): ?>onclick="rate(2);"<?php endif; ?> onmouseover="rating_over(2);"></span>
		                <span id="rate_3" class="fa fa-star" <?php if (!$this->rated && $this->viewer_id): ?>onclick="rate(3);"<?php endif; ?> onmouseover="rating_over(3);"></span>
		                <span id="rate_4" class="fa fa-star" <?php if (!$this->rated && $this->viewer_id): ?>onclick="rate(4);"<?php endif; ?> onmouseover="rating_over(4);"></span>
		                <span id="rate_5" class="fa fa-star" <?php if (!$this->rated && $this->viewer_id): ?>onclick="rate(5);"<?php endif; ?> onmouseover="rating_over(5);"></span>
		                <span id="rating_text" class="rating_text ynvideo_rating_text"><?php echo $this->translate('click to rate'); ?></span>
		            </div>
		            
		            <?php else :?>

		            	<div class="ynvideo_rating">
			            <!-- if viewer type professional or club -> can rate -->
			            <?php if($this -> viewer() -> getIdentity() 
			            		&& $this -> video -> canAddRatings()
			            		&& $this -> video -> parent_type == "user_playercard") :?>
							
							<?php echo $this->partial('_video_rating_big.tpl', 'ynvideo', array('video' => $this->video)); ?>

				            <?php 
				    			$tableRatingType = Engine_Api::_() -> getItemTable('ynvideo_ratingtype');
								$rating_types = $tableRatingType -> getAllRatingTypes();
				            	echo $this->partial('_rate_video.tpl', 'ynvideo', array(
								        'ratingTypes' => $rating_types,
								        'video_id' => $this->video->getIdentity(),
							        )); 
							?>
						<?php endif ?>
						<!-- if player video -->
						<?php if( $this -> video -> parent_type == "user_playercard"):?>

							<!-- view ratings for user not in professional and club-->
							<?php if($this -> viewer() -> getIdentity() && !$this -> video -> canAddRatings()) :?>
								<?php echo $this->partial('_video_rating_big.tpl', 'ynvideo', array('video' => $this->video)); ?>
							<?php 
				    			$tableRatingType = Engine_Api::_() -> getItemTable('ynvideo_ratingtype');
								$rating_types = $tableRatingType -> getAllRatingTypes();
				            	echo $this->partial('_view_rate_video.tpl', 'ynvideo', array(
								        'ratingTypes' => $rating_types,
								        'video_id' => $this->video->getIdentity(),
							        )); 
							?>
							<?php endif;?>
							<!-- view ratings for guest-->
							<?php if(!$this -> viewer() -> getIdentity()):?>
								<?php echo $this->partial('_video_rating_big.tpl', 'ynvideo', array('video' => $this->video)); ?>

								<?php 
					    			$tableRatingType = Engine_Api::_() -> getItemTable('ynvideo_ratingtype');
									$rating_types = $tableRatingType -> getAllRatingTypes();
					            	echo $this->partial('_view_rate_video.tpl', 'ynvideo', array(
									        'ratingTypes' => $rating_types,
									        'video_id' => $this->video->getIdentity(),
								        )); 
								?>
							<?php endif;?>
						<?php endif;?> 

						</div>
					<?php endif;?>

			    </div>
				    <?php if ($this->video->parent_type == 'user_playercard') :?>
					<?php $player = $this->video->getParent();?>
						<?php if ($player):?>
							<div class="player-info">
							    <div class="player-photo">
							        <?php echo $this->itemPhoto($player, 'thumb.icon')?>
							    </div>
							    <div class="player_info_detail">
							        <div class="player-title">
							            <?php echo $player?>
							        </div>
							        <div class="player-position">
							        <?php $position = $player->getPosition()?>
							        <?php if ($position) : ?>
							            <?php //echo $position?>
							
							        <?php echo substr($position,0, 2)?>
							
							        <?php endif;?>
							
							        <?php $sport = $player->getSport();?>
							            <?php if ($sport):?>    
							                <?php //echo ' - '.$sport->title ?>
							            <?php endif;?>
							        </div>
							    </div>
							</div>
						<?php endif;?>
					<?php endif;?>
		        
		    </div>
	        <?php 
		        $json = '{"taggingContent":["friends"],"showComposerOptions":["addLink","addSmilies"],"showAsNested":"1","showAsLike":"0","showDislikeUsers":"1","showLikeWithoutIcon":"0","showLikeWithoutIconInReplies":"0","commentsorder":"1","loaded_by_ajax":"0","name":"yncomment.comments","nomobile":"0","notablet":"0","nofullsite":"0"}';
				echo $this->content()->renderWidget('yncomment.comments', (array)json_decode($json));
			?>
	    </div>
	    
	    <div class="ynvideo_popup_right">
	    	<!-- <div class="suggest_videos" style="display: none">
	    		<?php //echo $this->content()->renderWidget('ynvideo.show-same-poster'); ?>
	    	</div> -->
	    	<div class="related_videos">
	    	<?php echo $this->content()->renderWidget('ynvideo.show-same-categories'); ?>
	    	</div>
	    </div>
	</div>
</div>

<script type="text/javascript">
	$$('.ynvideo_popup_close').addEvent('click',function(){parent.Smoothbox.close()});	
</script>
