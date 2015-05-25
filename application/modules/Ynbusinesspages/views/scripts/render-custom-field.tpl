<?php $customFields = $this->category->getCustomFieldsList();?>

<?php foreach ($customFields as $field) : ?>
<li class="business-customField_<?php echo $field->field_id?>"><?php echo $this->business->getFieldValue($field->field_id)?></li>
<?php endforeach;?>