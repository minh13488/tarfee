<?php if(!empty($this -> business -> timezone)):?>
<div style="padding: 5px 0">
	<?php echo $this -> business -> timezone;?>
</div>
<?php endif;?>
<?php if(count($this -> operationHours)):?>
<ul class="ynbusinesspages-overview-listtime">		
	<?php foreach($this -> operationHours  as $operationHour) :?>
	<li>
		<span><?php echo ucfirst($operationHour -> day)?></span>
		<span>
			<?php if($operationHour -> from == 'CLOSED') :?>
				<?php echo $this -> translate('CLOSED') ?>
			<?php else :?>
				<?php echo $operationHour -> from?>
				-	
				<?php echo $operationHour -> to?>
			<?php endif;?>
		</span>
	</li>
	<?php endforeach;?>
</ul>
<?php endif;?>

