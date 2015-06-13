<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    User
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.net/license/
 * @version    $Id: EditController.php 7244 2010-09-01 01:49:53Z john $
 * @author     John
 */

/**
 * @category   Application_Core
 * @package    User
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.net/license/
 */
class Webcamavatar_CameraController extends Core_Controller_Action_User {
	public function init() {
		if (!Engine_Api::_() -> core() -> hasSubject()) {
			// Can specifiy custom id
			$id = $this -> _getParam('id', null);
			$subject = null;
			if (null === $id) {
				$subject = $this -> _helper -> api() -> user() -> getViewer();
				$this -> _helper -> api() -> core() -> setSubject($subject);
			} else {
				$subject = $this -> _helper -> api() -> user() -> getUser($id);
				$this -> _helper -> api() -> core() -> setSubject($subject);
			}
		}
		if (!empty($id)) {
			$params = array('params' => array('id' => $id));
		} else {
			$params = array();
		}
		// Set up navigation
		$this -> view -> navigation = $navigation = $this -> _helper -> api() -> getApi('menus', 'core') -> getNavigation('user_edit', array('params' => array('id' => $id)));

		// Set up require's
		$this -> _helper -> requireUser();
		$this -> _helper -> requireSubject('user');
		$this -> _helper -> requireAuth() -> setAuthParams(null, null, 'edit');
	}

	public function editAction() {
		$this -> _helper -> layout -> disableLayout();
		$this -> _helper -> viewRenderer -> setNoRender(TRUE);

		$this -> view -> user = $user = Engine_Api::_() -> core() -> getSubject();
		$this -> view -> viewer = $viewer = $this -> _helper -> api() -> user() -> getViewer();
		// remove styles if users are not allowed to style page
		if (!$this -> getRequest() -> isPost()) {
			return;
		}

		/* WC Avatar;
		 */
		$webcamform = $this -> getRequest() -> getPost();

		if (isset($webcamform["px0"])) {

			$url_photo = $user -> getPhotoUrl();
			$w = (int)$webcamform['width'];
			$h = (int)$webcamform['height'];
			// create the image with desired width and height
			$img = imagecreatetruecolor($w, $h);
			// now fill the image with blank color
			// do you remember i wont pass the 0xFFFFFF pixels
			// from flash?
			imagefill($img, 0, 0, 0xFFFFFF);
			$rows = 0;
			$cols = 0;
			// now process every POST variable which
			// contains a pixel color
			for ($rows = 0; $rows < $h; $rows++) {
				// convert the string into an array of n elements
				$c_row = explode(",", $webcamform['px' . $rows]);
				for ($cols = 0; $cols < $w; $cols++) {
					// get the single pixel color value
					$value = $c_row[$cols];
					// if value is not empty (empty values are the blank pixels)
					if ($value != "") {
						// get the hexadecimal string (must be 6 chars length)
						// so add the missing chars if needed
						$hex = $value;
						while (strlen($hex) < 6) {
							$hex = "0" . $hex;
						}
						// convert value from HEX to RGB
						$r = hexdec(substr($hex, 0, 2));
						$g = hexdec(substr($hex, 2, 2));
						$b = hexdec(substr($hex, 4, 2));
						// allocate the new color
						// N.B. teorically if a color was already allocated
						// we dont need to allocate another time
						// but this is only an example
						$newcolor = imagecolorallocate($img, $r, $g, $b);
						// and paste that color into the image
						// at the correct position
						imagesetpixel($img, $cols, $rows, $newcolor);
					}
				}
			}

			// print out the correct header to the browser
			// display the image
			if ($webcamform['task'] == "avatar_download") {

				header("Content-type: charset=UTF-8");
				header("Content-type:image/jpeg");
				header("Content-Disposition: attachment; filename=webcam-avatar.jpg");
				header("Pragma: no-cache");
				header("Expires: 0");
				imagejpeg($img, NULL, 100);
				ImageDestroy($img);
				return;
			} else if ($webcamform['task'] == "avatar_upload") {
				if ($user -> photo_id == 0) {

					$params = array('parent_type' => 'user', 'parent_id' => $viewer -> user_id);
					$path = APPLICATION_PATH . '/public/temporary/' . time() . mt_rand(1000, 9000) . '.jpg';
					// Save
					$storage = Engine_Api::_() -> storage();

					// Main Image
					$w = 720;
					$h = 540;
					$file_1 = imagecreatetruecolor($w, $h);
					for ($i = 0; $i < 256; $i++) {
						imagecolorallocate($file_1, $i, $i, $i);
					}
					imagecopyresampled($file_1, $img, 0, 0, 0, 0, $w, $h, 480, 360);
					imagejpeg($file_1, $path, 100);

					$viewer -> setPhoto($path);

				} else {
					$url_photo = $user -> getPhotoUrl();
					$url_photo_array = explode('/', $url_photo);
					$directory_base = explode('\\', APPLICATION_PATH);
					//check if ..
					if ($url_photo_array[1] == $directory_base[sizeof($directory_base) - 1])
						unset($directory_base[sizeof($directory_base) - 1]);
					$directory_base = implode('\\', $directory_base);

					$url_photo = $directory_base . $url_photo;
					$url_photo_profile = $directory_base . $user -> getPhotoUrl("thumb.profile");
					$url_photo_normal = $directory_base . $user -> getPhotoUrl("thumb.normal");
					$url_photo_thumb = $directory_base . $user -> getPhotoUrl("thumb.icon");

					// fix se4.1.1
					if ((int) strrpos($url_photo_thumb, "?") > 0) {

						$url_photo = substr($url_photo, 0, (int) strrpos($url_photo, "?"));
						$url_photo_profile = substr($url_photo_profile, 0, (int) strrpos($url_photo_profile, "?"));
						$url_photo_normal = substr($url_photo_normal, 0, (int) strrpos($url_photo_normal, "?"));
						$url_photo_thumb = substr($url_photo_thumb, 0, (int) strrpos($url_photo_thumb, "?"));
					}

					unlink($url_photo);
					unlink($url_photo_profile);
					unlink($url_photo_normal);
					unlink($url_photo_thumb);

					// current path
					$path = APPLICATION_PATH . '/public/temporary/' . time() . mt_rand(1000, 9000) . '.jpg';
					// Main Image
					$w = 720;
					$h = 540;
					$file_1 = imagecreatetruecolor($w, $h);
					for ($i = 0; $i < 256; $i++) {
						imagecolorallocate($file_1, $i, $i, $i);
					}
					imagecopyresampled($file_1, $img, 0, 0, 0, 0, $w, $h, 480, 360);
					imagejpeg($file_1, $path, 100);

					$viewer -> setPhoto($path);

				}

				// Insert activity
				$action = Engine_Api::_() -> getDbtable('actions', 'activity') -> addActivity($user, $user, 'profile_photo_update', '{item:$subject} added a new profile photo.');
			}
			return $this -> _redirect("members/edit/photo");
		} else
			return $this -> _redirect("members/edit/photo");
		// End WC Avatar

	}

}
