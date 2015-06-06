INSERT IGNORE INTO `engine4_core_menuitems` (`name`, `module`, `label`, `plugin`, `params`, `menu`, `submenu`, `order`) VALUES
('core_admin_main_plugins_language', 'user', 'Languages Settings', '', '{"route":"admin_default","module":"user","controller":"languages","action":"manage"}', 'core_admin_main_settings', '', 999);


-- --------------------------------------------------------

--
-- Table structure for table `engine4_user_languages`
--

CREATE TABLE IF NOT EXISTS `engine4_user_languages` (
  `language_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` text NOT NULL,
  PRIMARY KEY (`language_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

-- Table structure for table `engine4_user_languagemappings`
--

CREATE TABLE IF NOT EXISTS `engine4_user_languagemappings` (
	`languagemapping_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
	`language_id` int(11) unsigned NOT NULL,
	`item_id` int(11) unsigned NOT NULL,
	`item_type` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
	PRIMARY KEY (`languagemapping_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ;