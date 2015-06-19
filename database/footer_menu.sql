INSERT IGNORE INTO `engine4_core_menuitems` (`name`, `module`, `label`, `plugin`, `params`, `menu`, `submenu`, `enabled`, `custom`, `order`) VALUES
('socialconnect_admin_categories', 'social-connect', 'Manage Categories', NULL, '{"route":"admin_default","module":"social-connect","controller":"settings","action":"categories"}', 'socialconnect_admin', NULL, 1, 0, 3),
('socialconnect_admin_pages', 'social-connect', 'Manage Pages', NULL, '{"route":"admin_default","module":"social-connect","controller":"settings","action":"pages"}', 'socialconnect_admin', NULL, 1, 0, 4);

DROP TABLE IF EXISTS `engine4_socialconnect_categories`;
CREATE TABLE IF NOT EXISTS `engine4_socialconnect_categories` (
  `category_id` int(11) unsigned NOT NULL auto_increment,
  `user_id` int(11) unsigned NOT NULL,
  `category_name` varchar(128) NOT NULL,
  `order` smallint(6) NOT NULL DEFAULT '0',
  PRIMARY KEY  (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ;

CREATE TABLE IF NOT EXISTS `engine4_socialconnect_pages` (
`page_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
`title` varchar(200) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
`content` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
`category_id` int(11) unsigned NOT NULL,
`creation_date` datetime NOT NULL,
`order` smallint(6) NOT NULL DEFAULT '0',
PRIMARY KEY (`page_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;