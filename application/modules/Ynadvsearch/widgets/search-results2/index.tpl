<style>
	.highlighted-text {
		font-weight: bold;
	}
</style>
<div id="ynadvsearch_loading" class="ynadvsearch_loading" style="display: none">
    <img src='application/modules/Ynadvsearch/externals/images/loading.gif'/>
</div>
<?php if(count($this->results) <= 0): ?>
<div class="tip">
	<span>
  		<?php echo $this->translate('No results were found.') ?>
	</span>
</div>
<?php else: ?>
<ul class = "ynadvsearch_searchresult" id="ynadvsearch_searchresults">
<?php foreach( $this->results as $row): ?>
	<?php $item = $this->item($row->type, $row->id);?>
	<?php if ($item) :?>
	<li class="result-search-item <?php echo $item->getType()?>-item">
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
	</li>
	<?php endif; ?>
<?php endforeach;?>	
</ul>
<?php endif; ?>
