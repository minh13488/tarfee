<div class="ynbusinesspages-profile-fields">
	<ul class="ynbusinesspages-overview-list-information">
		<?php if(isset($this -> params['phone']) && $this -> params['phone']):?>
		<?php if(!empty($this -> business -> phone)) :?>			
		<li>
			<span><?php echo $this->translate('Phone');?></span>
			<?php foreach($this -> business -> phone as $itemlist) :?>
				<span><?php echo $itemlist; ?></span>
			<?php endforeach;?>
		</li>
		<?php endif;?>
		<?php endif;?>
		
		<?php if(isset($this -> params['fax']) && $this -> params['fax']):?>
		<?php if(!empty($this -> business -> fax)) :?>
		<li>
			<span><?php echo $this->translate('Fax');?></span>
			<?php foreach($this -> business -> fax as $itemlist) :?>
				<span><?php echo $itemlist; ?></span>
			<?php endforeach;?>
		</li>
		<?php endif;?>
		<?php endif;?>

		<?php if(isset($this -> params['email']) && $this -> params['email']):?>
		<?php if(!empty($this -> business -> email)) :?>
		<li>			
			<span><?php echo $this->translate('Email');?></span>
			<span>
				<a href="mailto:<?php echo $this -> business -> email;?>"><?php echo $this -> business -> email;?></a>
			</span>
		</li>
		<?php endif;?>
		<?php endif;?>
	
		<?php if(isset($this -> params['website']) && $this -> params['website']):?>
		<?php if(!empty($this -> business -> web_address)) :?>
		<li>			
			<span><?php echo $this->translate('Website');?></span>
			<?php foreach($this -> business -> web_address as $itemlist) :?>
				<span><a href="<?php echo $itemlist; ?>"><?php echo $itemlist; ?></a></span>
			<?php endforeach;?>
		</li>
		<?php endif;?>
		<?php endif;?>
	</ul>
</div>

