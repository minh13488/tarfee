<?php $campaign = $this -> campaign;?>


<!-- submissionPlayers -->   

<?php if(count($this -> submissionPlayers)) :?>
<h3><?php echo $this -> translate('Hidden Player Cards');?></h3>
<?php foreach($this -> submissionPlayers as $submissionPlayer) :?>
	<?php $player = Engine_Api::_() -> getItem('user_playercard', $submissionPlayer -> player_id);?>
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
		<?php echo $this -> htmlLink($this -> url(array('action' => 'unhide', 'campaign_id' => $campaign -> getIdentity(), 'id' => $submissionPlayer -> getIdentity()), 'tfcampaign_specific', true), $this -> translate("unhide with player"), array('class' => 'smoothbox')) ?>
	<?php endif;?>
	<?php $reason = $submissionPlayer -> getReason();?>
	<?php if($reason) :?>
		<?php echo $this -> translate('Reason');?>:<?php echo $this -> translate($reason -> title);?>
	<?php endif;?>
	<br/>
<?php endforeach;?>
<?php endif;?>

