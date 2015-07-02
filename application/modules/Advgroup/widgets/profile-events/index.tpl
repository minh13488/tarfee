<script type="text/javascript">
  en4.core.runonce.add(function(){

    <?php if( !$this->renderOne ): ?>
    var anchor = $('profile_groups_events').getParent();
    $('profile_groups_events_previous').style.display = '<?php echo ( $this->paginator->getCurrentPageNumber() == 1 ? 'none' : '' ) ?>';
    $('profile_groups_events_next').style.display = '<?php echo ( $this->paginator->count() == $this->paginator->getCurrentPageNumber() ? 'none' : '' ) ?>';

    $('profile_groups_events_previous').removeEvents('click').addEvent('click', function(){
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

    $('profile_groups_events_next').removeEvents('click').addEvent('click', function(){
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

<div class="group_album_options">
  <?php if( $this->canAdd ): ?>
    <?php echo $this->htmlLink(array(
        'route' => 'event_general',
        'controller' => 'event',
        'action' => 'create',
        'parent_type'=> 'group',
        'subject_id' => $this->subject()->getIdentity(),
      ), $this->translate('Add Events'), array(
        'class' => 'tf_button_action'
    )) ?>
  <?php endif; ?>
</div>
<?php if( $this->paginator->getTotalItemCount() > 0 ): ?>

  <ul id="profile_groups_events">
    <?php foreach( $this->paginator as $event ): ?>
      <li>
        <div class="ynevents_photo">
            <?php echo $this->htmlLink($event, $this->itemPhoto($event, 'thumb.normal')) ?>
        </div>

        <div class="ynevents_info">
            <div class="ynevents_title">
                <?php echo $this->htmlLink($event->getHref(), $event->getTitle()) ?>
            </div>
            <div class="ynevents_desc">
                <?php echo $event->getDescription() ?>
            </div>

        </div>

        <div class="ynevents_members">
            <?php echo '<i class="fa fa-user"></i> &nbsp;&nbsp;'.$this->translate(array('%s guest', '%s guests', $event->member_count),$this->locale()->toNumber($event->member_count)) ?>
        </div>

        <div class="ynevents_time_place_rating">
            <div class="ynevents_time_place">
                <span>
                    <?php echo $this->locale()->toDate($event->starttime, array('size' => 'long')) ?>
                </span>
                <span>
                    <?php echo $event->address;?>
                </span>
            </div>

            <div class="ynevents_rating">
                
            </div>
        </div>

        <?php 
        if($this -> viewer() -> getIdentity()):
            ?>
            <div class="ynevents_button" id = "ynevent_rsvp_<?php echo $event -> getIdentity()?>">
               <?php echo $this -> action('list-rsvp', 'widget', 'ynevent', array( 'id' => $event -> getIdentity()));?>
            </div>
        <?php endif;?>
        <?php if($this -> viewer() -> getIdentity() && Engine_Api::_()->user()->canTransfer($event)) :?>
		<div class="group_button_action btn-exchange">
			<?php
				echo $this->htmlLink(array(
		            'route' => 'user_general',
		            'action' => 'transfer-item',
					'subject' => $event -> getGuid(),
		        ), '<i class="fa fa-exchange fa-lg"></i>', array(
		            'class' => 'smoothbox', 'title' => $this -> translate('Transfer to user profile')
		        ));
			?>
		</div>
		<?php endif;?>
      </li>
    <?php endforeach;?>
  </ul>
    <div >
      <div id="profile_groups_events_previous" class="paginator_previous">
        <?php echo $this->htmlLink('javascript:void(0);', $this->translate('Previous'), array(
          'onclick' => '',
          'class' => 'buttonlink icon_previous'
        )); ?>
      </div>
      <div id="profile_groups_events_next" class="paginator_next">
        <?php echo $this->htmlLink('javascript:void(0);', $this->translate('Next'), array(
          'onclick' => '',
          'class' => 'buttonlink_right icon_next'
        )); ?>
      </div>
    </div>
<?php else: ?>

  <div class="tip">
    <span>
      <?php echo $this->translate('No events have been added to this club yet.');?>
    </span>
  </div>
<?php endif; ?>
<?php if($this -> viewer() -> getIdentity()):?>
<script type="text/javascript">
 var tempChange = 0;
   var changeRsvp = function(id, option)
   {
        if (tempChange == 0) 
        {
            tempChange = 1;
            if ($('rsvp_option_' + id + '_' + option)) {
                $('rsvp_option_' + id + '_' + option).innerHTML = '<img width="16" src="application/modules/Yncomment/externals/images/loading.gif" alt="Loading" />';
            }
            var url = en4.core.baseUrl + 'ynevent/widget/rsvp';
            en4.core.request.send(new Request.JSON({
                url : url,
                data : {
                    format : 'json',
                    id : id,
                    option_id: option
                },
                onComplete : function(e) {
                    tempChange = 0;
                }
            }), {
                'element' : $('ynevent_rsvp_' + id)
            });
        }
   }
</script>
<?php endif;?>