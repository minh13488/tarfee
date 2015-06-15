<!--h2><?php  //echo $this -> library -> getTitle();?></h2-->

<?php if($this -> viewer() -> isSelf($this -> subject())) :?>
<div class="user-library-item-action">
    <span class="ul-item-action-title"><?php echo '<i class="fa fa-plus-square fa-lg"></i>&nbsp;&nbsp;'.$this -> translate('add more');?></span>

    <ul>
		<li>
			<?php echo $this->htmlLink(array(
					'route' => 'user_library',
					'action' => 'edit',
					'id' => $this -> library -> getIdentity(),
					), '<i class="fa fa-pencil-square fa-lg"></i>&nbsp;&nbsp;'.$this->translate('Edit'), array(
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
				), '<i class="fa fa-video-camera fa-lg"></i>&nbsp;&nbsp;'.$this->translate('Add Video'), array(
				'class' => 'buttonlink'
				)) ;
			?>
		</li>
		<li>
			<?php echo $this->htmlLink(array(
					'route' => 'user_library',
					'action' => 'create-sub-library',
				), '<i class="fa fa-folder-open fa-lg"></i>&nbsp;&nbsp;'.$this->translate('Create Sub Library'), array(
				'class' => 'smoothbox buttonlink'
				)) ;
			?>
		</li>
	</ul>

</div>
<?php endif;?>


<?php if(count($this -> mainVideos)) :?>
	<ul class="videos_browse tf_library_videos">
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

<!-- get sub libraries -->
<?php $subLibraries = $this -> library -> getSubLibrary(); ?>
<ul class="tf_list_sublibrary">
<?php foreach($subLibraries as $subLibrary) :?>
	<?php if($subLibrary -> isViewable()) :?>
	<li>
		<div class="item_sublibrary">
			<div class="item_background" style="background: url(<?php echo $subLibrary -> getPhotoUrl();?>)">
			<div class="avatar-box-hover">
			    <ul class="actions">
					<li>
						<!-- delete link for sub library -->
						<?php echo $this->htmlLink(array(
							'route' => 'user_library',
							'action' => 'delete',
							'id' => $subLibrary -> getIdentity(),
							), '<i class="fa fa-times"></i>', array(
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
							), '<i class="fa fa-pencil"></i>', array(
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
							), '<i class="fa fa-video-camera"></i>', array(
							'class' => 'buttonlink'
						)) ;
						?>
					</li>	
				</ul>
			</div>	
			</div>

			<div class="tf_sublibrary_title">
				<?php echo $subLibrary -> getTitle();?>
			</div>

			<div class="tf_sublibrary_count">
				<div class="count_videos">
					<span>
						<?php echo $this->translate('20') ?>
					</span>
					<span>
						<?php echo $this->translate('videos') ?>
					</span>
				</div>

				<div class="count_views_comments">
					<?php echo $this->translate('1.525.506 views') ?> <br>
					<?php echo $this->translate('1.628 comments') ?>
				</div>
			</div>

			<div class="tf_sublibrary_author">
				by <span>James Jaredson</span>
			</div>
		</div>

		<?php if($this -> viewer() -> isSelf($this -> subject())) :?>

		<?php endif;?>

		<!-- show video of sub library -->
		<div>
			<!-- get videos of sub libraries -->
			<?php
			    $mappingTable = Engine_Api::_()->getDbTable('mappings', 'user');
			    $videoTable = Engine_Api::_()->getItemTable('video');
			    $params = array();
			    $params['owner_type'] = $subLibrary -> getType();
				$params['owner_id'] = $subLibrary -> getIdentity();
			    $subVideos = $videoTable -> fetchAll($mappingTable -> getVideosSelect($params));
			?>

			<?php if(count($subVideos)):?>
				<ul class="videos_browse">
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

		</div><!-- show video of sub library -->

	</li><!-- end item sublibrary -->
	<?php endif;?>
<?php endforeach; ?>
</ul><!--tf_list_sublibrary-->

<script type="text/javascript">
	window.addEvent('domready', function(){

		
		$$('.tf_sublibrary_title').addEvent('click', function(){
			var parent = this.getParent('.tf_list_sublibrary li')
			//Get height -> set padding top
			var padding = parseInt(parent.getStyle('height')) + 15;
			$$('.tf_list_sublibrary').setStyle('padding-top',padding);

			//Add class chose player
			$$('.tf_list_sublibrary li').removeClass('chose_player');
			parent.addClass('chose_player');
		})

		 
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
			
			// if($('global_footer').getStyle('margin-top') != "0px") {
			// 	$('global_footer').setStyle('margin-top', '');
			// } else {
			// 	$('global_footer').setStyle('margin-top', '60px');	
			// }
		});
		 
		 $$('.user-library-close-box').addEvent('click', function(){
		 	var parent = this.getParent().getParent().getParent();
			parent.removeClass('open-submenu');				
		});
		
				
  	});	
</script>
