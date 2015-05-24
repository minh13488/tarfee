<style>
	
	.sub-title{
		background-color: #eaeaea;
		  margin-bottom: 0;
		  border: 0;
		  border-bottom: 1px solid #eaeaea;
		  -moz-border-radius: 0;
		  -webkit-border-radius: 0;
		  border-radius: 0;
	}
	
</style>

<h2><?php echo $this -> library -> getTitle();?></h2>


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
<br/>
<?php if(count($this -> mainVideos)) :?>
<ul style="border-bottom: 5px solid #eaeaea;"  class="videos_browse">
 <?php foreach ($this->mainVideos as $item): ?>
        <?php
        echo $this->partial('_video_listing.tpl', 'user', array(
            'video' => $item,
            'library' => $this->library,
        ));
        ?>
<?php endforeach; ?>
</ul>
<?php endif;?>

<br/>

<!-- get sub libraries -->
<?php $subLibraries = $this -> library -> getSubLibrary(); ?>
<div id="accordion">
<?php foreach($subLibraries as $subLibrary) :?>
	<?php if($subLibrary -> isViewable()) :?>
		<div class="sub-title">
			<h3 class="toggler atStart"><?php echo $subLibrary -> getTitle();?></h3>
		</div>
		<div class="element atStart">
			
			<?php if($this -> viewer() -> isSelf($this -> subject())) :?>
			
			<!-- delete link for sub library -->
			<?php echo $this->htmlLink(array(
				'route' => 'user_library',
				'action' => 'delete',
				'id' => $subLibrary -> getIdentity(),
				), '<i class="fa fa-plus-square"></i>'.$this->translate('Delete'), array(
				'class' => 'smoothbox buttonlink'
				)) ;
			?>	
				
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
			<br/>
			<?php if(count($subVideos)):?>
			<ul style="border: 5px solid #eaeaea;" class="videos_browse">
			 <?php foreach ($subVideos as $item): ?>
		            <?php
		            echo $this->partial('_video_listing.tpl', 'user', array(
		                'video' => $item,
		                'library' => $subLibrary,
		            ));
		            ?>
			<?php endforeach; ?>
			</ul>
			<?php endif;?>
		</div>
		<br/>
	<?php endif;?>
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
