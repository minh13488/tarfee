<div class="group_album_options">
<?php if($this->subject()->isOwner($this->viewer())) :?>
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
		<div class="tf_btn_action">
			<?php
				echo $this->htmlLink(array(
		            'route' => 'user_general',
		            'action' => 'transfer-item',
					'subject' => $event -> getGuid(),
		        ), '<i class="fa fa-exchange fa-lg"></i>', array(
		            'class' => 'smoothbox tf_button_action', 'title' => $this -> translate('Transfer to user profile')
		        ));
			?>
		</div>
		<?php endif;?>
		<?php if($event -> isOwner($this->viewer())) :?>
			<div class="tf_btn_action">
			<?php
				echo $this->htmlLink(array(
					'route' => 'event_specific',
					'action' => 'edit',
					'event_id' => $event->event_id,
					'parent_type' =>'group',
					'subject_id' =>  $this->subject()->getIdentity(),
			    ), '<i class="fa fa-pencil-square-o fa-lg"></i>', array('class' => 'tf_button_action'));
			?>
		    </div>
		    <div class="tf_btn_action">
			<?php
				echo $this->htmlLink(array(
			 	        'route' => 'event_specific', 
			         	'action' => 'delete', 
			         	'event_id' => $event->event_id, 
			         	'format' => 'smoothbox'), 
			         	'<i class="fa fa-trash-o fa-lg"></i>', array('class' => 'tf_button_action smoothbox'
			     ));
			?>
			</div>
			<?php endif;?>
      </li>
    <?php endforeach;?>
  </ul>
  	<?php if($this->paginator->getTotalItemCount() > $this->itemCountPerPage):?>
	  <?php echo $this->htmlLink($this -> url(array(), 'default', true).'search?type%5B%5D=event&parent_type=group&parent_id='.$this->subject()->getIdentity(), $this -> translate('View all'), array('class' => 'icon_event_viewall')) ?>
	<?php endif;?>
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