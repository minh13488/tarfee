<?php $campaign = $this -> campaign;?>

<!-- filter -->
<select id="filter-submission">
	<option value="matching"><?php echo $this -> translate("% of matching");?></option>
	<option value="rating"><?php echo $this -> translate("rating");?></option>
	<option value="location"><?php echo $this -> translate("location");?></option>
	<option value="age"><?php echo $this -> translate("age");?></option>
	<option value="gender"><?php echo $this -> translate("gender");?></option>
</select>


<!-- submissionPlayers -->   

<?php if(count($this -> submissionPlayers)) :?>
<h3><?php echo $this -> translate('Submitted Player Cards');?></h3>
<?php foreach($this -> submissionPlayers as $submissionPlayer) :?>
	<?php $player = Engine_Api::_() -> getItem('user_playercard', $submissionPlayer -> player_id);?>
	<?php if($player) :?>
		<?php $overRallRating = $player -> getOverallRating();?>
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
		<?php echo $this -> itemPhoto($player);?>
		<?php echo $player;?>
		<?php 
			$today = new DateTime();
			$birthdate = new DateTime($player -> birth_date);
			$interval = $today->diff($birthdate);
			$player_age =  $interval->format('%y');
		?> 
		<?php echo $this -> translate("Age");?>:<?php echo $player_age;?> <br/>
		<?php echo $this -> translate("Owner");?>:<?php echo $player -> getOwner();?><br/>
		<?php echo $this -> translate("Note");?>:<?php echo $submissionPlayer -> getTitle();?> <br/>
		<?php echo $this -> translate("Description");?>:<?php echo $submissionPlayer -> getDescription();?><br/>
		<?php echo $submissionPlayer -> countPercentMatching()."%";?><br/>
		<?php if($this -> viewer() -> isSelf($campaign -> getOwner())) :?>
			<?php echo $this -> htmlLink($this -> url(array('action' => 'hide', 'campaign_id' => $campaign -> getIdentity(), 'id' => $submissionPlayer -> getIdentity()), 'tfcampaign_specific', true), $this -> translate("hide with reason"), array('class' => 'smoothbox')) ?>
		<?php endif;?>
		<?php if($this -> viewer() -> isSelf($submissionPlayer -> getOwner())) :?>
			<?php echo $this -> htmlLink($this -> url(array('action' => 'withdraw', 'campaign_id' => $campaign -> getIdentity(), 'id' => $submissionPlayer -> getIdentity()), 'tfcampaign_specific', true), $this -> translate("withdraw"), array('class' => 'smoothbox')) ?>
		<?php endif;?>
		<?php
			Engine_Api::_()->core()->clearSubject();
			Engine_Api::_()->core()->setSubject($player -> getOwner());
			$menuUser = new User_Plugin_Menus();
			$menuMessage = new Messages_Plugin_Menus();
			$aFollowButton = $menuUser -> onMenuInitialize_UserProfileFriend();
			$aReportButton  = $menuUser -> onMenuInitialize_UserProfileReport();
			$aMessageButton = $menuMessage -> onMenuInitialize_UserProfileMessage();
		?>
		<?php if($aFollowButton) :?>
			<a class='<?php if(isset($aFollowButton['class'])) echo $aFollowButton['class']; ?>' href="<?php echo $this -> url($aFollowButton['params'], $aFollowButton['route'], array()); ?>" > 
				<?php echo $this -> translate($aFollowButton['label']) ?>
			</a>
		<?php endif;?>
		<?php if($aReportButton) :?>
			<a class='<?php if(isset($aReportButton['class'])) echo $aReportButton['class']; ?>' href="<?php echo $this -> url($aReportButton['params'], $aReportButton['route'], array()); ?>" > 
				<?php echo $this -> translate($aReportButton['label']) ?>
			</a>
		<?php endif;?>
		<?php if($aMessageButton) :?>
			<a class='<?php if(isset($aMessageButton['class'])) echo $aMessageButton['class']; ?>' href="<?php echo $this -> url($aMessageButton['params'], $aMessageButton['route'], array()); ?>" > 
				<?php echo $this -> translate($aMessageButton['label']) ?>
			</a>
		<?php endif;?>
		<!-- clear subject for loop to get action button -->
		<?php Engine_Api::_()->core()->clearSubject('user');?>
	<br/>
	<?php endif;?>
<?php endforeach;?>
<?php 
	//set subject to campaign
	Engine_Api::_()->core()->clearSubject();
	Engine_Api::_()->core()->setSubject($campaign);
?>
<?php endif;?>

<script type="text/javascript">
	window.addEvent('domready', function(){
		<?php if($this -> filterType):?>
			$('filter-submission').set('value', '<?php echo $this -> filterType;?>');
		<?php endif;?>
		$('filter-submission').addEvent('change', function(){
			type_id = this.value;
			url = '<?php echo $this -> url(array('id' => $campaign -> getIdentity(), 'slug' => $campaign -> getSlug()), 'tfcampaign_profile',true);?>' + '/sort/' + type_id;
			window.location.assign(url);
		});
	});
</script>