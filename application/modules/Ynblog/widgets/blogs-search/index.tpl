<div>
  <form id="filter_form" action="" method="post">
  	<input type="text" name="search" value="<?php echo $this -> search?>" placeholder="<?php echo $this -> translate("Searh Talks")?>"/>
  	<a href="<?php $this -> url(array('action' => 'create'), 'blog_general', true)?>"><?php echo $this -> translate("Add Talks")?></a>
  	<h3><?php echo $this -> translate("Filters")?></h3>
  	<?php $cat_arrays = Engine_Api::_()->getItemTable('blog_category')->getCategoriesAssoc();?>
  	<span><?php echo $this -> translate("Categories")?></span>
  	<?php foreach($cat_arrays as $key => $value):?>
  		<label><?php echo $value?></label>
  		<input type="checkbox" name="categories[]" value="<?php echo $value?>" <?php if(in_array($value, $this -> categories)):?>  checked="checked" <?php endif;?>/>
	<?php endforeach; ?>
	<span><?php echo $this -> translate("By author")?></span>
	<label><?php echo $this -> translate("Professional")?></label>
	<input type="checkbox" name="by_authors[]" value="professional" <?php if(in_array('professional', $this -> by_authors)):?>  checked="checked" <?php endif;?>/>
	<?php if($this -> viewer() -> getIdentity()):?>
		<label><?php echo $this -> translate("My networks")?></label>
		<input type="checkbox" name="by_authors[]" value="networks" <?php if(in_array('networks', $this -> by_authors)):?>  checked="checked" <?php endif;?>/>
	<?php endif;?>
	<label><?php echo $this -> translate("All")?></label>
	<input type="checkbox" name="by_authors[]" value="all" <?php if(in_array('all', $this -> by_authors) || !$this -> by_authors):?>  checked="checked" <?php endif;?>/>
	<input type="hidden" name="page" id="page" value="<?php echo $this -> page?>" />
	<button name="submit" id="submit" type="submit"><?php echo $this -> translate("Search")?></button>
  </form>
</div>
<script type="text/javascript">
 var pageAction =function(page){
    $('page').value = page;
    $('filter_form').submit();
  }
</script>
