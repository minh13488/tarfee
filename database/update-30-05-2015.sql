-- --------------------------------------------------------

-- Table structure for table `engine4_user_itemviews`
--
CREATE TABLE IF NOT EXISTS `engine4_user_itemviews` (
`itemview_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
`user_id` int(11) unsigned NOT NULL,
`item_id` int(11) unsigned NOT NULL,
`item_type` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
PRIMARY KEY (`itemview_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

--
-- Table structure for table `engine4_user_photos`
--
CREATE TABLE IF NOT EXISTS `engine4_user_photos` (
	`photo_id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
	`file_id` INT(11) UNSIGNED NOT NULL,
	`title` VARCHAR(128)  NULL COLLATE 'utf8_unicode_ci',
	`description` MEDIUMTEXT NULL COLLATE 'utf8_unicode_ci',
	`creation_date` DATETIME NOT NULL,
	`modified_date` DATETIME NOT NULL,
	`item_id` int(11) unsigned NOT NULL,
	`item_type` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
	PRIMARY KEY (`photo_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE utf8_unicode_ci ;

