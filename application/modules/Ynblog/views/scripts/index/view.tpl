<script type="text/javascript">
var categoryAction = function(category){
    $('category').value = category;
    $('ynblog_filter_form').submit();
  }
var tagAction =function(tag){
    $('tag').value = tag;
    $('ynblog_filter_form').submit();
  }
</script>
<style>
pre {
white-space: normal;
}
</style>
<h2 style="padding: 0 10px;margin:0;">
  <?php echo $this->blog->getTitle() ?>
</h2>
<ul class='ynblogs_entrylist'>
  <li>

      

      <?php $category = Engine_Api::_ ()->getItemTable ( 'blog_category' )->find ( $this->blog->category_id )->current (); ?>
      <?php if($category): ?>

        <div class="ynblog_category">
          <a href='<?php echo $this->url(array('user_id'=>$this->blog->owner_id,'category'=>$this->category->category_id,'sort'=>'recent'),'blog_view',true);?>'><?php echo $this->translate($this->category->category_name) ?></a>
        </div>
        <?php endif; ?>

      <div class="ynblog_entrylist_entry_body rich_content_body">
        <?php echo $this->blog->body ?>
      </div>
      
      <div style="padding-left:10px;margin-top: 5px;">
        <?php if (count($this->blogTags )):?>
          <?php foreach ($this->blogTags as $tag): ?>
            <a href='javascript:void(0);' onclick='javascript:tagAction(<?php echo $tag->getTag()->tag_id; ?>);'>#<?php echo $tag->getTag()->text?></a>&nbsp;
          <?php endforeach; ?>
        <?php endif; ?>
      </div>

      <div class="ynblog_entrylist_entry_date">
          <?php echo $this->translate('Posted by');?> <?php echo $this->htmlLink($this->owner->getHref(), $this->owner->getTitle()) ?>

          <span>&nbsp;-&nbsp;<?php echo $this->timestamp($this->blog->creation_date) ?></span>
      </div>

      <div class="ynblog_statistics">
        <?php $likeCount = $this->blog ->likes()->getLikeCount(); ?>
        <span><?php echo $this->translate(array('%s like','%s likes', $likeCount), $likeCount)?></span>

        <?php $disLikeCount = Engine_Api::_()->getDbtable('dislikes', 'yncomment') -> getDislikeCount($this->blog); ?>
        <span><?php echo $this->translate(array('%s dislike','%s dislikes', $disLikeCount), $disLikeCount)?></span>

        <span><?php echo $this->translate(array('%s comment','%s comments', $this->blog -> comment_count), $this->blog -> comment_count)?></span>
          <span>
            <?php echo $this->translate(array('%s view', '%s views', $this->blog->view_count), $this->locale()->toNumber($this->blog->view_count)) ?>
          </span>
      </div>


  </li>
</ul>
<br/>
<!-- Google Translation -->
<div id="google_translate_element"></div>
<script type="text/javascript">
	function googleTranslateElementInit() {
	  new google.translate.TranslateElement({pageLanguage: 'en', layout: google.translate.TranslateElement.InlineLayout.SIMPLE, multilanguagePage: true}, 'google_translate_element');
	}
</script>
<script type="text/javascript" src="//translate.google.com/translate_a/element.js?cb=googleTranslateElementInit"></script>
<br/>
 <!-- Add-This Button BEGIN -->
<div class="addthis_toolbox addthis_default_style">
   <a class="addthis_button_google_plusone addthis_32x32_style"></a>
   <a class="addthis_button_facebook_like" fb:like:layout="button_count"></a>
   <a class="addthis_counter addthis_pill_style"></a>
</div>
<?php $protocol = (!empty($_SERVER['HTTPS']) && $_SERVER['HTTPS'] !== 'off' || $_SERVER['SERVER_PORT'] == 443) ? "https://" : "http://";?>
 <script type="text/javascript">var addthis_config = {"data_track_clickback":true};</script>
 <script type="text/javascript" src="<?php echo $protocol?>s7.addthis.com/js/250/addthis_widget.js#pubid=<?php echo Engine_Api::_()->getApi('settings', 'core')->getSetting('ynblog.pubid');?>"></script>
 <!-- Add-This Button END -->
 <br>
<div class="ynblogs_browse_options">
<span class="blog_favorite" id = "favourite_id">
	<?php if(!$this -> blog -> checkFavourite()):?>
		<a href="javascript:;" onclick="favourite_blog()"><i class="fa fa-heart-o"></i> <?php echo $this -> translate("Favourite") ?></a>
	<?php else:?>
		<a href="javascript:;" onclick="unfavourite_blog()"><i class="fa fa-heart"></i> <?php echo $this->translate('Unfavourite')?></a>
	<?php endif;?>
</span>

<!-- favourite-->
<?php $url = $this->url(array('module'=> 'core', 'controller' => 'report', 'action' => 'create', 'subject' => $this->blog->getGuid()),'default', true);?>
<a href="javascript:;" onclick="openPopup('<?php echo $url?>')"><i class="fa fa-flag"></i> <?php echo $this->translate("Report")?></a>
</div>

<script type="text/javascript">
	function openPopup(url)
    {
    	if(window.innerWidth <= 480)
      {
      	Smoothbox.open(url, {autoResize : true, width: 300});
      }
      else
      {
      	Smoothbox.open(url);
      }
    }
	function favourite_blog()
   {
   	   var url = '<?php echo $this -> url(array('action' => 'favorite-ajax'), 'blog_general', true)?>';
       var request = new Request.JSON({
            'method' : 'post',
            'url' :  url,
            'data' : {
                'blog_id' : <?php echo $this->blog->getIdentity()?>
            },
            'onComplete':function(responseObject)
            {  
                obj = document.getElementById('favourite_id');
                obj.innerHTML = '<a href="javascript:;" onclick="unfavourite_blog()">' + '<i class="fa fa-heart"></i> <?php echo $this->translate("Unfavourite")?>' + '</a>';
            }
        });
        request.send();  
   } 
   function unfavourite_blog()
   {
   	   var url = '<?php echo $this -> url(array('action' => 'un-favorite-ajax'), 'blog_general', true)?>';
       var request = new Request.JSON({
            'method' : 'post',
            'url' :  url,
            'data' : {
                'blog_id' : <?php echo $this->blog->getIdentity()?>
            },
            'onComplete':function(responseObject)
            {  
                obj = document.getElementById('favourite_id');
                obj.innerHTML = '<a href="javascript:;" onclick="favourite_blog()">' + '<i class="fa fa-heart-o"></i> <?php echo $this->translate("Favourite")?>' + '</a>';
            }
        });
        request.send();  
   } 
</script>