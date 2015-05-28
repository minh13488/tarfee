<?php
class Ynvideo_Model_Review extends Core_Model_Item_Abstract {

	public function getRating()
	{
		$ratingTbl = Engine_Api::_()-> getItemTable('ynmember_rating');
		$ratingTblName = $ratingTbl -> info('name');
		
		$ratingTypeTbl = Engine_Api::_()-> getItemTable('ynmember_ratingtype');
		$ratingTypeTblName = $ratingTypeTbl -> info('name');
		
		$select = $ratingTbl -> select() -> setIntegrityCheck(false)
			-> from($ratingTblName)
			-> joinleft($ratingTypeTblName, "{$ratingTblName}.rating_type = {$ratingTypeTblName}.ratingtype_id")
			-> where("$ratingTblName.review_id = ?", $this -> getIdentity())
			;
		$ratings = $ratingTbl -> fetchAll($select);
		return $ratings;
	}
	
}