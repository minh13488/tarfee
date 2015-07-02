<style>
	.highlighted-text {
		font-weight: bold;
	}
</style>
<?php if(count($this->results) <= 0): ?>
<div class="tip">
	<span>
  		<?php echo $this->translate('No results were found.') ?>
	</span>
</div>
<?php else: ?>
<ul class = "ynadvsearch_searchresult" id="ynadvsearch_searchresults">
<?php $count = 1;?>
<?php foreach( $this->results as $row): ?>
	<?php if ($count > $this->limit) break;?>
	<?php $item = (!empty($row->type) && !empty($row->id)) ? $this->item($row->type, $row->id): $row;?>
	<?php if ($item) :?>
	<li class="result-search-item <?php echo $item->getType()?>-item">
	<?php switch ($item->getType()) :
		case 'user_playercard': ?>
		<div id='profile_photo'>
			<?php $photoUrl = ($item -> getPhotoUrl('thumb.main')) ? $item->getPhotoUrl('thumb.main') : "application/modules/User/externals/images/nophoto_playercard_thumb_profile.png" ?>
			<div class="avatar">
				<div class="thumb_profile" style="background-image:url(<?php echo $photoUrl?>)">
					
					<div class="avatar-box-hover">
						<ul class="actions">
							<li><a href="<?php echo $item -> getHref()?>"><i class="fa fa-external-link"></i></a></li>
							<?php if($this -> viewer() -> getIdentity() && $item -> getOwner() -> isSelf($this -> viewer())): ?>
							<!-- Button Edit Crop Delete -->
							<li class="first">
								<?php
					            	echo $this->htmlLink(array(
							            'route' => 'user_extended',
							            'controller' => 'player-card',
							            'action' => 'edit',
							            'id' => $item->playercard_id,
							        ), '<i class="fa fa-pencil"></i>', array(
							            'class' => '', 'title' => $this -> translate('Edit')
							        ));
								?>
							</li>

							<li class="second">
								<?php
					        		echo $this->htmlLink(array(
							            'route' => 'user_extended',
							            'controller' => 'player-card',
							            'action' => 'crop-photo',
							            'id' => $item->playercard_id,
							        ), '<i class="fa fa-crop"></i>', array(
							            'class' => 'smoothbox', 'title' => $this -> translate('Crop Photo')
							        ));
								?>
							</li>

							<li class="fifth">
								<?php
									echo $this->htmlLink(array(
							            'route' => 'user_extended',
							            'controller' => 'player-card',
							            'action' => 'delete',
							            'id' => $item->playercard_id,
							        ), '<i class="fa fa-times"></i>', array(
							            'class' => 'smoothbox', 'title' => $this -> translate('Delete')
							        ));
								?>
							</li>
							
							<?php if($this -> viewer() -> getIdentity() && Engine_Api::_()->user()->canTransfer($item)) :?>
							<li>
								<?php
									echo $this->htmlLink(array(
							            'route' => 'user_general',
							            'action' => 'transfer-item',
	    								'subject' => $item -> getGuid(),
							        ), '<i class="fa fa-exchange"></i>', array(
							            'class' => 'smoothbox', 'title' => $this -> translate('Transfer to user profile')
							        ));
								?>
							</li>
							<?php endif;?>	

							<li class="setting" onclick="showOptions(<?php echo $item->playercard_id ?>, this)">
								<a href="javascript:void(0)"><i class="fa fa-plus"></i></a>
							</li>
								<ul class="setting-list" style="display: none" id="setting-list_<?php echo $item->playercard_id?>">
									<li>
									<?php
					        			echo $this->htmlLink(array(
										'route' => 'video_general',
											'action' => 'create',
											'parent_type' =>'user_playercard',
											'subject_id' =>  $item->playercard_id,
										), '<i class="fa fa-video-camera"></i>&nbsp;'.$this->translate('Add Video'), array(
										'class' => '', 'title' => $this -> translate('Add Video')
										)) ;
									?>
									</li>

									<li>
									<?php
										echo $this->htmlLink(array(
								            'route' => 'user_photo',
								            'controller' => 'upload',
								            'id' => $item->playercard_id,
								            'type' => $item->getType(),
								        ), '<i class="fa fa-camera"></i>&nbsp;'.$this->translate('Add Photos'), array(
								            'class' => 'smoothbox', 'title' => $this -> translate('Add Photos')
								        ));
									?>
									</li>
								</ul>
							
							
							<?php else: ?>

								<!-- asd sa d  -->
								<?php if ($this -> viewer() -> getIdentity()):?>
									<li title="<?php echo $this -> translate("Eye on")?>" id="user_eyeon_<?php echo $item -> getIdentity()?>">
			                    		<?php if($item->isEyeOn()): ?>              
			                        	<a class="actions_generic" href="javascript:void(0);" onclick="removeEyeOn('<?php echo $item->getIdentity() ?>')">
			                        		<span>
			                        			<i class="fa fa-eye-slash"></i>
		                        			</span>
			                    		</a>
			                    		<?php else: ?>
			                        	<a class="actions_generic" href="javascript:void(0);" onclick="addEyeOn('<?php echo $item->getIdentity() ?>')">
			                        		<span>
			                        			<i class="fa fa-eye"></i>
		                        			</span>
			                        	</a>
			                    		<?php endif; ?>
			                		</li>

									<li title="<?php echo $this -> translate('Comment')?>">
										<a class="actions_generic" href="<?php echo $item -> getHref()?>">
											<span>
												<i class="fa fa-comment"></i>
											</span>
										</a>
									</li>
								
									<?php $url = $this->url(array('module'=> 'core', 'controller' => 'report', 'action' => 'create', 'subject' => $item->getGuid(), 'format' => 'smoothbox'),'default', true);?>
									<li title="<?php echo $this -> translate('Report')?>">
										<a class="actions_generic smoothbox" href="<?php echo $url?>">
											<span>
												<i class="fa fa-flag"></i>
											</span>
										</a>
									</li>
								<?php endif;?>
							<?php endif; ?>
							
						</ul>
					</div>
					<div class="tarfee_sport_type_position">
						<?php if($item -> getSport()):?>
							<?php echo $this -> itemPhoto($item -> getSport(), 'thumb.icon');?>
							<span title="<?php echo $item -> getSport() -> getTitle();?>" class="player-title"><?php echo $item -> getSport() -> getTitle();?></span>
						<?php endif;?>
						<?php if($item -> getPosition()):?>
							<span title="<?php echo $item -> getPosition() -> getTitle();?>" class="player-position">
								<?php echo $item -> getPosition() -> getTitle();?>
							</span>
						<?php endif;?>
						
					</div><!--tarfee_sport_type_position-->
				</div>
			</div>
			<div class="tarfee_gender_player_name">
				<span class="gender_player">
					<?php if (($item->gender) == 1){
						echo '<i class="fa fa-mars"></i>';
					}else{
						echo '<i class="fa fa-venus"></i>';
					}

					?>
					
				</span>
				<a title="<?php echo $item -> first_name.' '.$item -> last_name;?>" href="<?php echo $item -> getHref()?>" class="player_name" ><?php echo $this -> string() -> truncate($item -> first_name.' '.$item -> last_name, 20)?></a>
			</div>

			<?php $overRallRating = $item -> rating;?>
			<div class="user_rating" title="<?php echo $overRallRating;?>">
				<?php for ($x = 1; $x <= $overRallRating; $x++): ?>
			        <span class="rating_star_generic"><i class="fa fa-star"></i></span>
			    <?php endfor; ?>
			    <?php if ((round($overRallRating) - $overRallRating) > 0): $x ++; ?>
			        <span class="rating_star_generic"><i class="fa fa-star-half-o"></i></span>
			    <?php endif; ?>
			    <?php if ($x <= 5) :?>
			        <?php for (; $x <= 5; $x++ ) : ?>
			            <span class="rating_star_generic"><i class="fa fa-star-o"></i></span>
			        <?php endfor; ?>
			    <?php endif; ?>
			</div>
			<?php
				$countryName = '';
				if($item ->country_id && $country = Engine_Api::_() -> getItem('user_location', $item ->country_id))
				{
					$countryName = $country -> getTitle();
				}
			?>

			<div class="tarfee_infomation_player">
				<p>
					<?php echo  $this->locale()->toDate($item -> birth_date);?> 
				</p>
				<p>
					<?php 
						if($countryName)
						echo $countryName
					?>
				</p>
				<p>
					<?php 
						$laguages = json_decode($item -> languages);
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
			<ul class="tarfee_count">
				<li>
					<?php $eyeons = $item->getEyeOns(); ?>
					<?php $url = $this->url(array('action'=>'view-eye-on', 'player_id'=>$item->getIdentity()), 'user_playercard' , true)?>
					<?php if(count($eyeons)):?>		
					<a href="<?php echo $url?>" class="smoothbox">
						<span class="tarfee-count-number"><?php echo count($eyeons); ?></span>
						<span><?php echo $this->translate('eye on');  ?></span>
					</a>
					<?php else:?>
						<span class="tarfee-count-number"><?php echo count($eyeons); ?></span>
						<span><?php echo $this->translate('eye on');  ?></span>
					<?php endif;?>
				</li>

				<li>
					<span class="tarfee-count-number"><?php  echo $totalVideo; ?></span>
					<span><?php echo $this->translate(array('video','videos', $totalVideo)); ?></span>
				</li>
				<li>
					<span class="tarfee-count-number"><?php echo $totalPhoto; ?></span>
					<span><?php echo $this->translate(array('photo','photos', $totalPhoto));?></span>
				</li>
			</ul>
			
			<div class="nickname">
				<?php echo $this->htmlLink($item -> getOwner()->getHref(), $this->itemPhoto($item -> getOwner(), 'thumb.icon', $item -> getOwner()->getTitle(), array('style' => 'width: auto')), array('class' => 'members_thumb')) ?>
				<div class='members_info'>
			        <div class='members_name'>
				          <?php echo $this->htmlLink($item -> getOwner()->getHref(), $item -> getOwner() ->getTitle()) ?>
			        </div>
			        <div class='members_date'>
			          <?php echo $this->timestamp($item -> getOwner() -> creation_date) ?>
			        </div>
		      	</div>
	     	</div><!-- nickname-->

		</div>	
		<?php break;?>
		
		<?php case 'video': ?>
			<?php
        		echo $this->partial('_video_listing_mainpage.tpl', 'ynvideo', array(
        			'video' => $item
        		));
            ?>
		<?php break;?>
		
		<?php case 'event': ?>
			<div class="ynevents_photo">
	            <?php echo $this->htmlLink($item, $this->itemPhoto($item, 'thumb.normal')) ?>
	        </div>
	
	        <div class="ynevents_info">
	            <div class="ynevents_title">
	                <?php echo $this->htmlLink($item->getHref(), $item->getTitle()) ?>
	            </div>
	            <div class="ynevents_desc">
	                <?php echo $item->getDescription() ?>
	            </div>
	
	        </div>
	        
	        <?php if($this -> viewer() -> getIdentity() && Engine_Api::_()->user()->canTransfer($item)) :?>
			<div>
				<?php
					echo $this->htmlLink(array(
			            'route' => 'user_general',
			            'action' => 'transfer-item',
						'subject' => $item -> getGuid(),
			        ), '<i class="fa fa-exchange"></i>', array(
			            'class' => 'smoothbox', 'title' => $this -> translate('Transfer to club')
			        ));
				?>
			</div>
			<?php endif;?>
			
	        <div class="ynevents_members">
	            <?php echo '<i class="fa fa-user"></i> &nbsp;&nbsp;'.$this->translate(array('%s guest', '%s guests', $item->member_count),$this->locale()->toNumber($item->member_count)) ?>
	        </div>
	        <div class="ynevents_time_place_rating">
	            <div class="ynevents_time_place">
	                <span>
	                    <?php echo $this->locale()->toDate($item->starttime, array('size' => 'long')) ?>
	                </span>
	                <span>
	                    <?php echo $item->address;?>
	                </span>
	            </div>
	
	            <div class="ynevents_rating">
	                
	            </div>
	        </div>
			<?php 
			if($this -> viewer() -> getIdentity()):
				$row = $item->membership()->getRow($this -> viewer());
				if($row):
					$rsvp = $row -> rsvp;
				?>
		        <div class="ynevents_button" id = "ynevent_rsvp_<?php echo $item -> getIdentity()?>">
		           <?php echo $this -> action('list-rsvp', 'widget', 'ynevent', array( 'id' => $item -> getIdentity()));?>
		        </div>
		        <?php endif;?>
	        <?php endif;?>
		<?php break;?>
		
		<?php case 'blog': ?>
			<div class='blogs_browse_info'>
	        	<p class='blogs_browse_info_title'>
	          	<?php echo $this->htmlLink($item->getHref(), $item->getTitle()) ?>
	        	</p>
	        	<p class='blogs_browse_info_date'>
	          	<?php echo $this->translate('Posted');?> <?php echo $this->timestamp($item->creation_date) ?>
	        	</p>
	        	<p class='blogs_browse_info_blurb'>
	          	<?php echo $item->getDescription(); ?>
	        	</p>
	      	</div>
	      	<?php if($this -> viewer() -> getIdentity() && Engine_Api::_()->user()->canTransfer($item)) :?>
			<div>
				<?php
					echo $this->htmlLink(array(
			            'route' => 'user_general',
			            'action' => 'transfer-item',
						'subject' => $item -> getGuid(),
			        ), '<i class="fa fa-exchange"></i>', array(
			            'class' => 'smoothbox', 'title' => $this -> translate('Transfer to club')
			        ));
				?>
			</div>
			<?php endif;?>
		<?php break;?>
		
		<?php default: ?>
		<div class="ynadvsearch-result-item-photo">
        	<?php echo $this->htmlLink($item->getHref(), $this->itemPhoto($item, 'thumb.icon')) ?>
      	</div>
      	<div class="ynadvsearch-result-item-info">
	    	<?php
	        if(!empty($this->text)):
	            echo $this->htmlLink($item->getHref(), $this->highlightText($item->getTitle(), implode(' ', $this->text)), array('class' => 'search_title'));
	            else:
	            echo  $this->htmlLink($item->getHref(), $item->getTitle(), array('class' => 'search_title'));
	          ?>
	        <?php endif; ?>
        	<div class="search_description">
     		<?php 
     		if(!empty($this->text)):
	            echo $this->viewMore($this->highlightText($item->getDescription(), implode(' ', $this->text)));
	       	else:
	            echo $this->viewMore($item->getDescription());
	          ?>
	        <?php endif; ?>
        	</div>
      	</div>
  	<?php endswitch; ?>
	</li>
	<?php endif; ?>
	<?php $count++;?>
<?php endforeach;?>
</ul>
<?php if (count($this->results) > $this->limit && !$this->reachLimit):?>
<a id="ynadvsearch-viewmore-btn" href="javascript:void(0)" onclick="showMore(<?php echo ($this->limit + $this->from)?>)"><?php echo $this->translate('View more result') ?></a>
<div id="ynadvsearch-loading" style="display: none;">
	<img src='<?php echo $this->layout()->staticBaseUrl ?>application/modules/Core/externals/images/loading.gif' style='float:left;margin-right: 5px;' />
</div>
<script type="text/javascript">
function showMore(from){
    var url = '<?php echo $this->url(array('module' => 'core','controller' => 'widget','action' => 'index','name' => 'ynadvsearch.search-results2'), 'default', true) ?>';
    $('ynadvsearch-viewmore-btn').destroy();
    $('ynadvsearch-loading').style.display = '';
    var params = <?php echo json_encode($this->params)?>;
    params.format = 'html';
    params.from = from;
    var request = new Request.HTML({
      	url : url,
      	data : params,
      	onSuccess : function(responseTree, responseElements, responseHTML, responseJavaScript) {
        	$('ynadvsearch-loading').destroy();
            var result = Elements.from(responseHTML);
            var results = result.getElement('#ynadvsearch_searchresults').getChildren();
            $('ynadvsearch_searchresults').adopt(results);
            var viewMore = result.getElement('#ynadvsearch-viewmore-btn');
            if (viewMore[0]) viewMore.inject($('ynadvsearch_searchresults'), 'after');
            var loading = result.getElement('#ynadvsearch-loading');
            if (loading[0]) loading.inject($('ynadvsearch_searchresults'), 'after');
            eval(responseJavaScript);
        }
    });
   request.send();
  }

</script>
<?php endif;?>	
<?php endif; ?>
