<?php
class Ynvideo_Form_EditRate extends Engine_Form
{
	protected $_video;
	protected $_item;
	protected $_ratingTypes;
	
	public function getRatingTypes()
	{
		return $this -> _ratingTypes;
	}
	
	public function setRatingTypes($ratingTypes)
	{
		$this -> _ratingTypes = $ratingTypes;
	} 
	
	public function getItem()
	{
		return $this -> _item;
	}
	
	public function setItem($item)
	{
		$this -> _item = $item;
	} 
	
	public function getVideo()
	{
		return $this -> _video;
	}
	
	public function setVideo($video)
	{
		$this -> _video = $video;
	} 
	
  public function init()
  {
	 
    $this->setTitle('Edit review for '.$this -> _video->getTitle());
	
	
	$this -> addElement('dummy', 'rate', array(
			'decorators' => array( array(
				'ViewScript',
				array(
					'viewScript' => '_rate_video.tpl',
					'video_id' => $this -> _video -> getIdentity(),
					'edit' => 1,
					'ratingTypes' =>  $this -> _ratingTypes,
					'review' => $this->_item,
					'class' => 'form element',
				)
			)), 
	));  
	
		
    // Buttons
    $this->addElement('Button', 'submit', array(
      'value' => 'submit',
      'label' => 'Save',
      'type' => 'submit',
      'ignore' => true,
      'decorators' => array(
        'ViewHelper',
      ),
    ));
	
    $this->addElement('Cancel', 'cancel', array(
      'label' => 'Cancel',
      'link' => true,
      'prependText' => ' or ',
      'href' => '',
      'onclick' => 'parent.Smoothbox.close();',
      'decorators' => array(
        'ViewHelper',
      ),
    ));

    $this->addDisplayGroup(array('submit', 'cancel'), 'buttons', array(
      'decorators' => array(
        'FormElements',
        'DivDivDivWrapper',
      ),
    ));
  }
}
