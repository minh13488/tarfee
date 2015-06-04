ALTER TABLE `engine4_event_events` ADD `type_id` INT(11) NOT NULL DEFAULT '0' AFTER `title`;
ALTER TABLE `engine4_event_events` ADD `registration_type` INT(11) NOT NULL DEFAULT '0' AFTER `price`;

INSERT IGNORE INTO `engine4_core_menuitems` (`name`, `module`, `label`, `plugin`, `params`, `menu`, `submenu`, `enabled`, `custom`, `order`) VALUES 
('ynevent_main_new', 'ynevent', 'New Events', '', '{"route":"event_new"}', 'ynevent_main', '', 1, 0, 2),
('ynevent_main_following', 'ynevent', 'My Following', 'Ynevent_Plugin_Menus', '{"route":"event_following"}', 'ynevent_main', '', 1, 0, 4);