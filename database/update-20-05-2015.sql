-- --------------------------------------------------------

--
-- Table structure for table `engine4_user_libraries`
--

CREATE TABLE IF NOT EXISTS `engine4_user_libraries` (
  `library_id` int(11) unsigned NOT NULL auto_increment,
  `photo_id` INT(11) NOT NULL DEFAULT '0',
  `title` varchar(100) NOT NULL,
  `description` text NOT NULL,
  `parent_id` int(11) unsigned DEFAULT NULL,
  `level` int(11) unsigned NOT NULL DEFAULT '0',
  `user_id` int(11) NOT NULL,
  `creation_date` datetime NOT NULL,
  `modified_date` datetime NOT NULL,
  PRIMARY KEY  (`library_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_user_mappings`
--

CREATE TABLE IF NOT EXISTS `engine4_user_mappings` (
`mapping_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
`user_id` int(11) unsigned NOT NULL,
`owner_id` int(11) unsigned NOT NULL,
`owner_type` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
`item_id` int(11) unsigned NOT NULL,
`item_type` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
`creation_date` datetime NOT NULL,
`modified_date` datetime DEFAULT NULL,
PRIMARY KEY (`mapping_id`,`owner_id`,`item_id`),
KEY `owner_id` (`owner_id`,`item_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ;