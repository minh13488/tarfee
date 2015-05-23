<?php
class Ynbusinesspages_Model_DbTable_Modulesettings extends Engine_Db_Table 
{
	protected $_rowClass = 'Ynbusinesspages_Model_Modulesetting';
	
	public function getEnabledModuleSettings()
	{
		$settings = array();
		foreach ($this -> fetchAll($this -> select()) as $row)
		{
			if (Engine_Api::_()->hasModuleBootstrap($row->module_name))
			{
				$settings[] = $row;
			}
		}
		return $settings;
	}
}
