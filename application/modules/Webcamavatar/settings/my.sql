INSERT IGNORE INTO `engine4_core_modules` (`name`, `title`, `description`, `version`, `enabled`, `type`) VALUES  ('webcamavatar', 'Webcamavatar', 'Webcam  Avatar Module', '4.01', 1, 'extra') ;
INSERT IGNORE INTO `engine4_user_signup` (`class`,`order`,`enable`) VALUES('Webcamavatar_Plugin_Signup_Photo',3,1);
UPDATE `engine4_user_signup` set enable= 0 where class = 'User_Plugin_Signup_Photo';

