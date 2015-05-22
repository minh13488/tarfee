<?php $paginater_vari = 0; if( !empty($this->following)) {  $paginater_vari = $this->paginator->getCurrentPageNumber(); }  ?>

<script type="text/javascript">
 var likeMemberPage = <?php if(empty($this->no_result_msg)){ echo sprintf('%d', $paginater_vari); } else { echo 1; } ?>;
 var url = en4.core.baseUrl + 'user/friends/list-all-following';

 var paginateFollowing = function(page) {
		var search_value = $('like_members_search_input').value;
		if (search_value == '') {
			search_value = '';
		}
		var request = new Request.HTML({
		'url' : url,
			'data' : {
				'format' : 'html',
				'page' : page,
				'is_ajax':1,
			},
			onSuccess : function(responseTree, responseElements, responseHTML, responseJavaScript) {
				document.getElementById('following_popup_content').innerHTML = responseHTML;
				en4.core.runonce.trigger();
			}
		});					
		request.send();
  }
</script>
</div>

<?php  if(empty($this->is_ajax)) { ?>
<div class="following_members_popup">
	<div class="top">
		<?php
            $title = $this->translate('Following who following you');
		?>
		<div class="heading"><?php echo $title; ?></div>
	</div>
	<div class="following_members_popup_content" id="following_popup_content">
		<?php } ?>
    <?php if( !empty($this->following) && count($this->following) > 1 ): ?>
				<?php if( $this->paginator->getCurrentPageNumber() > 1 ): ?>
					<div class="following_members_popup_paging">
						<div id="user_following_previous" class="paginator_previous">
							<?php echo $this->htmlLink('javascript:void(0);', $this->translate('Previous'), array(
								'onclick' => 'paginateFollowing(likeMemberPage - 1)'
							)); ?>
						</div>
					</div>
				<?php endif; ?>
			<?php  endif; ?>
		<?php $count_user = count($this->following);
				if(!empty($count_user)) {
					foreach( $this->following as $user_info ) { ?>
				<div class="item_member">
					<div class="item_member_thumb">
						<?php echo $this->htmlLink($user_info->getHref(), $this->itemPhoto($user_info, 'thumb.icon', $user_info->getTitle()), array('class' => 'item_photo', 'target' => '_parent', 'title' => $user_info->getTitle(), 'rel'=> 'user'.' '.$user_info->getIdentity()));?>
					</div>
					<div class="item_member_details">
						<div class="item_member_name">
							<?php  $title1 = $user_info->getTitle(); ?>
							<?php  $truncatetitle = Engine_String::strlen($title1) > 20 ? Engine_String::substr($title1, 0, 20) . '..' : $title1?>
							<?php echo $this->htmlLink($user_info->getHref(), $truncatetitle, array('title' => $user_info->getTitle(), 'target' => '_parent', 'class' => '', 'rel'=> 'user'.' '.$user_info->getIdentity())); ?>
						</div>
					</div>	
				</div>
				<?php	}
			 } else { ?>
			<div class='tip' style="margin:10px 0 0 140px;"><span>
			 		<?php
			 			echo $this->no_result_msg;
			 		?>
			 </span></div>
			<?php } ?>
			<?php 
				if(!empty($this->following) && $this->paginator->count() > 1 ): ?>
					<?php if( $this->paginator->getCurrentPageNumber() < $this->following->count() ): ?>
						<div class="ynfeed_members_popup_paging">
							<div id="user_like_members_next" class="paginator_next" style="border-top-width:1px;">
								<?php echo $this->htmlLink('javascript:void(0);', $this->translate('Next') , array(
									'onclick' => 'paginateFollowing(likeMemberPage + 1)'
								)); ?>
							</div>
						</div>
					<?php endif; ?>
				<?php endif; ?>
<?php if(empty($this->is_ajax)) { ?>
	</div>
</div>
<div class="following_members_popup_bottom">
	<button onclick="parent.Smoothbox.close();"><?php echo $this->translate("Close") ?></button>
</div>
<?php } ?>