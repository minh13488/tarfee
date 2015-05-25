<?php echo $this->partial('_business_listing.tpl', 'ynbusinesspages', array(
    'paginator' => $this -> paginator,
    'businessIds' => $this -> businessIds,
    'idName' => 'business-claim',
    'idPrefix' => 'BusinessClaim',
    'isClaim' => true,
    'mode_enabled' => $this -> mode_enabled,
    'formValues' => $this->formValues
));
?>