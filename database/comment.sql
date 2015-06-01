-- 31/05/2015
CREATE TABLE IF NOT EXISTS `engine4_yncomment_unsures` (
  `unsure_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `resource_type` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `resource_id` int(11) unsigned NOT NULL,
  `poster_type` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `poster_id` int(11) unsigned NOT NULL,
  `creation_date` datetime NOT NULL,
  PRIMARY KEY (`unsure_id`),
  KEY `resource_type` (`resource_type`,`resource_id`),
  KEY `poster_type` (`poster_type`,`poster_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;