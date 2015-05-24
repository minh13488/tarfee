<?php 
    $label = Engine_Api::_()->user()->getSectionLabel($this->section);
    $viewer = Engine_Api::_()->user()->getViewer();
    $user = $this->user;
    $params = $this->params;
    $manage = ($viewer->getIdentity() == $user->getIdentity()) ;
	$recommendations = $user->getShowRecommendations();
	$enable = Engine_Api::_()->user()->checkSectionEnable($user, 'recommendation');
	$canAsk = ($manage) ? $user->canAskRecommendation() : false;
	$pendings = ($manage) ? count($user->getPendingRecommendations()) : 0;
	$requests = ($manage) ? count($user->getRequestRecommendations()) : 0;
	$request = ($manage || !$viewer->getIdentity()) ? false : $user->getRecommendation($viewer->getIdentity());
	$canRecommendation = ($manage) ? false : ($viewer->getIdentity() && (!$request || $request->request) && $user->isFriend($viewer->getIdentity()));
?>
<?php if (($manage || count($recommendations) || $canRecommendation) && $enable) : ?>
<h3 class="section-label"><?php echo $this->translate($label);?></h3>
 
<div class="profile-section-button">
<?php if ($canAsk) :?>
	<span class="manage-section-button">
		<?php echo $this->htmlLink(array('route'=>'user_recommendation', 'action'=>'ask'), $this->translate('Ask for recommendations'), array('class'=>'smoothbox'))?>
	</span>	
<?php endif;?>

<?php if ($manage) :?>
	<span class="manage-section-button">
		<?php echo $this->htmlLink(array('route'=>'user_recommendation', 'action'=>'received'), $this->translate('Manage'), array('class'=>'smoothbox'))?>
	</span>
	
	<?php if ($pendings) : ?>
	<span class="manage-section-button">
		<?php echo $this->htmlLink(array('route'=>'user_recommendation', 'action'=>'pending'), $this->translate(array('(%s) pending', '(%s) pendings', $pendings), $pendings), array('class'=>'smoothbox'))?>
	</span>
	<?php endif; ?>
	
	<?php if ($requests) : ?>
	<span class="manage-section-button">
		<?php echo $this->htmlLink(array('route'=>'user_recommendation', 'action'=>'request'), $this->translate(array('(%s) request', '(%s) requests', $requests), $requests), array('class'=>'smoothbox'))?>
	</span>
	<?php endif; ?>
<?php else:?>	
	
<?php if ($canRecommendation) : ?>
	<span class="manage-section-button">
		<?php $message = ($request) ? $this->translate('%s is waiting for your recommendation. Recommend now!', $user->getTitle()) : $this->translate('Recommend for %s', $user->getTitle());?>
		<?php echo $this->htmlLink(array('route'=>'user_recommendation', 'action'=>'give', 'receiver_id'=>$user->getIdentity()), $message, array('class'=>'smoothbox'))?>
	</span>
<?php endif;?>
<?php endif?>	
</div>

<div class="profile-section-content">
	<div class="profile-section-list">
	<?php if (count($recommendations)) : ?>
		<ul id="recommendation-list" class="section-list">
	    <?php foreach ($recommendations as $item) :?>
	    <li class="section-item" id="recommendation-<?php echo $item->getIdentity()?>">
	    	<div class="giver-info">
	    		<?php $giver = Engine_Api::_()->user()->getUser($item->giver_id);?>
	    		<span class="photo"><?php echo $this->htmlLink($giver->getHref(), $this->itemPhoto($giver, 'thumb.icon'), array())?></span>
	    		<span class="title"><?php echo $giver?></span>
	    	</div>
	    	<div class="recommendation-content">
	    		<div class="content">
	    			<?php echo $this->viewMore($item->content, 255);?>
	    		</div>
	    		<div class="time">
	    			<?php echo date('M, d, Y', $item->getGivenDate()->getTimestamp());?>
	    		</div>
	    	</div>
	    </li>
	    <?php endforeach;?>
	   </ul>
	<?php else: ?>
		<div class="tip">
			<span><?php echo $this->translate('Don\'t have any recommendations')?></span>
		</div>
	<?php endif; ?>
	</div>
</div>
<?php endif;?>