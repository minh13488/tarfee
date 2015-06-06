<?php

class Ynevent_Widget_ProfileMapController extends Engine_Content_Widget_Abstract
{
	public function indexAction()
	{
		// Prepare data
		$this -> view -> event = $event = Engine_Api::_() -> core() -> getSubject();
		$this -> view -> fullAddress = $event -> getFullAddress();
		if(!$this -> view -> fullAddress)
		{
			$countryName = '';
			$provinceName = '';
			$cityName = '';
			if($event ->country_id && $country = Engine_Api::_() -> getItem('user_location', $event ->country_id))
			{
				$countryName = $country -> getTitle();
			}
			if($event ->province_id && $province = Engine_Api::_() -> getItem('user_location', $event ->province_id))
			{
				$provinceName = $province -> getTitle();
			}
			if($event ->city_id && $city = Engine_Api::_() -> getItem('user_location', $event ->city_id))
			{
				$cityName = $city -> getTitle();
			}
			$fullAddress = '';
			if($cityName)
			{
				$fullAddress .= $cityName;
			}
			
			if($provinceName && $fullAddress)
			{
				$fullAddress .= ', '.$provinceName;
			}
			else if($provinceName)
			{
				$fullAddress .= $provinceName;
			}
			
			if($countryName && $fullAddress)
			{
				$fullAddress .= ', '.$countryName;
			}
			else if($countryName)
			{
				$fullAddress .= $countryName;
			}
			$this -> view -> fullAddress = $fullAddress;
		}
	}

}
