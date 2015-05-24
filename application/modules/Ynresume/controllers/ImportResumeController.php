<?php

class Ynresume_ImportResumeController extends Core_Controller_Action_Standard
{
	CONST DEBUG = TRUE;
	
	public function linkedinAction()
    {
        if (!Engine_Api::_()->hasModuleBootstrap('socialbridge')){
            return $this -> _helper -> redirector -> gotoRoute( array ( 'action' => 'import' ), 'ynresume_general', true );
        }

    	$serviceName = 'linkedin';
    	$obj = Socialbridge_Api_Core::getInstance($serviceName);
    	
    	$req = $this -> getRequest();
		$callbackUrl = $req -> getScheme() . '://' . $req -> getHttpHost() .
			Zend_Controller_Front::getInstance() -> getRouter() -> assemble(array('controller' => 'import-resume', 'action' => 'linkedin'), 'ynresume_extended');
		$me = array();
    	if(isset($_SESSION['socialbridge_session'][$serviceName]['secret_token'])
    	&& $_SESSION['socialbridge_session'][$serviceName]['secret_token'] != ""
		&& !empty($_SESSION['socialbridge_session'][$serviceName]['ynresume_likedin_token']))
    	{
    		$me = $obj->getOwnerInfo($_SESSION['socialbridge_session'][$serviceName]);
    	}
    	else 
    	{
    		$_SESSION['socialbridge_session'][$serviceName]['ynresume_likedin_token'] = 'full_profile';
    		$url = $obj->getConnectUrl() .
                    '&scope=r_fullprofile,rw_nus'.
                    '&' . http_build_query(array(
                    'callbackUrl' => $callbackUrl.'?service='.$serviceName
    		));
    		header('Location: '.$url); exit;
    	}
    	
    	$this -> view -> error = '';
    	if (empty($me) || is_null($me))
    	{
    		$this -> view -> error = Zend_Registry::get("Zend_Translate")->_("Can not connect your LinkedIn account!");	
    	}
    	$inputs = array(
    		'formatted-name' => 'Full Name',
    		'headline' => 'Headline',
	    	'location' => 'Location',
	    	'picture-url' => 'Photo',
	    	'summary' => 'Summary',
	    	'skills' => 'Skill',
	    	'educations' => 'Education',
	    	'publications' => 'Publications',
			'languages' => 'Languages',
    		'certifications' => 'Certifications',
    		'projects' => 'Project',
    		'courses' => 'Courses',
			'honors-awards' => 'Honor & wards',
    		'positions' => 'Experience' 
    	);
    	
    	$this -> view -> inputs = $inputs;
    	$this -> view -> me = $me;
    	if (isset($_POST['linkedin_settings']))
    	{
    		$settings = $_POST['linkedin_settings'];
    		if (!count($settings))
    		{
    			$this -> view -> error = Zend_Registry::get("Zend_Translate")->_("Please choose the setting!");
    			return;
    		}
    		$viewer = Engine_Api::_() -> user() -> getViewer();
    		$resumeTbl = Engine_Api::_()->getItemTable('ynresume_resume');
    		$resume = $resumeTbl -> getResume($viewer->getIdentity());
    		if (is_null($resume))
    		{
    			$resume = $resumeTbl -> createRow();
    		}
    		$db = Engine_Db_Table::getDefaultAdapter();
            $db->beginTransaction();
    		try 
    		{
                $this -> removeImportedData($resume);
	    		$resume = $this -> saveData($resume, $me, $settings);
	    		$resume -> user_id = $viewer -> getIdentity();
	    		$resume -> save();	
	    		$db->commit();
    		}
    		catch (Exception $e) 
    		{
    			$db->rollBack();
                throw $e;
    		}

    		$this -> _helper -> redirector -> gotoRoute( array ( 'action' => 'import' ), 'ynresume_general', true );
    	}
    }
    
    public function saveData($resume, $me, $settings)
    {
    	foreach ($settings as $s)
    	{
			switch ($s) {
    			case 'formatted-name':
					$resume -> name = (string)$me['formattedName'] ;
				break;
				
				case 'headline':
					$resume -> headline = (string)$me['headline'] ;
                    $resume -> title = (string)$me['headline'] ;
				break;
				
				case 'location':
					$resume -> location = (string)$me['location']['name'] ;
				break;
				
				case 'picture-url':
					$url = (string)$me['picture'];
                    if ($url == '')
                    {
                        $url = $me['pictureUrl'];
                    }
					if ($url != '')
					{
						$path = APPLICATION_PATH . DIRECTORY_SEPARATOR . 'temporary';
						$data = file_get_contents($url);
						$tempFilePath = $path = APPLICATION_PATH . DIRECTORY_SEPARATOR . 'temporary' . DIRECTORY_SEPARATOR . time(). '.jpg';
						file_put_contents($tempFilePath, $data);
						$resume -> setPhoto($tempFilePath);
						@unlink($tempFilePath);
					}
					
				break;
				
				case 'summary':
					$resume -> summary = (string)$me['summary'] ;
				break;
				
				case 'skills':
					$resume = $this -> saveSkills($resume, $me);
				break;
				
				case 'educations':
					$resume = $this -> saveEducations($resume, $me);
				break;
				
				case 'publications':
					$resume = $this -> savePublications($resume, $me);
				break;
				
				case 'languages':
					$resume = $this -> saveLanguages($resume, $me);
				break;
				
				case 'certifications':
					$resume = $this -> saveCertifications($resume, $me);
				break;

				case 'projects':
					$resume = $this -> saveProjects($resume, $me);
				break;
				
				case 'courses':
					$resume = $this -> saveCourses($resume, $me);
				break;
				
				case 'honors-awards':
					$resume = $this -> saveAwards($resume, $me);
				break;

				case 'positions':
					$resume = $this -> saveExperiences($resume, $me);
				break;
    		}
    	}
    	$resume -> save();
    	return $resume;
    }
    
    public function saveSkills($resume, $me)
    {
    	if (!isset($me['skills']))
    	{
    		return $resume;
    	}
    	$skills = $me['skills']['values'];
    	
    	$skillTbl = Engine_Api::_()->getDbTable('skills', 'ynresume');
    	$viewer = Engine_Api::_() -> user() -> getViewer();
    	$order = 0;
    	foreach ($skills as $skill)
    	{
    		$order++;
    		$skillText = (string)$skill['skill']['name'];
            $skillmap = $skillTbl -> addSkillMap($resume, $viewer, $skillText, $order);
            $this -> addLog($resume, 'ynresume_skill_map', $skillmap -> getIdentity());
    	}
    	return $resume;
    }
    
    public function saveEducations($resume, $me)
    {
    	if (!isset($me['educations']))
    	{
    		return $resume;
    	}
    	$educations = $me['educations']['values'];
    	
    	$viewer = Engine_Api::_() -> user() -> getViewer();
    	$educationTbl = Engine_Api::_()->getItemTable('ynresume_education');
    	foreach ($educations as $e)
    	{
    		$education = $educationTbl -> createRow();
	    	$education -> setFromArray(array(
	    		'resume_id' => $resume -> getIdentity(),
	    		'user_id' => $viewer -> getIdentity(),
	    		'title' => (string)$e['schooName'],
	    		'attend_from' => (string)$e['startDate']['year'],
	    		'attend_to' => (string)$e['endDate']['year'],
	    		'study_field' => (string)$e['fieldOfStudy'],
	    		'degree_id' => 0,
	    		'creation_date' => date(),
	    		'modified_date' => date(),
	    	));	
	    	$education -> save();
            $this -> addLog($resume, 'ynresume_education', $education -> getIdentity());
    	}
    	
    	return $resume;
    }
    
    public function savePublications($resume, $me)
    {
    	if (!isset($me['publications']))
    	{
    		return $resume;
    	}
    	$publications = $me['publications']['values'];
    	$viewer = Engine_Api::_() -> user() -> getViewer();
    	$publicationTbl = Engine_Api::_()->getItemTable('ynresume_publication');
    	foreach ($publications as $p)
    	{
    		$publication = $publicationTbl -> createRow();
    		$year = (string)$p['date']['year'];
    		$month = (string)$p['date']['month'];
    		$day = (string)$p['date']['day'];
    		
	    	$publication -> setFromArray(array(
	    		'resume_id' => $resume -> getIdentity(),
	    		'user_id' => $viewer -> getIdentity(),
	    		'title' => (string)$p['title'],
	    		'publisher' => '',
	    		'date' => "{$year}-{$month}-{$day} 0:00:00",
	    		'creation_date' => date(),
	    		'url' => '',
	    		'desciption' => ''
	    	));	
	    	$publication -> save();
            $this -> addLog($resume, 'ynresume_publication', $publication -> getIdentity());
    	}
    	return $resume;
    }
    
	public function saveLanguages($resume, $me)
    {
    	if (!isset($me['languages']))
    	{
    		return $resume;
    	}
    	$languages = $me['languages']['values'];
    	$languageTbl = Engine_Api::_()->getItemTable('ynresume_language');
    	foreach ($languages as $lang)
    	{
    		$language = $languageTbl -> createRow();
	    	$language -> setFromArray(array(
	    		'resume_id' => $resume -> getIdentity(),
	    		'name' => (string)$lang['language']['name'],
	    		'proficiency' => 'elementary'
	    	));	
	    	$language -> save();
            $this -> addLog($resume, 'ynresume_language', $language -> getIdentity());
    	}
    	return $resume;
    }
    
    public function saveCertifications($resume, $me)
    {
    	if (!isset($me['certifications']))
    	{
    		return $resume;
    	}
    	$certifications = $me['certifications']['values'];
    	$viewer = Engine_Api::_() -> user() -> getViewer();
    	$certificationTbl = Engine_Api::_()->getItemTable('ynresume_certification');
    	foreach ($certifications as $cer)
    	{
    		$certification = $certificationTbl -> createRow();
	    	$certification -> setFromArray(array(
	    		'resume_id' => $resume -> getIdentity(),
	    		'user_id' => $viewer -> getIdentity(),
	    		'name' => (string)$cer['name'],
	    		'authority' => '',
	    		'license_number' => '',
	    		'url' => '',
	    		'start_month' => '',
	    		'start_year' => '',
	    		'end_month' => '',
	    		'end_year' => '',
	    		'creation_date' => date(),
	    		'modified_date' => date(),
	    	));	
	    	$certification -> save();
            $this -> addLog($resume, 'ynresume_certification', $certification -> getIdentity());
    	}
    	return $resume;
    }
    
    public function saveProjects($resume, $me)
    {
    	if (!isset($me['projects']))
    	{
    		return $resume;
    	}
    	$projects = $me['projects']['values'];
    	$viewer = Engine_Api::_() -> user() -> getViewer();
    	$projectTbl = Engine_Api::_()->getItemTable('ynresume_project');
    	foreach ($projects as $pro)
    	{
    		$project = $projectTbl -> createRow();
	    	$project -> setFromArray(array(
	    		'resume_id' => $resume -> getIdentity(),
	    		'user_id' => $viewer -> getIdentity(),
	    		'name' => (string)$pro['name'],
	    		'description' => (string)$pro['description'],
	    		'url' => (string)$pro['url'],
	    		'authority' => '',
	    		'license_number' => '',
	    		'start_month' => '',
	    		'start_year' => '',
	    		'end_month' => '',
	    		'end_year' => '',
	    		'occupation_type' => '',
	    		'occupation_id' => 0,
	    	));	
	    	$project -> save();
            $this -> addLog($resume, 'ynresume_project', $project -> getIdentity());
    	}
    	return $resume;
    }
    
    public function saveCourses($resume, $me)
    {
    	if (!isset($me['courses']))
    	{
    		return $resume;
    	}
    	$courses = $me['courses']['values'];
    	$viewer = Engine_Api::_() -> user() -> getViewer();
    	$courseTbl = Engine_Api::_()->getItemTable('ynresume_course');
    	foreach ($courses as $c)
    	{
    		$course = $courseTbl -> createRow();
	    	$course -> setFromArray(array(
	    		'resume_id' => $resume -> getIdentity(),
	    		'name' => (string) $c['name'],
	    		'number' => (string) $c['number'],
	    		'associated_type' => '',
	    		'associated_id' => 0,
	    	));	
	    	$course -> save();
            $this -> addLog($resume, 'ynresume_course', $course -> getIdentity());
    	}
    	return $resume;
    }
    
    public function saveAwards($resume, $me)
    {
    	if (!isset($me['honors-awards']))
    	{
    		return $resume;
    	}
    	$awards = $me['honors-awards']['values'];
    	
    	$viewer = Engine_Api::_() -> user() -> getViewer();
    	$awardTbl = Engine_Api::_()->getItemTable('ynresume_award');
    	foreach ($awards as $item)
    	{
    		$award = $awardTbl -> createRow();
	    	$award -> setFromArray(array(
	    		'resume_id' => $resume -> getIdentity(),
	    		'user_id' => $viewer -> getIdentity(),
	    		'title' => (string) $item['name'],
	    		'occupation_type' => '',
	    		'occupation_id' => 0,
	    		'issuer' => (string) $item['issuer'],
	    		'date_month' => '',
		    	'date_year' => '',
		    	'creation_date' => date(),
		    	'modified_date' => date(),
	    	));	
	    	$award -> save();
            $this -> addLog($resume, 'ynresume_award', $award -> getIdentity());
    	}
    	return $resume;
    }
    
	public function saveExperiences($resume, $me)
    {
    	if (!isset($me['positions']))
    	{
    		return $resume;
    	}
    	$experiences = $me['positions']['values'];
    	
    	$viewer = Engine_Api::_() -> user() -> getViewer();
    	$experienceTbl = Engine_Api::_()->getItemTable('ynresume_experience');
    	foreach ($experiences as $item)
    	{
    		$experience = $experienceTbl -> createRow();
	    	$experience -> setFromArray(array(
	    		'resume_id' => $resume -> getIdentity(),
	    		'user_id' => $viewer -> getIdentity(),
	    		'title' => (string)$item['title'],
	    		'company' => (string)$item['company']['name'],
		    	'description' => '',
		    	'location' => '',
		    	'start_month' => (int)$item['startDate']['month'],
		    	'start_year' => (int)$item['startDate']['year'],
	    		'creation_date' => date(),
		    	'modified_date' => date(),
	    	));	
			if (@$item['isCurrent'] == 0)
			{
				$experience -> end_month = (int)$item['endDate']['month'];
				$experience -> end_year = (int)$item['endDate']['year'];
			}
	    	$experience -> save();
            $this -> addLog($resume, 'ynresume_experience', $experience -> getIdentity());
    	}
    	return $resume;
    }

    public function addLog($resume, $itemType, $itemId)
    {
        $table = Engine_Api::_()->getDbTable('importedlog', 'ynresume');
        $viewer = Engine_Api::_() -> user() -> getViewer();
        $row = $table -> createRow();
        $row -> setFromArray(array(
            'resume_id' => $resume -> getIdentity(),
            'user_id' => $viewer -> getIdentity(),
            'item_type' => $itemType,
            'item_id' => $itemId
        ));
        $row -> save();
    }

    public function removeImportedData($resume)
    {
        $table = Engine_Api::_()->getDbTable('importedlog', 'ynresume');
        $select = $table->select()->where("resume_id = ?", $resume->getIdentity());
        $logs = $table->fetchAll($select);
        foreach ($logs as $log)
        {
            if (Engine_Api::_()->hasItemType($log -> item_type))
            {
                $item = Engine_Api::_()->getItem($log -> item_type, $log -> item_id);
                $item -> delete();
            }
            $log -> delete();
        }
    }
}