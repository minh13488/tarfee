<?php echo $this -> library -> getTitle();?>

<?php if($this -> viewer() -> isSelf($this -> subject())) :?>
<?php echo $this->htmlLink(array(
		'route' => 'video_general',
		'action' => 'create',
		'parent_type' =>'user_library',
		'subject_id' =>  $this->library->getIdentity(),
	), '<i class="fa fa-plus-square"></i>'.$this->translate('Create New Video'), array(
	'class' => 'buttonlink'
	)) ;
?>
<?php endif;?>

 <?php foreach ($this->paginator as $item): ?>
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