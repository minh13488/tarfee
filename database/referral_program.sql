INSERT IGNORE INTO `engine4_core_menuitems` (`name`, `module`, `label`, `plugin`, `params`, `menu`, `submenu`, `order`) VALUES
('core_admin_main_settings_referral', 'user', 'Referral Program Settings', '', '{"route":"admin_default","module":"user","controller":"referral-settings","action":"global"}', 'core_admin_main_settings', '', 999);

INSERT IGNORE INTO `engine4_core_menuitems` (`name`, `module`, `label`, `plugin`, `params`, `menu`, `submenu`, `order`) VALUES
('referral_admin_main_registeredusers', 'user', 'Registered Users', '', '{"route":"admin_default","module":"user","controller":"registered-users","action":"index"}', 'referral_admin_main', '', 5),
('referral_admin_main_generatedusers', 'user', 'Users Generated Codes', '', '{"route":"admin_default","module":"user","controller":"users-generated-codes","action":"index"}', 'referral_admin_main', '', 4),
('referral_admin_main_referralcodes', 'user', 'Referral Codes', '', '{"route":"admin_default","module":"user","controller":"referral-codes","action":"generated"}', 'referral_admin_main', '', 3),
('referral_admin_main_levelsettings', 'user', 'Member Level Settings', '', '{"route":"admin_default","module":"user","controller":"referral-settings","action":"level"}', 'referral_admin_main', '', 2),
('referral_admin_main_globalsettings', 'user', 'Global Settings', '', '{"route":"admin_default","module":"user","controller":"referral-settings","action":"global"}', 'referral_admin_main', '', 1);

usersregistered

INSERT IGNORE INTO `engine4_core_menuitems` (`name`, `module`, `label`, `plugin`, `params`, `menu`, `submenu`, `order`) VALUES
('user_settings_referral', 'user', 'Referral Code Generation', 'User_Plugin_Menus', '{"route":"user_extended", "controller":"settings", "action":"referral"}', 'user_settings', '', 999);