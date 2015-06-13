<?php


class Webcamavatar_Plugin_Signup_Photo extends Core_Plugin_FormSequence_Abstract {

  protected $_name = 'account';
  protected $_formClass = 'User_Form_Signup_Photo';
  protected $_script = array('signup/form/webcam-photo.tpl', 'webcamavatar');
  protected $_adminFormClass = 'Webcamavatar_Form_Photo';
  protected $_adminScript = array('admin-signup/photo.tpl', 'user');
  protected $_skip;
  protected $_coordinates;

  public function isActive() {
    // Skip this step for mobile browsers
    try {

      if (class_exists('Mobi_Api_Core') && ($api = Engine_Api::_()->getApi('core', 'mobi'))) {
        if ($api->isMobile()) {
          return false;
        }
      }
    } catch (Exception $e) {
      // Silence
    }

    return parent::isActive();
  }

  public function onSubmit(Zend_Controller_Request_Abstract $request) {
    // Form was valid
    $skip = $request->getParam("skip");
    $uploadPhoto = $request->getParam("uploadPhoto");
    $finishForm = $request->getParam("nextStep");
    $this->_coordinates = $request->getParam("coordinates");
    

    // do this if the form value for "skip" was not set
    // if it is set, $this->setActive(false); $this->onsubmisvalue and return true.

    $webcamform = $request->getPost();
    
    
    if ($webcamform && isset($webcamform["px0"]) && (@$webcamform['task'] == "avatar_upload") && (@$webcamform['nextStep'] == 'finish')) {
      
      
      $directory_base = APPLICATION_PATH;
      //$url_photo = $viewer->getPhotoUrl();
      $w = (int) $webcamform['width'];
      $h = (int) $webcamform['height'];
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

      $avatar_path = APPLICATION_PATH . '/public/temporary/' . time() . mt_rand(1000, 9000) . '.jpg';
      // Save
      // Main Image
      $w = 720;
      $h = 540;
      $file_1 = imagecreatetruecolor($w, $h);
      for ($i = 0; $i < 256; $i++) {
        imagecolorallocate($file_1, $i, $i, $i);
      }
      imagecopyresampled($file_1, $img, 0, 0, 0, 0, $w, $h, 480, 360);
      imagejpeg($file_1, $avatar_path, 100);
      $this->_resizeImages($avatar_path);

      $this->getSession()->data = array(1,);
      $this->getSession()->active = true;
      $this->getSession()->avatar_path = $avatar_path;
      $this->onSubmitNotIsValid();
      return true;
    } elseif ($this->getForm()->isValid($request->getPost()) &&
            $skip != "skipForm" &&
            $uploadPhoto == true &&
            $finishForm != "finish") {
      $this->getSession()->data = $this->getForm()->getValues();
      $this->getSession()->Filedata = $this->getForm()->Filedata->getFileInfo();
      $this->_resizeImages($this->getForm()->Filedata->getFileName());
      $this->getSession()->active = true;
      $this->onSubmitNotIsValid();
      return false;
    } else if ($skip != "skipForm" &&
            $finishForm == "finish" &&
            isset($_SESSION['TemporaryProfileImg'])) {
      $this->setActive(false);
      $this->onSubmitIsValid();
      return true;
    } else if ($skip == "skipForm" ||
            (!isset($_SESSION['TemporaryProfileImg']) && $finishForm == "finish")) {
      $this->setActive(false);
      $this->onSubmitIsValid();
      $this->getSession()->skip = true;
      $this->_skip = true;
      return true;
    }

    // Form was not valid
    else {
      $this->getSession()->active = true;
      $this->onSubmitNotIsValid();
      return false;
    }

    parent::onSubmit($request);
  }

  public function onProcess() {

    // In this case, the step was placed before the account step.
    // Register a hook to this method for onUserCreateAfter
    if (!$this->_registry->user) {
      // Register temporary hook
      Engine_Hooks_Dispatcher::getInstance()->addEvent('onUserCreateAfter', array(
          'callback' => array($this, 'onProcess'),
      ));
      return;
    } else {
      
    }

    $user = $this->_registry->user;

    // Remove old key
    unset($_SESSION['TemporaryProfileImg']);
    unset($_SESSION['TemporaryProfileImgProfile']);
    unset($_SESSION['TemporaryProfileImgSquare']);

    // Process
    //$data = $this->getSession()->data;

    $params = array(
        'parent_type' => 'user',
        'parent_id' => $user->user_id
    );

    if (!$this->_skip &&
            !$this->getSession()->skip &&
            !empty($this->getSession()->tmp_file_id)) {
      echo "process " . __CLASS__ . '::onprocess save file';
      // Save
      $storage = Engine_Api::_()->getItemTable('storage_file');

      // Update info
      $iMain = $storage->getFile($this->getSession()->tmp_file_id);
      $iMain->setFromArray($params);
      $iMain->save();
      $iMain->updatePath();

      $iProfile = $storage->getFile($this->getSession()->tmp_file_id, 'thumb.profile');
      $iProfile->setFromArray($params);
      $iProfile->save();
      $iProfile->updatePath();

      $iNormal = $storage->getFile($this->getSession()->tmp_file_id, 'thumb.normal');
      $iNormal->setFromArray($params);
      $iNormal->save();
      $iNormal->updatePath();

      $iSquare = $storage->getFile($this->getSession()->tmp_file_id, 'thumb.icon');
      $iSquare->setFromArray($params);
      $iSquare->save();
      $iSquare->updatePath();

      // Update row
      $user->photo_id = $iMain->file_id;
      $user->save();

      if ($this->_coordinates) {
        $this->_resizeThumbnail($user);
      }
    }
  }

  protected function _resizeImages($file) {
    $name = basename($file);
    $path = dirname($file);

    // Resize image (main)
    $iMainPath = $path . '/m_' . $name;
    $image = Engine_Image::factory();
    $image->open($file)
            ->resize(720, 720)
            ->write($iMainPath)
            ->destroy();

    // Resize image (profile)
    $iProfilePath = $path . '/p_' . $name;
    $image = Engine_Image::factory();
    $image->open($file)
            ->resize(200, 400)
            ->write($iProfilePath)
            ->destroy();

    // Resize image (icon.normal)
    $iNormalPath = $path . '/n_' . $name;
    $image = Engine_Image::factory();
    $image->open($file)
            ->resize(48, 120)
            ->write($iNormalPath)
            ->destroy();

    // Resize image (icon.square)
    $iSquarePath = $path . '/s_' . $name;
    $image = Engine_Image::factory();
    $image->open($file);
    $size = min($image->height, $image->width);
    $x = ($image->width - $size) / 2;
    $y = ($image->height - $size) / 2;
    $image->resample($x, $y, $size, $size, 48, 48)
            ->write($iSquarePath)
            ->destroy();

    // Cloud compatibility, put into storage system as temporary files
    $storage = Engine_Api::_()->getItemTable('storage_file');

    // Save/load from session
    if (empty($this->getSession()->tmp_file_id)) {
      // Save
      $iMain = $storage->createTemporaryFile($iMainPath);
      $iProfile = $storage->createTemporaryFile($iProfilePath);
      $iNormal = $storage->createTemporaryFile($iNormalPath);
      $iSquare = $storage->createTemporaryFile($iSquarePath);

      $iMain->bridge($iProfile, 'thumb.profile');
      $iMain->bridge($iNormal, 'thumb.normal');
      $iMain->bridge($iSquare, 'thumb.icon');

      $this->getSession()->tmp_file_id = $iMain->file_id;
    } else {
      // Overwrite
      $iMain = $storage->getFile($this->getSession()->tmp_file_id);
      $iMain->store($iMainPath);

      $iProfile = $storage->getFile($this->getSession()->tmp_file_id, 'thumb.profile');
      $iProfile->store($iProfilePath);

      $iNormal = $storage->getFile($this->getSession()->tmp_file_id, 'thumb.normal');
      $iNormal->store($iNormalPath);

      $iSquare = $storage->getFile($this->getSession()->tmp_file_id, 'thumb.icon');
      $iSquare->store($iSquarePath);
    }

    // Save path to session?
    $_SESSION['TemporaryProfileImg'] = $iMain->map();
    $_SESSION['TemporaryProfileImgProfile'] = $iProfile->map();
    $_SESSION['TemporaryProfileImgSquare'] = $iSquare->map();

    // Remove temp files
    @unlink($path . '/p_' . $name);
    @unlink($path . '/m_' . $name);
    @unlink($path . '/n_' . $name);
    @unlink($path . '/s_' . $name);
  }

  protected function _resizeThumbnail($user) {
    $storage = Engine_Api::_()->storage();

    $iProfile = $storage->get($user->photo_id, 'thumb.profile');
    $iSquare = $storage->get($user->photo_id, 'thumb.icon');

    // Read into tmp file
    $pName = $iProfile->getStorageService()->temporary($iProfile);
    $iName = dirname($pName) . '/nis_' . basename($pName);

    list($x, $y, $w, $h) = explode(':', $this->_coordinates);

    $image = Engine_Image::factory();
    $image->open($pName)
            ->resample($x + .1, $y + .1, $w - .1, $h - .1, 48, 48)
            ->write($iName)
            ->destroy();

    $iSquare->store($iName);

    @unlink($iName);
  }

  public function onAdminProcess($form) {
    $enable =$form->getValue('enable');
    $step_table = Engine_Api::_()->getDbtable('signup', 'user');
    $step_row = $step_table->fetchRow($step_table->select()->where('class = ?', 'Webcamavatar_Plugin_Signup_Photo'));
    $step_row->enable = $enable;
    $step_row->save();
    if($enable == 1 );
    $step_row_1 = $step_table->fetchRow($step_table->select()->where('class = ?', 'User_Plugin_Signup_Photo'));
    $step_row_1->enable = 0;
    $step_row_1->save();
    $form->addNotice('Your changes have been saved.');
  }

}