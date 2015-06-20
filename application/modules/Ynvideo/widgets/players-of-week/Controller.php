<?php
class Ynvideo_Widget_PlayersOfWeekController extends Engine_Content_Widget_Abstract {
	public function indexAction() {
		$table = Engine_Api::_()->getItemTable('video');
		$numberOfVideos = $this->_getParam('numberOfVideos', 5);
		$select = $table->select();
		$select->from($table->info('name'), '*,(comment_count + rating + share_count + like_count) as point');
		$select->where('parent_type = ?', 'user_playercard');
		$select->limit($numberOfVideos);
		$select->order('point DESC');
		$results = $table->fetchAll($select);
		
		if (!count($results)) {
			return $this->setNoRender();
		}

		$this->view->results = $results;
	}
}
