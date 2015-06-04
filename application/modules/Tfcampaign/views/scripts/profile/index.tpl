<?php $campaign = $this -> campaign;?>
<h3><?php echo $campaign;?></h3>
<p><?php echo $campaign -> getDescription();?></p>

<?php 
	$endDateObj = null;
	$startDateObj = null;
	if (!is_null($campaign->start_date) && !empty($campaign->start_date) && $campaign->start_date) 
	{
		$endDateObj = new Zend_Date(strtotime($campaign->start_date));	
	}
	if (!is_null($campaign->end_date) && !empty($campaign->end_date) && $campaign->end_date) 
	{
		$startDateObj = new Zend_Date(strtotime($campaign->end_date));	
	}
	if( $this->viewer() && $this->viewer()->getIdentity() ) {
		$tz = $this->viewer()->timezone;
		if (!is_null($endDateObj))
		{
			$endDateObj->setTimezone($tz);
		}
		if (!is_null($startDateObj))
		{
			$startDateObj->setTimezone($tz);
		}
    }
?>

<?php if(!empty($startDateObj)) :?>
(<i><?php echo $this -> translate('Start At') ;?>: <?php echo (!is_null($startDateObj)) ?  date('M d Y', $startDateObj -> getTimestamp()) : ''; ?></i>)
<?php endif;?>


<?php if(!empty($endDateObj)) :?>
(<i><?php echo $this -> translate('End At') ;?>: <?php echo (!is_null($endDateObj)) ?  date('M d Y', $endDateObj -> getTimestamp()) : ''; ?></i>)
<?php endif;?>
<br/>
<?php echo $this -> translate("Campaign Preferences");?>
<ul>
<?php
	$from_age = $campaign -> from_age;
	$to_age = $campaign -> to_age;
?>
<?php if($from_age && $to_age) :?>
	<li><?php echo $this -> translate("From %s To %s", $from_age, $to_age);?></li>
<?php elseif($from_age) :?>
	<li><?php echo $this -> translate("Minimum age is %s", $from_age);?></li>
<?php elseif($to_age) :?>
	<li><?php echo $this -> translate("Maximum age is %s", $to_age);?></li>
<?php endif;?>
</ul>
