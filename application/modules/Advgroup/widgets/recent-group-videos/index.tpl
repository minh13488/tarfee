<?php
	$this->headScript()-> appendScript('jQuery.noConflict();'); 
?>
<script type="text/javascript">
    en4.core.runonce.add(function(){
        addEventForButtonAddTo();
        <?php if (!$this->renderOne): ?>
            var anchor = $('ynvideo_recent_videos').getParent();
            $('ynvideo_videos_previous').style.display = '<?php echo ( $this->paginator->getCurrentPageNumber() == 1 ? 'none' : '' ) ?>';
            $('ynvideo_videos_next').style.display = '<?php echo ( $this->paginator->count() == $this->paginator->getCurrentPageNumber() ? 'none' : '' ) ?>';

            $('ynvideo_videos_previous').removeEvents('click').addEvent('click', function(){
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

            $('ynvideo_videos_next').removeEvents('click').addEvent('click', function(){
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

<?php
	 $ynvideo_enable = Engine_Api::_() -> advgroup() ->checkYouNetPlugin('ynvideo');
 ?>
<?php if($this->subject()->isOwner($this->viewer())) :?>
	<?php 
		if($ynvideo_enable)
		{
			echo $this->htmlLink(array(
				'route' => 'video_general',
				'action' => 'create',
				'parent_type' =>'group',
				'subject_id' =>  $this->group->group_id,
			), $this->translate('Add Video'), array(
			'class' => 'tf_button_action'
			)) ;
		}
		else
		{
			echo $this->htmlLink(array(
				'route' => 'video_general',
				'action' => 'create',
				'parent_type' =>'group',
				'subject_id' =>  $this->group->getGuid(),
			), $this->translate('Add Video'), array(
			'class' => 'tf_button_action'
			)) ;
		}
	?>
<?php endif; ?>

<?php
if($this->paginator -> getTotalItemCount()):?>
    <ul class="videos_browse" id="ynvideo_recent_videos">
        <?php foreach ($this->paginator as $item): ?>
        <?php
             $table = Engine_Api::_() -> getDbTable('highlights', 'advgroup');
             $select = $table -> select() -> where("group_id = ?", $this->group->group_id) -> where('item_id = ?', $item->getIdentity()) -> where("type = 'video'") -> limit(1);		
			 $row = $table -> fetchRow($select);
		?>
            <li <?php echo isset($this->marginLeft)?'style="margin-left:' . $this->marginLeft . 'px"':''?>>
                <?php
	        		echo $this->partial('_players_of_week.tpl', 'ynvideo', array(
	        			'video' => $item
	        		));
	            ?>
               
               <?php if($this -> viewer() -> getIdentity() && Engine_Api::_()->user()->canTransfer($item)) :?>
				<div class="tf_btn_action">
					<?php
						echo $this->htmlLink(array(
				            'route' => 'user_general',
				            'action' => 'transfer-item',
							'subject' => $item -> getGuid(),
				        ), '<i class="fa fa-exchange fa-lg"></i>', array(
				            'class' => 'smoothbox btn-exchange', 'title' => $this -> translate('Transfer to user profile')
				        ));
					?>
				</div>
				<?php endif;?>
				<div class="tf_btn_action">
				<?php
					echo $this->htmlLink(array(
						'route' => 'default',
						'module' => 'video',
						'controller' => 'index',
						'action' => 'edit',
						'video_id' => $item->video_id,
						'parent_type' =>'group',
						'subject_id' =>  $this->group->getIdentity(),
				    ), '<i class="fa fa-pencil-square-o fa-lg"></i>', array('class' => 'tf_button_action'));
				?>
			    </div>
			    <div class="tf_btn_action">
				<?php
					echo $this->htmlLink(array(
				 	        'route' => 'default', 
				         	'module' => 'video', 
				         	'controller' => 'index', 
				         	'action' => 'delete', 
				         	'video_id' => $item->video_id, 
				         	'subject_id' =>  $this->group->getIdentity(),
				        	'parent_type' => 'group',
				         	'format' => 'smoothbox'), 
				         	'<i class="fa fa-trash-o fa-lg"></i>', array('class' => 'tf_button_action smoothbox'
				     ));
				?>
				</div>
            </li>
            
        <?php endforeach; ?>
    </ul>
<?php else:?>
  <div class="tip">
    <span>
      <?php echo $this->translate('No videos have been added in this group yet.');?>
    </span>
  </div>
<?php endif;?>