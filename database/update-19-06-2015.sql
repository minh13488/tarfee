CREATE TABLE IF NOT EXISTS `engine4_user_signup1` (
`signup_id` int(11) unsigned NOT NULL,
  `class` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `order` smallint(6) NOT NULL DEFAULT '999',
  `enable` smallint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `engine4_user_signup1`
--

INSERT INTO `engine4_user_signup1` (`signup_id`, `class`, `order`, `enable`) VALUES
(1, 'User_Plugin_Signup1_Step1', 1, 1),
(2, 'User_Plugin_Signup1_Step2', 2, 1),
(3, 'User_Plugin_Signup1_Account', 3, 1),
(4, 'User_Plugin_Signup1_Fields', 4, 1),
(5, 'Payment_Plugin_Signup1_Subscription', 5, 1);
