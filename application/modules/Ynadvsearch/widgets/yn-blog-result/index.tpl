<?php 
$count = 0;
foreach ($this->blogs as $item) {
	if ($item->authorization()->isAllowed(null,'view')) {
		$count++;
	}
}
?>
<div class='count_results'>
	<span class="search_icon fa fa-search"></span>
	<span class="num_results"><?php echo $this->translate(array('%s Result', '%s Results', $count), $count)?></span>
	<span class="total_results">(<?php echo $this->total_content?>)</span>
	<span class="label_results"><?php echo $this->htmlLink(array('route'=>'blog_general'), $this->label_content, array());?></span>
</div>

<script type="text/javascript">
	var pageAction =function(page){
		$('page').value = page;
		$('ynblog_filter_form').submit();
	}
</script>
<?php if( $this->paginator->getTotalItemCount() > 0 ): ?>
	<ul class='ynblogs_entrylist'>
		<?php foreach ($this->paginator as $item):
		if($item->authorization()->isAllowed(null,'view')):
			?>
		<li>
			<div class="wrap_col3">
				<div class="wrap_col_left">
					<div class="ynblog_entrylist_entry_date">
						<?php $creation_date = new Zend_Date(strtotime($item->creation_date)); 
						$creation_date->setTimezone($this->timezone);
						?>
						<div class="day">
							<?php echo $creation_date->get(Zend_Date::DAY)?>
						</div>
						<div class="month">
							<?php echo $creation_date->get(Zend_Date::MONTH_NAME_SHORT)?>
						</div>
						<div class="year">
							<?php echo $creation_date->get(Zend_Date::YEAR)?>
						</div>
					</div>
				</div>
				<div class="wrap_col_center">
					<div class="yn_title">
						<?php echo $this->htmlLink($item->getHref(), $item->getTitle()) ?>
					</div>
					<div class="post_by">
						<?php echo $this->translate('by');?>  <?php echo $this->htmlLink($item->getParent(), $item->getParent()->getTitle()) ?>
					</div>
					<div class="ynblog_entrylist_entry_body">
						<?php echo $this->string()->truncate($this->string()->stripTags($item->body), 200) ?>
					</div>
				</div>
			</div>
		</li>
	<?php endif; endforeach; ?>
</ul>

<?php elseif( $this->category || $this->tag ): ?>
	<div class="tip">
		<span>
			<?php echo $this->translate('There were no blogs found matching your search criteria.'); ?>
		</span>
	</div>

<?php else: ?>
	<div class="tip">
		<span>
			<?php echo $this->translate('There were no blogs found matching your search criteria.'); ?>
		</span>
	</div>
<?php endif; ?>

<?php echo $this->paginationControl($this->paginator, null, null, array(
	'pageAsQuery' => true,
	'query' => $this->formValues,
	)); ?>