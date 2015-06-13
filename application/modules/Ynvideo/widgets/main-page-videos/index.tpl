<ul class = "video-items" id="main-page-videos">
<?php $count = 1;?>
<?php foreach( $this->results as $row): ?>
	<?php if ($count > $this->limit) break;?>
	<li class="video-item">
		<?php
        		echo $this->partial('_video_listing_mainpage.tpl', 'ynvideo', array(
        			'video'     => $row
        		));
            ?>
	</li>
	<?php $count++;?>
<?php endforeach;?>
</ul>
<?php if (count($this->results) > $this->limit && !$this->reachLimit):?>
<a id="video-viewmore-btn" href="javascript:void(0)" onclick="showMore(<?php echo ($this->limit + $this->from)?>)"><?php echo $this->translate('View more result') ?></a>
<div id="video-loading" style="display: none;">
	<img src='<?php echo $this->layout()->staticBaseUrl ?>application/modules/Core/externals/images/loading.gif' style='float:left;margin-right: 5px;' />
</div>
<script type="text/javascript">
function showMore(from){
    var url = '<?php echo $this->url(array('module' => 'core','controller' => 'widget','action' => 'index','name' => 'ynvideo.main-page-videos'), 'default', true) ?>';
    $('video-viewmore-btn').destroy();
    $('video-loading').style.display = '';
    var params = {};
    params.format = 'html';
    params.from = from;
    var request = new Request.HTML({
      	url : url,
      	data : params,
      	onSuccess : function(responseTree, responseElements, responseHTML, responseJavaScript) {
        	$('video-loading').destroy();
            var result = Elements.from(responseHTML);
            var results = result.getElement('#main-page-videos').getChildren();
            $('main-page-videos').adopt(results);
            var viewMore = result.getElement('#video-viewmore-btn');
            if (viewMore[0]) viewMore.inject($('main-page-videos'), 'after');
            var loading = result.getElement('#video-loading');
            if (loading[0]) loading.inject($('main-page-videos'), 'after');
            eval(responseJavaScript);
        }
    });
   request.send();
  }

</script>
<?php endif;?>	
