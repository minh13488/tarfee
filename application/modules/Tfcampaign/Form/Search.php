<?php
class Tfcampaign_Form_Search extends Engine_Form
{
	public function init()
	{
		$this -> setAttribs(array(
			'class' => 'global_form_box search_form',
			'id' => 'filter_form'
		)) -> setMethod('GET');

		$this -> addElement('Text', 'title', array(
			'label' => 'Search Campaigns',
			'placeholder' => Zend_Registry::get('Zend_Translate') -> _('Search Campaigns'),
		));

		$sportCattable = Engine_Api::_() -> getDbtable('sportcategories', 'user');
		$node = $sportCattable -> getNode(0);
		$categories = $node -> getChilren();
		$sport_categories[0] = '';
		foreach ($categories as $category)
		{
			$sport_categories[$category -> getIdentity()] = $category -> getTitle();
		}
		$this -> addElement('Select', 'category_id', array(
			'label' => 'Sport Category',
			'multiOptions' => $sport_categories,
			'onchange' => 'subCategories()',
		));

		$arrAge = array();
		$arrAge[] = "";
		for ($i = 1; $i <= 100; $i++)
		{
			$arrAge[] = $i;
		}

		$this -> addElement('Select', 'from_age', array(
			'label' => 'From Age',
			'multiOptions' => $arrAge,
		));

		$this -> addElement('Select', 'to_age', array(
			'label' => 'To Age',
			'multiOptions' => $arrAge,
		));

		$gender = new Engine_Form_Element_Select('gender');
		$gender -> setLabel("Gender");
		$gender -> setAllowEmpty(false);
		$gender -> setMultiOptions(array(
			'0' => '',
			'1' => 'Male',
			'2' => 'Female'
		));
		$gender -> setRequired(true);
		$this -> addElement($gender);

		$countriesAssoc = Engine_Api::_() -> getDbTable('locations', 'user') -> getLocationsAssoc(0);
		$countriesAssoc = array('0' => '') + $countriesAssoc;

		$this -> addElement('Select', 'country_id', array(
			'label' => 'Country',
			'multiOptions' => $countriesAssoc,
		));

		$this -> addElement('Select', 'province_id', array('label' => 'Province/State', ));

		$this -> addElement('Select', 'city_id', array('label' => 'City', ));

		$positions = $sportCattable -> getMultiOptions('--', '', FALSE);
		$this -> addElement('Select', 'position_id', array(
			'label' => 'Position',
			'multiOptions' => $positions,
		));

		$this -> addElement('Button', 'search', array(
			'label' => 'Search',
			'type' => 'submit',
			'ignore' => true,
		));

		$this -> loadDefaultDecorators();
	}

}
