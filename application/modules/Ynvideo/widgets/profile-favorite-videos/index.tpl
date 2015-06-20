<script type="text/javascript">    
    en4.core.runonce.add(function(){
        addEventForButtonAddTo();
        <?php if (!$this->renderOne): ?>
            var anchor = $('ynvideo_favorite_videos').getParent();
            $('ynvideo_fav_videos_previous').style.display = '<?php echo ( $this->paginator->getCurrentPageNumber() == 1 ? 'none' : '' ) ?>';
            $('ynvideo_fav_videos_next').style.display = '<?php echo ( $this->paginator->count() == $this->paginator->getCurrentPageNumber() ? 'none' : '' ) ?>';

            $('ynvideo_fav_videos_previous').removeEvents('click').addEvent('click', function(){
                en4.core.request.send(new Request.HTML({
                    url : en4.core.baseUrl + 'widget/index/content_id/' + <?php echo sprintf('%d', $this->identity) ?>,
                    data : {
                        format : 'html',
                        subject : en4.core.subject.guid,
                        page : <?php echo sprintf('%d', $this->paginator->getCurrentPageNumber() - 1) ?>
                    }
                }), {
                    'element' : anchor
                })
            });

            $('ynvideo_fav_videos_next').removeEvents('click').addEvent('click', function(){
                en4.core.request.send(new Request.HTML({
                    url : en4.core.baseUrl + 'widget/index/content_id/' + <?php echo sprintf('%d', $this->identity) ?>,
                    data : {
                        format : 'html',
                        subject : en4.core.subject.guid,
                        page : <?php echo sprintf('%d', $this->paginator->getCurrentPageNumber() + 1) ?>
                    }
                }), {
                    'element' : anchor
                })
            });
        <?php endif; ?>
    });
</script>

<ul id="ynvideo_favorite_videos">
    <?php foreach ($this->paginator as $item): ?>
        <li id="favorite_video_<?php echo $item -> getIdentity()?>">
            <?php
                echo $this->partial('_video_listing_favorite.tpl', 'ynvideo', array('video' => $item));
            ?>
        </li>
<?php endforeach; ?>
</ul>
<script type="text/javascript">
   var unfavorite_video = function(videoId)
   {
   	   var url = '<?php echo $this -> url(array('action' => 'remove-favorite'), 'video_favorite', true)?>';
       var request = new Request.JSON({
            'method' : 'post',
            'url' :  url,
            'data' : {
                'video_id' : videoId
            },
            'onComplete':function(responseObject)
            {  
            	$('favorite_video_' + videoId).destroy();
            }
        });
        request.send();  
   } 
</script>
<div>
    <div id="ynvideo_fav_videos_previous" class="paginator_previous">
        <?php
        echo $this->htmlLink('javascript:void(0);', $this->translate('Previous'), array(
            'onclick' => '',
            'class' => 'buttonlink icon_previous'
        ));
        ?>
    </div>
    <div id="ynvideo_fav_videos_next" class="paginator_next">
        <?php
        echo $this->htmlLink('javascript:void(0);', $this->translate('Next'), array(
            'onclick' => '',
            'class' => 'buttonlink_right icon_next'
        ));
        ?>
    </div>
</div>