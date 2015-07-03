<ul id="profile_events_<?php echo $this->identity?>" class="ynevents_profile_tab">
    <?php foreach( $this->paginator as $event ): ?>
    <li>
        <div class="ynevents_info">
            <div class="ynevents_title">
                <?php echo $this->htmlLink($event->getHref(), $event->getTitle()) ?>
            </div>
        </div>
        <div class="ynevents_time_place_rating">
            <div class="ynevents_time_place">
                <span>
                    <?php echo $this->locale()->toDate($event->starttime, array('size' => 'long')) ?>
                </span>
            </div>
        </div>
        <?php 
        if($this -> viewer() -> getIdentity()):
            ?>
            <div class="ynevents_button" id = "ynevent_rsvp_<?php echo $event -> getIdentity()?>">
               <?php echo $this -> action('list-rsvp', 'widget', 'ynevent', array( 'id' => $event -> getIdentity()));?>
            </div>
        <?php endif;?>
    </li>
    <?php endforeach; ?>
</ul>
<?php if($this->paginator->getTotalItemCount() > $this->items_per_page):?>
  <?php echo $this->htmlLink($this->url(array('action' => 'manage'), 'event_general'), $title, array('class' => 'icon_event_viewall')) ?>
<?php endif;?>

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