<?php

class Tfcampaign_Model_Campaign extends Core_Model_Item_Abstract {
	
	public function getSubmissionPlayers() {
		$submissionTable =Engine_Api::_() -> getItemTable('tfcampaign_submission');
		$select = $submissionTable -> select();
		$select -> where('campaign_id = ?', $this -> getIdentity());
		return $submissionTable -> fetchAll($select);
	}
	
	public function setPhoto($photo)
	{
		if ($photo instanceof Zend_Form_Element_File)
		{
			$file = $photo -> getFileName();
		}
		else
		if (is_array($photo) && !empty($photo['tmp_name']))
		{
			$file = $photo['tmp_name'];
		}
		else
		if (is_string($photo) && file_exists($photo))
		{
			$file = $photo;
		}
		else
		{
			throw new Tfcampaign_Model_Exception('invalid argument passed to setPhoto');
		}

		$name = basename($file);
		$path = APPLICATION_PATH . DIRECTORY_SEPARATOR . 'temporary';
		$params = array(
			'parent_type' => 'tfcampaign_campagin',
			'parent_id' => $this -> getIdentity()
		);

		// Save
		$storage = Engine_Api::_() -> storage();

		// Resize image (main)
		$image = Engine_Image::factory();
		$image -> open($file) -> resize(720, 720) -> write($path . '/m_' . $name) -> destroy();

		// Resize image (profile)
		$image = Engine_Image::factory();
		$image -> open($file) -> resize(200, 400) -> write($path . '/p_' . $name) -> destroy();

		// Store
		$iMain = $storage -> create($path . '/m_' . $name, $params);
		$iProfile = $storage -> create($path . '/p_' . $name, $params);
		$iMain -> bridge($iProfile, 'thumb.profile');

		// Remove temp files
		@unlink($path . '/p_' . $name);
		@unlink($path . '/m_' . $name);

		// Update row
		$this -> modified_date = date('Y-m-d H:i:s');
		$this -> photo_id = $iMain -> file_id;
		$this -> save();

		return $this;
	}
	
	public function getSlug($str = NULL, $maxstrlen = 64)
	{
		$str = $this -> getTitle();
		if (strlen($str) > 32)
		{
			$str = Engine_String::substr($str, 0, 32) . '...';
		}
		$str = preg_replace('/([a-z])([A-Z])/', '$1 $2', $str);
		$str = strtolower($str);
		$str = preg_replace('/[^a-z0-9-]+/i', '-', $str);
		$str = preg_replace('/-+/', '-', $str);
		$str = trim($str, '-');
		if (!$str)
		{
			$str = '-';
		}
		return $str;
	}
	
	public function getHref($params = array())
	{
		$slug = $this -> getSlug();
		$params = array_merge(array(
			'route' => 'tfcampaign_profile',
			'reset' => true,
			'id' => $this -> getIdentity(),
			'slug' => $slug,
		), $params);
		$route = $params['route'];
		$reset = $params['reset'];
		unset($params['route']);
		unset($params['reset']);
		return Zend_Controller_Front::getInstance() -> getRouter() -> assemble($params, $route, $reset);
	}
	
	public function isViewable() {
		//get viewer
		$viewer = Engine_Api::_() -> user() -> getViewer();
		
		//view for specific users
		$tableUserItemView = Engine_Api::_() -> getDbTable('userItemView', 'user');
		$userViewRows = $tableUserItemView -> getUserByItem($this);
		foreach($userViewRows as $userViewRow) {
			$user = Engine_Api::_() -> getItem('user', $userViewRow -> user_id);
			if($user -> getIdentity() && $viewer -> isSelf($user)) {
				return true;
			}
		}
        return $this->authorization()->isAllowed(null, 'view'); 
    }
	
	public function isEditable() {
		return $this->authorization()->isAllowed(null, 'edit'); 
	}
	
	public function isDeletable() {
		return $this->authorization()->isAllowed(null, 'delete'); 
	}
	
	public function getSportId() {
		return $this->category_id‏;
	}
}
