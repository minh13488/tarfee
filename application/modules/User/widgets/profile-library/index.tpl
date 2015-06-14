<h2><?php echo $this -> library -> getTitle();?></h2>
<?php if($this -> viewer() -> isSelf($this -> subject())) :?>
<div class="user-library-item-action">
    <span><?php echo $this -> translate('Options');?></span>
    <ul>
    	<li class="user-library-close-box"><i class="fa fa-times"></i></li>
		<li>
			<?php echo $this->htmlLink(array(
					'route' => 'user_library',
					'action' => 'edit',
					'id' => $this -> library -> getIdentity(),
					), '<i class="fa fa-plus-square"></i>'.$this->translate('Edit'), array(
					'class' => 'smoothbox buttonlink'
					)) ;
			?>
		</li>
		<li>
			<?php echo $this->htmlLink(array(
					'route' => 'video_general',
					'action' => 'create',
					'parent_type' =>'user_library',
					'subject_id' =>  $this->library->getIdentity(),
					'tab' => $this->identity,
				), '<i class="fa fa-plus-square"></i>'.$this->translate('Add Video'), array(
				'class' => 'buttonlink'
				)) ;
			?>
		</li>
		<li>
			<?php echo $this->htmlLink(array(
					'route' => 'user_library',
					'action' => 'create-sub-library',
				), '<i class="fa fa-plus-square"></i>'.$this->translate('Create Sub Library'), array(
				'class' => 'smoothbox buttonlink'
				)) ;
			?>
		</li>
		
	</ul>
</div>
<?php endif;?>

<br/>
<?php if(count($this -> mainVideos)) :?>
	<ul style="border-bottom: 5px solid #eaeaea;"  class="videos_browse">
 	<?php foreach ($this->mainVideos as $item): ?>
        <?php
        echo $this->partial('_video_listing.tpl', 'user', array(
            'video' => $item,
            'library' => $this->library,
            'main' => true,
            'tab_id' => $this->identity,
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
			<h3 style="font-size: large;" class="toggler atStart"> <?php echo $subLibrary -> getTitle();?></h3>
			
			<?php echo $this -> itemPhoto($subLibrary);?>

			<?php if($this -> viewer() -> isSelf($this -> subject())) :?>
			<div class="user-library-item-action">
			    <span> <?php echo $this -> translate('Options');?></span>
			    <ul>
				<li class="user-library-close-box"><i class="fa fa-times"></i></li>
				<li>
				<!-- delete link for sub library -->
				<?php echo $this->htmlLink(array(
					'route' => 'user_library',
					'action' => 'delete',
					'id' => $subLibrary -> getIdentity(),
					), '<i class="fa fa-plus-square"></i>'.$this->translate('Delete'), array(
					'class' => 'smoothbox buttonlink'
					)) ;
				?>
				</li>	
				<li>	
				<!-- edit link for sub library -->
				<?php echo $this->htmlLink(array(
					'route' => 'user_library',
					'action' => 'edit',
					'id' => $subLibrary -> getIdentity(),
					), '<i class="fa fa-plus-square"></i>'.$this->translate('Edit'), array(
					'class' => 'smoothbox buttonlink'
					)) ;
				?>
				</li>
				<li>
					<!-- create video link for sub library -->
						<?php echo $this->htmlLink(array(
								'route' => 'video_general',
								'action' => 'create',
								'parent_type' =>'user_library',
								'subject_id' =>  $subLibrary->getIdentity(),
								'tab' => $this->identity,
							), '<i class="fa fa-plus-square"></i>'.$this->translate('Add Video'), array(
							'class' => 'buttonlink'
							)) ;
						?>
					</li>	
				</ul>
			</div>
			<?php endif;?>
		</div>
		<div class="element atStart">
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
			                'tab_id' => $this->identity,
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

<script type="text/javascript">
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
		 
		
		$$('.user-library-item-action').addEvent('outerClick', function(){
	    	if ( this.hasClass('open-submenu') ) {
	    		this.removeClass('open-submenu');	
	    	}
	    });
	
		$$('.user-library-item-action').addEvent('click', function(){
			if ( this.hasClass('open-submenu') ) {
	    		this.removeClass('open-submenu');	
	    	} else {
	    		$$('.open-submenu').removeClass('open-submenu');
	    		this.addClass('open-submenu');
	    	}  
			
			if($('global_footer').getStyle('margin-top') != "0px") {
				$('global_footer').setStyle('margin-top', '');
			} else {
				$('global_footer').setStyle('margin-top', '60px');	
			}
		});
		 
		 $$('.user-library-close-box').addEvent('click', function(){
		 	var parent = this.getParent().getParent().getParent();
			parent.removeClass('open-submenu');				
		});
		
				
  	});	
</script>
