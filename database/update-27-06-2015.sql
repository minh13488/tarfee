-- --------------------------------------------------------
--
-- Dumping data for table `engine4_core_mailtemplates`
--

INSERT IGNORE INTO `engine4_core_mailtemplates` (`type`, `module`, `vars`) VALUES
('user_email_trial_confirm', 'user', '[link],[plan]');

# user_email_trial_confirm
"_EMAIL_USER_EMAIL_TRIAL_CONFIRM_TITLE";"Trial Plan Confirmation"
"_EMAIL_USER_EMAIL_TRIAL_CONFIRM_DESCRIPTION";"This is the email that gets sent when user choose to use trial plan."
"_EMAIL_USER_EMAIL_TRIAL_CONFIRM_SUBJECT";"Trial Plan Confirmation"
"_EMAIL_USER_EMAIL_TRIAL_CONFIRM_BODY";"[header]

You are using trial of [plan].
Please confirm by clicking the link below:
[link]

[footer]"

-- --------------------------------------------------------

--
-- Table structure for table `engine4_user_trialplans`
--

CREATE TABLE IF NOT EXISTS `engine4_user_trialplans` (
  `trialplan_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL,
  `package_id` int(11) unsigned NOT NULL,
  `level_id` INT(11) unsigned NOT NULL
  `active` TINYINT(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`trialplan_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

ALTER TABLE `engine4_payment_packages` ADD `discount` INT(3) NOT NULL DEFAULT '0' AFTER `trial_duration_type`;
ALTER TABLE `engine4_user_trialplans` ADD `active` TINYINT(1) NOT NULL DEFAULT '1';
ALTER TABLE `engine4_user_trialplans` ADD `level_id` INT(11) unsigned NOT NULL;

ALTER TABLE `engine4_invites` ADD `discount_used` TINYINT(1) NOT NULL DEFAULT '0' AFTER `new_user_id`;
ALTER TABLE `engine4_invites` ADD `active` TINYINT(1) NOT NULL DEFAULT '1' AFTER `discount_used`;


-- --------------------------------------------------------
--
-- Dumping data for table `engine4_core_mailtemplates`
--

INSERT IGNORE INTO `engine4_core_mailtemplates` (`type`, `module`, `vars`) VALUES
('user_email_to_friend', 'user', '[host],[email],[date],[sender_title],[sender_link],[sender_photo],[message]');

# user_email_to_friend
"_EMAIL_USER_EMAIL_TO_FRIEND_TITLE";"Email To Friend"
"_EMAIL_USER_EMAIL_TO_FRIEND_DESCRIPTION";"This is the email that gets sent when user wants to send message to friends."
"_EMAIL_USER_EMAIL_TO_FRIEND_SUBJECT";"You have received a message from your friend [sender_title]"
"_EMAIL_USER_EMAIL_TO_FRIEND_BODY";"[header]

[message]

Check out this at
http://[host]

[footer]"