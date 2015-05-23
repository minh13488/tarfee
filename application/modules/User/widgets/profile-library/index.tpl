<?php echo $this -> library -> getTitle();?>

<?php if($this -> viewer() -> isSelf($this -> subject())) :?>

<?php echo $this->htmlLink(array(
		'route' => 'user_library',
		'action' => 'edit',
		'id' => $this -> library -> getIdentity(),
		), '<i class="fa fa-plus-square"></i>'.$this->translate('Edit'), array(
		'class' => 'smoothbox buttonlink'
		)) ;
	?>

<?php echo $this->htmlLink(array(
		'route' => 'video_general',
		'action' => 'create',
		'parent_type' =>'user_library',
		'subject_id' =>  $this->library->getIdentity(),
	), '<i class="fa fa-plus-square"></i>'.$this->translate('Create New Video'), array(
	'class' => 'buttonlink'
	)) ;
?>

<?php echo $this->htmlLink(array(
		'route' => 'user_library',
		'action' => 'create-sub-library',
	), '<i class="fa fa-plus-square"></i>'.$this->translate('Create Sub Library'), array(
	'class' => 'smoothbox buttonlink'
	)) ;
?>

<?php endif;?>
<br/><br/>
 <?php foreach ($this->mainVideos as $item): ?>
        <li>
            <?php
            echo $this->partial('_video_listing.tpl', 'user', array(
                'video' => $item,
                'library' => $this->library,
                'recentCol' => $this->recentCol
            ));
            ?>
        </li>
<?php endforeach; ?>

<br/><br/>

<!-- get sub libraries -->
<?php $subLibraries = $this -> library -> getSubLibrary(); ?>
<div id="accordion">
<?php foreach($subLibraries as $subLibrary) :?>
	<h3 class="toggler atStart"><?php echo $subLibrary -> getTitle();?></h3>
	<div class="element atStart">
		
		<?php if($this -> viewer() -> isSelf($this -> subject())) :?>
		<!-- edit link for sub library -->
		<?php echo $this->htmlLink(array(
			'route' => 'user_library',
			'action' => 'edit',
			'id' => $subLibrary -> getIdentity(),
			), '<i class="fa fa-plus-square"></i>'.$this->translate('Edit'), array(
			'class' => 'smoothbox buttonlink'
			)) ;
		?>
		
		<!-- create video link for sub library -->
		
			<?php echo $this->htmlLink(array(
					'route' => 'video_general',
					'action' => 'create',
					'parent_type' =>'user_library',
					'subject_id' =>  $subLibrary->getIdentity(),
				), '<i class="fa fa-plus-square"></i>'.$this->translate('Create New Video'), array(
				'class' => 'buttonlink'
				)) ;
			?>
		<?php endif;?>
		
		<!-- get videos of sub libraries -->
		<?php
		    $mappingTable = Engine_Api::_()->getDbTable('mappings', 'user');
		    $videoTable = Engine_Api::_()->getItemTable('video');
		    $params = array();
		    $params['owner_type'] = $subLibrary -> getType();
			$params['owner_id'] = $subLibrary -> getIdentity();
		    $subVideos = $videoTable -> fetchAll($mappingTable -> getVideosSelect($params));
		?>
		<br/><br/>
		 <?php foreach ($subVideos as $item): ?>
	        <li>
	            <?php
	            echo $this->partial('_video_listing.tpl', 'user', array(
	                'video' => $item,
	                'library' => $subLibrary,
	                'recentCol' => $this->recentCol
	            ));
	            ?>
	        </li>
		<?php endforeach; ?>
	</div>
	<br/><br/>
<?php endforeach; ?>
</div>

<script>
	window.addEvent('domready', function(){
		
		
		var accordion = new Accordion('h3.atStart', 'div.atStart', {
			opacity: false,
			onActive: function(toggler, element){
				toggler.setStyle('color', '#ff3300');
			},
		 
			onBackground: function(toggler, element){
				toggler.setStyle('color', '#222');
			}
		}, $('accordion'));
		 
		 
				
  	});	
</script>
