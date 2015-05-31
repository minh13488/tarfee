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