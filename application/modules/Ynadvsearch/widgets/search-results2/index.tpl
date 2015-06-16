<style>
	.highlighted-text {
		font-weight: bold;
	}
</style>
<?php if(count($this->results) <= 0): ?>
<div class="tip">
	<span>
  		<?php echo $this->translate('No results were found.') ?>
	</span>
</div>
<?php else: ?>
<ul class = "ynadvsearch_searchresult" id="ynadvsearch_searchresults">
<?php $count = 1;?>
<?php foreach( $this->results as $row): ?>
	<?php if ($count > $this->limit) break;?>
	<?php $item = (!empty($row->type) && !empty($row->id)) ? $this->item($row->type, $row->id): $row;?>
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
	<?php $count++;?>
<?php endforeach;?>
</ul>
<?php if (count($this->results) > $this->limit && !$this->reachLimit):?>
<a id="ynadvsearch-viewmore-btn" href="javascript:void(0)" onclick="showMore(<?php echo ($this->limit + $this->from)?>)"><?php echo $this->translate('View more result') ?></a>
<div id="ynadvsearch-loading" style="display: none;">
	<img src='<?php echo $this->layout()->staticBaseUrl ?>application/modules/Core/externals/images/loading.gif' style='float:left;margin-right: 5px;' />
</div>
<script type="text/javascript">
function showMore(from){
    var url = '<?php echo $this->url(array('module' => 'core','controller' => 'widget','action' => 'index','name' => 'ynadvsearch.search-results2'), 'default', true) ?>';
    $('ynadvsearch-viewmore-btn').destroy();
    $('ynadvsearch-loading').style.display = '';
    var params = <?php echo json_encode($this->params)?>;
    params.format = 'html';
    params.from = from;
    var request = new Request.HTML({
      	url : url,
      	data : params,
      	onSuccess : function(responseTree, responseElements, responseHTML, responseJavaScript) {
        	$('ynadvsearch-loading').destroy();
            var result = Elements.from(responseHTML);
            var results = result.getElement('#ynadvsearch_searchresults').getChildren();
            $('ynadvsearch_searchresults').adopt(results);
            var viewMore = result.getElement('#ynadvsearch-viewmore-btn');
            if (viewMore[0]) viewMore.inject($('ynadvsearch_searchresults'), 'after');
            var loading = result.getElement('#ynadvsearch-loading');
            if (loading[0]) loading.inject($('ynadvsearch_searchresults'), 'after');
            eval(responseJavaScript);
        }
    });
   request.send();
  }

</script>
<?php endif;?>	
<?php endif; ?>
