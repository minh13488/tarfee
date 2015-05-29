ALTER TABLE `engine4_users` ADD `cover_photo` INT(11) NOT NULL AFTER `skype`;
ALTER TABLE `engine4_users` ADD `cover_top` INT(11) NOT NULL AFTER `cover_photo`;

ALTER TABLE `engine4_profilecompleteness_weights` CHANGE `field_id` `field_id` INT(11) NOT NULL;
INSERT IGNORE INTO `engine4_profilecompleteness_weights` (`type_id`, `field_id`, `weight`) VALUES (0,-1,2);
INSERT IGNORE INTO `engine4_profilecompleteness_weights` (`type_id`, `field_id`, `weight`) VALUES (0,-2,2);
INSERT IGNORE INTO `engine4_profilecompleteness_weights` (`type_id`, `field_id`, `weight`) VALUES (0,-3,2);