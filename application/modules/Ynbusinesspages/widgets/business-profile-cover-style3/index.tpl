<script type="text/javascript">
<?php if(!$this->subject()->is_claimed) :?>
function setFollow(option_id)
{
	new Request.JSON({
        url: '<?php echo $this->url(array('action' => 'profile-follow', 'business_id' => $this->subject()->business_id), 'ynbusinesspages_specific', true); ?>',
        method: 'post',
        data : {
        	format: 'json',
            'option_id' : option_id
        },
        onComplete: function(responseJSON, responseText) {
            if (option_id == '0')
            {
            	$("ynbusinesspages_widget_cover_follow").set("html", '<i class="fa fa-arrow-right"></i> <?php echo $this -> translate("Follow Business");?>');
            	$("ynbusinesspages_widget_cover_follow").set("onclick", "setFollow(1)");
            	$("ynbusinesspages_widget_cover_follow").set("title", "<?php echo $this -> translate("Follow Business");?>");
            }
            else if (option_id == '1')
            {
            	$("ynbusinesspages_widget_cover_follow").set("html", '<i class="fa fa-arrow-right"></i> <?php echo $this -> translate("Un-follow Business");?>');
            	$("ynbusinesspages_widget_cover_follow").set("onclick", "setFollow(0)");
            	$("ynbusinesspages_widget_cover_follow").set("title", "<?php echo $this -> translate("Un-follow Business");?>");
            }
            
        }
    }).send();
}
function setFavourite(option_id)
{
	new Request.JSON({
        url: '<?php echo $this->url(array('action' => 'profile-favourite', 'business_id' => $this->subject()->business_id), 'ynbusinesspages_specific', true); ?>',
        method: 'post',
        data : {
        	format: 'json',
            'business_id': <?php echo $this->subject()->business_id ?>,
            'option_id' : option_id
        },
        onComplete: function(responseJSON, responseText) {
            if (option_id == '0')
            {
            	$("ynbusinesspages_widget_cover_favourite").set("html", '<i class="fa fa-star"></i>  <?php echo $this -> translate("Favourite Business");?>');
            	$("ynbusinesspages_widget_cover_favourite").set("onclick", "setFavourite(1)");
            	$("ynbusinesspages_widget_cover_favourite").set("title", "<?php echo $this -> translate("Favourite Business");?>");
            }
            else if (option_id == '1')
            {
            	$("ynbusinesspages_widget_cover_favourite").set("html", '<i class="fa fa-star"></i>  <?php echo $this -> translate("Un-favourite Business");?>');
            	$("ynbusinesspages_widget_cover_favourite").set("onclick", "setFavourite(0)");
            	$("ynbusinesspages_widget_cover_favourite").set("title", "<?php echo $this -> translate("Un-favourite Business");?>");
            }
            
        }
    }).send();
}
<?php endif;?>

function checkOpenPopup(url)
{
	  if(window.innerWidth <= 480)
	  {
	  	Smoothbox.open(url, {autoResize : true, width: 300});
	  }
	  else
	  {
	  	Smoothbox.open(url);
	  }
}

function reloadOptionsWidget() {
	new Request.JSON({
		'format': 'json',
		'url' : '<?php echo $this->url(array('controller' => 'business', 'action' => 'like-count'), 'ynbusinesspages_extended') ?>',
		'data' : {
			'format' : 'json',
			'business_id' : '<?php echo $this->subject()->business_id ?>'
		},
		'onSuccess' : function(responseJSON, responseText)
		{
			$('ynbusinesspages_like_count').set('html', responseJSON.html);
		}
	}).send();
}

function like(itemType, itemId)
{
	$('ynbusinesspages_like_button').set('html', '<a><i class="fa fa fa-spinner fa-pulse"></i></a>')
	
	new Request.JSON({
        url: en4.core.baseUrl + 'core/comment/like',
        method: 'post',
        data : {
        	format: 'json',
        	type : itemType,
            id : itemId,
            comment_id : 0
        },
        onSuccess: function(responseJSON, responseText) {
        	if (responseJSON.status == true)
        	{
            	html = '<a class="ynbusinesspages_liked" href="javascript:void(0);" onclick="unlike(\'<?php echo $this->subject()->getType()?>\', \'<?php echo $this->subject()->getIdentity() ?>\')"><i title="<?php echo $this -> translate('Liked');?>" class="fa fa-heart"></i></a>';
            	$("ynbusinesspages_like_button").set('html', html);
            	reloadOptionsWidget();
        	}            
        },
        onComplete: function(responseJSON, responseText) {
        }
    }).send();
}

function unlike(itemType, itemId)
{
	$('ynbusinesspages_like_button').set('html', '<a><i class="fa fa fa-spinner fa-pulse"></i></a>')

	new Request.JSON({
        url: en4.core.baseUrl + 'core/comment/unlike',
        method: 'post',
        data : {
        	format: 'json',
        	type : itemType,
            id : itemId,
            comment_id : 0
        },
        onSuccess: function(responseJSON, responseText) {
        	if (responseJSON.status == true)
        	{
        		html = '<a href="javascript:void(0);" onclick="like(\'<?php echo $this->subject()->getType()?>\', \'<?php echo $this->subject()->getIdentity() ?>\')"><i title="<?php echo $this -> translate('Like');?>" class="fa fa-heart"></i></a>';
            	$("ynbusinesspages_like_button").set('html', html);
            	reloadOptionsWidget();
        	}            
        }
    }).send();
}

</script>

<div class="ynbusinesspages-profile-cover">

	<div class="ynbusinesspages-business-listing-item-claim-status <?php if($this->subject() -> is_claimed) echo "claim-unclaimed"; ?>" title="<?php if($this->subject() -> is_claimed) echo $this->translate('Unclaimed'); else echo $this->translate('Verified'); ?>">
		<i class="fa fa-check"></i>
	</div>

	<div class="ynbusinesspages-profile-avatar">
		<div class="ynbusinesspages-profile-avatar-image">
			<div class="ynbusinesspages-profile-avatar-photo">
                <?php echo Engine_Api::_()->ynbusinesspages()->getPhotoSpan($this->subject()); ?>
			</div>
		</div>
		<?php if (!Engine_Api::_()->ynbusinesspages()->isLogAsBusiness() && !Engine_Api::_()->ynbusinesspages()->isMobile2()) : ?>
		<div class="ynbusinesspages-profile-add-compare">
			<input rel="<?php echo $this->url(array('action' => 'add-to-compare', 'business_id' => $this->subject() -> getIdentity()), 'ynbusinesspages_specific', true)?>" type="checkbox" class="business-add-to-compare_<?php echo $this->subject() -> getIdentity();?>" <?php if ($this->subject()->inCompare()) echo 'checked'?> onchange="addToCompare(this, <?php echo $this->subject() -> getIdentity();?>)"/>
			<?php echo $this->translate('Add to compare')?>
		</div>
		<?php endif; ?>
	</div>
 
	<div class="ynbusinesspages-profile-content">		
		<div class="ynbusinesspages-like-information">			
			<?php if ($this->viewer()->getIdentity()):?>
			<span id="ynbusinesspages_like_button">			
				<?php if( $this->subject()->likes()->isLike($this->viewer()) ): ?>				
			   		<a class="ynbusinesspages_liked" href="javascript:void(0);" onclick="unlike('<?php echo $this->subject()->getType()?>', '<?php echo $this->subject()->getIdentity() ?>')"><i title="<?php echo $this -> translate('Liked');?>" class="fa fa-heart"></i></a>
				<?php else: ?>
			       <a href="javascript:void(0);" onclick="like('<?php echo $this->subject()->getType()?>', '<?php echo $this->subject()->getIdentity() ?>')"><i title="<?php echo $this -> translate('Like');?>" class="fa fa-heart"></i></a>
				<?php endif; ?>
			</span>
			<?php endif;?>	

			<span id="ynbusinesspages_like_count">
				<?php echo $this ->translate(array('<span>%1$s</span> like', '<span>%1$s</span> likes', $this -> subject() -> like_count), $this -> subject() -> like_count);?>
			</span>	
		</div>

		<div class="ynbusinesspages-profile-content-information">			
			<h3><?php echo $this->subject()->name; ?></h3>
			<div class="ynbusinesspages-profile-location">
				<?php echo $this->subject()->getMainLocation(); ?>
				&nbsp;-&nbsp;
			  	<?php 
				$mainLocation = $this->subject()->getMainLocation(true);
				if($mainLocation)
				{
					echo $this->htmlLink(
			        array('route' => 'ynbusinesspages_general', 'action' => 'direction', 'id' => $mainLocation->getIdentity()), 
			        $this->translate('<i class="fa fa-location-arrow"></i> Get Direction'),
			        array('class' => 'smoothbox'));
			    }   
			    ?>
			</div>
			<div class="ynbusinesspages-profile-rate">
				<?php if ($this->can_review):?>
					<?php if ($this -> my_review):?>
						<a class="smoothbox" href="<?php echo $this -> url(array('action' => 'edit',  'id' => $this->my_review->getIdentity()), 'ynbusinesspages_review');?>">
							<?php echo Engine_Api::_()->ynbusinesspages()->renderBusinessRating($this->subject()->getIdentity(), false); ?>
						</a>
					<?php else:?>
						<a class="smoothbox" href="<?php echo $this -> url(array('action' => 'create', 'business_id' => $this->subject()->getIdentity()), 'ynbusinesspages_review');?>">
							<?php echo Engine_Api::_()->ynbusinesspages()->renderBusinessRating($this->subject()->getIdentity(), false); ?>
						</a>
					<?php endif;?>
				<?php else:?>
					<?php echo Engine_Api::_()->ynbusinesspages()->renderBusinessRating($this->subject()->getIdentity(), false); ?>
				<?php endif;?>
					
				<?php if ($this -> subject() -> review_count > 0):?>
					<a class="smoothbox" href="<?php echo $this -> url(array('action' => 'list-user',  'business_id' => $this->subject()->getIdentity()), 'ynbusinesspages_review');?>">
						<?php echo "({$this -> subject() -> review_count})";?>
					</a>
				<?php else:?>
					<?php echo "({$this -> subject() -> review_count})";?>
				<?php endif;?>	
			</div>

			<div class="ynbusinesspages-profile-item-info"><span><?php echo $this -> translate('Business Size');?>:</span> <?php echo $this->subject()->size;?></div>
			<div class="ynbusinesspages-profile-item-info"><span><?php echo $this -> translate('Phone');?>:</span> <?php echo $this->subject()->phone[0];?></div>
			<div class="ynbusinesspages-profile-item-info"><span><?php echo $this -> translate('Email');?>:</span> <a href="mailto:<?php echo $this->subject()->email;?>"><?php echo $this->subject()->email;?></a></div>
			<div class="ynbusinesspages-profile-item-info"><span><?php echo $this -> translate('Website');?>:</span> <a target="_blank" href="<?php echo $this->subject()->web_address[0]; ?>"><?php echo $this->subject()->web_address[0];?></a></div>
		</div>		

		<div class="ynbusinesspages-profile-footer ynbusinesspages-clearfix">
			<div class="ynbusinesspages-profile-footer-action">			
				<?php $menu = new Ynbusinesspages_Plugin_Menus(); ?>
				<?php $memberOption = $menu -> onMenuInitialize_YnbusinesspagesProfileMember(); ?>
				<?php if ($memberOption) : ?>
					<div class="ynbusinesspages-profile-footer-action">
					<?php if (count($memberOption) == 2):?>
						<?php foreach($memberOption as $memberOptionItem):?>
							<a class = "<?php echo (!empty($memberOptionItem['class'])) ? $memberOptionItem['class'] : "";?>" href="<?php echo $this -> url($memberOptionItem['params'], $memberOptionItem['route'], array()); ?>" > 
								<?php echo $this -> translate($memberOptionItem['label']) ?>
							</a>
							<span>&nbsp;</span>
						<?php endforeach;?>
					<?php else:?>
							<a class = "<?php echo (!empty($memberOption['class'])) ? $memberOption['class'] : "";?>" href="<?php echo $this -> url($memberOption['params'], $memberOption['route'], array()); ?>" > 
								<?php echo $this -> translate($memberOption['label']) ?>
							</a>
					<?php endif;?>
					</div>
				<?php endif;?>
				
				 <?php if(!$this->subject()->is_claimed && $this->viewer()->getIdentity()) :?>
					<!-- Follow Business -->
					<div>
						<a href="javascript:;" id="ynbusinesspages_widget_cover_follow" class="" title="<?php echo ($this->follow) ? $this -> translate("Un-follow Business") : $this -> translate("Follow Business")?>" onclick="<?php echo ($this->follow) ? "setFollow(0);" : "setFollow(1);"; ?>"><i class="fa fa-arrow-right"></i> <?php echo ($this->follow) ? $this -> translate("Un-follow Business") : $this -> translate("Follow Business")?></a>
					</div>
				<?php endif;?>
				
				<!-- claim business -->
				<?php if(!$this->subject() -> isClaimedByUser() && $this->subject()->status == 'unclaimed') :?>
	            <div>
	                <?php echo $this->htmlLink($this -> url(array('action' => 'claim-business', 'id' => $this->subject() -> getIdentity()), 'ynbusinesspages_general', true), $this->translate("<i class='fa fa-paper-plane'></i> Claim business"), array('class' => 'smoothbox'));?> 
	            </div>
	            <?php endif;?>
				
				<!-- print -->
				<?php if($this->subject()->status == 'unclaimed') :?>
	                <?php $url = $this -> url(array(
	                    'module' => 'ynbusinesspages',
	                    'controller' => 'index',
	                    'action' => 'print',
	                    'id' => $this->subject()->getIdentity()),'ynbusinesspages_general', true)
	                ;?>
			        <div>      
		               	 <a href="<?php echo $url?>"><i class="fa fa-print"></i> <?php echo $this->translate('Print Business')?></a>
			        </div>
				<?php endif;?>
				
				<!-- message owner -->
				<?php  $aMessageButton = $menu -> onMenuInitialize_YnbusinesspagesProfileMessage();?>
				<?php if($aMessageButton):?>
					<div>
						<a class="<?php echo (!empty($aMessageButton['class'])) ? $aMessageButton['class'] : "";?>" href="<?php echo $this -> url($aMessageButton['params'], $aMessageButton['route'], array()); ?>" > 
							<i class="fa fa-envelope"></i> <?php echo $this -> translate($aMessageButton['label']) ?>
						</a>
					</div>
				<?php endif;?>
				
				<?php if ($this->viewer()->getIdentity() && $this->subject()->status != 'unclaimed'):?>
				<div class="ynbusinesspages-profile-footer-more-action">
					<span>
						<i class="fa fa-chevron-circle-down"></i>
						<span><?php echo $this->translate("More");?></span>						
					</span>
					<div class="ynbusinesspages-profile-footer-more-option">
	                     <?php 
	                        $aDashboardButton = $menu -> onMenuInitialize_YnbusinesspagesBusinessDashBoard();
	                        $aOpenCloseButton = $menu -> onMenuInitialize_YnbusinesspagesOpenCloseBusiness();
	                        $aDeleteButton = $menu -> onMenuInitialize_YnbusinesspagesDeleteBusiness();
	                        $aMakePaymentButton = $menu -> onMenuInitialize_YnbusinesspagesMakePaymentBusiness();
	                        $aFetureButton = $menu -> onMenuInitialize_YnbusinesspagesFeatureBusiness();
	                        $aMakeClaimPaymentButton = $menu -> onMenuInitialize_YnbusinesspagesMakePaymentClaimBusiness();
	                        $aShareButton = $menu -> onMenuInitialize_YnbusinesspagesProfileShare();
	                        $aPromoteButton = $menu -> onMenuInitialize_YnbusinesspagesProfilePromote();
	                        $aInviteButton = $menu -> onMenuInitialize_YnbusinesspagesProfileInvite();
	                        $aReportButton = $menu -> onMenuInitialize_YnbusinesspagesProfileReport();
	                        $aCheckInButton = $menu -> onMenuInitialize_YnbusinesspagesProfileCheckin();
	                        $aEditButton = $menu -> onMenuInitialize_YnbusinesspagesBusinessEdit();
					    ?>
						
						<!-- print -->
		                <?php $url = $this -> url(array(
		                    'module' => 'ynbusinesspages',
		                    'controller' => 'index',
		                    'action' => 'print',
		                    'id' => $this->subject()->getIdentity()),'ynbusinesspages_general', true)
		                ;?>
				        <div>      
			               	 <a href="<?php echo $url?>"><i class="fa fa-print"></i> <?php echo $this->translate('Print Business')?></a>
				        </div>
						
						<?php if(!$this->subject()->is_claimed) :?>
							<!-- Favourite Business -->
							<div>
								<a href="javascript:;" id="ynbusinesspages_widget_cover_favourite" class="" title="<?php echo ($this->favourite) ? $this -> translate("Un-favourite Business") : $this -> translate("Favourite Business")?>" onclick="<?php echo ($this->favourite) ? "setFavourite(0);" : "setFavourite(1);"; ?>"><i class="fa fa-star"></i>  <?php echo ($this->favourite) ? $this -> translate("Un-favourite Business") : $this -> translate("Favourite Business")?></a>
							</div>
						<?php endif;?>
						
	                    <!-- share -->
						<?php if($aShareButton):?>
							<div>
								<a class="<?php echo (!empty($aShareButton['class'])) ? $aShareButton['class'] : "";?>" href="<?php echo $this -> url($aShareButton['params'], $aShareButton['route'], array()); ?>" > 
									<i class="fa fa-share-alt"></i> <?php echo $this -> translate($aShareButton['label']) ?>
								</a>
							</div>
						<?php endif;?>

						<!-- promote -->
						<?php if($aPromoteButton):?>
							<div>
								<a class="<?php echo (!empty($aPromoteButton['class'])) ? $aPromoteButton['class'] : "";?>" href="<?php echo $this -> url($aPromoteButton['params'], $aPromoteButton['route'], array()); ?>" > 
									<i class="fa fa-bullhorn"></i> <?php echo $this -> translate($aPromoteButton['label']) ?>
								</a>
							</div>
						<?php endif;?>

						<!-- invite -->
						<?php if($aInviteButton):?>
							<div>
								<a class="<?php echo (!empty($aInviteButton['class'])) ? $aInviteButton['class'] : "";?>" href="<?php echo $this -> url($aInviteButton['params'], $aInviteButton['route'], array()); ?>" > 
									<i class="fa fa-user"></i> <?php echo $this -> translate($aInviteButton['label']) ?>
								</a>
							</div>
						<?php endif;?>

						<!-- report -->
						<?php if($aReportButton):?>
							<div>
								<a class="<?php echo (!empty($aReportButton['class'])) ? $aReportButton['class'] : "";?>" href="<?php echo $this -> url($aReportButton['params'], $aReportButton['route'], array()); ?>" > 
									<i class="fa fa-exclamation-circle"></i> <?php echo $this -> translate($aReportButton['label']) ?>
								</a>
							</div>
						<?php endif;?>

						<!-- checkin -->
						<?php if($aCheckInButton):?>
							<div>
								<a class="<?php echo (!empty($aCheckInButton['class'])) ? $aCheckInButton['class'] : "";?>" href="<?php echo $this -> url($aCheckInButton['params'], $aCheckInButton['route'], array()); ?>" > 
									<i class="fa fa-map-marker"></i> <?php echo $this -> translate($aCheckInButton['label']) ?>
								</a>
							</div>
						<?php endif;?>

						<!-- feature -->
	                    <?php if($aFetureButton) :?>
	                    <?php $aFetureButton['params']['load_smoothbox'] = 1;?>
	                    <div>
	                    <a class = "smoothbox <?php
	                        if (!empty($aFetureButton['class']))
	                            echo $aFetureButton['class'];
	                        ?>" href="<?php echo $this -> url($aFetureButton['params'], $aFetureButton['route'], array()); ?>" > 
	                        <i class="fa fa-star"></i> <?php echo $this -> translate($aFetureButton['label']) ?>
	                    </a>
	                    </div>
	                    <?php endif;?>
						
						<!-- for claim business -->
						<?php if($aMakeClaimPaymentButton) :?>
						<div>
							<a class='<?php if(isset($aMakeClaimPaymentButton['smoothbox'])) echo 'smoothbox'; ?>' href="<?php echo $this -> url($aMakeClaimPaymentButton['params'], $aMakeClaimPaymentButton['route'], array()); ?>" > 
								<i class = "<?php if (!empty($aMakeClaimPaymentButton['class']))	echo $aMakeClaimPaymentButton['class'];?>"></i> <?php echo $this -> translate($aMakeClaimPaymentButton['label']) ?>
							</a>
						</div>
						<?php endif;?>
						
						<!-- make payment -->
	                    <?php if($aMakePaymentButton) :?>
	                    <div>
	                    <a class = "<?php
	                        if (!empty($aMakePaymentButton['class']))
	                            echo $aMakePaymentButton['class'];
	                        ?>" href="<?php echo $this -> url($aMakePaymentButton['params'], $aMakePaymentButton['route'], array()); ?>" > 
	                        <i class="fa fa-money"></i> <?php echo $this -> translate($aMakePaymentButton['label']) ?>
	                    </a>
	                    </div>
	                    <?php endif;?>
	                    
	                    <!-- edit  -->
						<?php if($aEditButton) :?>
	                    <div>
	                        <a class = "<?php
	                            if (!empty($aEditButton['class']))
	                                echo $aEditButton['class'];
	                        ?>" href="<?php echo $this -> url($aEditButton['params'], $aEditButton['route'], array()); ?>" > 
	                            <i class="fa fa-pencil-square-o"></i> <?php echo $this -> translate($aEditButton['label']) ?>
	                        </a>
	                    </div>
	                    <?php endif;?>
	                    
	                    <!-- close/publish  -->
	                    <?php if($aOpenCloseButton) :?>
	                    <div>
	                    <a class = "<?php
	                        if (!empty($aOpenCloseButton['class']))
	                            echo $aOpenCloseButton['class'];
	                    ?>" href="<?php echo $this -> url($aOpenCloseButton['params'], $aOpenCloseButton['route'], array()); ?>" > 
	                        <i class="fa fa-times-circle-o"></i> <?php echo $this -> translate($aOpenCloseButton['label']) ?>
	                    </a>
	                    </div>
	                    <?php endif;?>
	                    
	                    <?php if($aDeleteButton) :?>
	                        <!-- delete  -->
	                        <div>
	                            <a class = "<?php
	                                if (!empty($aDeleteButton['class']))
	                                    echo $aDeleteButton['class'];
	                            ?>" href="<?php echo $this -> url($aDeleteButton['params'], $aDeleteButton['route'], array()); ?>" > 
	                                <i class="fa fa-trash-o"></i> <?php echo $this -> translate($aDeleteButton['label']) ?>
	                            </a>
	                        </div>
	                    <?php endif;?>
	                    
						<!-- dashboard  -->
						<?php if($aDashboardButton) :?>
						<div>
						<a class = "<?php
							if (!empty($aDashboardButton['class']))
								echo $aDashboardButton['class'];
						?>" href="<?php echo $this -> url($aDashboardButton['params'], $aDashboardButton['route'], array()); ?>" > 
							<i class="fa fa-tachometer"></i> <?php echo $this -> translate($aDashboardButton['label']) ?>
						</a>
						</div>
						<?php endif;?>
						
						<?php if(!$this->subject()->is_claimed) :?>
						<?php
	                    if($this->subject()->isAllowed('login_business')):
	                        $business_session = new Zend_Session_Namespace('ynbusinesspages_business');
	                        $businessId = $business_session -> businessId;
	                        if(!$businessId):?>
	                            <div>
	                                <a onclick="selectForSwitch('<?php echo $this->subject() -> getIdentity() ?>');" href="javascript:;"><i class="fa fa-sign-in"></i> <?php echo $this -> translate("Login As Business");?></a>

	                                <form action="<?php echo $this->url(array('action' => 'login-as-business', 'business_id' => $this->subject()->getIdentity()),'ynbusinesspages_general'); ?>" id="form_login_as_business" method="post">
	                                    <input type="hidden" name="business_item" id="business_item" value="" />
	                                </form>

	                                <script type="text/javascript">
	                                  var hideItem=new Array();
	                                  function selectForSwitch(id)
	                                  { 
	                                      $('business_item').value = id;
	                                      $('form_login_as_business').submit();
	                                  }
	                                </script>
	                            </div>
	                            
	                        <?php else:?>
	                            <div>
	                                <a href="<?php echo $this->url(array('action' => 'logout-business', 'business_id' => $this->subject()->getIdentity()),'ynbusinesspages_general'); ?>"><i class="fa fa-sign-out"></i> <?php echo $this -> translate("Logout of Business");?></a>
	                            </div>
	                    <?php endif; endif; endif;?>   
					</div>
				</div>
				<?php endif; ?>
			</div>
		</div>	
	</div>		
</div>
<script type="text/javascript">
	(function($,$$){
      var events;
      var check = function(e){
        var target = $(e.target);
        var parents = target.getParents();
        events.each(function(item){
          var element = item.element;
          if (element != target && !parents.contains(element))
            item.fn.call(element, e);
        });
      };
      Element.Events.outerClick = {
        onAdd: function(fn){
          if(!events) {
            document.addEvent('click', check);
            events = [];
          }
          events.push({element: this, fn: fn});
        },
        onRemove: function(fn){
          events = events.filter(function(item){
            return item.element != this || item.fn != fn;
          }, this);
          if (!events.length) {
            document.removeEvent('click', check);
            events = null;
          }
        }
      };
    })(document.id,$$);

    $$('.ynbusinesspages-profile-footer-more-action > span').addEvent('outerClick', function(){
        $$('.ynbusinesspages-profile-footer-open-option').removeClass('ynbusinesspages-profile-footer-open-option');
    });

	$$('.ynbusinesspages-profile-footer-more-action > span').addEvent('click', function(){
		this.getParent().toggleClass('ynbusinesspages-profile-footer-open-option');
	});
</script>

<script type="text/javascript">
 //script for add to compare
    function addToCompare(obj, id) {
        var value = (obj.checked) ? 1 : 0;
        var url = obj.get('rel');
        var jsonRequest = new Request.JSON({
            url : url,
            onSuccess : function(json, text) {
                if (!json.error) {
                    $$('.business-add-to-compare_'+id).set('checked', obj.checked);
                    var params = {};
                    params['format'] = 'html';
                    var request = new Request.HTML({
                        url : en4.core.baseUrl + 'widget/index/name/ynbusinesspages.compare-bar',
                        data : params,
                        onSuccess: function(responseTree, responseElements, responseHTML, responseJavaScript) {
                            $$('.layout_ynbusinesspages_compare_bar').destroy();
                            var body = document.getElementsByTagName('body')[0];
                            Elements.from(responseHTML).inject(body);
                            eval(responseJavaScript);
                        }
                    });
                    request.send();
                }
                else {
                    obj.set('checked', !obj.checked);
                    alert(json.message);
                }
            }
        }).get({value:value});
    }

</script>
