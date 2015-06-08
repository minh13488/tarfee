<?php
class User_Model_Playercard extends Core_Model_Item_Abstract
{

	public function getTitle()
	{
		return $this -> first_name . ' ' . $this -> last_name;
	}

	public function getHref($params = array())
	{
		$params = array_merge(array(
			'route' => 'playercard_profile',
			'reset' => true,
			'id' => $this -> getIdentity(),
			'slug' => $this -> getSlug(),
		), $params);
		$route = $params['route'];
		$reset = $params['reset'];
		unset($params['route']);
		unset($params['reset']);
		return Zend_Controller_Front::getInstance() -> getRouter() -> assemble($params, $route, $reset);
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
			throw new User_Model_Exception('invalid argument passed to setPhoto');
		}

		$name = basename($file);
		$path = APPLICATION_PATH . DIRECTORY_SEPARATOR . 'temporary';
		$params = array(
			'parent_type' => 'player_card',
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

	public function getOverallRating()
	{
		$mappingTable = Engine_Api::_() -> getDbTable('mappings', 'user');
		$ratingTable = Engine_Api::_() -> getDbTable('reviewRatings', 'ynvideo');
		$params = array(
			'owner_id' => $this -> getIdentity(),
			'owner_type' => $this -> getType(),
		);
		$type = 'video';
		$videoIds = $mappingTable -> getItemIdsMapping($type, $params);
		$totalOverallRating = 0;
		$totalOverallRatingReview = 0;
		foreach ($videoIds as $video_id)
		{
			//loop for each video
			$video = Engine_Api::_() -> getItem('video', $video_id);
			if ($video)
			{
				//get all user add ratings for this video
				$userIds = $ratingTable -> getUserRatingByResource($video_id);
				$totalOverallRatingVideo = 0;
				foreach ($userIds as $userId)
				{
					//loop for each user to get overall ratings for video
					$params = array(
						'resource_id' => $video_id,
						'user_id' => $userId,
					);
					$ratings = $ratingTable -> getRatingsBy($params);
					$ratingTotal = 0;
					foreach ($ratings as $rating)
					{
						$ratingTotal += $rating -> rating;
					}
					$totalOverallRatingVideo += round(($ratingTotal / 5), 2);
					$totalOverallRatingReview++;
				}
				$totalOverallRating += $totalOverallRatingVideo;
			}
		}
		if ($totalOverallRatingReview != 0)
		{
			$total = round(($totalOverallRating / $totalOverallRatingReview), 2);
			return $total;
		}
		else
			return "0";
	}
	
	function isViewable() {
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
	
	function isEyeOn($user_id = null) {
		if (!$user_id) {
            $user_id = Engine_Api::_()->user()->getViewer()->getIdentity();
        }
        return Engine_Api::_()->getDbTable('eyeons', 'user')->isEyeOn($user_id, $this->getIdentity());
	}
	
	function getEyeOns() {
		return Engine_Api::_()->getDbTable('eyeons', 'user')->getPlayerEyeOns($this->getIdentity());
	}
	
	public function getPhotosTotal() {
		$photoTable = Engine_Api::_() -> getItemTable('user_photo');
		$select = $photoTable -> select();
    	$select -> from($photoTable->info('name'), 'COUNT(*) AS count')
				-> where('item_id = ?', $this -> getIdentity())
				-> where('item_type = ?', $this -> getType());
    	return $select->query()->fetchColumn(0);
	}
	public function getSport()
	{
		return Engine_Api::_() -> getItem('user_sportcategory', $this -> category_id);
	}
	
	public function getPosition()
	{
		return Engine_Api::_() -> getItem('user_sportcategory', $this -> position_id);
	}
	
	public function getSportId() {
		return $this->category_id;
	}
}
