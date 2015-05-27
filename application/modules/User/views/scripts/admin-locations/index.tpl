<?php 
$item = array('', 'Country', 'Province/State', 'City');
$child_item = array('Country', 'Province/State', 'City');
$child_items = array('countries', 'provinces/states', 'cities');
$level = 0;
if ($this->location) $level = intval($this->location->level) + 1;
?>
<h2><?php echo $this->translate("User") ?></h2>

<?php if( count($this->navigation) ): ?>
  <div class='tabs'>
    <?php
      echo $this->navigation()->menu()->setContainer($this->navigation)->render()
    ?>
  </div>
<?php endif; ?>

  <div class='clear'>
    <div class='settings'>
    <form class="global_form">
      <div>
        <h3> <?php echo $this->translate("Manage Locations") ?> </h3>
        
        <?php if ($this->location) :?>
        <div class="location-title"><?php echo $this->translate('%s: %s', $item[$level], $this->location)?></div>
        <br />
        <?php endif;?>
        
        <?php if ($level <= 2) :?>
     	<?php echo $this->htmlLink(array('route' => 'admin_default', 'module' => 'user', 'controller' => 'locations', 'action' => 'add', 'id' => $this->id), $this->translate('Add %s', $child_item[$level]), array(
      	'class' => 'smoothbox')) ?>
		<br /> <br />
          <?php if(count($this->locations)>0):?>
         <table class='admin_table'>
          <thead>
            <tr>
              <th><?php echo $this->translate($child_item[$level]) ?></th>
              <th><?php echo $this->translate('Num of %s', $child_items[$level + 1]) ?></th>
              <th><?php echo $this->translate("Actions") ?></th>
            </tr>

          </thead>
          <tbody>
            <?php foreach ($this->locations as $location): ?>
                    <tr>
                      <td>
                          <?php echo $location?>
                      </td>
                      <td>
                      <?php $childs = Engine_Api::_()->getItemTable('user_location')->getLocations($location->getIdentity());	?>
					  <?php echo count($childs)?>                      
                      </td>
                      <td>
                        <?php echo $this->htmlLink(array('route' => 'admin_default', 'module' => 'user', 'controller' => 'locations', 'action' => 'edit', 'id' =>$location->getIdentity()), $this->translate("edit"), array(
                          'class' => 'smoothbox',
                        )) ?>
                        |
                        <?php echo $this->htmlLink(array('route' => 'admin_default', 'module' => 'user', 'controller' => 'locations', 'action' => 'delete', 'id' =>$location->getIdentity()), $this->translate("delete"), array(
                          'class' => 'smoothbox',
                        )) ?>

                      </td>
                    </tr>                  
                   <?php endforeach; ?>
          </tbody>
        </table>
      <?php else:?>
      <br/>
      <div class="tip">
      <span><?php echo $this->translate("There are no %s.", $child_items[$level]) ?></span>
      </div>
      <?php endif;?>
        <br/>
       <?php endif;?> 
    </div>
    </form>
    </div>
  </div>
     