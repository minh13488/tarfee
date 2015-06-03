<ul class="blogs_browse">
  <?php foreach ($this->paginator as $item): ?>
    <li>
      <div class='blogs_browse_info'>
        <p class='blogs_browse_info_title'>
          <?php echo $this->htmlLink($item->getHref(), $item->getTitle()) ?>
        </p>
        <p class='blogs_browse_info_date'>
          <?php echo $this->translate('Posted');?> <?php echo $this->timestamp($item->creation_date) ?>
        </p>
        <p class='blogs_browse_info_blurb'>
          <?php echo $item->getDescription(); ?>
        </p>
      </div>
    </li>
  <?php endforeach; ?>
</ul>

<?php if($this->paginator->getTotalItemCount() > $this->items_per_page):?>
  <?php echo $this->htmlLink($this->url(array('user_id' => Engine_Api::_()->core()->getSubject()->getIdentity()), 'blog_view'), $this->translate('View All Entries'), array('class' => 'buttonlink icon_blog_viewall')) ?>
<?php endif;?>