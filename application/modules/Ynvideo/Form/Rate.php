<?php
class Ynvideo_Form_Rate extends Engine_Form
{
	protected $_video;
	protected $_ratingTypes;
	
	public function getRatingTypes()
	{
		return $this -> _ratingTypes;
	}
	
	public function setRatingTypes($ratingTypes)
	{
		$this -> _ratingTypes = $ratingTypes;
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
	 
    $this->setTitle('Add ratings for video '.$this -> _video->getTitle());
	
	$this -> addElement('dummy', 'rate', array(
			'decorators' => array( array(
				'ViewScript',
				array(
					'viewScript' => '_rate_video.tpl',
					'ratingTypes' =>  $this -> _ratingTypes,
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
