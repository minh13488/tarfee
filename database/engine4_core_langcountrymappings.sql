-- phpMyAdmin SQL Dump
-- version 4.4.4
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Aug 27, 2015 at 04:22 PM
-- Server version: 5.6.24
-- PHP Version: 5.5.24

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `tarfee`
--

-- --------------------------------------------------------

--
-- Table structure for table `engine4_core_langcountrymappings`
--

CREATE TABLE IF NOT EXISTS `engine4_core_langcountrymappings` (
  `langcountrymapping_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `country_code` varchar(5) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `country_name` varchar(32) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `language_code` varchar(5) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `language_name` varchar(32) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`langcountrymapping_id`)
) ENGINE=MyISAM AUTO_INCREMENT=23 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `engine4_core_langcountrymappings`
--

INSERT INTO `engine4_core_langcountrymappings` (`langcountrymapping_id`, `country_code`, `country_name`, `language_code`, `language_name`) VALUES
(1, 'AR', 'Argentina', 'es', 'Spanish'),
(2, 'CU', 'Cuba', 'es', 'Spanish'),
(3, 'BO', 'Bolivia', 'es', 'Spanish'),
(4, 'CL', 'Chile', 'es', 'Spanish'),
(5, 'CO', 'Colombia', 'es', 'Spanish'),
(6, 'CR', 'Costa Rica', 'es', 'Spanish'),
(7, 'DO', 'Dominican Republic', 'es', 'Spanish'),
(8, 'EC', 'Ecuador', 'es', 'Spanish'),
(9, 'GT', 'Guatemala', 'es', 'Spanish'),
(10, 'HN', 'Honduras', 'es', 'Spanish'),
(11, 'MX', 'Mexico', 'es', 'Spanish'),
(12, 'NI', 'Nicaragua', 'es', 'Spanish'),
(13, 'PA', 'Panama', 'es', 'Spanish'),
(14, 'PE', 'Peru', 'es', 'Spanish'),
(15, 'PR', 'Puerto Rico', 'es', 'Spanish'),
(16, 'PY', 'Paraguay', 'es', 'Spanish'),
(17, 'SV', 'El Salvador', 'es', 'Spanish'),
(18, 'UY', 'Uruguay', 'es', 'Spanish'),
(19, 'VE', 'Venezuela', 'es', 'Spanish'),
(20, 'HT', 'Haiti', 'es', 'Spanish');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `engine4_core_langcountrymappings`
--
ALTER TABLE `engine4_core_langcountrymappings`
  ADD PRIMARY KEY (`langcountrymapping_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `engine4_core_langcountrymappings`
--
ALTER TABLE `engine4_core_langcountrymappings`
  MODIFY `langcountrymapping_id` int(11) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=23;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
