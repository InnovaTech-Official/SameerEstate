-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 07, 2025 at 10:49 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `sameer`
--

-- --------------------------------------------------------

--
-- Table structure for table `accounts`
--

CREATE TABLE `accounts` (
  `id` int(11) NOT NULL,
  `sub_account_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `accounts`
--

INSERT INTO `accounts` (`id`, `sub_account_id`, `name`) VALUES
(1, 1, 'Bank'),
(2, 1, 'Cheque'),
(3, 1, 'Cash'),
(4, 1, 'Online'),
(5, 30, 'Zahid Ghori'),
(6, 24, 'Electricity');

-- --------------------------------------------------------

--
-- Table structure for table `accounts_head`
--

CREATE TABLE `accounts_head` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `accounts_head`
--

INSERT INTO `accounts_head` (`id`, `name`) VALUES
(1, 'Assets'),
(2, 'Liabilities'),
(3, 'Equity'),
(4, 'Income'),
(5, 'Expenses');

-- --------------------------------------------------------

--
-- Table structure for table `activity_log`
--

CREATE TABLE `activity_log` (
  `id` int(11) NOT NULL,
  `admin_id` int(11) NOT NULL,
  `activity` varchar(255) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `areas`
--

CREATE TABLE `areas` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `city_id` int(11) DEFAULT NULL,
  `status` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `areas`
--

INSERT INTO `areas` (`id`, `name`, `city_id`, `status`, `created_at`) VALUES
(12, 'SADI', NULL, 1, '2025-02-14 14:28:27'),
(13, 'GULSHAN', NULL, 1, '2025-02-14 14:28:37'),
(15, 'Sab', NULL, 1, '2025-02-19 16:50:03'),
(19, 'Soldier Bazar 02', NULL, 1, '2025-02-27 08:46:41'),
(20, 'Soldier Bazar 03', NULL, 1, '2025-02-27 09:06:59'),
(21, 'Parsi Colony', NULL, 1, '2025-02-27 09:11:05'),
(22, 'Gurumandir', NULL, 1, '2025-02-27 09:20:12'),
(23, 'Saddar', NULL, 1, '2025-02-27 11:03:58'),
(24, 'Amil Colony', NULL, 1, '2025-02-28 16:30:23'),
(25, 'Soldier Bazar 01', NULL, 1, '2025-03-02 16:21:39'),
(26, 'Garden East', NULL, 1, '2025-03-06 11:39:41'),
(27, 'Patel Para', NULL, 1, '2025-03-07 09:27:40'),
(28, 'Sarjani', NULL, 1, '2025-03-11 09:43:34'),
(29, 'Punjab Town', NULL, 1, '2025-03-13 17:32:42'),
(30, 'Hasrat Mohani', NULL, 1, '2025-03-14 17:00:47'),
(31, 'Garden', NULL, 1, '2025-03-14 18:26:08'),
(32, 'Tariq Road', NULL, 1, '2025-03-15 07:38:29'),
(33, 'D.H.A', NULL, 1, '2025-03-15 07:41:52'),
(34, 'Clifton', NULL, 1, '2025-03-15 07:44:57'),
(35, 'Katchi Para', NULL, 1, '2025-03-15 10:10:33'),
(36, 'Kharadar', NULL, 1, '2025-03-18 09:45:34'),
(37, 'Kharadar', NULL, 1, '2025-03-18 09:47:53'),
(38, 'Light House', NULL, 1, '2025-03-18 17:19:56'),
(39, 'Light House', NULL, 1, '2025-03-18 17:24:26'),
(40, 'LYARI', NULL, 1, '2025-03-18 17:51:30'),
(41, 'Jamshed Road', NULL, 1, '2025-03-23 07:28:23'),
(42, 'Garden West', NULL, 1, '2025-03-24 17:33:16'),
(43, 'Britto Road', NULL, 1, '2025-03-24 17:38:29'),
(44, 'Lines Area', NULL, 1, '2025-03-24 17:51:06'),
(45, 'Nazimabad', NULL, 1, '2025-04-07 12:52:57'),
(46, 'PECHS', NULL, 1, '2025-04-07 14:35:08'),
(47, 'Pakola', NULL, 1, '2025-04-07 14:37:23'),
(48, 'Kachi Para', NULL, 1, '2025-05-12 12:20:35'),
(49, 'PostGuard', NULL, 1, '2025-06-03 08:47:14');

-- --------------------------------------------------------

--
-- Table structure for table `attendance`
--

CREATE TABLE `attendance` (
  `id` int(11) NOT NULL,
  `employee_id` int(11) NOT NULL,
  `check_in_time` datetime DEFAULT NULL,
  `check_out_time` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `attendance_settings`
--

CREATE TABLE `attendance_settings` (
  `id` int(11) NOT NULL,
  `check_in_start` time NOT NULL DEFAULT '08:00:00',
  `check_in_end` time NOT NULL DEFAULT '17:00:00',
  `late_after` time NOT NULL DEFAULT '09:00:00',
  `absent_after` time NOT NULL DEFAULT '00:00:00',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `bank`
--

CREATE TABLE `bank` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `bank`
--

INSERT INTO `bank` (`id`, `name`, `created_at`) VALUES
(1, 'Meezan', '2025-06-06 11:45:27'),
(2, 'Allied Bank Limited', '2025-06-06 12:58:42'),
(3, 'Bank Al Habib', '2025-06-06 12:58:56');

-- --------------------------------------------------------

--
-- Table structure for table `bank_info`
--

CREATE TABLE `bank_info` (
  `id` int(11) NOT NULL,
  `bank_name` varchar(255) NOT NULL,
  `branch_name` varchar(255) DEFAULT NULL,
  `branch_code` varchar(50) DEFAULT NULL,
  `account_number` varchar(50) NOT NULL,
  `account_title` varchar(255) NOT NULL,
  `iban` varchar(50) DEFAULT NULL,
  `swift_code` varchar(50) DEFAULT NULL,
  `bank_address` text DEFAULT NULL,
  `contact_person` varchar(255) DEFAULT NULL,
  `contact_number` varchar(50) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `bank_info`
--

INSERT INTO `bank_info` (`id`, `bank_name`, `branch_name`, `branch_code`, `account_number`, `account_title`, `iban`, `swift_code`, `bank_address`, `contact_person`, `contact_number`, `email`, `created_at`, `updated_at`) VALUES
(1, 'First National Bank', '', '', '46546868468', 'GGG', '', '', '', '', '', '', '2025-02-28 22:12:16', '2025-02-28 22:12:16');

-- --------------------------------------------------------

--
-- Table structure for table `casts`
--

CREATE TABLE `casts` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `status` enum('Active','Inactive') DEFAULT 'Active',
  `created_by` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `casts`
--

INSERT INTO `casts` (`id`, `name`, `status`, `created_by`, `created_at`) VALUES
(1, 'Memon', 'Active', NULL, '2025-02-16 16:35:58'),
(2, 'Jutt', 'Active', NULL, '2025-02-16 16:35:58'),
(3, 'Khan', 'Active', NULL, '2025-02-16 16:36:15'),
(9, 'Khoja', 'Active', NULL, '2025-02-27 08:45:35'),
(10, 'Ismaili', 'Active', NULL, '2025-02-27 09:54:42'),
(11, 'batwa memon', 'Active', NULL, '2025-02-27 10:08:16'),
(12, 'None', 'Active', NULL, '2025-02-27 11:03:14'),
(13, 'Kachi Sindhi', 'Active', NULL, '2025-03-02 16:19:49'),
(14, 'Syed', 'Active', NULL, '2025-03-11 09:42:49'),
(15, 'Shia', 'Active', NULL, '2025-03-14 18:28:20'),
(16, 'Bori', 'Active', NULL, '2025-03-16 11:54:51');

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`) VALUES
(52, 'PENDING'),
(54, 'addkarnewcat'),
(59, 'Flat'),
(61, 'Shop'),
(62, 'Plot'),
(63, 'Flat-GW'),
(64, 'Flat-GW');

-- --------------------------------------------------------

--
-- Table structure for table `cell_no`
--

CREATE TABLE `cell_no` (
  `id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `cell_no` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `cell_no`
--

INSERT INTO `cell_no` (`id`, `customer_id`, `cell_no`) VALUES
(1, 32, '03333111470'),
(2, 32, '03307050555'),
(3, 33, '03047451070'),
(4, 33, '8765'),
(5, 33, '87654'),
(6, 37, '03343655662'),
(7, 38, '03332172267'),
(8, 39, '03333384243'),
(9, 42, '03002804586'),
(10, 45, '03319255794'),
(11, 46, '03333968859'),
(12, 47, '03332018231'),
(13, 48, '03323649634'),
(14, 49, '03002300134'),
(15, 50, '03002138492'),
(16, 51, '03332249349'),
(17, 52, '03352220169'),
(18, 53, '03012312419'),
(19, 54, '03352440053'),
(20, 55, '03248267130'),
(21, 56, '03352472725'),
(22, 57, '03478125615'),
(23, 58, '03212443111'),
(24, 58, '03332443111'),
(25, 59, '03233001212'),
(26, 59, '03212993624'),
(27, 65, '03218277245'),
(28, 66, '03114611255'),
(29, 67, '03312897538'),
(30, 68, '03202113882'),
(31, 69, '03142469517'),
(32, 70, '03223829790'),
(33, 71, '03456177919'),
(34, 72, '03343419332'),
(35, 73, '03313449224'),
(36, 73, '03433815941'),
(37, 74, '03003956394'),
(38, 75, '03332246075'),
(39, 76, '03415489779'),
(40, 77, '03131171183'),
(41, 78, '03100027722'),
(42, 79, '03442997448'),
(43, 80, '03353241660'),
(44, 81, '03232425637'),
(45, 82, '03002477584'),
(46, 82, '03072343453'),
(47, 83, '03122991305'),
(48, 84, '03272040536'),
(49, 85, '03111292102'),
(50, 86, '03339282024'),
(51, 87, '03373332396'),
(52, 88, '03323449784'),
(53, 88, '03002214335'),
(54, 89, '03360818658'),
(55, 90, '03193529822'),
(56, 91, '03212741177'),
(57, 92, '03222385310'),
(58, 93, '03201298532'),
(59, 94, '03002235627'),
(60, 95, '03472053530'),
(61, 96, '03152746040'),
(62, 97, '03242072364'),
(63, 98, '03348648846'),
(64, 99, '03113252979'),
(65, 100, '03003693051'),
(66, 101, '03222292231'),
(67, 102, '03212993471'),
(68, 103, '03008313085'),
(69, 103, '03158313085'),
(70, 104, '03218941519'),
(71, 105, '03228282567'),
(72, 106, '03152386940'),
(73, 107, '03452490358'),
(74, 108, '03130312124'),
(75, 109, '03442200676'),
(76, 110, '03323594582'),
(77, 111, '03212587564'),
(78, 112, '03223345882'),
(79, 113, '03363493712'),
(80, 114, '03363408530'),
(81, 115, '03152800738'),
(82, 116, '03313026676'),
(83, 117, '03303677764'),
(84, 118, '03162627842'),
(85, 119, '03182748027'),
(86, 120, '03052416535'),
(87, 121, '03092448370'),
(88, 122, '03152890918'),
(89, 123, '+96895385240'),
(90, 124, '03002545060'),
(91, 125, '03332395636'),
(92, 126, '03331664656'),
(93, 127, '03312235031'),
(94, 128, '03229783566'),
(95, 129, '03232703586'),
(96, 130, '03002279264'),
(97, 131, '03243298851'),
(98, 132, '03332318882'),
(99, 133, '03312684742'),
(100, 134, '03343067928'),
(101, 135, '03408385044'),
(102, 136, '03312227323'),
(103, 137, '03212464657'),
(104, 138, '03199238034'),
(105, 139, '03351133714'),
(106, 140, '03335207272'),
(107, 141, '03312029010'),
(108, 141, '03312138780'),
(109, 142, '03150233720'),
(110, 143, '03039238878'),
(137, 144, '03323013822'),
(138, 145, '03312469573'),
(139, 146, '03002470330'),
(140, 147, '03453265661'),
(141, 148, '03432926921'),
(142, 149, '03332354680'),
(143, 150, '03343000830'),
(144, 151, '03032790079'),
(145, 151, '03242576950'),
(146, 152, '03337223579'),
(147, 153, '03453131616'),
(148, 154, '03122491505'),
(149, 155, '03002248418'),
(150, 156, '03360073333'),
(151, 157, '03232161883'),
(152, 157, '03212042073'),
(153, 158, '03121392234'),
(154, 159, '03312535195'),
(155, 160, '03362646815'),
(156, 161, '03312395338'),
(157, 162, '03432796487'),
(158, 163, '03007019491'),
(159, 164, '03343471353'),
(160, 165, '03222329123'),
(161, 166, '03323359705'),
(162, 167, '03456187962'),
(163, 168, '03312688003'),
(164, 169, '03152617682'),
(165, 170, '03172543124'),
(166, 172, '03343952616'),
(167, 173, '03007051782'),
(168, 174, '03323898787'),
(169, 175, '03002024530'),
(170, 176, '03222640545'),
(171, 177, '03322827036'),
(172, 178, '03163385227'),
(173, 179, '032189604121'),
(174, 180, '03002289003'),
(175, 181, '03323766292'),
(176, 182, '03053996450'),
(177, 183, '03009211346'),
(178, 184, '03002415980'),
(179, 185, '03191676124'),
(180, 186, '03222024324'),
(181, 186, '03003941719'),
(182, 187, '03128361315'),
(183, 188, '03012219456'),
(184, 189, '03337819381'),
(185, 190, '03222717089'),
(186, 190, '03367887463'),
(187, 190, '03362530679'),
(188, 191, '03022514999'),
(189, 192, '03368059850'),
(190, 193, '03022611786'),
(191, 194, '03332297828'),
(192, 195, '03346264200'),
(193, 195, '03202086232'),
(194, 196, '03350035589'),
(195, 197, '03373113278'),
(196, 198, '03009264064'),
(197, 199, '03009277527'),
(198, 199, '03121113780'),
(199, 200, '03159229915'),
(200, 201, '03202021771'),
(201, 202, '03333181435'),
(202, 203, '03132325595'),
(203, 203, '03132525595'),
(204, 204, '03452057740'),
(205, 205, '03332401114'),
(206, 206, '03013718684'),
(207, 207, '03394013808'),
(208, 208, '03062669066'),
(209, 209, '03333561281'),
(210, 210, '03212967725'),
(211, 211, '03362772778'),
(212, 212, '03343121001'),
(213, 213, '03232179963'),
(214, 214, '03322123409'),
(215, 215, '02132220429'),
(216, 216, '03232480492'),
(217, 217, '03343907637'),
(218, 218, '03342894926'),
(219, 219, '03003490490'),
(220, 221, '03233367706'),
(221, 222, '03312885375'),
(222, 223, '03441100767'),
(223, 224, '03368265555'),
(224, 225, '03242260883'),
(225, 226, '03318796705'),
(226, 227, '03323479708'),
(227, 228, '03452321847'),
(228, 228, '03213974162'),
(229, 229, '03162585647'),
(230, 230, '03312066839'),
(231, 231, '03332199255'),
(232, 232, '03002134441'),
(233, 233, '03228456736'),
(234, 234, '03333799865'),
(235, 235, '03212734285'),
(236, 235, '03131105050'),
(237, 236, '03352811713'),
(238, 236, '03009256153'),
(239, 237, '03343521445'),
(240, 238, '03162365511'),
(241, 239, '03312090746'),
(242, 240, '03308413978'),
(243, 241, '03333737041'),
(244, 242, '03032300923'),
(245, 244, '033301010101'),
(246, 245, '03113566535'),
(247, 249, '03459490089'),
(248, 249, '03312829571'),
(249, 250, '03158498386'),
(250, 251, '03002670058'),
(251, 252, '03032883124'),
(252, 253, '03362075386'),
(253, 254, '03312913433'),
(254, 256, '03202151576'),
(255, 257, '03333161171'),
(256, 258, '03172000582'),
(257, 259, '03240425368'),
(258, 260, '03002189756'),
(259, 261, '03243171970'),
(260, 262, '03018250870'),
(261, 263, '03312070438'),
(262, 264, '03362265542'),
(263, 265, '03192414502'),
(264, 266, '03003977911'),
(265, 267, '03212869522'),
(266, 268, '03212286534'),
(267, 269, '03343808117'),
(268, 270, '03092382102'),
(269, 271, '03343734568'),
(270, 272, '03422518056'),
(271, 273, '03164743406'),
(272, 274, '03008202189'),
(273, 275, '03322564266'),
(274, 276, '03352288992'),
(275, 277, '03212070731'),
(276, 278, '03128924553'),
(277, 279, '03196839432'),
(278, 280, '03377097655'),
(279, 281, '03222101342'),
(280, 282, '03422114418'),
(281, 283, '03218753385'),
(282, 284, '03218973486'),
(283, 285, '03222728094'),
(285, 292, '033379344076'),
(286, 293, '03353209142'),
(287, 294, '03333435056');

-- --------------------------------------------------------

--
-- Table structure for table `cities`
--

CREATE TABLE `cities` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `country_id` int(11) DEFAULT NULL,
  `status` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `cities`
--

INSERT INTO `cities` (`id`, `name`, `country_id`, `status`, `created_at`) VALUES
(10, 'SBA', NULL, 1, '2025-02-13 10:15:24'),
(14, 'Karachi', NULL, 1, '2025-02-14 14:29:16'),
(15, 'Hala', NULL, 1, '2025-02-14 14:29:26'),
(16, 'Hyd', NULL, 1, '2025-02-14 14:29:38'),
(17, 'SB', 14, 1, '2025-02-19 16:53:23'),
(18, 'hala', 14, 1, '2025-02-19 17:42:29'),
(22, 'addkarbhai', NULL, 1, '2025-02-21 15:32:17'),
(23, 'sk', NULL, 1, '2025-02-21 17:22:11'),
(24, 'Quetta', NULL, 1, '2025-03-16 11:55:36');

-- --------------------------------------------------------

--
-- Table structure for table `coa`
--

CREATE TABLE `coa` (
  `id` int(11) NOT NULL,
  `account_name` varchar(255) NOT NULL,
  `sub_account_name` varchar(255) DEFAULT NULL,
  `bank_name` varchar(255) DEFAULT NULL,
  `mode_of_payment` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `company_settings`
--

CREATE TABLE `company_settings` (
  `id` int(11) NOT NULL,
  `company_name` varchar(100) NOT NULL,
  `company_logo` varchar(255) DEFAULT NULL,
  `address_line1` varchar(100) DEFAULT NULL,
  `address_line2` varchar(100) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `state` varchar(50) DEFAULT NULL,
  `postal_code` varchar(20) DEFAULT NULL,
  `country` varchar(50) DEFAULT NULL,
  `phone_1` varchar(20) DEFAULT NULL,
  `phone_2` varchar(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `website` varchar(100) DEFAULT NULL,
  `tax_id` varchar(50) DEFAULT NULL,
  `registration_number` varchar(50) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `countries`
--

CREATE TABLE `countries` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `code` varchar(3) DEFAULT NULL,
  `status` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `countries`
--

INSERT INTO `countries` (`id`, `name`, `code`, `status`, `created_at`) VALUES
(14, 'Pakistan', NULL, 1, '2025-02-14 14:29:48'),
(15, 'Ind', NULL, 1, '2025-02-14 14:29:56'),
(16, 'UK', NULL, 1, '2025-02-14 14:30:12'),
(17, 'USA', NULL, 1, '2025-02-14 14:30:20'),
(23, 'UAE', NULL, 1, '2025-03-15 07:55:13');

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `id` int(11) NOT NULL,
  `lead_id` int(11) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `father` varchar(100) DEFAULT NULL,
  `cast_id` int(11) DEFAULT NULL,
  `religion_id` int(11) DEFAULT NULL,
  `marital_status_id` int(11) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `web_page` varchar(255) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `area_id` int(11) DEFAULT NULL,
  `city_id` int(11) DEFAULT NULL,
  `country_id` int(11) DEFAULT NULL,
  `cnic` varchar(20) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `star` varchar(50) DEFAULT NULL,
  `bank` varchar(100) DEFAULT NULL,
  `account_iban` varchar(50) DEFAULT NULL,
  `company` varchar(100) DEFAULT NULL,
  `department` varchar(100) DEFAULT NULL,
  `designation` varchar(100) DEFAULT NULL,
  `occupation` varchar(100) DEFAULT NULL,
  `off_address` text DEFAULT NULL,
  `work_note` text DEFAULT NULL,
  `ref_name` varchar(100) DEFAULT NULL,
  `ref_cnic` varchar(20) DEFAULT NULL,
  `ref_cell` varchar(20) DEFAULT NULL,
  `ref_note` text DEFAULT NULL,
  `photo` varchar(255) DEFAULT NULL,
  `remarks` varchar(500) NOT NULL,
  `visiting_card` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `cnic_front` varchar(255) DEFAULT NULL,
  `cnic_back` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`id`, `lead_id`, `name`, `father`, `cast_id`, `religion_id`, `marital_status_id`, `email`, `web_page`, `address`, `area_id`, `city_id`, `country_id`, `cnic`, `dob`, `star`, `bank`, `account_iban`, `company`, `department`, `designation`, `occupation`, `off_address`, `work_note`, `ref_name`, `ref_cnic`, `ref_cell`, `ref_note`, `photo`, `remarks`, `visiting_card`, `created_at`, `cnic_front`, `cnic_back`) VALUES
(32, 6, 'Ali Lilani', 'Mehboob Ali', 9, 1, NULL, 'LilaniGroups@gmail.com', NULL, 'Plot No 188/B, Flat 10 , 4th floor Zohra Garden', NULL, NULL, NULL, '4220107422221', '1983-05-11', 'Taurus', NULL, '852', 'LILANIGROUPS', 'Administration', 'CEO', '12', NULL, NULL, NULL, NULL, NULL, NULL, '67bf346e319a2.jpg', '', NULL, '2025-02-26 15:34:06', '67bf346e31b02_front.jpg', NULL),
(33, 7, 'Kaneez Fatima', 'Ali Hussain', 9, 1, 1, 'tahirafatima986@gmail.com', NULL, '204/2nd floor tayyaba homes near saylani diagnostic parsi colony karachi', 21, 14, 14, '876543567887', '1985-10-01', 'Libra', NULL, NULL, 'sameer estate', 'office', 'data records', '11', 'ghosia chowk zainabia homes', NULL, NULL, NULL, NULL, NULL, '67bf3530e3d37.jpg', '', NULL, '2025-02-26 15:37:20', '67c02dd85ffe8_front.jpeg', NULL),
(37, 7, 'Samir Raza Lilani', 'Mehboob Ali', 9, 1, 2, NULL, NULL, 'Plot no 188/B, 4th floor, Zohra Garden Soldier Bazar No 03, Near KMC Hospital.', 19, 14, 14, '4200005590367', '1977-10-17', 'Libra', 'Bank Al Habib', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '67c02a74d5ebb.png', '', NULL, '2025-02-27 09:03:48', '67c02a74d6016_front.jpg', NULL),
(38, 7, 'Mehboob Ali Lilani', 'Muhammad Ali', 9, 1, 2, NULL, NULL, NULL, 20, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '67c02b5eb3fb8.png', '', NULL, '2025-02-27 09:07:42', NULL, NULL),
(39, 7, 'Aamir Raza Lilani', 'Mehboob Ali', 9, 1, 1, NULL, NULL, NULL, 20, 14, 14, NULL, '1979-12-11', 'Sagittarius', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-02-27 09:16:45', NULL, NULL),
(42, 9, 'Imran Ismaili (Taj Terc)', NULL, 10, 1, 2, NULL, NULL, NULL, 22, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-02-27 09:55:12', NULL, NULL),
(45, 16, 'Zawar Van', NULL, 9, 1, 2, NULL, NULL, 'Roof Flat Zainabia house', 19, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-02-27 11:01:12', NULL, NULL),
(46, 9, 'Amir Shroff (Scs)', NULL, 9, 1, 2, NULL, NULL, NULL, 21, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-02-27 11:02:29', NULL, NULL),
(47, 9, 'Giyan 3 Bed 40k', NULL, 12, 2, 2, NULL, NULL, NULL, 23, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-02-27 11:04:00', NULL, NULL),
(48, 15, 'Rajab Ali (Scaff)', NULL, 9, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-02-27 11:06:49', NULL, NULL),
(49, 15, 'Inamullah', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-02-28 11:12:42', NULL, NULL),
(50, 15, 'Mr Iqbal (press wala)', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-02-28 11:13:51', NULL, NULL),
(51, 15, 'Zulfiqar Ali', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-02-28 11:15:39', NULL, NULL),
(52, 15, 'Hussain', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-02-28 11:17:09', NULL, NULL),
(53, 15, 'Sohail Bori', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-02-28 11:18:01', NULL, NULL),
(54, 15, 'Mrs Shoaib', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-02-28 11:18:55', NULL, NULL),
(55, 15, 'Haroon', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-02-28 11:21:54', NULL, NULL),
(56, 15, 'M.Riaz', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-02-28 15:16:05', NULL, NULL),
(57, 15, 'M.Khalid', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-02-28 15:17:08', NULL, NULL),
(58, 17, 'Naeem Damani', NULL, 1, 1, 2, NULL, NULL, NULL, 24, 14, 14, NULL, NULL, NULL, NULL, NULL, 'Damani Groups', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '67c1e5228f5a7.jpg', 'Best builder in town', NULL, '2025-02-28 16:32:34', NULL, NULL),
(59, 17, 'Shayad Builder Hyd', NULL, 9, 1, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Maskan Associates', NULL, NULL, NULL, 'MASKAN Associates (Khurasan Garden Site Office)', NULL, 'Sabir Ali', NULL, '0321-2993624', 'Office Staff', '67c1e6ff18812.jpg', '', NULL, '2025-02-28 16:40:31', NULL, NULL),
(65, 13, 'Abbas Ali', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-02-28 18:43:12', NULL, NULL),
(66, 13, 'Waris Hussain', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-02-28 18:43:59', NULL, NULL),
(67, 13, 'Mr Raza', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-02-28 18:44:46', NULL, NULL),
(68, 13, 'Umair', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-02-28 18:45:36', NULL, NULL),
(69, 13, 'Sanjay', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-02-28 18:46:22', NULL, NULL),
(70, 13, 'Furqan', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-02-28 18:47:15', NULL, NULL),
(71, 13, 'Zahid Hussain', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-02-28 18:49:02', NULL, NULL),
(72, 13, 'Wahab Mother', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-02-28 18:49:56', NULL, NULL),
(73, 13, 'Ali Raza', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-02-28 18:51:55', NULL, NULL),
(74, 13, 'M.Ali', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-02-28 18:52:49', NULL, NULL),
(75, 13, 'M.Hanif', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-02-28 18:53:33', NULL, NULL),
(76, 13, 'Bilal', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-02-28 18:54:23', NULL, NULL),
(77, 13, 'Imran', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-02-28 18:55:13', NULL, NULL),
(78, 13, 'Imran', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-02-28 18:56:35', NULL, NULL),
(79, 13, 'Dharminder', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-02-28 18:57:29', NULL, NULL),
(80, 13, 'Rehan', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-02-28 18:58:39', NULL, NULL),
(81, 13, 'Nadeem', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-02-28 19:00:23', NULL, NULL),
(82, 13, 'Khalid Majeed', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-02-28 19:03:45', NULL, NULL),
(83, 13, 'Asma Naveed', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-02-28 19:04:33', NULL, NULL),
(84, 13, 'Muzammil ', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-02-28 19:05:29', NULL, NULL),
(85, 13, 'Zeeshan', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-02-28 19:06:19', NULL, NULL),
(86, 13, 'Mr Lal', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-02-28 19:07:14', NULL, NULL),
(87, 11, 'Miss Farbah', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-02-28 19:08:33', NULL, NULL),
(88, 13, 'Jawaid', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-02-28 19:09:50', NULL, NULL),
(89, 13, 'Hasnain', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-02-28 19:11:13', NULL, NULL),
(90, 13, 'Prakash', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-02-28 19:12:10', NULL, NULL),
(91, 13, 'M.Wasif', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-02-28 19:12:56', NULL, NULL),
(92, 13, 'Mustafa Ali', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-02-28 19:13:42', NULL, NULL),
(93, 13, 'Mustafa ', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-02-28 19:14:45', NULL, NULL),
(94, 13, 'Asif', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-02-28 19:15:41', NULL, NULL),
(95, 13, 'Miss AR', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-02-28 19:18:33', NULL, NULL),
(96, 13, 'Ali Hussain ', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-02-28 19:19:35', NULL, NULL),
(97, 13, 'Waqas', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-02-28 19:20:20', NULL, NULL),
(98, 13, 'Shezad', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-02-28 19:21:07', NULL, NULL),
(99, 13, 'Amin', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-02-28 19:22:05', NULL, NULL),
(100, 13, 'Dr Paras', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-02-28 19:22:56', NULL, NULL),
(101, 13, 'Nasir', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-02-28 19:23:37', NULL, NULL),
(102, 13, 'Ravi Roy', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-02-28 19:24:48', NULL, NULL),
(103, 13, 'Ashok Kumar ', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-02-28 19:26:21', NULL, NULL),
(104, 13, 'Waseem', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-02-28 19:27:04', NULL, NULL),
(105, 13, 'Asma', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-02-28 19:28:10', NULL, NULL),
(106, 13, 'Akber', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-02-28 19:28:59', NULL, NULL),
(107, 13, 'Waqar', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-02-28 19:29:41', NULL, NULL),
(108, 13, 'Jay Rathore', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-02-28 19:30:28', NULL, NULL),
(109, 13, 'Ali Hassan', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-02-28 19:31:12', NULL, NULL),
(110, 13, 'Shabaz', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-02-28 19:32:03', NULL, NULL),
(111, 13, 'Anil', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-02-28 19:32:46', NULL, NULL),
(112, 13, 'Shabbir Ali', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-02-28 19:33:32', NULL, NULL),
(113, 13, 'Zain', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-02-28 19:34:15', NULL, NULL),
(114, 13, 'M.Imran', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-02-28 19:35:13', NULL, NULL),
(115, 13, 'Ravi Das', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-02-28 19:37:32', NULL, NULL),
(116, 13, 'Zain Abbas', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-02-28 19:38:32', NULL, NULL),
(117, 13, 'Haslain', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-02-28 19:39:24', NULL, NULL),
(118, 13, 'Muzaffar Abbas', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-02-28 19:40:17', NULL, NULL),
(119, 13, 'Hamza', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-02-28 19:46:02', NULL, NULL),
(120, 13, 'M.Abbas', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-02-28 19:49:22', NULL, NULL),
(121, 13, 'Sukaina', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-02-28 19:50:44', NULL, NULL),
(122, 13, 'Fatima', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-02-28 19:53:04', NULL, NULL),
(123, 13, 'Fayaz', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-02-28 19:54:14', NULL, NULL),
(124, 13, 'Hussain ', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-02-28 19:55:17', NULL, NULL),
(125, 13, 'Mrs Raza', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-02-28 19:56:05', NULL, NULL),
(126, 13, 'Shieraz', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-02-28 19:56:56', NULL, NULL),
(127, 13, 'Hammad', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-02-28 19:57:45', NULL, NULL),
(128, 13, 'Tariq Jameel', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-02-28 19:58:54', NULL, NULL),
(129, 13, 'Hasnain', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-02-28 20:00:06', NULL, NULL),
(130, 13, 'Bashir', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-02-28 20:00:50', NULL, NULL),
(131, 13, 'Noor ul ain', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-02-28 20:01:43', NULL, NULL),
(132, 13, 'Zain', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-02-28 20:02:27', NULL, NULL),
(133, 13, 'Aliza', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-02-28 20:03:17', NULL, NULL),
(134, 13, 'Kainat', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-02-28 20:04:00', NULL, NULL),
(135, 13, 'Frauees', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-02-28 20:04:51', NULL, NULL),
(136, 13, 'Prakash', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-02-28 20:05:44', NULL, NULL),
(137, 13, 'Asif', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-02-28 20:06:34', NULL, NULL),
(138, 13, 'Satish', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-02-28 20:07:25', NULL, NULL),
(139, 13, 'Shazaib', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-02-28 20:08:09', NULL, NULL),
(140, 13, 'Naveed', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-02-28 20:09:08', NULL, NULL),
(141, 13, 'Anum', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-02-28 20:09:56', NULL, NULL),
(142, 13, 'Afaq', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-02-28 20:11:57', NULL, NULL),
(143, 13, 'Sajjad', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-02-28 20:13:06', NULL, NULL),
(144, 13, 'Asif', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-02-28 20:14:01', NULL, NULL),
(145, 13, 'Imran', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-02-28 20:14:54', NULL, NULL),
(146, 13, 'Waqar', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-02-28 20:16:21', NULL, NULL),
(147, 13, 'Raza', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-02-28 20:17:06', NULL, NULL),
(148, 13, 'Abdul Hameed', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-02-28 20:17:55', NULL, NULL),
(149, 13, 'Saira Khan', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-02-28 20:19:17', NULL, NULL),
(150, 13, 'Nirmal', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-02-28 20:20:14', NULL, NULL),
(151, 13, 'Abdul Moiz', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-02-28 20:23:59', NULL, NULL),
(152, 13, 'Nadeem', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-02-28 20:24:48', NULL, NULL),
(153, 13, 'Waqas', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-02-28 20:25:30', NULL, NULL),
(154, 13, 'Abdul Rauf', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-02-28 20:26:17', NULL, NULL),
(155, 13, 'Umair', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-02-28 20:26:56', NULL, NULL),
(156, 13, 'Aijaz', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-02-28 20:27:41', NULL, NULL),
(157, 13, 'Deepak', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-02-28 20:28:29', NULL, NULL),
(158, 18, 'Asgher Ali', 'Abdul Karim', 13, 1, 2, NULL, NULL, NULL, 25, 14, 14, '4180205977171', '1980-03-01', 'Pisces', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '67c485ab99659.jpg', '', NULL, '2025-03-02 16:22:03', NULL, NULL),
(159, 13, 'Muhammad Zohair', NULL, NULL, 1, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-03-02 16:24:29', NULL, NULL),
(160, 13, 'Mrs Noushad Ahmed', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-03-03 10:44:24', NULL, NULL),
(161, 13, 'Abdul Raheem', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-03-03 16:28:36', NULL, NULL),
(162, 15, 'Khurram', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-03-03 16:40:10', NULL, NULL),
(163, 15, 'Nawab Ali', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-03-05 10:58:57', NULL, NULL),
(164, 9, 'Sohail ', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-03-05 11:14:12', NULL, NULL),
(165, 15, 'Batool', NULL, NULL, 1, NULL, NULL, NULL, NULL, 19, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-03-06 11:21:24', NULL, NULL),
(166, 15, 'Asif', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-03-06 11:43:40', NULL, NULL),
(167, 15, 'Taufeeq', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-03-07 09:30:52', NULL, NULL),
(168, 15, 'Rajesh', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-03-07 10:43:23', NULL, NULL),
(169, 15, 'Anil Kumar', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-03-07 10:44:45', NULL, NULL),
(170, 15, 'Naveed(sister)', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-03-07 10:46:09', NULL, NULL),
(172, 15, 'Atif', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-03-07 17:16:41', NULL, NULL),
(173, 13, 'Mrs Rehana Waqar', NULL, 14, 1, 2, NULL, NULL, 'sajani', 28, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-03-11 09:44:05', NULL, NULL),
(174, 19, 'Jalal Ismaili ', NULL, 10, 1, NULL, NULL, NULL, NULL, 19, 14, 14, NULL, NULL, NULL, 'Sonari bank', '00130000835863', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-03-11 09:48:40', NULL, NULL),
(175, 13, 'Hyder Bhai Jammat', NULL, 9, 1, 2, NULL, NULL, NULL, 19, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-03-11 09:49:59', NULL, NULL),
(176, 15, 'Riaz', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-03-12 11:03:35', NULL, NULL),
(177, 15, 'Faheem', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-03-12 11:12:34', NULL, NULL),
(178, 15, 'Mrs Kamla', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-03-12 11:15:43', NULL, NULL),
(179, 15, 'Amir Abbas Jessani', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, '42301-4091491-1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-03-12 11:17:42', NULL, NULL),
(180, 15, 'M.Younus', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-03-12 11:42:34', NULL, NULL),
(181, 15, 'Noor Ali', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-03-13 17:05:47', NULL, NULL),
(182, 15, 'Shouket Bhai', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-03-13 17:42:58', NULL, NULL),
(183, 15, 'Noor Muhammad', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-03-13 17:49:26', NULL, NULL),
(184, 15, 'Hussain', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-03-14 16:43:39', NULL, NULL),
(185, 15, 'Sameerudeen', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-03-14 16:57:27', NULL, NULL),
(186, 15, 'Mohammad Idress', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-03-14 17:09:58', NULL, NULL),
(187, 15, 'Daniel', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-03-14 17:21:26', NULL, NULL),
(188, 17, 'Ali Raza Builder (SB)', NULL, 9, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-03-14 18:19:59', NULL, NULL),
(189, 20, 'Mohd Ali (UNO)', NULL, 15, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-03-14 18:28:28', NULL, NULL),
(190, 11, 'Br Ali Hussain', NULL, NULL, 1, NULL, NULL, NULL, 'Taj Petrol pump ki lane mein razia wale ke pass Sameer estate se samne', 19, 14, 14, NULL, NULL, NULL, NULL, NULL, 'Razzak Estate', 'Admin', 'Manager ', '14', 'soldier bazar 2 opposite lane of habib metro', 'Deals in flats/shops', NULL, NULL, NULL, NULL, NULL, 'Contact them for association work for properties ', NULL, '2025-03-15 07:36:29', NULL, NULL),
(191, 11, 'Habib', NULL, NULL, 1, NULL, NULL, NULL, NULL, 32, 14, 14, NULL, NULL, NULL, NULL, NULL, 'Hussain Real Estate', NULL, NULL, '14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-03-15 07:39:52', NULL, NULL),
(192, 11, 'Kumail', NULL, NULL, 1, NULL, NULL, NULL, NULL, 33, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-03-15 07:42:36', NULL, NULL),
(193, 11, 'Raza', NULL, NULL, 1, NULL, NULL, NULL, NULL, 34, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-03-15 07:45:29', NULL, NULL),
(194, 11, 'Shezad', NULL, NULL, 1, NULL, NULL, NULL, NULL, 31, 14, 14, NULL, NULL, NULL, NULL, NULL, 'CPLC Estate', NULL, NULL, '14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-03-15 07:47:39', NULL, NULL),
(195, 11, 'Shoaib', NULL, NULL, 1, NULL, NULL, NULL, NULL, 19, 14, 14, NULL, NULL, NULL, NULL, NULL, 'MAA Estate', NULL, NULL, '14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-03-15 07:50:10', NULL, NULL),
(196, 14, 'Zain', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, 23, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-03-15 07:55:37', NULL, NULL),
(197, 15, 'Syed Salman Ali', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-03-15 10:09:31', NULL, NULL),
(198, 15, 'Khalid', NULL, NULL, 1, NULL, NULL, NULL, NULL, 22, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-03-15 10:18:45', NULL, NULL),
(199, 15, 'M.Hanif', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-03-15 10:31:32', NULL, NULL),
(200, 15, 'Arshad Ali', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-03-15 10:41:46', NULL, NULL),
(201, 15, 'M.Anwar Ali', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-03-15 17:38:01', NULL, NULL),
(202, 15, 'M.Aqeel', NULL, NULL, 1, NULL, NULL, NULL, NULL, 19, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-03-15 17:48:03', NULL, NULL),
(203, 15, 'Sanaullah', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-03-15 17:54:54', NULL, NULL),
(204, 15, 'Mansoor', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-03-15 18:02:59', NULL, NULL),
(205, 19, 'Ghulam Abbas', NULL, 9, 1, 2, NULL, NULL, NULL, 21, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-03-16 11:52:54', NULL, NULL),
(206, 22, 'Hasnain Abbas Quetta', 'Saif Uddin', 16, NULL, NULL, NULL, NULL, NULL, NULL, 24, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-03-16 11:55:44', NULL, NULL),
(207, 9, 'Mr Moin', NULL, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-03-17 09:29:35', NULL, NULL),
(208, 15, 'Maham', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-03-18 07:50:49', NULL, NULL),
(209, 15, 'M.Nadeem', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'M.Farooq', NULL, '0332-3370710', NULL, NULL, '', NULL, '2025-03-18 07:53:29', NULL, NULL),
(210, 15, 'Ramzan Ali', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-03-18 07:54:30', NULL, NULL),
(211, 15, 'Haider Ali', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-03-18 07:55:52', NULL, NULL),
(212, 15, 'Aqeel(Bank Al Falah)', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-03-18 07:57:14', NULL, NULL),
(213, 15, 'M.Sohail', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-03-18 07:58:38', NULL, NULL),
(214, 15, 'Aun Ali', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-03-18 08:00:55', NULL, NULL),
(215, 15, 'Haji Sadiq ', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-03-18 08:02:29', NULL, NULL),
(216, 15, 'Nelson', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-03-18 08:04:01', NULL, NULL),
(217, 15, 'Abdul Hussain', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-03-18 08:05:25', NULL, NULL),
(218, 15, 'Mrs Raza', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-03-18 08:07:00', NULL, NULL),
(219, 15, 'Imran Ali', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-03-18 08:16:05', NULL, NULL),
(221, 15, 'Ghulam Mustaffa', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-03-18 09:17:42', NULL, NULL),
(222, 15, 'Hussain Sheikh', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-03-18 09:29:12', NULL, NULL),
(223, 15, 'Akber Ali', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-03-18 09:37:02', NULL, NULL),
(224, 15, 'Abbas', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-03-18 09:46:30', NULL, NULL),
(225, 15, 'Saffiudeen', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-03-18 17:03:44', NULL, NULL),
(226, 15, 'Irfan', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-03-18 17:20:46', NULL, NULL),
(227, 15, 'Jawaid Ali', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-03-18 17:42:11', NULL, NULL),
(228, 15, 'Muzammil', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-03-18 17:52:29', NULL, NULL),
(229, 9, 'Mukesh', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Manoj Kumar', NULL, '0337-8033064', 'Needy urgent required favor in low budget', NULL, '', NULL, '2025-03-22 16:59:52', NULL, NULL),
(230, 15, 'Mohsin Bori', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-03-23 07:15:03', NULL, NULL),
(231, 15, 'Mrs Hassan', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-03-23 07:26:45', NULL, NULL),
(232, 15, 'Faisal Gova', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-03-23 07:35:41', NULL, NULL),
(233, 15, 'Dr Fahad', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-03-23 07:41:56', NULL, NULL),
(234, 15, 'Ali Haider', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-03-24 16:54:57', NULL, NULL),
(235, 15, 'Abdul Rehman', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-03-24 17:00:47', NULL, NULL),
(236, 15, 'M.Raza Masala', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-03-24 17:02:41', NULL, NULL),
(237, 15, 'M.Raza', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-03-24 17:04:09', NULL, NULL),
(238, 15, 'Hadi Mother', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-03-24 17:05:34', NULL, NULL),
(239, 15, 'Mrs Hanif', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-03-24 17:06:47', NULL, NULL),
(240, 15, 'Moiz Ali Zaidi', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-03-24 17:09:08', NULL, NULL),
(241, 15, 'Yaqoob', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-03-25 07:28:32', NULL, NULL),
(242, 15, 'Murtaza', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-03-25 07:30:13', NULL, NULL),
(243, 23, 'Hasnain 5093', NULL, NULL, 1, 8, NULL, NULL, NULL, 20, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-03-25 10:31:42', NULL, NULL),
(244, NULL, 'Abc27march2025', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-03-27 16:14:33', NULL, NULL),
(245, 19, 'Soraj kumar', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-03-27 17:56:01', NULL, NULL),
(249, 15, 'M Kashif', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-04-07 12:22:22', NULL, NULL),
(250, 15, 'Muzammil ', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-04-07 12:30:17', NULL, NULL),
(251, 15, 'Siraj', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-04-07 12:50:17', NULL, NULL),
(252, 15, 'Khaliq Ur Rehman', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-04-07 13:50:56', NULL, NULL),
(253, 14, 'Mrs Munir', NULL, 9, 1, 2, NULL, NULL, NULL, 46, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-04-07 14:35:27', NULL, NULL),
(254, 9, 'Muhammad Tahir ', 'Muhammad Umar', 1, 1, 2, NULL, NULL, NULL, 47, 14, 14, '42201-9877381-5', '1977-03-05', 'Pisces', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-04-07 14:41:17', '67f3e40da4289_front.jpeg', '67f3e40da444d_back.jpeg'),
(255, 14, 'Tauseef Raza', 'Yaqoob Ali', 9, 1, 2, NULL, NULL, NULL, 26, 14, 14, '42201-0281917-9', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-04-07 14:45:27', '67f3e50739d6b_front.jpeg', '67f3e50739f55_back.jpeg'),
(256, 24, 'Sadiq Bojani', NULL, 9, 1, NULL, NULL, NULL, NULL, 20, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-04-07 14:49:57', NULL, NULL),
(257, 9, 'Meraj Water Board', NULL, 1, 1, 2, NULL, NULL, NULL, 26, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-04-07 14:51:35', NULL, NULL),
(258, 21, 'Br Ali Wahab Mirza', NULL, 14, 1, 1, NULL, NULL, NULL, 20, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-04-07 17:31:18', '67f40be66489d_front.jpeg', NULL),
(259, 14, 'M Arif', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-04-08 09:28:09', NULL, NULL),
(260, 13, 'Mustafa bori', NULL, 16, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-04-20 10:11:57', NULL, NULL),
(261, 13, 'Raju', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-04-20 10:13:12', NULL, NULL),
(262, 13, 'Jaffer', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-04-20 10:14:06', NULL, NULL),
(263, 13, 'Anida Azhar Abbas', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-04-20 10:15:13', NULL, NULL),
(264, 13, 'Mrs Akeel', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-04-20 10:15:57', NULL, NULL),
(265, 13, 'Mustaffa', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-04-20 10:16:46', NULL, NULL),
(266, 13, 'Shantilal', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-04-20 10:19:03', NULL, NULL),
(267, 13, 'Farhan', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-04-20 10:19:44', NULL, NULL),
(268, 13, 'M.Usman', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-04-20 10:20:32', NULL, NULL),
(269, 13, 'Hamza', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-04-20 10:21:40', NULL, NULL),
(270, 13, 'Zahid', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-04-20 10:22:29', NULL, NULL),
(271, 13, 'Jagdish', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-04-20 10:24:28', NULL, NULL);
INSERT INTO `customers` (`id`, `lead_id`, `name`, `father`, `cast_id`, `religion_id`, `marital_status_id`, `email`, `web_page`, `address`, `area_id`, `city_id`, `country_id`, `cnic`, `dob`, `star`, `bank`, `account_iban`, `company`, `department`, `designation`, `occupation`, `off_address`, `work_note`, `ref_name`, `ref_cnic`, `ref_cell`, `ref_note`, `photo`, `remarks`, `visiting_card`, `created_at`, `cnic_front`, `cnic_back`) VALUES
(272, 13, 'Zain un nisa', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-04-20 10:25:15', NULL, NULL),
(273, 13, 'Jamshed', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-04-20 10:26:03', NULL, NULL),
(274, 13, 'Hussain naqvi', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-04-20 10:26:55', NULL, NULL),
(275, 13, 'Vinod', NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-04-20 10:27:31', NULL, NULL),
(276, 13, 'Madiha zaidi', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-04-20 10:28:21', NULL, NULL),
(277, 13, 'Naveed memon', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-04-20 10:30:07', NULL, NULL),
(278, 13, 'Mohsin khan', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-04-20 10:30:56', NULL, NULL),
(279, 13, 'Hasan ', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-04-20 10:31:47', NULL, NULL),
(280, 13, 'No name', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-04-20 10:39:25', NULL, NULL),
(281, 13, 'No name', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-04-20 10:49:44', NULL, NULL),
(282, 13, 'No name', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-04-20 10:50:34', NULL, NULL),
(283, 13, 'No name', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-04-20 10:51:27', NULL, NULL),
(284, 13, 'Raj Kumar', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-04-22 13:14:52', NULL, NULL),
(285, 7, 'Ali Hyder Office', NULL, 15, 1, 1, NULL, NULL, NULL, 20, 14, 14, '4230147103159', '2003-08-16', 'Leo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-05-09 14:48:30', NULL, NULL),
(286, 15, 'Shabbir Hussain', NULL, 9, NULL, NULL, NULL, NULL, NULL, 48, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-05-12 12:21:06', NULL, NULL),
(292, 22, 'Hassan ZQ', NULL, 16, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-05-29 13:25:16', NULL, NULL),
(293, 15, 'Asgher ghori', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-06-03 08:41:20', NULL, NULL),
(294, 15, 'Murtuza C/o Agha Qammar', NULL, NULL, NULL, NULL, NULL, NULL, 'Pakola', 47, 14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2025-06-03 08:55:07', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `customer_banks`
--

CREATE TABLE `customer_banks` (
  `id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `bank_name` varchar(100) NOT NULL,
  `iban` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `departments`
--

CREATE TABLE `departments` (
  `id` int(11) NOT NULL,
  `dept_name` varchar(50) NOT NULL,
  `dept_code` varchar(10) DEFAULT NULL,
  `parent_dept_id` int(11) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `manager_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `document_categories`
--

CREATE TABLE `document_categories` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `status` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `education_levels`
--

CREATE TABLE `education_levels` (
  `id` int(11) NOT NULL,
  `level_name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `employees`
--

CREATE TABLE `employees` (
  `id` int(11) NOT NULL,
  `employee_id` varchar(20) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `date_of_birth` date NOT NULL,
  `place_of_birth` varchar(100) DEFAULT NULL,
  `gender` enum('Male','Female','Other') NOT NULL,
  `marital_status` enum('Single','Married','Divorced','Widowed') NOT NULL,
  `religion` varchar(50) DEFAULT NULL,
  `caste` varchar(50) DEFAULT NULL,
  `nationality` varchar(50) NOT NULL,
  `address` text DEFAULT NULL,
  `city` varchar(50) NOT NULL,
  `state` varchar(50) DEFAULT NULL,
  `postal_code` varchar(20) DEFAULT NULL,
  `country` varchar(50) NOT NULL,
  `hire_date` date NOT NULL,
  `department_id` int(11) NOT NULL,
  `position` varchar(50) NOT NULL,
  `employment_type` enum('Full-time','Part-time','Contract','Temporary') NOT NULL,
  `status` enum('Active','On Leave','Terminated') DEFAULT 'Active',
  `reporting_manager_id` int(11) DEFAULT NULL,
  `work_location` varchar(100) DEFAULT NULL,
  `barcode` varchar(50) NOT NULL,
  `id_expiry_date` date NOT NULL,
  `passport_number` varchar(50) DEFAULT NULL,
  `passport_expiry` date DEFAULT NULL,
  `emergency_contact_name` varchar(100) DEFAULT NULL,
  `emergency_contact_relationship` varchar(50) DEFAULT NULL,
  `emergency_contact_phone` varchar(20) DEFAULT NULL,
  `emergency_contact_address` text DEFAULT NULL,
  `blood_group` varchar(5) DEFAULT NULL,
  `has_diseases` tinyint(1) DEFAULT 0,
  `disease_details` text DEFAULT NULL,
  `has_disability` tinyint(1) DEFAULT 0,
  `disability_details` text DEFAULT NULL,
  `skills` text DEFAULT NULL,
  `languages` text DEFAULT NULL,
  `remarks` text DEFAULT NULL,
  `hired_by` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `photo` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `employee_education`
--

CREATE TABLE `employee_education` (
  `id` int(11) NOT NULL,
  `employee_id` int(11) NOT NULL,
  `education_level_id` int(11) NOT NULL,
  `institution_name` varchar(100) NOT NULL,
  `field_of_study` varchar(100) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date DEFAULT NULL,
  `grade_or_gpa` varchar(20) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `employee_qrcodes`
--

CREATE TABLE `employee_qrcodes` (
  `id` int(11) NOT NULL,
  `employee_id` varchar(20) NOT NULL,
  `qr_code` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `employee_work_history`
--

CREATE TABLE `employee_work_history` (
  `id` int(11) NOT NULL,
  `employee_id` int(11) NOT NULL,
  `company_name` varchar(100) NOT NULL,
  `position` varchar(100) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date DEFAULT NULL,
  `responsibilities` text DEFAULT NULL,
  `reason_for_leaving` text DEFAULT NULL,
  `reference_name` varchar(100) DEFAULT NULL,
  `reference_contact` varchar(100) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `features`
--

CREATE TABLE `features` (
  `id` int(11) NOT NULL,
  `bedrooms` int(11) DEFAULT NULL,
  `bathrooms` int(11) DEFAULT NULL,
  `floors` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `features`
--

INSERT INTO `features` (`id`, `bedrooms`, `bathrooms`, `floors`) VALUES
(1, 3, 2, 1);

-- --------------------------------------------------------

--
-- Table structure for table `feature_categories`
--

CREATE TABLE `feature_categories` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `status` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `leads`
--

CREATE TABLE `leads` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `status` enum('Active','Inactive') DEFAULT 'Active',
  `created_by` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `leads`
--

INSERT INTO `leads` (`id`, `name`, `status`, `created_by`, `created_at`) VALUES
(6, 'LILANIGROUPS', 'Active', NULL, '2025-02-26 22:12:33'),
(7, 'SEA', 'Active', NULL, '2025-02-27 08:45:02'),
(9, 'Flat-Tenant', 'Active', NULL, '2025-02-27 09:53:59'),
(11, 'Agent', 'Active', NULL, '2025-02-27 10:26:03'),
(13, 'Flat-Purchaser', 'Active', NULL, '2025-02-27 10:26:26'),
(14, 'Flat-Rentowner', 'Active', NULL, '2025-02-27 10:27:14'),
(15, 'Flat-Seller', 'Active', NULL, '2025-02-27 10:27:33'),
(16, 'School-Van', 'Active', NULL, '2025-02-27 11:00:03'),
(17, 'Builder', 'Active', NULL, '2025-02-28 16:29:42'),
(18, 'Employee', 'Active', NULL, '2025-03-02 16:19:06'),
(19, 'Shop-Tenant', 'Active', NULL, '2025-03-11 09:45:15'),
(20, 'Investor', 'Active', NULL, '2025-03-14 18:27:56'),
(21, 'Broker', 'Active', NULL, '2025-03-15 07:30:27'),
(22, 'Shop-RO', 'Active', NULL, '2025-03-16 11:54:29'),
(23, 'None', 'Active', NULL, '2025-03-25 10:29:59'),
(24, 'Travels', 'Active', NULL, '2025-04-07 14:48:43');

-- --------------------------------------------------------

--
-- Table structure for table `main_form`
--

CREATE TABLE `main_form` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `cast` varchar(255) DEFAULT NULL,
  `cell` varchar(255) DEFAULT NULL,
  `cnic` varchar(255) DEFAULT NULL,
  `photo` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `priority` varchar(255) DEFAULT NULL,
  `category` varchar(255) DEFAULT NULL,
  `property_types` varchar(255) DEFAULT NULL,
  `bedrooms` int(11) DEFAULT NULL,
  `bathrooms` int(11) DEFAULT NULL,
  `floors` int(11) DEFAULT NULL,
  `features` varchar(255) DEFAULT NULL,
  `budget` decimal(10,2) DEFAULT NULL,
  `budget_in_words` varchar(255) DEFAULT NULL,
  `office_charges` decimal(10,2) DEFAULT NULL,
  `percentage` decimal(5,2) DEFAULT NULL,
  `ref_name` varchar(255) DEFAULT NULL,
  `ref_cnic` varchar(255) DEFAULT NULL,
  `ref_cell` varchar(255) DEFAULT NULL,
  `note` text DEFAULT NULL,
  `remarks` text DEFAULT NULL,
  `date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `main_form`
--

INSERT INTO `main_form` (`id`, `name`, `cast`, `cell`, `cnic`, `photo`, `status`, `priority`, `category`, `property_types`, `bedrooms`, `bathrooms`, `floors`, `features`, `budget`, `budget_in_words`, `office_charges`, `percentage`, `ref_name`, `ref_cnic`, `ref_cell`, `note`, `remarks`, `date`) VALUES
(85, 'Deepak', '', '0323-2161883', '', '', '27', '20', '59', '71', 2, 2, 4, 'Common', 4000000.00, 'Four Million', 0.00, 2.00, '', '', '', '', '', '2025-02-26'),
(86, 'Aijaz', '', '0336-0073333', '', '', '27', '20', '59', '71', 3, 3, 0, 'Drawing, Dining', 30000000.00, 'Thirty Million', 0.00, 2.00, '', '', '', '', '', '2025-02-26'),
(87, 'Umair', '', '0300-2248418', '', NULL, '27', '20', '59', '71', 2, 2, 0, 'Drawing, Dining', 10000000.00, 'Ten Million', 0.00, 2.00, '', '', '', '', '', '2025-02-25'),
(88, 'Abdul Rauf', '', '0312-2491505', '', NULL, '27', '20', '59', '71', 2, 0, 0, 'Common', 4000000.00, 'Four Million', 0.00, 2.00, '', '', '', '', '', '2025-02-21'),
(89, 'Waqas', '', '0345-3131616', '', NULL, '27', '20', '59', '71', 2, 2, 0, 'Common', 6000000.00, 'Six Million', 0.00, 2.00, '', '', '', '', '', '2025-02-20'),
(90, 'Nadeem', '', '0333-7223579', '', NULL, '27', '20', '59', '71', 2, 1, 0, 'Drawing, Dining', 15000000.00, 'Fifteen Million', 0.00, 2.00, '', '', '', '', '', '2025-02-19'),
(91, 'Abdul Moiz', '', '0303-2790079', '', NULL, '27', '20', '59', '71', 2, 2, 0, 'Drawing, Dining', 6500000.00, 'Six Million Five Hundred Thousand', 0.00, 2.00, '', '', '', '', '', '2025-02-17'),
(93, 'Saira Khan', '', '0333-2354680', '', NULL, '27', '20', '59', '71', 2, 2, 0, 'Common', 6000000.00, 'Six Million', 0.00, 2.00, '', '', '', '', '', '2025-02-20'),
(94, 'Nirmal', '', '0334-3000830', '', NULL, '27', '20', '59', '71', 2, 2, 0, 'Common', 4500000.00, 'Four Million Five Hundred Thousand', 0.00, 2.00, '', '', '', '', '', '2025-02-20'),
(95, 'Abdul Hameed', '', '0343-2926921', '', '', '27', '20', '59', '71', 2, 2, 0, 'Common', 2500000.00, 'Two Million Five Hundred Thousand', 0.00, 2.00, '', '', '', '', '', '2025-02-12'),
(96, 'Raza', '', '0345-3265661', '', NULL, '27', '20', '59', '71', 1, 1, 0, 'Common', 2500000.00, 'Two Million Five Hundred Thousand', 0.00, 2.00, '', '', '', '', '', '2025-02-12'),
(97, 'Waqar', '', '0300-2470330', '', NULL, '27', '20', '59', '71', 2, 2, 0, 'Drawing, Dining', 16000000.00, 'Sixteen Million', 0.00, 2.00, '', '', '', '', '', '2025-02-09'),
(98, 'Asif', '', '0332-3013822', '', NULL, '27', '20', '59', '71', 2, 2, 0, 'Common', 2200000.00, 'Two Million Two Hundred Thousand', 0.00, 2.00, '', '', '', '', '', '2025-02-09'),
(99, 'Imran', '', '0331-2469573', '', NULL, '27', '20', '59', '71', 2, 2, 0, 'Dining', 5000000.00, 'Five Million', 0.00, 2.00, '', '', '', '', '', '2025-02-09'),
(100, 'Bashir', '', '0300-2279264', '', NULL, '27', '20', '59', '71', 2, 2, 0, 'Common', 6000000.00, 'Six Million', 0.00, 2.00, '', '', '', '', '', '2025-02-20'),
(103, 'Sajjad', '', '0303-9238878', '', NULL, '27', '22', '59', '71', 2, 2, 0, 'Drawing, Dining, Roof', 20000000.00, 'Twenty Million', 0.00, 2.00, '', '', '', '', '', '2025-02-09'),
(104, 'Afaq', '', '0315-0233720', '', NULL, '27', '20', '59', '71', 2, 2, 0, 'Common', 4500000.00, 'Four Million Five Hundred Thousand', 0.00, 2.00, '', '', '', '', '', '2025-02-07'),
(105, 'Anum', '', '0331-2029010', '', NULL, '27', '22', '59', '71', 2, 2, 0, 'Drawing, Dining', 10000000.00, 'Ten Million', 0.00, 2.00, '', '', '', '', '', '2025-02-01'),
(106, 'Naveed', '', '0333-5207272', '', NULL, '27', '20', '59', '71', 3, 3, 0, 'Drawing, Dining', 13500000.00, 'Thirteen Million Five Hundred Thousand', 0.00, 2.00, '', '', '', '', '', '2025-02-03'),
(107, 'Shazaib', '', '0335-1133714', '', NULL, '27', '20', '62', '71', 0, 0, 0, NULL, 10000000.00, 'Ten Million', 0.00, 2.00, '', '', '', '', '', '2025-02-03'),
(108, 'Satish', '', '0319-9238034', '', NULL, '27', '20', '59', '71', 2, 2, 0, 'Common', 5000000.00, 'Five Million', 0.00, 2.00, '', '', '', '', '', '2025-02-03'),
(109, 'Asif', '', '0321-2464657', '', NULL, '27', '20', '59', '71', 2, 2, 0, 'Drawing', 8500000.00, 'Eight Million Five Hundred Thousand', 0.00, 2.00, '', '', '', '', '', '2025-02-03'),
(110, 'Prakash', '', '0331-2227323', '', NULL, '27', '20', '59', '71', 2, 2, 0, 'Common', 5500000.00, 'Five Million Five Hundred Thousand', 0.00, 2.00, '', '', '', '', '', '2025-01-31'),
(111, 'Frauees', '', '0340-8385044', '', NULL, '27', '20', '59', '71', 2, 2, 0, 'Common', 4500000.00, 'Four Million Five Hundred Thousand', 0.00, 2.00, '', '', '', '', '', '2025-01-31'),
(112, 'Kainat', '', '0334-3067928', '', NULL, '27', '20', '59', '71', 3, 3, 0, 'Drawing, Dining', 22000000.00, 'Twenty Two Million', 0.00, 2.00, '', '', '', '', '', '2025-01-30'),
(113, 'Aliza', '', '0331-2684742', '', NULL, '27', '20', '59', '71', 3, 3, 0, 'Drawing, Dining', 12500000.00, 'Twelve Million Five Hundred Thousand', 0.00, 2.00, '', '', '', '', '', '2025-01-30'),
(114, 'Zain', '', '0333-2318882', '', NULL, '27', '20', '59', '71', 2, 2, 0, 'Common', 5000000.00, 'Five Million', 0.00, 2.00, '', '', '', '', '', '2025-01-30'),
(115, 'Noor ul ain', '', '0324-3298851', '', NULL, '27', '20', '59', '71', 2, 2, 0, 'Drawing', 8000000.00, 'Eight Million', 0.00, 2.00, '', '', '', '', '', '2025-01-29'),
(117, 'Hasnain', '', '0323-2703586', '', NULL, '27', '22', '59', '71', 2, 2, 0, 'Drawing, Dining', 14000000.00, 'Fourteen Million', 0.00, 2.00, '', '', '', '', '', '2025-01-27'),
(118, 'Tariq Jameel', '', '0322-9783566', '', NULL, '27', '22', '59', '71', 2, 2, 0, 'Common', 3000000.00, 'Three Million', 0.00, 2.00, '', '', '', '', '', '2025-01-22'),
(119, 'Hammad', '', '0331-2235031', '', NULL, '27', '22', '59', '71', 2, 2, 0, 'Drawing', 8500000.00, 'Eight Million Five Hundred Thousand', 0.00, 2.00, '', '', '', '', '', '2025-01-20'),
(120, 'Shieraz', '', '0333-1664656', '', NULL, '27', '22', '59', '71', 2, 2, 0, 'Common', 6000000.00, 'Six Million', 0.00, 2.00, '', '', '', '', '', '2025-01-20'),
(121, 'Mrs Raza', '', '0333-2395636', '', NULL, '27', '22', '59', '71', 2, 2, 0, 'Drawing, Dining', 12500000.00, 'Twelve Million Five Hundred Thousand', 0.00, 2.00, '', '', '', '', '', '2025-01-18'),
(122, 'Hussain ', '', '0300-2545060', '', NULL, '27', '22', '59', '71', 2, 2, 0, 'Drawing, Dining', 12500000.00, '', 0.00, 2.00, '', '', '', '', '', '2025-01-18'),
(123, 'Fayaz', '', '+968-9538-5240', '', NULL, '27', '22', '59', '71', 2, 2, 0, 'Drawing, Dining', 12500000.00, '', 0.00, 2.00, '', '', '', '', '', '2025-01-18'),
(124, 'Fatima', '', '0315-2890918', '', NULL, '27', '22', '59', '71', 2, 2, 0, 'Drawing, Dining', 12500000.00, '', 0.00, 2.00, '', '', '', '', '', '2025-01-18'),
(125, 'Sukaina', '', '0309-2448370', '', NULL, '27', '22', '59', '71', 2, 2, 0, 'Drawing, Dining', 12500000.00, '', 0.00, 2.00, '', '', '', '', '', '2025-01-18'),
(126, 'M.Abbas', '', '0305-2416535', '', NULL, '27', '22', '59', '71', 2, 2, 0, 'Drawing, Dining', 10000000.00, 'Ten Million', 0.00, 2.00, '', '', '', '', '', '2025-01-18'),
(127, 'M.Imran', '', '0336-3408530', '', NULL, '27', '22', '59', '71', 2, 2, 0, 'Common', 4000000.00, 'Four Million', 0.00, 2.00, '', '', '', '', '', '2025-01-17'),
(128, 'Hamza', '', '0318-2748027', '', NULL, '27', '22', '59', '71', 3, 3, 0, 'Common', 6500000.00, 'Six Million Five Hundred Thousand', 0.00, 2.00, '', '', '', '', '', '2025-01-17'),
(129, 'Muzaffar Abbas', '', '0316-2627842', '', NULL, '27', '22', '59', '71', 2, 2, 0, 'Drawing, Dining', 14000000.00, 'Fourteen Million', 0.00, 2.00, '', '', '', '', '', '2025-01-15'),
(130, 'Haslain', '', '0330-3677764', '', NULL, '27', '22', '59', '71', 2, 2, 0, 'Common', 4500000.00, 'Four Million Five Hundred Thousand', 0.00, 2.00, '', '', '', '', '', '2025-01-14'),
(131, 'Zain Abbas', '', '0331-3026676', '', NULL, '27', '22', '59', '71', 2, 2, 0, 'Drawing, Dining', 1500000.00, 'One Million Five Hundred Thousand', 0.00, 2.00, '', '', '', '', '', '2025-01-14'),
(132, 'Ravi Das', '', '0315-2800738', '', NULL, '27', '22', '59', '71', 2, 2, 0, 'Common', 4500000.00, 'Four Million Five Hundred Thousand', 0.00, 2.00, '', '', '', '', '', '2025-01-13'),
(134, 'Rehan', '', '0335-3241660', '', NULL, '27', '22', '59', '71', 2, 2, 0, 'Drawing, Dining', 12500000.00, 'Twelve Million Five Hundred Thousand', 0.00, 2.00, '', '', '', '', '', '2025-01-13'),
(135, 'Zain', '', '0336-3493712', '', NULL, '27', '22', '59', '71', 2, 2, 0, 'Drawing, Dining', 9000000.00, 'Nine Million', 0.00, 2.00, '', '', '', '', '', '2025-01-10'),
(136, 'Shabbir Ali', '', '0322-3345882', '', NULL, '27', '22', '59', '71', 2, 2, 0, 'Drawing, Dining', 12500000.00, 'Twelve Million Five Hundred Thousand', 0.00, 2.00, '', '', '', '', '', '2025-01-01'),
(137, 'Anil', '', '0321-2587564', '', NULL, '27', '22', '59', '71', 3, 3, 0, 'Common', 10000000.00, 'Ten Million', 0.00, 2.00, '', '', '', '', '', '2024-12-29'),
(138, 'Shabaz', '', '0332-3594582', '', NULL, '27', '22', '59', '71', 2, 2, 0, 'Drawing, Dining', 5000000.00, 'Five Million', 0.00, 2.00, '', '', '', '', '', '2024-12-28'),
(139, 'Ali Hassan', '', '0344-2200676', '', NULL, '27', '22', '59', '71', 2, 2, 0, 'Common', 5000000.00, '', 0.00, 2.00, '', '', '', '', '', '2024-12-28'),
(140, 'Jay Rathore', '', '0313-0312124', '', NULL, '27', '20', '59', '71', 3, 3, 0, 'Common', 7500000.00, 'Seven Million Five Hundred Thousand', 0.00, 2.00, '', '', '', '', '', '2024-12-28'),
(141, 'Abbas Ali', '', '0321-8277245', '', NULL, '27', NULL, '59', '71', 2, 2, 0, 'Common', 5000000.00, 'Five Million', 0.00, 2.00, '', '', '', '', '', '2024-10-31'),
(142, 'Waris Hussain', '', '0311-4611255', '', NULL, '27', '20', '59', '71', 3, 3, 0, 'Common', 10000000.00, 'Ten Million', 0.00, 2.00, '', '', '', '', '', '2024-10-30'),
(143, 'Mr Raza', '', '0331-2897538', '', NULL, '27', '20', '59', '71', 3, 3, 0, 'Common', 9000000.00, 'Nine Million', 0.00, 2.00, '', '', '', '', '', '2024-11-02'),
(144, 'Umair', '', '0320-2113882', '', NULL, '27', '20', '59', '71', 2, 2, 0, 'Common', 2700000.00, 'Two Million Seven Hundred Thousand', 0.00, 2.00, '', '', '', '', '', '2024-11-03'),
(145, 'Sanjay', '', '0314-2469517', '', NULL, '27', '20', '59', '71', 2, 2, 0, 'Common', 2500000.00, 'Two Million Five Hundred Thousand', 0.00, 2.00, '', '', '', '', '', '2024-11-04'),
(146, 'Furqan', '', '0322-3829790', '', NULL, '27', '20', '59', '71', 1, 1, 0, 'Common', 2500000.00, '', 0.00, 2.00, '', '', '', '', '', '2024-11-05'),
(147, 'Zahid Hussain', '', '0345-6177919', '', NULL, '27', '20', '59', '71', 1, 1, 0, 'Common', 2000000.00, 'Two Million', 0.00, 2.00, '', '', '', '', '', '2024-11-05'),
(148, 'Wahab Mother', '', '0334-3419332', '', NULL, NULL, NULL, NULL, NULL, 2, 2, 0, 'Drawing', 10000000.00, 'Ten Million', 0.00, 0.00, '', '', '', '', '', '2024-11-05'),
(149, 'Ali Raza', '', '0331-3449224', '', NULL, '27', '20', '59', '71', 2, 2, 0, 'Drawing, Dining', 3000000.00, 'Three Million', 0.00, 2.00, '', '', '', '', '', '2024-11-06'),
(150, 'M.Ali', '', '0300-3956394', '', NULL, '27', '20', '59', '71', 2, 2, 0, 'Drawing, Dining', 21500000.00, 'Twenty One Million Five Hundred Thousand', 0.00, 2.00, '', '', '', '', '', '2024-11-06'),
(151, 'M.Hanif', '', '0333-2246075', '', NULL, '27', '20', '59', '71', 2, 2, 0, 'Roof', 4000000.00, 'Four Million', 0.00, 2.00, '', '', '', '', '', '2024-11-09'),
(152, 'Bilal', '', '0341-5489779', '', NULL, '27', '20', '59', '71', 2, 2, 0, 'Drawing, Dining', 20500000.00, 'Twenty Million Five Hundred Thousand', 0.00, 2.00, '', '', '', '', '', '2024-11-13'),
(153, 'Imran', '', '0313-1171183', '', NULL, '27', '20', '59', '71', 2, 2, 0, 'Common', 5000000.00, 'Five Million', 0.00, 2.00, '', '', '', '', '', '2024-11-13'),
(154, 'Imran', '', '0310-0027722', '', NULL, '27', '20', '59', '71', 2, 2, 0, 'Drawing, Dining', 25000000.00, 'Twenty Five Million', 0.00, 2.00, '', '', '', '', '', '2024-11-15'),
(155, 'Dharminder', '', '0344-2997448', '', NULL, '27', '20', '59', '71', 4, 4, 0, 'Drawing, Dining', 8500000.00, 'Eight Million Five Hundred Thousand', 0.00, 2.00, '', '', '', '', '', '2024-11-15'),
(156, 'Nadeem', '', '0323-2425637', '', NULL, '27', '20', '59', '71', 3, 3, 0, 'Common', 6500000.00, 'Six Million Five Hundred Thousand', 0.00, 2.00, '', '', '', '', '', '2024-11-17'),
(157, 'Khalid Majeed', '', '0300-2477584', '', NULL, '27', '20', '59', '71', 2, 2, 0, 'Drawing, Dining', 12500000.00, 'Twelve Million Five Hundred Thousand', 0.00, 2.00, '', '', '', '', '', '2024-11-19'),
(158, 'Asma Naveed', '', '0312-2991305', '', NULL, '27', '20', '59', '71', 2, 2, 0, 'Drawing, Dining', 6500000.00, 'Six Million Five Hundred Thousand', 0.00, 2.00, '', '', '', '', '', '2024-11-19'),
(159, 'Muzammil ', '', '0327-2040536', '', NULL, '27', '20', '63', '71', 2, 2, 0, 'Drawing, Dining', 2500000.00, 'Two Million Five Hundred Thousand', 0.00, 2.00, '', '', '', '', '', '2024-11-19'),
(160, '', '', '', '', NULL, '27', '20', '59', '71', 1, 1, 0, 'Common', 1500000.00, 'One Million Five Hundred Thousand', 0.00, 2.00, '', '', '', '', '', '2024-11-19'),
(161, 'Zeeshan', '', '0311-1292102', '', NULL, '27', '20', '59', '71', 2, 2, 0, 'Common', 3000000.00, 'Three Million', 0.00, 2.00, '', '', '', '', '', '2024-11-25'),
(162, 'Mr Lal', '', '0333-9282024', '', NULL, '27', '20', '59', '71', 3, 3, 0, 'Drawing, Dining', 30000000.00, 'Thirty Million', 0.00, 2.00, '', '', '', '', '', '2024-11-25'),
(163, 'Miss Farbah', '', '0337-3332396', '', NULL, NULL, NULL, NULL, NULL, 3, 3, 0, 'Drawing, Dining', 25000000.00, 'Twenty Five Million', 0.00, 2.00, '', '', '', '', '', '2024-11-25'),
(164, 'Jawaid', '', '0332-3449784', '', NULL, '27', '20', '59', '71', 2, 2, 0, 'Drawing, Dining', 10000000.00, 'Ten Million', 0.00, 2.00, '', '', '', '', '', '2024-11-27'),
(165, 'Hasnain', '', '0336-0818658', '', NULL, '27', '20', '59', '71', 2, 2, 0, 'Common', 5000000.00, 'Five Million', 0.00, 2.00, '', '', '', '', '', '2024-11-29'),
(166, 'Prakash', '', '0319-3529822', '', NULL, '27', '20', '59', '71', 3, 3, 0, 'Common', 3000000.00, 'Three Million', 0.00, 2.00, '', '', '', '', '', '2024-11-29'),
(167, 'M.Wasif', '', '0321-2741177', '', NULL, '27', '20', '59', '71', 2, 2, 0, 'Drawing', 12000000.00, 'Twelve Million', 0.00, 2.00, '', '', '', '', '', '2024-11-29'),
(168, 'Mustafa Ali', '', '0322-2385310', '', NULL, '27', '20', '59', '71', 2, 2, 0, 'Drawing', 7500000.00, 'Seven Million Five Hundred Thousand', 0.00, 2.00, '', '', '', '', '', '2024-11-30'),
(169, 'Mustafa ', '', '0320-1298532', '', NULL, '27', '20', '59', '71', 3, 3, 0, 'Common', 5000000.00, 'Five Million', 0.00, 2.00, '', '', '', '', '', '2024-12-01'),
(170, 'Asif', '', '0300-2235627', '', NULL, '27', '20', '59', '71', 2, 2, 0, 'Common', 5000000.00, '', 0.00, 2.00, '', '', '', '', '', '2024-12-01'),
(171, 'Miss AR', '', '0347-2053530', '', NULL, '27', '20', '59', '71', 2, 2, 0, 'Drawing', 13000000.00, 'Thirteen Million', 0.00, 2.00, '', '', '', '', '', '2024-12-07'),
(172, 'Ali Hussain ', '', '0315-2746040', '', NULL, '27', '20', '59', '71', 1, 1, 0, 'Common', 2500000.00, 'Two Million Five Hundred Thousand', 0.00, 2.00, '', '', '', '', '', '2024-12-07'),
(173, 'Waqas', '', '0324-2072364', '', NULL, '27', '20', '59', '71', 1, 1, 0, 'Common', 2500000.00, '', 0.00, 2.00, '', '', '', '', '', '2024-12-12'),
(174, 'Shezad', '', '0334-8648846', '', NULL, '27', '20', '59', '71', 3, 3, 0, 'Drawing, Dining', 28000000.00, 'Twenty Eight Million', 0.00, 2.00, '', '', '', '', '', '2024-12-17'),
(175, 'Amin', '', '0311-3252979', '', NULL, '27', '20', '59', '71', 2, 2, 0, 'Common', 3000000.00, 'Three Million', 0.00, 2.00, '', '', '', '', '', '2024-12-17'),
(176, 'Dr Paras', '', '0300-3693051', '', NULL, '27', '20', '59', '71', 2, 2, 0, 'Common', 7000000.00, 'Seven Million', 0.00, 2.00, '', '', '', '', '', '2024-12-14'),
(177, 'Nasir', '', '0322-2292231', '', NULL, '27', '20', '59', '71', 1, 1, 0, 'Common', 3000000.00, 'Three Million', 0.00, 2.00, '', '', '', '', '', '2024-12-15'),
(178, 'Ravi Roy', '', '0321-2993471', '', NULL, '27', '20', '59', '71', 3, 3, 0, 'Common', 6000000.00, 'Six Million', 0.00, 2.00, '', '', '', '', '', '2024-12-16'),
(179, 'Ravi Roy', '', '0321-2993471', '', NULL, '27', '20', '59', '71', 3, 3, 0, 'Common', 6000000.00, 'Six Million', 0.00, 2.00, '', '', '', '', '', '2024-12-16'),
(180, 'Ashok Kumar ', '', '0300-8313085', '', NULL, '27', '20', '59', '71', 1, 1, 0, 'Common', 3200000.00, 'Three Million Two Hundred Thousand', 0.00, 2.00, '', '', '', '', '', '2024-12-16'),
(181, 'Waseem', '', '0321-8941519', '', NULL, '27', '20', '59', '71', 2, 2, 0, 'Drawing', 7000000.00, 'Seven Million', 0.00, 2.00, '', '', '', '', '', '2024-12-20'),
(182, 'Asma', '', '0322-8282567', '', NULL, '27', '20', '59', '71', 2, 2, 0, 'Common', 6500000.00, 'Six Million Five Hundred Thousand', 0.00, 2.00, '', '', '', '', '', '2024-12-20'),
(183, 'Akber', '', '0315-2386940', '', NULL, '27', '20', '59', '71', 2, 2, 0, 'Common', 3000000.00, 'Three Million', 0.00, 2.00, '', '', '', '', '', '2024-12-26'),
(184, 'Waqar', '', '0345-2490358', '', NULL, '27', '20', '59', '71', 3, 3, 0, 'Drawing', 17500000.00, 'Seventeen Million Five Hundred Thousand', 0.00, 2.00, '', '', '', '', '', '2024-12-27'),
(185, 'Mrs Noushad Ahmed', '', '0336-2646815', '', '', '27', '20', '59', '71', 2, 2, 0, 'Common', 5000000.00, 'Five Million', 2.00, 0.00, '', '', '', '', '', '2025-03-01'),
(186, 'Abdul Raheem', '', '0331-2395338', '', NULL, '27', '20', '59', '71', 2, 2, 0, 'Common', 4000000.00, 'Four Million', 2.00, 0.00, '', '', '', '', '', '2025-03-02'),
(187, 'Raju', '', '0324-3171970', '', NULL, '30', '20', '59', '71', 2, 2, 0, 'Common', 550000.00, 'Five Hundred Fifty Thousand', 0.00, 0.00, '', '', '', '', '', '2025-04-20'),
(188, 'Jaffer', '', '0301-8250870', '', NULL, '30', '20', '59', '71', 2, 2, 0, 'Drawing', 10000000.00, 'Ten Million', 0.00, 2.00, '', '', '', '', '', '2025-04-14'),
(189, 'Anida Azhar Abbas', '', '0331-2070438', '', NULL, '30', NULL, '59', '71', 2, 2, 0, 'Drawing', 11500000.00, 'Eleven Million Five Hundred Thousand', 0.00, 2.00, '', '', '', '', '', '2025-04-14'),
(190, 'Mrs Akeel', '', '0336-2265542', '', '', '30', '20', '59', '71', 2, 2, 0, 'Drawing, Dining', 99999999.99, 'One Hundred Twenty Five Million', 0.00, 2.00, '', '', '', '', '', '2025-04-13'),
(191, 'Mustaffa', '', '0319-2414502', '', NULL, '30', '20', '59', '71', 2, 2, 0, 'Common', 0.00, '', 0.00, 0.00, '', '', '', '', 'Cash', '2025-04-09'),
(192, 'Shantilal', '', '0300-3977911', '', NULL, '30', '22', '59', '71', 3, 3, 0, 'Drawing', 12500000.00, 'Twelve Million Five Hundred Thousand', 0.00, 2.00, '', '', '', '', '', '2025-04-08'),
(193, 'Farhan', '', '0321-2869522', '', NULL, '30', NULL, '59', '71', 1, 1, 0, 'Common', 2500000.00, 'Two Million Five Hundred Thousand', 0.00, 0.00, '', '', '', '', '', '0000-00-00'),
(194, 'M.Usman', '', '0321-2286534', '', NULL, '30', '20', '59', '71', 1, 1, 0, 'Common', 2500000.00, 'Two Million Five Hundred Thousand', 0.00, 2.00, '', '', '', '', '', '2025-04-07'),
(195, 'Hamza', '', '0334-3808117', '', NULL, '30', NULL, '59', '71', 2, 0, 0, 'Common', 0.00, '', 0.00, 2.00, '', '', '', '', '', '0000-00-00'),
(196, 'Zahid', '', '0309-2382102', '', NULL, '30', '20', '59', '71', 2, 2, 0, 'Common', 6500000.00, 'Six Million Five Hundred Thousand', 0.00, 2.00, '', '', '', '', 'UBL bank loan', '2025-04-03'),
(197, 'Zain un nisa', '', '0342-2518056', '', NULL, '30', '20', '59', '71', 3, 3, 0, 'Dining', 7500000.00, 'Seven Million Five Hundred Thousand', 0.00, 2.00, '', '', '', '', 'Loan', '2025-04-03'),
(198, 'Jagdish', '', '0334-3734568', '', NULL, '30', '20', '59', '71', 3, 3, 0, 'Common', 6500000.00, 'Six Million Five Hundred Thousand', 0.00, 2.00, '', '', '', '', 'Cash', '2025-04-03'),
(199, 'Jamshed', '', '0316-4743406', '', NULL, '30', '20', '62', '28', 2, 2, 0, 'Common', 6000000.00, 'Six Million', 0.00, 2.00, '', '', '', '', 'Cash investment ', '2025-04-03'),
(200, 'Hussain naqvi', '', '0300-8202189', '', NULL, '30', '22', '59', '71', 3, 3, 0, 'Drawing', 25000000.00, 'Twenty Five Million', 0.00, 2.00, '', '', '', '', '', '2025-04-03'),
(201, 'Vinod', '', '0332-2564266', '', NULL, '31', '20', '59', '71', 2, 2, 0, 'Common', 35000000.00, 'Thirty Five Million', 0.00, 2.00, 'Vinod', '', '0332-2564266', '', 'Cash', '2025-03-26'),
(202, 'Raj Kumar', '', '0321-8973486', '', NULL, '30', '20', '59', '71', 3, 3, 0, 'Common', 3500000.00, 'Three Million Five Hundred Thousand', 0.00, 2.00, '', '', '', '', '', '2025-04-21');

-- --------------------------------------------------------

--
-- Table structure for table `marital_statuses`
--

CREATE TABLE `marital_statuses` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `status` enum('Active','Inactive') DEFAULT 'Active',
  `created_by` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `marital_statuses`
--

INSERT INTO `marital_statuses` (`id`, `name`, `status`, `created_by`, `created_at`) VALUES
(1, 'Single', 'Active', NULL, '2025-02-19 12:12:58'),
(2, 'Married', 'Active', NULL, '2025-02-19 12:12:58'),
(8, 'None', 'Active', NULL, '2025-03-25 10:30:12');

-- --------------------------------------------------------

--
-- Table structure for table `occupations`
--

CREATE TABLE `occupations` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `occupations`
--

INSERT INTO `occupations` (`id`, `name`, `created_at`) VALUES
(11, 'education', '2025-02-27 09:27:22'),
(12, 'Banker', '2025-02-27 09:30:03'),
(13, 'Judge', '2025-02-27 09:44:21'),
(14, 'Property Dealer', '2025-03-15 07:34:39');

-- --------------------------------------------------------

--
-- Table structure for table `payment_plan_templates`
--

CREATE TABLE `payment_plan_templates` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `installments` int(11) DEFAULT NULL,
  `status` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payment_plan_template_details`
--

CREATE TABLE `payment_plan_template_details` (
  `id` int(11) NOT NULL,
  `template_id` int(11) DEFAULT NULL,
  `installment_number` int(11) DEFAULT NULL,
  `percentage` decimal(5,2) DEFAULT NULL,
  `description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `priorities`
--

CREATE TABLE `priorities` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `priorities`
--

INSERT INTO `priorities` (`id`, `name`) VALUES
(18, 'high'),
(20, 'mod'),
(22, 'medium');

-- --------------------------------------------------------

--
-- Table structure for table `privileges`
--

CREATE TABLE `privileges` (
  `id` int(11) NOT NULL,
  `privilege_name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `projects`
--

CREATE TABLE `projects` (
  `project_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `plot_no` varchar(50) DEFAULT NULL,
  `years` int(11) DEFAULT NULL,
  `land_mark` varchar(255) DEFAULT NULL,
  `country_id` int(11) DEFAULT NULL,
  `city_id` int(11) DEFAULT NULL,
  `area_id` int(11) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `builder_name` varchar(100) NOT NULL,
  `builder_cell` varchar(20) DEFAULT NULL,
  `builder_dob` date DEFAULT NULL,
  `builder_address` text DEFAULT NULL,
  `builder_remarks` text DEFAULT NULL,
  `project_features` text DEFAULT NULL,
  `project_photo` varchar(255) DEFAULT NULL,
  `builder_photo` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `projects`
--

INSERT INTO `projects` (`project_id`, `name`, `plot_no`, `years`, `land_mark`, `country_id`, `city_id`, `area_id`, `address`, `builder_name`, `builder_cell`, `builder_dob`, `builder_address`, `builder_remarks`, `project_features`, `project_photo`, `builder_photo`, `created_at`, `updated_at`) VALUES
(137, 'Taj Terrace', 'JM 00', 2000, 'Aross bakery', 14, 14, 22, '', 'Ali Lilani', '03333111470', '1983-05-11', 'Plot No 188/B, Flat 10 , 4th floor Zohra Garden', '', 'Bike Parking,Bank Loan', 'uploads/project_67e85403e1b24.jpeg', 'uploads/builder_67e85403e1cc1.jpeg', '2025-02-28 16:09:03', '2025-03-29 20:11:47'),
(139, 'M L Heights', 'JM 138 -139', 2000, 'Saqib Bakery', NULL, 14, 21, '', '', '', '0000-00-00', '', '', 'CCTV,Car Parking,Intercom,Bank Loan', '', '', '2025-02-28 16:21:36', '2025-02-28 16:21:36'),
(144, 'Al Rauf Gold Raas', '400', 0, '', 15, 10, 12, '', 'None', '12-4532-321', NULL, NULL, '', '', '', '', '2025-02-28 17:11:07', '2025-03-18 08:57:24'),
(151, 'Shareef Manzil', '', 0, 'Qadri Medical', 14, NULL, 19, '', '', '', '0000-00-00', '', '', 'Project Completion Certificate,Bank Loan', '', '', '2025-03-05 16:44:17', '2025-03-05 16:44:17'),
(156, 'Qadir Manzil', '', 0, 'Mehboob Kitchen', 14, 14, 19, 'soldier bazar 2 bori masjid', '', '', '0000-00-00', '', '', 'Project Completion Certificate,Bank Loan', '', '', '2025-03-06 11:19:28', '2025-03-06 11:19:28'),
(157, 'Al Rehman Arcade', '', 0, 'Lakhpatti hall', 14, 14, 26, 'Garden East', 'None', '0321-1231456', NULL, NULL, '', 'Car Parking,Project Completion Certificate,Bank Loan', '', '', '2025-03-06 11:40:52', '2025-03-07 16:48:52'),
(158, 'Taj Prince', '', 0, 'Agah Khan Hospital', 14, 14, 27, 'Patel Para', '', '', '0000-00-00', '', '', 'Car Parking', '', '', '2025-03-07 09:28:35', '2025-03-07 09:28:35'),
(159, 'Sher Mohd Manzil', '182', 0, 'Gyser Gali', 14, 14, 19, 'soldier bazar 2 bori masjid', '', '', '0000-00-00', '', '', '', '', '', '2025-03-07 09:45:15', '2025-03-07 09:45:15'),
(160, 'Haya Palace', '', 0, 'Nagori Milk', 14, 14, 19, '', '', '', '0000-00-00', '', '', '', '', '', '2025-03-07 10:55:40', '2025-03-07 10:55:40'),
(161, 'Taitanic', '', 0, 'Sakhawat Roll Point', 14, 14, 25, 'soldier bazar 1 sakhawat roll', '', '', '0000-00-00', '', '', '', '', '', '2025-03-07 11:02:44', '2025-03-07 11:02:44'),
(162, 'Sonia Heights', 'JM-933', 2000, 'Yameen', 14, 14, 20, 'Near Nale wali Gali', '', '', '0000-00-00', '', '', 'Lift,CCTV,Car Parking', '', '', '2025-03-07 16:01:46', '2025-03-07 16:01:46'),
(163, 'Al Raza Mansion', '', 0, 'Saqib Bakery', 14, 14, 21, 'Parsi Colony', '', '', '0000-00-00', '', '', 'Car Parking', '', '', '2025-03-07 16:53:56', '2025-03-07 16:53:56'),
(164, 'Kashan e Zainab', '', 0, 'Allah Tawakkal Estate', 14, 14, 19, '', 'None', '0321-1231456', NULL, NULL, '', '', '', '', '2025-03-07 17:19:55', '2025-03-07 17:19:55'),
(165, 'Marium Manzil', '', 0, '', 14, 14, 25, '', '', '', '0000-00-00', '', '', '', '', '', '2025-03-08 10:30:50', '2025-03-08 10:30:50'),
(166, 'Miskin Manzil ', '', 0, 'Hanuman Mandir', 14, 14, 19, '', '', '', '0000-00-00', '', '', '', '', '', '2025-03-08 10:32:25', '2025-03-08 10:32:25'),
(167, 'Batool Zehra', '', 0, 'Makkar Kabari', 14, 14, 25, '', '', '', '0000-00-00', '', '', '', '', '', '2025-03-08 10:33:40', '2025-03-08 10:33:40'),
(168, 'Razia Sultana ', '', 0, 'Christian Behtak', 14, 14, 19, '', '', '', '0000-00-00', '', '', '', '', '', '2025-03-08 10:35:11', '2025-03-08 10:35:11'),
(169, 'Nida Heights', '', 0, 'Gul e Rana Colony ', 14, 14, 25, '', '', '', '0000-00-00', '', '', '', '', '', '2025-03-08 10:36:28', '2025-03-08 10:36:28'),
(170, 'Crown Comfort', '', 2000, 'Old Hussain Blood Bank', 14, 14, 21, '', 'None', '12-4532-321', NULL, NULL, '', 'Lift,CCTV,Car Parking,Intercom,Kid Area,Waiting Area', '', '', '2025-03-08 17:49:01', '2025-03-18 08:58:10'),
(171, 'Afshan Arcade', '', 0, 'Time Medico', 14, 14, 20, 'soldier bazar no 3', '', '', '0000-00-00', '', '', 'Car Parking,Bike Parking', '', '', '2025-03-12 11:25:24', '2025-03-12 11:25:24'),
(172, 'Rehman Plaza', '', 0, '7Day Hospital', 14, 14, 23, 'lines area', '', '', '0000-00-00', '', '', 'Lift,Bike Parking', '', '', '2025-03-12 11:29:42', '2025-03-12 11:29:42'),
(173, 'Super Mahal', '', 0, 'Sunny Plaza', 14, 14, NULL, '', '', '', '0000-00-00', '', '', 'Lift,Car Parking,Bike Parking', '', '', '2025-03-12 11:33:04', '2025-03-12 11:33:04'),
(174, 'Humera Appartment', '', 0, 'Irfan School', 14, 14, 21, 'Parsi Colony', '', '', '0000-00-00', '', '', 'Lift,Car Parking,Bike Parking,Project Completion Certificate,Bank Loan', '', '', '2025-03-13 17:20:33', '2025-03-13 17:20:33'),
(175, 'Nazeer Heights', '', 0, 'Pak Night Clinic', 14, 14, 21, '', '', '', '0000-00-00', '', '', 'Lift,Car Parking,Generator', '', '', '2025-03-13 17:33:47', '2025-03-13 17:33:47'),
(176, 'Hasrat Mohani Colony', '541-A', 0, 'Jamma Masjid HBL Main Road', 14, 14, 30, '', '', '', '0000-00-00', '', '', '', '', '', '2025-03-14 17:01:24', '2025-03-14 17:01:24'),
(177, 'Mosani Appartment', '', 0, 'Hyder Bakery', 14, 14, 25, '', '', '', '0000-00-00', '', '', '', '', '', '2025-03-14 17:16:34', '2025-03-14 17:16:34'),
(178, 'Heaven Heights', '', 0, 'Ayesha Masjid', 14, 14, 21, '', '', '', '0000-00-00', '', '', 'Lift,Car Parking,Bike Parking', '', '', '2025-03-14 17:24:33', '2025-03-14 17:24:33'),
(179, 'Maria Garden', 'JM 00', 2018, 'Sher Bano Bhag', 14, 14, 31, '', '', '', '0000-00-00', '', '', 'Lift,Car Parking,Bank Loan', '', '', '2025-03-14 18:26:31', '2025-03-14 18:26:31'),
(180, 'Huda Arcade', '', 0, '', 14, 14, 35, '', '', '', '0000-00-00', '', '', '', '', '', '2025-03-15 10:11:04', '2025-03-15 10:11:04'),
(181, 'UBL Building', '', 0, 'Blue Ribbon Bakery ', 14, 14, 22, 'Gurumandir, Blue Ribbon Bakery ', '', '', '0000-00-00', '', '', '', '', '', '2025-03-15 10:22:00', '2025-03-15 10:22:00'),
(182, 'Kulsoom Heights', '', 0, '', NULL, 14, 35, 'soldier bazar 1 katchi para', '', '', '0000-00-00', '', '', '', '', '', '2025-03-15 10:33:24', '2025-03-15 10:33:24'),
(183, 'Ghafoor Manzil', '', 0, 'Sahi Ka Maidan', 14, 14, 19, '', '', '', '0000-00-00', '', '', 'Bike Parking', '', '', '2025-03-15 10:46:03', '2025-03-15 10:46:03'),
(184, 'Shayan Square', '', 0, 'Bori Masjid', 14, 14, 23, 'saddar bori masjid', '', '', '0000-00-00', '', '', 'Bike Parking', '', '', '2025-03-15 11:01:23', '2025-03-15 11:01:23'),
(185, 'Gulshan e Alima', '', 0, 'Qasim Auto ', 14, 14, 19, 'soldier bazar 2 opposite lane of sameer estate', '', '', '0000-00-00', '', '', '', '', '', '2025-03-15 17:41:37', '2025-03-15 17:41:37'),
(186, 'Usman Arcade', '', 0, 'Phool Wala', 14, 14, 25, 'soldier bazar 1 punjab town', '', '', '0000-00-00', '', '', '', '', '', '2025-03-15 17:57:19', '2025-03-15 17:57:19'),
(187, 'Ali Homes', '', 0, 'HBL Metro', 14, 14, 19, 'soldier bazar 2 hbl metro', '', '', '0000-00-00', '', '', '', '', '', '2025-03-15 18:09:44', '2025-03-15 18:09:44'),
(188, 'JJ Appartment', '', 0, 'Hussaini Blood Bank', 14, 14, 21, 'Parsi Colony hussaini blood bank', '', '', '0000-00-00', '', '', 'Lift,Car Parking,Bike Parking,Generator', '', '', '2025-03-18 08:23:11', '2025-03-18 08:23:11'),
(189, 'Bano Plaza', '650', 0, 'Lakhpatti lawn', 14, 14, 26, 'garden east near lakhpatti lawn', '', '', '0000-00-00', '', '', 'Car Parking,Bike Parking', '', '', '2025-03-18 08:26:06', '2025-03-18 08:26:06'),
(190, 'Lakhani Appartment', '', 0, '', 14, 14, 25, 'soldier bazar 1 punjab town', '', '', '0000-00-00', '', '', '', '', '', '2025-03-18 08:27:54', '2025-03-18 08:27:54'),
(191, 'Nagori Square', '', 0, 'Taj Petrol Pump', 14, 14, 19, 'soldier bazar 2 opposite lane of sameer estate', '', '', '0000-00-00', '', '', '', '', '', '2025-03-18 08:30:41', '2025-03-18 08:30:41'),
(192, 'ZamZam Arcade', '', 0, 'Saqib Bakery', 14, 14, 21, 'Parsi Colony Saqib Bakery', '', '', '0000-00-00', '', '', 'Lift,Car Parking,Bike Parking,Generator', '', '', '2025-03-18 08:33:29', '2025-03-18 08:33:29'),
(193, 'Dawood Residency', '', 0, 'Luqman Samosa', 14, 14, 19, 'soldier bazar 2 luqman samosa', '', '', '0000-00-00', '', '', '', '', '', '2025-03-18 08:35:57', '2025-03-18 08:35:57'),
(194, 'ML Paradise', '', 0, 'Pak Night Clinic', 14, 14, 19, 'soldier bazar 2 nishter park', '', '', '0000-00-00', '', '', 'Car Parking,Bike Parking', '', '', '2025-03-18 08:39:17', '2025-03-18 08:39:17'),
(195, 'Usman Building', '', 0, '', 14, 14, 19, '', '', '', '0000-00-00', '', '', '', '', '', '2025-03-18 08:40:53', '2025-03-18 08:40:53'),
(196, 'Shams Avenue', '', 0, '', 14, 14, 21, 'Parsi Colony old husaini blood', '', '', '0000-00-00', '', '', 'Lift,Car Parking,Bike Parking,Generator', '', '', '2025-03-18 08:43:29', '2025-03-18 08:43:29'),
(197, 'Zainabia Building', '', 0, 'Chai Wala Hotel', 14, 14, 19, 'ghosia chowk sameer estate opposite', '', '', '0000-00-00', '', '', '', '', '', '2025-03-18 08:46:21', '2025-03-18 08:46:21'),
(198, 'Zulekha Bai Manzil', 'A-118/119', 0, '', 14, 14, 25, '', '', '', '0000-00-00', '', '', '', '', '', '2025-03-18 08:47:59', '2025-03-18 08:47:59'),
(199, 'Sara Manzil', '', 0, 'Sajjad Bakery', 14, 14, 19, 'soldier bazar 2 opposite lane of sameer estate', '', '', '0000-00-00', '', '', '', '', '', '2025-03-18 09:15:42', '2025-03-18 09:15:42'),
(200, 'Kausar Homes', '', 0, 'MQM Nasir Baig Building', 14, 14, 25, '', '', '', '0000-00-00', '', '', '', '', '', '2025-03-18 09:31:24', '2025-03-18 09:31:24'),
(201, 'Nazra Manzil', '', 0, '', 14, 14, 19, '', '', '', '0000-00-00', '', '', '', '', '', '2025-03-18 09:38:48', '2025-03-18 09:38:48'),
(202, 'Younus Mansion', '', 0, 'Shaheed Masjid', 14, 14, 37, 'kharadar shjaheed masjid', '', '', '0000-00-00', '', '', '', '', '', '2025-03-18 09:48:34', '2025-03-18 09:48:34'),
(203, 'Qasr e Zainab', '', 0, '', 14, 14, 25, '', '', '', '0000-00-00', '', '', '', '', '', '2025-03-18 09:53:00', '2025-03-18 09:53:00'),
(204, 'Hamza Homes', '', 0, 'Phool Wali Gali', 14, 14, 29, 'soldier bazar phool gali ke samne ghore gari walon ke peeche gali', '', '', '0000-00-00', '', '', '', '', '', '2025-03-18 17:12:21', '2025-03-18 17:12:21'),
(205, 'Naila Square', '', 0, 'Cycle Market', 14, 14, 39, 'Light House cycle market', '', '', '0000-00-00', '', '', '', '', '', '2025-03-18 17:36:38', '2025-03-18 17:36:38'),
(206, 'Ameer ul lah Building', '', 0, 'Christian Bhaitak ', 14, 14, 19, 'soldier bazar 2 christian bhaitak', '', '', '0000-00-00', '', '', '', '', '', '2025-03-18 17:44:43', '2025-03-18 17:44:43'),
(207, 'Zainab Arcade', '', 0, 'Raza Dairy Milk', 14, 14, 20, 'soldier bazar raza dairy milk', '', '', '0000-00-00', '', '', '', '', '', '2025-03-18 17:55:04', '2025-03-18 17:55:04'),
(208, 'Zohra Garden', '', 0, 'JDC Zahra Foundation', 14, 14, 20, 'kmc hospital soldier bazar 3', '', '', '0000-00-00', '', '', '', '', '', '2025-03-23 07:18:46', '2025-03-23 07:18:46'),
(209, 'Mustaffa Arcade', '', 0, 'Shell Petrol Pump', 14, 14, 41, '', '', '', '0000-00-00', '', '', '', '', '', '2025-03-23 07:28:53', '2025-03-23 07:28:53'),
(210, 'Apple ', '', 0, 'Adam Square', 14, 14, 19, 'taj petrol pump soldier bazar', '', '', '0000-00-00', '', '', '', '', '', '2025-03-23 07:37:57', '2025-03-23 07:37:57'),
(211, 'Fatima Residency', '', 0, 'Hadi Dairy Milk', 14, 14, 19, 'soldier bazar 2 hadi dairy milk opposite', '', '', '0000-00-00', '', '', '', '', '', '2025-03-24 17:31:15', '2025-03-24 17:31:15'),
(212, 'Maira Garden', '', 0, 'Sherbano Bagh', 14, 14, 42, 'jilani masjid garden west fawara chowk', '', '', '0000-00-00', '', '', 'Lift,Car Parking,Bike Parking', '', '', '2025-03-24 17:34:20', '2025-03-24 17:34:20'),
(213, 'Khadija Royal Residency', '', 0, 'Fatimiyah Jammat Sport Complex', 14, 14, 43, 'soldier bazar 3 near nishter park ', '', '', '0000-00-00', '', '', 'Lift,Car Parking,Generator', '', '', '2025-03-24 17:39:43', '2025-03-24 17:39:43'),
(214, 'Mudassir Terrace', '', 0, 'Charming Beaty Parlour', 14, 14, 25, 'soldier bazar 1 near pak discount store', '', '', '0000-00-00', '', '', '', '', '', '2025-03-24 17:42:31', '2025-03-24 17:42:31'),
(215, 'Lakhani Palace', '', 0, 'Phool Wali Gali', 14, 14, 29, 'punjab town phool gali soldier bazar 1', '', '', '0000-00-00', '', '', 'Lift,Car Parking,Bike Parking', '', '', '2025-03-24 17:49:24', '2025-03-24 17:49:24'),
(216, 'Zain Arcade', '', 0, 'Hashmani Hospital', 14, 14, 44, 'lines area near ali raza imam bargah', '', '', '0000-00-00', '', '', '', '', '', '2025-03-24 17:51:54', '2025-03-24 17:51:54'),
(217, 'Imperral Garden', 'JM 00', 0, 'Near Hassan Heights', 14, 14, 20, 'Near Nale wali Gali', '', '', '0000-00-00', '', '', 'Lift,CCTV,Car Parking', '', '', '2025-03-25 10:36:29', '2025-03-25 10:36:29'),
(218, 'Everest', '', 0, 'Huma beauty parlour ', 14, 14, 43, 'Soldier bazaar 3 fatimiyah hospital gali', '', '', '0000-00-00', '', '', 'Car Parking,Bike Parking', '', '', '2025-03-28 17:08:07', '2025-03-28 17:08:07'),
(219, 'Sidiqia Heights', '', 0, 'Sidiqia Masjid', 14, 14, 19, 'Taj Petrol Pump Gali medical ke bad', '', '', '0000-00-00', '', '', '', '', '', '2025-04-07 12:24:33', '2025-04-07 12:24:33'),
(220, 'Wali Heights ', '', 0, 'Ali Medical Clinic near Nishter park ', 14, 14, 21, 'Parsi colony opposite to Lakhani crystal', '', '', '0000-00-00', '', '', 'Lift,Car Parking,Bike Parking,Project Completion Certificate,Bank Loan', '', '', '2025-04-07 12:33:05', '2025-04-07 12:33:05'),
(221, 'Madina classic', '', 0, 'Madina Masjid', 14, 14, 45, '28/6 Nazimabad no 1', '', '', '0000-00-00', '', '', 'Project Completion Certificate,Bank Loan', '', '', '2025-04-07 12:54:11', '2025-04-07 12:54:11'),
(222, 'Ali Raza Builder Building ', '', 0, 'Soldier bazaar no 1 police station ', 14, 14, 25, 'Soldier bazaar police station opposite', 'Ali Raza Builder (SB)', '03012219456', NULL, NULL, '', '', '', '', '2025-04-07 13:10:13', '2025-04-07 13:10:13'),
(223, 'Noor Manzil', '', 0, '', 14, 14, 25, 'Soldier bazaar 1 bhanghi para', '', '', '0000-00-00', '', '', 'Project Completion Certificate,Bank Loan', '', '', '2025-04-07 13:54:41', '2025-04-07 13:54:41'),
(224, 'Khurasan Pride', 'JM 178', 2024, 'Quba Masjid', 14, NULL, 20, '', '', '', '0000-00-00', '', '', 'Lift,CCTV,Car Parking,Intercom,Generator,Waiting Area', '', '', '2025-04-07 17:34:26', '2025-04-07 17:34:26'),
(225, 'Tauheed Manzil ', '', 0, 'Mahboob ketchen  ', 14, 14, 19, 'Tauheed Manzil near Taj pump Soldier bazaar no 2', '', '', '0000-00-00', '', '', '', 'uploads/project_68131ff96d7ca.jpg', '', '2025-05-01 07:17:13', '2025-05-01 07:17:13'),
(226, 'S.M  Appartment ', 'JM 1/65', 0, 'Ayesha Masjid ', 14, 14, 21, 'S.M Appartment near Ayesha Masjid ', '', '', '0000-00-00', '', '', 'Lift,CCTV,Car Parking,Bike Parking,Intercom,Masjid', 'uploads/project_6813215cbccac.jpg', '', '2025-05-01 07:23:08', '2025-05-01 07:23:08'),
(227, 'Habib Manzil ', '', 0, 'Taj pump ', 14, 14, 19, 'Habib Manzil near Taj pump Soldier bazaar no 2 ', '', '', '0000-00-00', '', '', '', 'uploads/project_6813226a32601.jpg', '', '2025-05-01 07:27:38', '2025-05-01 07:27:38'),
(229, 'Sumara Arcare ', '', 0, 'Police Station ', 14, 14, 25, 'Sumara Arcare near Police Station soldier bazar no 1', '', '', '0000-00-00', '', '', '', 'uploads/project_68132452770fe.jpg', '', '2025-05-01 07:35:46', '2025-05-01 07:35:46'),
(230, 'Usman building ', '41', 0, 'Baghdadi pulao ', 14, 14, 25, 'Usman building near baghdadi pulao soldier bazar no 1', '', '', '0000-00-00', '', '', '', 'uploads/project_68132587899f6.jpg', '', '2025-05-01 07:40:55', '2025-05-01 07:40:55'),
(231, 'Almadni Plaza ', '10, 34 1/1', 0, 'Chase Plus ', 14, 14, 42, 'Almadni Plaza near Chase Plus Garden West Karachi ', '', '', '0000-00-00', '', '', 'Car Parking,Bike Parking', 'uploads/project_681326df2707c.jpg', '', '2025-05-01 07:46:39', '2025-05-01 07:46:39'),
(232, '', '', 0, '', NULL, NULL, NULL, '', '', '', '0000-00-00', '', '', '', '', NULL, '2025-05-06 12:20:31', '2025-05-06 12:20:31'),
(233, '', '', 0, '', NULL, NULL, NULL, '', '', '', '0000-00-00', '', '', '', '', NULL, '2025-05-06 12:20:32', '2025-05-06 12:20:32'),
(234, '', '', 0, '', NULL, NULL, NULL, '', '', '', '0000-00-00', '', '', '', '', NULL, '2025-05-06 12:20:32', '2025-05-06 12:20:32'),
(235, '', '', 0, '', NULL, NULL, NULL, '', '', '', '0000-00-00', '', '', '', '', NULL, '2025-05-06 12:20:33', '2025-05-06 12:20:33'),
(236, '', '', 0, '', NULL, NULL, NULL, '', '', '', '0000-00-00', '', '', '', '', NULL, '2025-05-06 12:20:49', '2025-05-06 12:20:49'),
(237, '', '', 0, '', NULL, NULL, NULL, '', '', '', '0000-00-00', '', '', '', '', NULL, '2025-05-06 12:22:03', '2025-05-06 12:22:03'),
(238, '', '', 0, '', NULL, NULL, NULL, '', '', '', '0000-00-00', '', '', '', '', NULL, '2025-05-06 12:26:33', '2025-05-06 12:26:33'),
(239, '', '', 0, '', NULL, NULL, NULL, '', '', '', '0000-00-00', '', '', '', '', NULL, '2025-05-06 12:27:13', '2025-05-06 12:27:13'),
(240, '', '', 0, '', NULL, NULL, NULL, '', '', '', '0000-00-00', '', '', '', '', NULL, '2025-05-06 12:29:07', '2025-05-06 12:29:07'),
(241, '', '', 0, '', NULL, NULL, NULL, '', '', '', '0000-00-00', '', '', '', '', NULL, '2025-05-06 12:29:48', '2025-05-06 12:29:48'),
(242, '', '', 0, '', NULL, NULL, NULL, '', '', '', '0000-00-00', '', '', '', '', NULL, '2025-05-06 12:30:19', '2025-05-06 12:30:19'),
(243, '', '', 0, '', NULL, NULL, NULL, '', '', '', '0000-00-00', '', '', '', '', NULL, '2025-05-06 12:32:21', '2025-05-06 12:32:21'),
(244, '', '', 0, '', NULL, NULL, NULL, '', '', '', '0000-00-00', '', '', '', '', NULL, '2025-05-06 12:33:12', '2025-05-06 12:33:12'),
(245, '', '', 0, '', NULL, NULL, NULL, '', '', '', '0000-00-00', '', '', '', '', NULL, '2025-05-06 12:33:48', '2025-05-06 12:33:48'),
(246, '', '', 0, '', NULL, NULL, NULL, '', '', '', '0000-00-00', '', '', '', '', NULL, '2025-05-06 12:34:17', '2025-05-06 12:34:17'),
(247, '', '', 0, '', NULL, NULL, NULL, '', '', '', '0000-00-00', '', '', '', '', NULL, '2025-05-06 12:35:37', '2025-05-06 12:35:37'),
(248, '', '', 0, '', NULL, NULL, NULL, '', '', '', '0000-00-00', '', '', '', '', NULL, '2025-05-06 12:43:58', '2025-05-06 12:43:58'),
(249, 'Huma Heights', 'JM 00', 0, 'Near Nasira Scholl', 14, 14, 49, '', '', '', '0000-00-00', '', '', 'Lift,Bike Parking', '', NULL, '2025-06-03 08:47:55', '2025-06-03 08:47:55');

-- --------------------------------------------------------

--
-- Table structure for table `projects_backup`
--

CREATE TABLE `projects_backup` (
  `id` int(11) NOT NULL DEFAULT 0,
  `name` varchar(100) NOT NULL,
  `location` varchar(255) DEFAULT NULL,
  `developer` varchar(100) DEFAULT NULL,
  `status` enum('Active','Inactive','Completed','Under Construction') DEFAULT 'Active',
  `code` varchar(20) DEFAULT NULL,
  `plot_no` varchar(100) DEFAULT NULL,
  `duration_years` int(11) DEFAULT NULL,
  `land_mark` varchar(255) DEFAULT NULL,
  `builder_id` int(11) DEFAULT NULL,
  `country_id` int(11) DEFAULT NULL,
  `area_id` int(11) DEFAULT NULL,
  `city_id` int(11) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `latitude` decimal(10,8) DEFAULT NULL,
  `longitude` decimal(11,8) DEFAULT NULL,
  `completion_percentage` int(11) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `created_by` int(11) DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `project_documents_backup`
--

CREATE TABLE `project_documents_backup` (
  `id` int(11) NOT NULL DEFAULT 0,
  `project_id` int(11) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `file_path` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `uploaded_by` int(11) DEFAULT NULL,
  `uploaded_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `project_document_categories`
--

CREATE TABLE `project_document_categories` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `is_system` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `project_features`
--

CREATE TABLE `project_features` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `status` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `project_features`
--

INSERT INTO `project_features` (`id`, `name`, `status`, `created_at`) VALUES
(1, 'Lift', 1, '2025-02-13 07:33:48'),
(2, 'Cargo Lift', 1, '2025-02-13 07:33:48'),
(3, 'CCTV', 1, '2025-02-13 07:33:48'),
(4, 'Car Parking', 1, '2025-02-13 07:33:48'),
(5, 'Bike Parking', 1, '2025-02-13 07:33:48'),
(6, 'Intercom', 1, '2025-02-13 07:33:48'),
(7, 'Generator', 1, '2025-02-13 07:33:48'),
(8, 'Kid Area', 1, '2025-02-13 07:33:48'),
(9, 'Gym', 1, '2025-02-13 07:33:48'),
(10, 'Waiting Area', 1, '2025-02-13 07:33:48'),
(11, 'Masjid', 1, '2025-02-13 07:33:48'),
(12, 'Project Completion Certificate', 1, '2025-02-13 07:33:48'),
(13, 'Bank Loan', 1, '2025-02-13 07:33:48');

-- --------------------------------------------------------

--
-- Table structure for table `project_features_backup`
--

CREATE TABLE `project_features_backup` (
  `id` int(11) NOT NULL DEFAULT 0,
  `project_id` int(11) DEFAULT NULL,
  `feature_id` int(11) DEFAULT NULL,
  `custom_value` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `project_floors_backup`
--

CREATE TABLE `project_floors_backup` (
  `id` int(11) NOT NULL DEFAULT 0,
  `project_id` int(11) DEFAULT NULL,
  `floor_number` int(11) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `status` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `project_landmarks_backup`
--

CREATE TABLE `project_landmarks_backup` (
  `id` int(11) NOT NULL DEFAULT 0,
  `project_id` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `distance` varchar(50) DEFAULT NULL,
  `coordinates` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `project_milestones_backup`
--

CREATE TABLE `project_milestones_backup` (
  `id` int(11) NOT NULL DEFAULT 0,
  `project_id` int(11) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `planned_date` date DEFAULT NULL,
  `actual_date` date DEFAULT NULL,
  `status` enum('pending','in_progress','completed','delayed') DEFAULT 'pending',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `project_notifications_backup`
--

CREATE TABLE `project_notifications_backup` (
  `id` int(11) NOT NULL DEFAULT 0,
  `project_id` int(11) DEFAULT NULL,
  `type` enum('payment_due','document_expiry','milestone_update','booking_status') DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `message` text DEFAULT NULL,
  `scheduled_date` datetime DEFAULT NULL,
  `status` enum('pending','sent','failed') DEFAULT 'pending',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `project_photos_backup`
--

CREATE TABLE `project_photos_backup` (
  `id` int(11) NOT NULL DEFAULT 0,
  `project_id` int(11) DEFAULT NULL,
  `type` enum('project','builder','unit','construction_update') DEFAULT NULL,
  `file_path` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `is_primary` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `project_selected_features`
--

CREATE TABLE `project_selected_features` (
  `id` int(11) NOT NULL,
  `project_id` int(11) NOT NULL,
  `feature_id` int(11) DEFAULT NULL,
  `custom_feature_name` varchar(100) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `project_status_history_backup`
--

CREATE TABLE `project_status_history_backup` (
  `id` int(11) NOT NULL DEFAULT 0,
  `project_id` int(11) DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `reason` text DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `changed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `project_units_backup`
--

CREATE TABLE `project_units_backup` (
  `id` int(11) NOT NULL DEFAULT 0,
  `project_id` int(11) DEFAULT NULL,
  `floor_id` int(11) DEFAULT NULL,
  `unit_type_id` int(11) DEFAULT NULL,
  `unit_number` varchar(20) DEFAULT NULL,
  `area_sqft` decimal(10,2) DEFAULT NULL,
  `direction` varchar(50) DEFAULT NULL,
  `base_price` decimal(15,2) DEFAULT NULL,
  `status` enum('available','sold','reserved','maintenance') DEFAULT 'available',
  `parking_spots` int(11) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `project_updates_backup`
--

CREATE TABLE `project_updates_backup` (
  `id` int(11) NOT NULL DEFAULT 0,
  `project_id` int(11) DEFAULT NULL,
  `field_name` varchar(50) DEFAULT NULL,
  `old_value` text DEFAULT NULL,
  `new_value` text DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `property_types`
--

CREATE TABLE `property_types` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `property_types`
--

INSERT INTO `property_types` (`id`, `name`) VALUES
(28, 'apartment'),
(71, 'Residential'),
(72, 'Commercial');

-- --------------------------------------------------------

--
-- Table structure for table `purchasers`
--

CREATE TABLE `purchasers` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `purchasers`
--

INSERT INTO `purchasers` (`id`, `name`) VALUES
(1, 'Ali');

-- --------------------------------------------------------

--
-- Table structure for table `purchases`
--

CREATE TABLE `purchases` (
  `id` int(11) NOT NULL,
  `purchase_number` varchar(50) NOT NULL,
  `date` date NOT NULL,
  `supplier_name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `quantity` int(11) NOT NULL,
  `total_amount` decimal(15,2) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `purchase_returns`
--

CREATE TABLE `purchase_returns` (
  `id` int(11) NOT NULL,
  `return_number` varchar(50) NOT NULL,
  `date` date NOT NULL,
  `supplier_name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `quantity` int(11) NOT NULL,
  `amount` decimal(15,2) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `receive_voucher`
--

CREATE TABLE `receive_voucher` (
  `id` int(11) NOT NULL,
  `account_id` int(11) DEFAULT NULL,
  `bank_account_id` int(11) DEFAULT NULL,
  `mode_of_payment` varchar(50) DEFAULT NULL,
  `debit_amount` decimal(10,2) DEFAULT NULL,
  `slip_check_no` varchar(50) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `date` date DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `receive_vouchers`
--

CREATE TABLE `receive_vouchers` (
  `id` int(11) NOT NULL,
  `voucher_number` varchar(50) NOT NULL,
  `date` date NOT NULL,
  `account_title` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `amount` decimal(15,2) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `receive_voucher_journal`
--

CREATE TABLE `receive_voucher_journal` (
  `id` int(11) NOT NULL,
  `receive_voucher_id` int(11) NOT NULL,
  `account_id` int(11) DEFAULT NULL,
  `debit_amount` decimal(10,2) DEFAULT NULL,
  `credit_amount` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ref_table`
--

CREATE TABLE `ref_table` (
  `id` int(11) NOT NULL,
  `ref_name` varchar(255) NOT NULL,
  `ref_cnic` varchar(15) DEFAULT NULL,
  `ref_cell` varchar(15) DEFAULT NULL,
  `note` varchar(500) NOT NULL,
  `remarks` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `ref_table`
--

INSERT INTO `ref_table` (`id`, `ref_name`, `ref_cnic`, `ref_cell`, `note`, `remarks`) VALUES
(2, 'John Doe', '12345-6789012-3', '03001234567', 'Trusted person', 'Referred by client X');

-- --------------------------------------------------------

--
-- Table structure for table `religions`
--

CREATE TABLE `religions` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `status` enum('Active','Inactive') DEFAULT 'Active',
  `created_by` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `religions`
--

INSERT INTO `religions` (`id`, `name`, `status`, `created_by`, `created_at`) VALUES
(1, 'Islam', 'Active', NULL, '2025-02-19 16:46:11'),
(2, 'Hindu', 'Active', NULL, '2025-02-19 16:46:11');

-- --------------------------------------------------------

--
-- Table structure for table `rents`
--

CREATE TABLE `rents` (
  `id` int(11) NOT NULL,
  `lead_id` int(11) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `cast_id` int(11) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `cell` varchar(20) DEFAULT NULL,
  `cnic` varchar(20) DEFAULT NULL,
  `bed_rooms` int(11) DEFAULT NULL,
  `bath` int(11) DEFAULT NULL,
  `floor` int(11) DEFAULT NULL,
  `block` varchar(50) DEFAULT NULL,
  `sqft` decimal(10,2) DEFAULT NULL,
  `drawing` tinyint(1) DEFAULT 0,
  `dining` tinyint(1) DEFAULT 0,
  `roof` tinyint(1) DEFAULT 0,
  `store` tinyint(1) DEFAULT 0,
  `common` tinyint(1) DEFAULT 0,
  `separate_gate` tinyint(1) DEFAULT 0,
  `basement` tinyint(1) DEFAULT 0,
  `mezzanine` tinyint(1) DEFAULT 0,
  `west_open` tinyint(1) DEFAULT 0,
  `back` tinyint(1) DEFAULT 0,
  `gas` tinyint(1) DEFAULT 0,
  `corner` tinyint(1) DEFAULT 0,
  `front` tinyint(1) DEFAULT 0,
  `water` tinyint(1) DEFAULT 0,
  `project_id` int(11) DEFAULT NULL,
  `plot_no` varchar(50) DEFAULT NULL,
  `project_feature` text DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  `area` varchar(100) DEFAULT NULL,
  `project_bank_loan` tinyint(1) DEFAULT 0,
  `project_completion_certificate` tinyint(1) DEFAULT 0,
  `builder_name` varchar(100) DEFAULT NULL,
  `project_photo` varchar(255) DEFAULT NULL,
  `overseas` tinyint(1) DEFAULT 0,
  `investor` tinyint(1) DEFAULT 0,
  `builder` tinyint(1) DEFAULT 0,
  `category` varchar(50) DEFAULT NULL,
  `prop_type` varchar(50) DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `priority` varchar(50) DEFAULT NULL,
  `possession` decimal(10,2) DEFAULT NULL,
  `deposit` decimal(10,2) DEFAULT NULL,
  `rent` decimal(10,2) DEFAULT NULL,
  `in_words` text DEFAULT NULL,
  `document_charges` decimal(10,2) DEFAULT NULL,
  `maintenance_charges` decimal(10,2) DEFAULT NULL,
  `project_entry_fee` decimal(10,2) DEFAULT NULL,
  `office_charges` decimal(10,2) DEFAULT NULL,
  `tenant_name` varchar(100) DEFAULT NULL,
  `tenant_cnic` varchar(20) DEFAULT NULL,
  `tenant_cell` varchar(20) DEFAULT NULL,
  `tenant_note` text DEFAULT NULL,
  `reference_name` varchar(100) DEFAULT NULL,
  `reference_cnic` varchar(20) DEFAULT NULL,
  `reference_cell` varchar(20) DEFAULT NULL,
  `reference_note` text DEFAULT NULL,
  `remarks` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `customer_id` varchar(50) DEFAULT NULL,
  `rent_photo` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `rents`
--

INSERT INTO `rents` (`id`, `lead_id`, `name`, `cast_id`, `email`, `cell`, `cnic`, `bed_rooms`, `bath`, `floor`, `block`, `sqft`, `drawing`, `dining`, `roof`, `store`, `common`, `separate_gate`, `basement`, `mezzanine`, `west_open`, `back`, `gas`, `corner`, `front`, `water`, `project_id`, `plot_no`, `project_feature`, `location`, `area`, `project_bank_loan`, `project_completion_certificate`, `builder_name`, `project_photo`, `overseas`, `investor`, `builder`, `category`, `prop_type`, `status`, `priority`, `possession`, `deposit`, `rent`, `in_words`, `document_charges`, `maintenance_charges`, `project_entry_fee`, `office_charges`, `tenant_name`, `tenant_cnic`, `tenant_cell`, `tenant_note`, `reference_name`, `reference_cnic`, `reference_cell`, `reference_note`, `remarks`, `created_at`, `updated_at`, `customer_id`, `rent_photo`) VALUES
(14, 17, 'Ali Raza Builder (SB)', 9, '', '03012219456', '', 0, 0, 0, '', 500.00, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 137, 'JM 00', 'Bike Parking,Bank Loan', 'Aross bakery', 'Gurumandir', 0, 0, '', NULL, 0, 0, 0, 'Shop', 'Commercial', 'Available', 'medium', NULL, 200000.00, 40000.00, 'Forty Thousand Only', 0.00, 0.00, 0.00, 40.00, NULL, '', '', '', NULL, '', '', '', '', '2025-03-14 18:23:49', '2025-03-14 18:23:49', '188', NULL),
(15, 20, 'Mohd Ali (UNO)', 15, '', '03337819381', '', 4, 4, 1, 'B-102', 1900.00, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 179, 'JM 00', 'Lift,Car Parking,Bank Loan', 'Sher Bano Bhag', 'Garden', 0, 0, '', NULL, 0, 1, 0, 'Flat', 'Residential', 'Available', 'high', NULL, 30000.00, 45000.00, 'Forty Five Thousand Only', 0.00, 4000.00, 10000.00, 45.00, NULL, '', '', '', NULL, '', '', '', '', '2025-03-14 18:30:16', '2025-03-14 18:30:16', '189', NULL),
(16, 22, 'Hasnain Abbas Quetta', 16, '', '0301-3718684', '', 0, 0, 0, '', 500.00, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, '', '', '', '', 0, 0, '', NULL, 0, 0, 0, 'Shop', 'Commercial', 'Available', 'high', NULL, 200000.00, 50000.00, 'Fifty Thousand Only', 0.00, 0.00, 0.00, 1.00, NULL, '', '', '', NULL, '', '', '', '', '2025-03-26 16:24:21', '2025-03-26 16:24:21', '206', NULL),
(17, 7, 'Kaneez Fatima', 9, 'tahirafatima986@gmail.com', '03047451070', '876543567887', 0, 0, 0, '', 0.00, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, '', '', '', '', 0, 0, '', NULL, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, 0.00, 0.00, '', 0.00, 0.00, 0.00, 0.00, NULL, '', '', '', NULL, '', '', '', '', '2025-03-26 18:28:17', '2025-03-26 18:28:17', '33', NULL),
(18, 14, 'Zain', 0, '', '0335-0035589', '', 2, 2, 2, '', 0.00, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 218, '', 'Car Parking,Bike Parking', 'Huma beauty parlour ', 'Britto Road', 0, 0, '', '', 0, 0, 0, 'Flat', 'Residential', 'Available', 'high', NULL, 500000.00, 57000.00, 'Fifty Seven Thousand Only', 0.00, 0.00, 0.00, 0.00, NULL, '', '', '', NULL, '', '', '', '', '2025-03-28 17:05:18', '2025-03-30 07:03:52', '196', '1743318232_IMG-20250226-WA0039.jpg,1743318232_IMG-20250226-WA0040.jpg,1743318232_IMG-20250226-WA0037.jpg,1743318232_IMG-20250226-WA0038.jpg,1743318232_IMG-20250226-WA0043.jpg,1743318232_IMG-20250226-WA0044.jpg,1743318232_IMG-20250226-WA0041.jpg,1743318232'),
(23, 14, 'Tauseef Raza', 9, '', '0300', '42201-0281917-9', 3, 3, 1, '106', 1400.00, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 224, 'JM 178', 'Lift,CCTV,Car Parking,Intercom,Generator,Waiting Area', 'Quba Masjid', 'Soldier Bazar 03', 0, 0, '', '', 0, 0, 0, 'Flat', 'Residential', 'Available', 'high', NULL, 50000.00, 850000.00, 'Eight Lakh Fifty Thousand Only', 0.00, 8000.00, 10000.00, 0.00, NULL, '', '', '', 'Br Ali Wahab Mirza', '', '0317-2000582', '', '', '2025-04-07 17:34:57', '2025-04-07 17:35:58', '255', ''),
(24, 11, 'Br Ali Hussain', 0, '', '0322-2717089', '', 0, 0, 0, '', 0.00, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, '', '', '', '', 0, 0, '', '', 0, 0, 0, 'Shop', 'Commercial', 'Available', 'mod', NULL, 900000.00, 150000.00, 'One Lakh Fifty Thousand Only', 0.00, 0.00, 0.00, 0.00, NULL, '', '', '', NULL, '', '', '', '', '2025-04-08 09:08:18', '2025-04-08 09:08:18', '190', '');

-- --------------------------------------------------------

--
-- Table structure for table `rent_agreements`
--

CREATE TABLE `rent_agreements` (
  `id` int(11) NOT NULL,
  `owner_id` int(11) NOT NULL,
  `owner_name` varchar(100) NOT NULL,
  `owner_cast` varchar(50) DEFAULT NULL,
  `owner_cnic` varchar(15) DEFAULT NULL,
  `owner_dob` date DEFAULT NULL,
  `owner_cell` varchar(16) DEFAULT NULL,
  `owner_email` varchar(100) DEFAULT NULL,
  `owner_address` text DEFAULT NULL,
  `owner_signature` varchar(255) DEFAULT NULL,
  `owner_cnic_photo` varchar(255) DEFAULT NULL,
  `owner_photo` varchar(255) DEFAULT NULL,
  `tenant_id` int(11) NOT NULL,
  `tenant_name` varchar(100) NOT NULL,
  `tenant_cast` varchar(50) DEFAULT NULL,
  `tenant_cnic` varchar(15) DEFAULT NULL,
  `tenant_dob` date DEFAULT NULL,
  `tenant_cell` varchar(16) DEFAULT NULL,
  `tenant_address` text DEFAULT NULL,
  `tenant_signature` varchar(255) DEFAULT NULL,
  `tenant_cnic_photo` varchar(255) DEFAULT NULL,
  `tenant_photo` varchar(255) DEFAULT NULL,
  `agreement_photo` varchar(255) DEFAULT NULL,
  `owner_witness_name` varchar(100) DEFAULT NULL,
  `owner_witness_id` int(11) DEFAULT NULL,
  `owner_witness_cast` varchar(50) DEFAULT NULL,
  `owner_witness_cnic` varchar(15) DEFAULT NULL,
  `owner_witness_dob` date DEFAULT NULL,
  `owner_witness_cell` varchar(16) DEFAULT NULL,
  `owner_witness_address` text DEFAULT NULL,
  `owner_witness_signature` varchar(255) DEFAULT NULL,
  `tenant_witness_name` varchar(100) DEFAULT NULL,
  `tenant_witness_id` int(11) DEFAULT NULL,
  `tenant_witness_cast` varchar(50) DEFAULT NULL,
  `tenant_witness_cnic` varchar(15) DEFAULT NULL,
  `tenant_witness_dob` date DEFAULT NULL,
  `tenant_witness_cell` varchar(16) DEFAULT NULL,
  `tenant_witness_address` text DEFAULT NULL,
  `tenant_witness_signature` varchar(255) DEFAULT NULL,
  `agreement_date` date NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `rent_agreements`
--

INSERT INTO `rent_agreements` (`id`, `owner_id`, `owner_name`, `owner_cast`, `owner_cnic`, `owner_dob`, `owner_cell`, `owner_email`, `owner_address`, `owner_signature`, `owner_cnic_photo`, `owner_photo`, `tenant_id`, `tenant_name`, `tenant_cast`, `tenant_cnic`, `tenant_dob`, `tenant_cell`, `tenant_address`, `tenant_signature`, `tenant_cnic_photo`, `tenant_photo`, `agreement_photo`, `owner_witness_name`, `owner_witness_id`, `owner_witness_cast`, `owner_witness_cnic`, `owner_witness_dob`, `owner_witness_cell`, `owner_witness_address`, `owner_witness_signature`, `tenant_witness_name`, `tenant_witness_id`, `tenant_witness_cast`, `tenant_witness_cnic`, `tenant_witness_dob`, `tenant_witness_cell`, `tenant_witness_address`, `tenant_witness_signature`, `agreement_date`, `created_at`) VALUES
(17, 16, 'Hasnain Abbas Quetta', 'Bori', '', NULL, '0301-3718684', '', '', NULL, NULL, '67e4470e9ccc4_67e3fda242eb1_men.png', 205, 'Ghulam Abbas', 'Khoja', '', NULL, '0333-2401114', '', NULL, NULL, NULL, NULL, '', NULL, 'khan', '', NULL, '', '', NULL, 'saud', NULL, '', '', NULL, '', '', NULL, '2025-03-26', '2025-03-26 16:26:04'),
(19, 17, 'Kaneez Fatima', 'Khoja', '876543567887', NULL, '03047451070', 'tahirafatima986@gmail.com', '', NULL, NULL, '67e447d3985d5_67e4024fb15ce_m1.jpg', 37, 'Samir Raza Lilani', 'Khoja', '4200005590367', NULL, '03343655662', '', NULL, NULL, NULL, NULL, '', NULL, '', '', NULL, '', '', NULL, '', NULL, '', '', NULL, '', '', NULL, '2024-11-16', '2025-03-26 18:30:43'),
(20, 17, 'Kaneez Fatima', 'Khoja', '876543567887', NULL, '03047451070', 'tahirafatima986@gmail.com', '', NULL, NULL, NULL, 37, 'Samir Raza Lilani', 'Khoja', '4200005590367', NULL, '03343655662', '', NULL, NULL, NULL, NULL, 'Ali Lilani', 32, 'Khoja', '4220107422221', '1983-05-11', '03333111470', 'Plot No 188/B, Flat 10 , 4th floor Zohra Garden', NULL, 'Ali Lilani', 32, 'Khoja', '4220107422221', '1983-05-11', '03333111470', 'Plot No 188/B, Flat 10 , 4th floor Zohra Garden', NULL, '2024-10-26', '2025-03-27 10:07:01'),
(22, 23, 'Tauseef Raza', 'Khoja', '42201-0281917-9', NULL, '0300', '', 'Quba Masjid', NULL, NULL, NULL, 254, 'Muhammad Tahir ', 'Memon', '42201-9877381-5', NULL, '0331-2913433', '', NULL, NULL, NULL, NULL, 'Br Ali Wahab Mirza', 258, 'Syed', '', NULL, '0317-2000582', '', NULL, 'Ali Lilani', 32, 'Khoja', '4220107422221', '1983-05-11', '03333111470', 'Plot No 188/B, Flat 10 , 4th floor Zohra Garden', '67f40e1e63da1_TA Flat Sadiq vs Tahir 85k.docx', '2025-04-07', '2025-04-07 17:40:46');

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` int(11) NOT NULL,
  `role_name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `role_name`) VALUES
(1, 'admin');

-- --------------------------------------------------------

--
-- Table structure for table `salary_components`
--

CREATE TABLE `salary_components` (
  `id` int(11) NOT NULL,
  `employee_id` int(11) NOT NULL,
  `basic_salary` decimal(10,2) NOT NULL,
  `monthly_bonus` decimal(10,2) DEFAULT 0.00,
  `quarterly_bonus` decimal(10,2) DEFAULT 0.00,
  `yearly_bonus` decimal(10,2) DEFAULT 0.00,
  `sales_commission_percentage` decimal(5,2) DEFAULT 0.00,
  `housing_allowance` decimal(10,2) DEFAULT 0.00,
  `transport_allowance` decimal(10,2) DEFAULT 0.00,
  `medical_allowance` decimal(10,2) DEFAULT 0.00,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sales`
--

CREATE TABLE `sales` (
  `id` int(11) NOT NULL,
  `sale_number` varchar(50) NOT NULL,
  `date` date NOT NULL,
  `customer_name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `quantity` int(11) NOT NULL,
  `total_amount` decimal(15,2) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sale_agreements`
--

CREATE TABLE `sale_agreements` (
  `id` int(11) NOT NULL,
  `agreement_date` date NOT NULL,
  `seller_id` int(11) NOT NULL,
  `purchaser_id` int(11) NOT NULL,
  `seller_witness_id` int(11) NOT NULL,
  `purchaser_witness_id` int(11) NOT NULL,
  `amount` decimal(12,2) NOT NULL,
  `seller_commission_percent` decimal(5,2) NOT NULL,
  `seller_commission` decimal(12,2) NOT NULL,
  `purchaser_commission_percent` decimal(5,2) NOT NULL,
  `purchaser_commission` decimal(12,2) NOT NULL,
  `seller_signature_path` varchar(255) DEFAULT NULL,
  `seller_cnic_photo_path` varchar(255) DEFAULT NULL,
  `seller_photo_path` varchar(255) DEFAULT NULL,
  `purchaser_signature_path` varchar(255) DEFAULT NULL,
  `purchaser_cnic_photo_path` varchar(255) DEFAULT NULL,
  `purchaser_photo_path` varchar(255) DEFAULT NULL,
  `agreement_photo_path` varchar(255) DEFAULT NULL,
  `seller_witness_signature_path` varchar(255) DEFAULT NULL,
  `purchaser_witness_signature_path` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sale_returns`
--

CREATE TABLE `sale_returns` (
  `id` int(11) NOT NULL,
  `return_number` varchar(50) NOT NULL,
  `date` date NOT NULL,
  `customer_name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `quantity` int(11) NOT NULL,
  `amount` decimal(15,2) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sellers_backup`
--

CREATE TABLE `sellers_backup` (
  `id` int(11) NOT NULL,
  `lead_id` int(11) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `cast_id` int(11) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `cell` varchar(20) DEFAULT NULL,
  `cnic` varchar(20) DEFAULT NULL,
  `bed_rooms` int(11) DEFAULT NULL,
  `bath` int(11) DEFAULT NULL,
  `floor` int(11) DEFAULT NULL,
  `block` varchar(50) DEFAULT NULL,
  `sqft` decimal(10,2) DEFAULT NULL,
  `drawing` tinyint(1) DEFAULT 0,
  `dining` tinyint(1) DEFAULT 0,
  `roof` tinyint(1) DEFAULT 0,
  `store` tinyint(1) DEFAULT 0,
  `common` tinyint(1) DEFAULT 0,
  `separate_gate` tinyint(1) DEFAULT 0,
  `basement` tinyint(1) DEFAULT 0,
  `mezzanine` tinyint(1) DEFAULT 0,
  `west_open` tinyint(1) DEFAULT 0,
  `back` tinyint(1) DEFAULT 0,
  `gas` tinyint(1) DEFAULT 0,
  `corner` tinyint(1) DEFAULT 0,
  `front` tinyint(1) DEFAULT 0,
  `water` tinyint(1) DEFAULT 0,
  `project_id` int(11) DEFAULT NULL,
  `plot_no` varchar(50) DEFAULT NULL,
  `project_feature` text DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  `area` varchar(100) DEFAULT NULL,
  `project_bank_loan` tinyint(1) DEFAULT 0,
  `project_completion_certificate` tinyint(1) DEFAULT 0,
  `builder_name` varchar(100) DEFAULT NULL,
  `project_photo` varchar(255) DEFAULT NULL,
  `builder_photo` varchar(255) DEFAULT NULL,
  `overseas` tinyint(1) DEFAULT 0,
  `investor` tinyint(1) DEFAULT 0,
  `builder` tinyint(1) DEFAULT 0,
  `category` varchar(50) DEFAULT NULL,
  `prop_type` varchar(50) DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `priority` varchar(50) DEFAULT NULL,
  `possession` decimal(10,2) DEFAULT NULL,
  `demand` decimal(10,2) DEFAULT NULL,
  `in_words` text DEFAULT NULL,
  `document_charges` decimal(10,2) DEFAULT NULL,
  `flat_maintenance` decimal(10,2) DEFAULT NULL,
  `project_entry_fee` decimal(10,2) DEFAULT NULL,
  `office_charges` decimal(10,2) DEFAULT NULL,
  `key_status` tinyint(1) DEFAULT 0,
  `tenant_name` varchar(100) DEFAULT NULL,
  `tenant_cnic` varchar(20) DEFAULT NULL,
  `tenant_cell` varchar(20) DEFAULT NULL,
  `tenant_note` text DEFAULT NULL,
  `reference_name` varchar(100) DEFAULT NULL,
  `reference_cnic` varchar(20) DEFAULT NULL,
  `reference_cell` varchar(20) DEFAULT NULL,
  `reference_note` text DEFAULT NULL,
  `remarks` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_by` int(11) DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `customer_id` varchar(50) DEFAULT NULL,
  `seller_photo` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `sellers_backup`
--

INSERT INTO `sellers_backup` (`id`, `lead_id`, `name`, `cast_id`, `email`, `cell`, `cnic`, `bed_rooms`, `bath`, `floor`, `block`, `sqft`, `drawing`, `dining`, `roof`, `store`, `common`, `separate_gate`, `basement`, `mezzanine`, `west_open`, `back`, `gas`, `corner`, `front`, `water`, `project_id`, `plot_no`, `project_feature`, `location`, `area`, `project_bank_loan`, `project_completion_certificate`, `builder_name`, `project_photo`, `builder_photo`, `overseas`, `investor`, `builder`, `category`, `prop_type`, `status`, `priority`, `possession`, `demand`, `in_words`, `document_charges`, `flat_maintenance`, `project_entry_fee`, `office_charges`, `key_status`, `tenant_name`, `tenant_cnic`, `tenant_cell`, `tenant_note`, `reference_name`, `reference_cnic`, `reference_cell`, `reference_note`, `remarks`, `created_at`, `updated_at`, `updated_by`, `created_by`, `customer_id`, `seller_photo`) VALUES
(126, 7, 'Samir Raza Lilani', 9, '', '03343655662', '4200005590367', 2, 2, 2, '', 600.00, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 137, 'JM 00', 'Bike Parking,Bank Loan', 'Aross bakery', 'Gurumandir', 0, 0, '', NULL, NULL, 0, 0, 0, 'Flat', 'Residential', 'Available', 'high', 0.00, 6500000.00, 'Sixty Five Lakh Only', 0.00, 0.00, 0.00, 2.00, 0, 'Imran Ismaili (Taj Terc)', '', '03002804586', 'call before visit only family', NULL, '', '', NULL, '', '2025-02-28 16:12:37', '2025-02-28 16:15:46', NULL, NULL, '37', NULL),
(128, 15, 'Khurram', 0, '', '0343-2796487', '', 2, 2, 1, '', 450.00, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 151, '', 'Project Completion Certificate,Bank Loan', 'Qadri Medical', 'Soldier Bazar 02', 1, 1, '', '1741021836_WhatsApp Image 2025-02-25 at 19.11.30 (1).jpeg', NULL, 0, 0, 0, 'Flat', 'Residential', 'Available', 'mod', 0.00, 5700000.00, 'Fifty Seven Lakh Only', 0.00, 0.00, 0.00, 0.00, 0, NULL, '', '', 'khurram(owner living)', NULL, '', '', NULL, '', '2025-03-03 17:10:36', '2025-03-05 16:55:00', NULL, NULL, '162', NULL),
(129, 15, 'Nawab Ali', 0, '', '0300-7019491', '', 2, 2, 3, '', 1300.00, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 1, 1, 163, '', 'Car Parking', 'Saqib Bakery', 'Parsi Colony', 1, 1, '', NULL, NULL, 0, 0, 0, 'Flat', 'Residential', 'Available', 'mod', 0.00, 13500000.00, 'One Crore Thirty Five Lakh Only', 0.00, 0.00, 0.00, 2700000.00, 0, 'Sohail ', '', '0334-3471353', '', NULL, '', '', NULL, '', '2025-03-05 11:11:40', '2025-03-07 16:55:53', NULL, NULL, '163', NULL),
(130, 15, 'Batool', 0, '', '0322-2329123', '', 2, 2, 0, '', 0.00, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 156, '', 'Project Completion Certificate,Bank Loan', 'Mehboob Kitchen', 'Soldier Bazar 02', 1, 1, '', NULL, NULL, 0, 0, 0, 'Flat', 'Residential', 'Available', 'medium', 0.00, 8500000.00, 'Eighty Five Lakh Only', 0.00, 0.00, 0.00, 170000.00, 0, NULL, '', '', '', NULL, '', '', '', '', '2025-03-06 11:25:22', '2025-03-06 11:25:22', NULL, NULL, '165', NULL),
(131, 15, 'Asif', 0, '', '0332-3359705', '', 2, 2, 0, '', 0.00, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 157, '', 'Car Parking', 'Lakhpatti hall', 'Garden East', 1, 1, '', NULL, NULL, 0, 0, 0, 'Flat', 'Residential', 'Available', 'medium', 0.00, 12500000.00, 'One Crore Twenty Five Lakh Only', 0.00, 0.00, 0.00, 250000.00, 0, NULL, '', '', '', NULL, '', '', '', '', '2025-03-06 11:47:53', '2025-03-06 11:47:53', NULL, NULL, '166', NULL),
(132, 15, 'Taufeeq', 0, '', '0345-6187962', '', 2, 2, 0, '', 0.00, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 158, '', 'Car Parking', 'Agah Khan Hospital', 'Patel Para', 0, 0, '', NULL, NULL, 0, 0, 0, 'Flat', 'Residential', 'Available', 'medium', 0.00, 15000000.00, 'One Crore Fifty Lakh Only', 0.00, 0.00, 0.00, 3000000.00, 0, NULL, '', '', '', NULL, '', '', '', '', '2025-03-07 09:36:05', '2025-03-07 09:36:05', NULL, NULL, '167', NULL),
(133, 13, 'Deepak', 0, '', '0323-2161883', '', 1, 1, 1, '', 400.00, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 160, '', '', 'Nagori Milk', 'Soldier Bazar 02', 0, 0, '', NULL, NULL, 0, 0, 0, 'Flat', 'Residential', 'Available', 'medium', 0.00, 3000000.00, 'Thirty Lakh Only', 0.00, 0.00, 0.00, 60000.00, 0, NULL, '', '', '', NULL, '', '', '', '', '2025-03-07 10:59:32', '2025-03-07 10:59:32', NULL, NULL, '157', NULL),
(134, 15, 'Rajesh', 0, '', '0331-2688003', '', 2, 1, 2, '', 0.00, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 161, '', '', 'Sakhawat Roll Point', 'Soldier Bazar 01', 0, 0, '', NULL, NULL, 0, 0, 0, 'Flat', 'Residential', 'Available', 'mod', 0.00, 3000000.00, 'Thirty Lakh Only', 0.00, 0.00, 0.00, 60000.00, 0, NULL, '', '', '', NULL, '', '', '', '', '2025-03-07 11:05:54', '2025-03-07 11:05:54', NULL, NULL, '168', NULL),
(135, 15, 'M.Riaz', 0, '', '0335-2472725', '', 1, 1, 4, '', 180.00, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 159, '182', '', 'Gyser Gali', 'Soldier Bazar 02', 0, 0, '', NULL, NULL, 0, 0, 0, 'Flat', 'Residential', 'Available', 'mod', 0.00, 3200000.00, 'Thirty Two Lakh Only', 0.00, 0.00, 0.00, 64000.00, 0, NULL, '', '', '', NULL, '', '', '', '', '2025-03-07 17:09:15', '2025-03-07 17:09:15', NULL, NULL, '56', NULL),
(136, 15, 'Anil Kumar', 0, '', '0315-2617682', '', 1, 1, 6, '', 0.00, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 160, '', '', 'Nagori Milk', 'Soldier Bazar 02', 0, 0, '', NULL, NULL, 0, 0, 0, 'Flat', 'Residential', 'Available', 'medium', 0.00, 2200000.00, 'Twenty Two Lakh Only', 0.00, 0.00, 0.00, 44000.00, 0, NULL, '', '', '', NULL, '', '', '', '', '2025-03-07 17:12:44', '2025-03-07 17:12:44', NULL, NULL, '169', NULL),
(137, 0, 'Amir Abbas Jessani', 0, '', '0321-89604121', '42301-4091491-1', 1, 1, 2, '', 0.00, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 169, '', '', 'Gul e Rana Colony ', 'Soldier Bazar 01', 0, 0, '', NULL, NULL, 0, 0, 0, 'Flat', 'Residential', 'Available', 'medium', 0.00, 2500000.00, 'Twenty Five Lakh Only', 0.00, 0.00, 0.00, 50000.00, 0, NULL, '', '', '', NULL, '', '', '', '', '2025-03-12 11:50:19', '2025-03-12 11:50:19', NULL, NULL, '179', NULL),
(138, 15, 'Mrs Kamla', 0, '', '0316-3385227', '', 2, 2, 4, '', 0.00, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 168, '', '', 'Christian Behtak', 'Soldier Bazar 02', 0, 0, '', NULL, NULL, 0, 0, 0, 'Flat', 'Residential', 'Available', 'mod', 0.00, 4000000.00, 'Forty Lakh Only', 0.00, 0.00, 0.00, 80000.00, 0, NULL, '', '', '', NULL, '', '', '', '', '2025-03-12 11:53:31', '2025-03-12 11:53:31', NULL, NULL, '178', NULL),
(139, 15, 'Faheem', 0, '', '0332-2827036', '', 1, 1, 4, '', 300.00, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 167, '', '', 'Makkar Kabari', 'Soldier Bazar 01', 0, 0, '', NULL, NULL, 0, 0, 0, 'Flat', 'Residential', 'Available', 'mod', 0.00, 2500000.00, 'Twenty Five Lakh Only', 0.00, 0.00, 0.00, 50000.00, 0, NULL, '', '', '', NULL, '', '', '', '', '2025-03-12 11:58:01', '2025-03-12 11:58:01', NULL, NULL, '177', NULL),
(140, 13, 'Mustafa Ali', 0, '', '0322-2385310', '', 1, 1, 1, '', 0.00, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 166, '', '', 'Hanuman Mandir', 'Soldier Bazar 02', 0, 0, '', NULL, NULL, 0, 0, 0, 'Flat', 'Residential', 'Available', 'mod', 0.00, 3500000.00, 'Thirty Five Lakh Only', 0.00, 0.00, 0.00, 70000.00, 0, NULL, '', '', '', NULL, '', '', NULL, '', '2025-03-12 12:01:11', '2025-03-13 17:55:53', NULL, NULL, '92', NULL),
(141, 15, 'Atif', 0, '', '0334-3952616', '', 1, 1, 6, '', 0.00, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 164, '', '', 'Allah Tawakkal Estate', 'Soldier Bazar 02', 0, 0, 'None', NULL, NULL, 0, 0, 0, 'Flat', 'Residential', 'Available', 'mod', 0.00, 1700000.00, 'Seventeen Lakh Only', 0.00, 0.00, 0.00, 34000.00, 0, NULL, '', '', '', NULL, '', '', NULL, '', '2025-03-12 12:04:08', '2025-03-13 17:56:42', NULL, NULL, '172', NULL),
(142, 15, 'Atif', 0, '', '0334-3952616', '', 1, 1, 7, '', 0.00, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 164, '', '', 'Allah Tawakkal Estate', 'Soldier Bazar 02', 0, 0, 'None', NULL, NULL, 0, 0, 0, 'Flat', 'Residential', 'Available', 'mod', 0.00, 1700000.00, 'Seventeen Lakh Only', 0.00, 0.00, 0.00, 34000.00, 0, NULL, '', '', '', NULL, '', '', '', '', '2025-03-12 12:05:58', '2025-03-12 12:05:58', NULL, NULL, '172', NULL),
(143, 15, 'Naveed(sister)', 0, '', '0317-2543124', '', 1, 1, 1, '', 0.00, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 165, '', '', '', 'Soldier Bazar 01', 0, 0, '', NULL, NULL, 0, 0, 0, 'Flat', 'Residential', 'Available', 'mod', 0.00, 1500000.00, 'Fifteen Lakh Only', 0.00, 0.00, 0.00, 30000.00, 0, NULL, '', '', '', NULL, '', '', '', '', '2025-03-12 12:09:33', '2025-03-12 12:09:33', NULL, NULL, '170', NULL),
(144, 15, 'Noor Ali', 0, '', '0332-3766292', '', 2, 2, 6, '', 900.00, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 174, '', 'Lift,Car Parking,Bike Parking,Project Completion Certificate,Bank Loan', 'Irfan School', 'Parsi Colony', 1, 1, '', NULL, NULL, 0, 0, 0, 'Flat', 'Residential', 'Available', 'mod', 0.00, 12500000.00, 'One Crore Twenty Five Lakh Only', 0.00, 0.00, 0.00, 250000.00, 0, NULL, '', '', '', NULL, '', '', '', '', '2025-03-13 17:25:50', '2025-03-13 17:25:50', NULL, NULL, '181', NULL),
(145, 15, 'Shouket Bhai', 0, '', '0305-3996450', '', 2, 2, 2, '', 950.00, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 175, '', 'Lift,Car Parking,Generator', 'Pak Night Clinic', 'Parsi Colony', 0, 0, '', NULL, NULL, 0, 0, 0, 'Flat', 'Residential', 'Available', 'mod', 0.00, 18000000.00, 'One Crore Eighty Lakh Only', 0.00, 0.00, 0.00, 360000.00, 0, NULL, '', '', '', NULL, '', '', '', '', '2025-03-13 17:46:44', '2025-03-13 17:46:44', NULL, NULL, '182', NULL),
(146, 15, 'Noor Muhammad', 0, '', '0300-9211346', '', 2, 2, 0, '', 1200.00, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 174, '', 'Lift,Car Parking,Bike Parking,Project Completion Certificate,Bank Loan', 'Irfan School', 'Parsi Colony', 0, 0, '', NULL, NULL, 0, 0, 0, 'Flat', 'Residential', 'Available', 'medium', 0.00, 15500000.00, 'One Crore Fifty Five Lakh Only', 0.00, 0.00, 0.00, 310000.00, 0, NULL, '', '', '', NULL, '', '', '', '', '2025-03-13 17:54:01', '2025-03-13 17:54:01', NULL, NULL, '183', NULL),
(147, 9, 'Hussain', 0, '', '0300-2415980', '', 2, 2, 1, '', 900.00, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 137, 'JM 00', 'Bike Parking,Bank Loan', 'Aross bakery', 'Gurumandir', 0, 0, '', NULL, NULL, 0, 0, 0, 'Flat', 'Residential', 'Available', 'medium', 0.00, 12500000.00, 'One Crore Twenty Five Lakh Only', 0.00, 0.00, 0.00, 250000.00, 0, NULL, '', '', '', NULL, '', '', '', '', '2025-03-14 16:46:18', '2025-03-14 16:46:18', NULL, NULL, '184', NULL),
(148, 15, 'Sameerudeen', 0, '', '0319-1676124', '', 2, 2, 2, '', 65.00, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 176, '541-A', '', 'Jamma Masjid HBL Main Road', 'Hasrat Mohani', 0, 0, '', NULL, NULL, 0, 0, 0, 'Flat', 'Residential', 'Available', 'medium', 0.00, 4000000.00, 'Forty Lakh Only', 0.00, 0.00, 0.00, 80000.00, 0, NULL, '', '', '', NULL, '', '', NULL, '', '2025-03-14 17:03:31', '2025-03-14 17:04:43', NULL, NULL, '185', NULL),
(149, 15, 'Mohammad Idress', 0, '', '0322-2024324', '', 2, 2, 5, '', 900.00, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 177, '', '', 'Hyder Bakery', 'Soldier Bazar 01', 0, 0, '', NULL, NULL, 0, 0, 0, 'Flat', 'Residential', 'Available', 'medium', 0.00, 8500000.00, 'Eighty Five Lakh Only', 0.00, 0.00, 0.00, 170000.00, 0, NULL, '', '', '', NULL, '', '', NULL, '', '2025-03-14 17:16:57', '2025-03-14 17:19:10', NULL, NULL, '186', NULL),
(150, 15, 'Daniel', 0, '', '0312-8361315', '', 2, 2, 7, '', 1000.00, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 178, '', 'Lift,Car Parking,Bike Parking', 'Ayesha Masjid', 'Parsi Colony', 0, 0, '', NULL, NULL, 0, 0, 0, 'Flat', 'Residential', 'Available', 'medium', 0.00, 11000000.00, 'One Crore Ten Lakh Only', 0.00, 0.00, 0.00, 220000.00, 0, NULL, '', '', '', NULL, '', '', '', '', '2025-03-14 17:30:21', '2025-03-14 17:30:21', NULL, NULL, '187', NULL),
(151, 15, 'Mr Iqbal (press wala)', 0, '', '0300-2138492', '', 3, 3, 3, '', 0.00, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 171, '', 'Car Parking,Bike Parking', 'Time Medico', 'Soldier Bazar 03', 0, 0, '', NULL, NULL, 0, 0, 0, 'Flat', 'Residential', 'Available', 'medium', 0.00, 25000000.00, 'Two Crore Fifty Lakh Only', 0.00, 0.00, 0.00, 500000.00, 0, NULL, '', '', '', NULL, '', '', '', '', '2025-03-14 17:41:47', '2025-03-14 17:41:47', NULL, NULL, '50', NULL),
(152, 15, 'Mr Iqbal (press wala)', 0, '', '0300-2138492', '', 3, 3, 3, '', 0.00, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 171, '', 'Car Parking,Bike Parking', 'Time Medico', 'Soldier Bazar 03', 0, 0, '', NULL, NULL, 0, 0, 0, 'Flat', 'Residential', 'Available', 'medium', 0.00, 25000000.00, 'Two Crore Fifty Lakh Only', 0.00, 0.00, 0.00, 500000.00, 0, NULL, '', '', '', NULL, '', '', '', '', '2025-03-14 17:44:24', '2025-03-14 17:44:24', NULL, NULL, '50', NULL),
(153, 15, 'M.Younus', 0, '', '0300-2289003', '', 3, 3, 5, '', 0.00, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 172, '', 'Lift,Bike Parking', '7Day Hospital', 'Saddar', 0, 0, '', NULL, NULL, 0, 0, 0, 'Flat', 'Residential', 'Available', 'medium', 0.00, 16500000.00, 'One Crore Sixty Five Lakh Only', 0.00, 0.00, 0.00, 330000.00, 0, NULL, '', '', '', NULL, '', '', '', '', '2025-03-14 17:50:22', '2025-03-14 17:50:22', NULL, NULL, '180', NULL),
(154, 13, 'Rehan', 0, '', '0335-3241660', '', 3, 3, 4, '', 1400.00, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 173, '', 'Lift,Car Parking,Bike Parking', 'Sunny Plaza', '', 0, 0, '', NULL, NULL, 0, 0, 0, 'Flat', 'Residential', 'Available', 'medium', 0.00, 12500000.00, 'One Crore Twenty Five Lakh Only', 0.00, 0.00, 0.00, 250000.00, 0, NULL, '', '', '', NULL, '', '', '', '', '2025-03-14 17:53:43', '2025-03-14 17:53:43', NULL, NULL, '80', NULL),
(155, 15, 'Syed Salman Ali', 0, '', '0337-3113278', '', 2, 2, 3, '', 0.00, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 180, '', '', '', 'Katchi Para', 0, 0, '', NULL, NULL, 0, 0, 0, 'Flat', 'Residential', 'Available', 'mod', 0.00, 6500000.00, 'Sixty Five Lakh Only', 0.00, 0.00, 0.00, 130000.00, 0, NULL, '', '', '', NULL, '', '', '', '', '2025-03-15 10:16:14', '2025-03-15 10:16:14', NULL, NULL, '197', NULL),
(157, 15, 'Khalid', 0, '', '0300-9264064', '', 2, 3, 4, '403', 1160.00, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 181, '', '', 'Blue Ribbon Bakery ', 'Gurumandir', 0, 0, '', NULL, NULL, 0, 0, 0, 'Flat-GW', 'Residential', 'Available', 'medium', 0.00, 2500000.00, 'Twenty Five Lakh Only', 0.00, 0.00, 0.00, 50000.00, 0, NULL, '', '', '', NULL, '', '', NULL, '', '2025-03-15 10:28:06', '2025-03-15 10:37:42', NULL, NULL, '198', NULL),
(158, 15, 'M.hanif', 0, '', '0300-9277527', '', 2, 2, 5, '503', 0.00, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 182, '', '', '', 'Katchi Para', 0, 0, '', NULL, NULL, 0, 0, 0, 'Flat', 'Residential', 'Available', 'mod', 0.00, 3500000.00, 'Thirty Five Lakh Only', 0.00, 0.00, 0.00, 70000.00, 0, NULL, '', '', '', NULL, '', '', '', '', '2025-03-15 10:36:10', '2025-03-15 10:36:10', NULL, NULL, '199', NULL),
(159, 15, 'Arshad Ali', 0, '', '0315-9229915', '', 2, 2, 5, '502', 0.00, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 183, '', 'Bike Parking', 'Sahi Ka Maidan', 'Soldier Bazar 02', 0, 0, '', NULL, NULL, 0, 0, 0, 'Flat', 'Residential', 'Available', 'medium', 0.00, 3000000.00, 'Thirty Lakh Only', 0.00, 0.00, 0.00, 60000.00, 0, NULL, '', '', '', NULL, '', '', '', '', '2025-03-15 10:48:23', '2025-03-15 10:48:23', NULL, NULL, '200', NULL),
(160, 15, 'M.Khalid', 0, '', '0347-8125615', '', 2, 2, 2, '7', 0.00, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 184, '', 'Bike Parking', 'Bori Masjid', 'Saddar', 0, 0, '', NULL, NULL, 0, 0, 0, 'Flat', 'Residential', 'Available', 'medium', 0.00, 6700000.00, 'Sixty Seven Lakh Only', 0.00, 0.00, 0.00, 134000.00, 0, NULL, '', '', '', NULL, '', '', '', '', '2025-03-15 11:06:32', '2025-03-15 11:06:32', NULL, NULL, '57', NULL),
(161, 15, 'M.Anwar Ali', 0, '', '0320-2021771', '', 2, 2, 1, '', 0.00, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 185, '', '', 'Qasim Auto ', 'Soldier Bazar 02', 0, 0, '', NULL, NULL, 0, 0, 0, 'Flat', 'Residential', 'Available', 'medium', 0.00, 3500000.00, 'Thirty Five Lakh Only', 0.00, 0.00, 0.00, 70000.00, 0, NULL, '', '', '', NULL, '', '', '', '', '2025-03-15 17:44:22', '2025-03-15 17:44:22', NULL, NULL, '201', NULL),
(162, 15, 'M.Aqeel', 0, '', '0333-3181435', '', 2, 2, 1, '102', 400.00, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 183, '', 'Bike Parking', 'Sahi Ka Maidan', 'Soldier Bazar 02', 0, 0, '', NULL, NULL, 0, 0, 0, 'Flat', 'Residential', 'Available', 'mod', 0.00, 3600000.00, 'Thirty Six Lakh Only', 0.00, 0.00, 0.00, 72000.00, 0, NULL, '', '', '', NULL, '', '', '', '', '2025-03-15 17:51:51', '2025-03-15 17:51:51', NULL, NULL, '202', NULL),
(163, 15, 'Sanaullah', 0, '', '0313-2325595', '', 2, 2, 1, '', 650.00, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 186, '', '', 'Phool Wala', 'Soldier Bazar 01', 0, 0, '', NULL, NULL, 0, 0, 0, 'Flat', 'Residential', 'Available', 'medium', 0.00, 7500000.00, 'Seventy Five Lakh Only', 0.00, 0.00, 0.00, 150000.00, 0, NULL, '', '', '', NULL, '', '', '', '', '2025-03-15 18:00:23', '2025-03-15 18:00:23', NULL, NULL, '203', NULL),
(164, 15, 'Mansoor', 0, '', '0345-2057740', '', 2, 2, 5, '502', 350.00, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 187, '', '', 'HBL Metro', 'Soldier Bazar 02', 0, 0, '', NULL, NULL, 0, 0, 0, 'Flat', 'apartment', 'Available', 'medium', 0.00, 3000000.00, 'Thirty Lakh Only', 0.00, 0.00, 0.00, 60000.00, 0, NULL, '', '', '', NULL, '', '', NULL, '', '2025-03-15 18:11:54', '2025-03-15 18:13:37', NULL, NULL, '204', NULL),
(165, 15, 'Ghulam Mustaffa', 0, '', '0323-3367706', '', 2, 2, 4, '402', 650.00, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 199, '', '', 'Sajjad Bakery', 'Soldier Bazar 02', 0, 0, '', NULL, NULL, 0, 0, 0, 'Flat', 'Residential', 'Available', 'mod', 0.00, 6000000.00, 'Sixty Lakh Only', 0.00, 0.00, 0.00, 120000.00, 0, NULL, '', '', '', NULL, '', '', '', '', '2025-03-18 09:21:17', '2025-03-18 09:21:17', NULL, NULL, '221', NULL),
(166, 15, 'Hussain Sheikh', 0, '', '0331-2885375', '', 2, 2, 5, '503', 400.00, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 200, '', '', 'MQM Nasir Baig Building', 'Soldier Bazar 01', 0, 0, '', NULL, NULL, 0, 0, 0, 'Flat', 'Residential', 'Available', 'mod', 0.00, 4000000.00, 'Forty Lakh Only', 0.00, 0.00, 0.00, 80000.00, 0, NULL, '', '', '', NULL, '', '', '', '', '2025-03-18 09:35:18', '2025-03-18 09:35:18', NULL, NULL, '222', NULL),
(167, 15, 'Akber Ali', 0, '', '0344-1100767', '', 2, 2, 2, '03', 0.00, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 201, '', '', '', 'Soldier Bazar 02', 0, 0, '', NULL, NULL, 0, 0, 0, 'Flat', 'Residential', 'Hold', 'mod', 0.00, 4500000.00, 'Forty Five Lakh Only', 0.00, 0.00, 0.00, 90000.00, 0, NULL, '', '', '', NULL, '', '', '', '', '2025-03-18 09:40:36', '2025-03-18 09:40:36', NULL, NULL, '223', NULL),
(168, 15, 'Abbas', 0, '', '0336-8265555', '', 2, 2, 6, '', 600.00, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 202, '', '', 'Shaheed Masjid', 'Kharadar', 0, 0, '', NULL, NULL, 0, 0, 0, 'Flat', 'Residential', 'Available', 'mod', 0.00, 5000000.00, 'Fifty Lakh Only', 0.00, 0.00, 0.00, 100000.00, 0, NULL, '', '', '', NULL, '', '', '', '', '2025-03-18 09:51:16', '2025-03-18 09:51:16', NULL, NULL, '224', NULL),
(169, 7, 'Samir Raza Lilani', 9, '', '03343655662', '4200005590367', 2, 2, 5, '', 600.00, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 203, '', '', '', 'Soldier Bazar 01', 0, 0, '', NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, 0.00, 6500000.00, 'Sixty Five Lakh Only', 0.00, 0.00, 0.00, 130000.00, 0, NULL, '', '', '', NULL, '', '', NULL, '', '2025-03-18 09:55:19', '2025-03-18 09:56:52', NULL, NULL, '37', NULL),
(170, 15, 'Maham', 0, '', '0306-2669066', '', 2, 2, 0, 'G-6', 1100.00, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 188, '', 'Lift,Car Parking,Bike Parking,Generator', 'Hussaini Blood Bank', 'Parsi Colony', 0, 0, '', NULL, NULL, 0, 0, 0, 'Flat', 'Residential', 'Hold', 'mod', 0.00, 11000000.00, 'One Crore Ten Lakh Only', 0.00, 0.00, 0.00, 220000.00, 0, NULL, '', '', '', NULL, '', '', '', '', '2025-03-18 11:39:40', '2025-03-18 11:39:40', NULL, NULL, '208', NULL),
(171, 15, 'M.Nadeem', 0, '', '0333-3561281', '', 2, 2, 4, '33', 650.00, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 189, '650', 'Car Parking,Bike Parking', 'Lakhpatti lawn', 'Garden East', 0, 0, '', NULL, NULL, 0, 0, 0, 'Flat', 'Residential', 'Hold', 'mod', 0.00, 7000000.00, 'Seventy Lakh Only', 0.00, 0.00, 0.00, 140000.00, 0, NULL, '', '', '', NULL, '', '', '', '', '2025-03-18 11:43:37', '2025-03-18 11:43:37', NULL, NULL, '209', NULL),
(172, 15, 'Ramzan Ali', 0, '', '0321-2967725', '', 2, 2, 4, '402', 0.00, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 190, '', '', '', 'Soldier Bazar 01', 0, 0, '', NULL, NULL, 0, 0, 0, 'Flat', 'Residential', 'Hold', 'medium', 0.00, 9000000.00, 'Ninety Lakh Only', 0.00, 0.00, 0.00, 180000.00, 0, NULL, '', '', '', NULL, '', '', '', '', '2025-03-18 11:46:21', '2025-03-18 11:46:21', NULL, NULL, '210', NULL),
(173, 15, 'Haider Ali', 0, '', '0336-2772778', '', 2, 2, 2, '5', 950.00, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 177, '', '', 'Hyder Bakery', 'Soldier Bazar 01', 0, 0, '', NULL, NULL, 0, 0, 0, 'Flat', 'Residential', 'Hold', 'mod', 0.00, 10000000.00, 'One Crore Only', 0.00, 0.00, 0.00, 100000.00, 0, NULL, '', '', '', NULL, '', '', '', '', '2025-03-18 11:50:02', '2025-03-18 11:50:02', NULL, NULL, '211', NULL),
(174, 15, 'Aqeel(Bank Al Falah)', 0, '', '0334-3121001', '', 2, 2, 1, '105', 900.00, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 191, '', '', 'Taj Petrol Pump', 'Soldier Bazar 02', 0, 0, '', NULL, NULL, 0, 0, 0, 'Flat', 'Residential', 'Hold', 'medium', 0.00, 10000000.00, 'One Crore Only', 0.00, 0.00, 0.00, 100000.00, 0, NULL, '', '', '', NULL, '', '', '', '', '2025-03-18 11:53:12', '2025-03-18 11:53:12', NULL, NULL, '212', NULL),
(175, 15, 'M.Sohail', 0, '', '0323-2179963', '', 4, 4, 3, '301', 0.00, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 192, '', 'Lift,Car Parking,Bike Parking,Generator', 'Saqib Bakery', 'Parsi Colony', 0, 0, '', NULL, NULL, 0, 0, 0, 'Flat', 'Residential', 'Hold', 'mod', 0.00, 33000000.00, 'Three Crore Thirty Lakh Only', 0.00, 0.00, 0.00, 990000.00, 0, NULL, '', '', '', NULL, '', '', '', '', '2025-03-18 11:57:42', '2025-03-18 11:57:42', NULL, NULL, '213', NULL),
(176, 15, 'Aun Ali', 0, '', '0332-2123409', '', 4, 4, 4, '', 8500000.00, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 193, '', '', 'Luqman Samosa', 'Soldier Bazar 02', 0, 0, '', NULL, NULL, 0, 0, 0, 'Flat', 'Residential', 'Hold', 'medium', 0.00, 8500000.00, 'Eighty Five Lakh Only', 0.00, 0.00, 0.00, 170000.00, 0, NULL, '', '', '', NULL, '', '', '', '', '2025-03-18 12:00:43', '2025-03-18 12:00:43', NULL, NULL, '214', NULL),
(177, 15, 'Saffiudeen', 0, '', '0324-2260883', '', 2, 2, 4, '16', 500.00, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 204, '', '', 'Phool Wali Gali', 'Punjab Town', 0, 0, '', NULL, NULL, 0, 0, 0, 'Flat', 'Residential', 'Available', 'medium', 0.00, 6000000.00, 'Sixty Lakh Only', 0.00, 0.00, 0.00, 120000.00, 0, NULL, '', '', '', NULL, '', '', '', '', '2025-03-18 17:17:14', '2025-03-18 17:17:14', NULL, NULL, '225', NULL),
(178, 15, 'Irfan', 0, '', '0331-8796705', '', 2, 2, 4, '402', 500.00, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 205, '', '', 'Cycle Market', 'Light House', 0, 0, '', NULL, NULL, 0, 0, 0, 'Flat', 'Residential', 'Available', 'medium', 0.00, 4000000.00, 'Forty Lakh Only', 0.00, 0.00, 0.00, 80000.00, 0, NULL, '', '', '', NULL, '', '', '', '', '2025-03-18 17:40:13', '2025-03-18 17:40:13', NULL, NULL, '226', NULL),
(179, 15, 'Jawaid Ali', 0, '', '0332-3479708', '', 2, 2, 5, '501', 0.00, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 206, '', '', 'Christian Bhaitak ', 'Soldier Bazar 02', 0, 0, '', NULL, NULL, 0, 0, 0, 'Flat', 'Residential', 'Available', 'medium', 0.00, 4500000.00, 'Forty Five Lakh Only', 0.00, 0.00, 0.00, 90000.00, 0, NULL, '', '', '', NULL, '', '', '', '', '2025-03-18 17:47:01', '2025-03-18 17:47:01', NULL, NULL, '227', NULL),
(180, 15, 'Muzammil', 0, '', '0345-2321847', '', 2, 2, 3, '302', 500.00, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 207, '', '', 'Raza Dairy Milk', 'Soldier Bazar 03', 0, 0, '', NULL, NULL, 0, 0, 0, 'Flat', 'Residential', 'Available', 'medium', 0.00, 6500000.00, 'Sixty Five Lakh Only', 0.00, 0.00, 0.00, 130000.00, 0, NULL, '', '', '', NULL, '', '', '', '', '2025-03-18 17:57:24', '2025-03-18 17:57:24', NULL, NULL, '228', NULL),
(181, 15, 'Haji Sadiq ', 0, '', '021-32220429', '', 3, 3, 4, '409', 0.00, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 194, '', 'Car Parking,Bike Parking', 'Pak Night Clinic', 'Soldier Bazar 02', 0, 0, '', NULL, NULL, 0, 0, 0, 'Flat', 'Residential', 'Hold', 'mod', 0.00, 15000000.00, 'One Crore Fifty Lakh Only', 0.00, 0.00, 0.00, 300000.00, 0, NULL, '', '', '', NULL, '', '', NULL, '', '2025-03-19 09:22:37', '2025-03-19 09:28:16', NULL, NULL, '215', NULL),
(182, 15, 'Nelson', 0, '', '0323-2480492', '', 2, 2, 1, '', 0.00, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 195, '', '', '', 'Soldier Bazar 02', 0, 0, '', NULL, NULL, 0, 0, 0, 'Flat', 'Residential', 'Hold', 'medium', 0.00, 5000000.00, 'Fifty Lakh Only', 0.00, 0.00, 0.00, 100000.00, 0, NULL, '', '', '', NULL, '', '', NULL, '', '2025-03-19 09:27:05', '2025-03-19 09:29:52', NULL, NULL, '216', NULL),
(183, 15, 'Abdul Hussain', 0, '', '0334-3907637', '', 3, 3, 3, '302', 0.00, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 196, '', 'Lift,Car Parking,Bike Parking,Generator', '', 'Parsi Colony', 0, 0, '', NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, 0.00, 24000000.00, 'Two Crore Forty Lakh Only', 0.00, 0.00, 0.00, 280000.00, 0, NULL, '', '', '', NULL, '', '', '', '', '2025-03-19 09:33:40', '2025-03-19 09:33:40', NULL, NULL, '217', NULL),
(184, 13, 'Mrs Raza', 0, '', '0333-2395636', '', 2, 1, 0, '', 0.00, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 197, '', '', 'Chai Wala Hotel', 'Soldier Bazar 02', 0, 0, '', NULL, NULL, 0, 0, 0, 'Flat', 'Residential', 'Hold', 'medium', 0.00, 5000000.00, 'Fifty Lakh Only', 0.00, 0.00, 0.00, 100000.00, 0, NULL, '', '', '', NULL, '', '', '', '', '2025-03-19 09:37:34', '2025-03-19 09:37:34', NULL, NULL, '125', NULL),
(185, 15, 'Imran Ali', 0, '', '0300-3490490', '', 2, 2, 3, 'A-118/119', 650.00, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 198, 'A-118/119', '', '', 'Soldier Bazar 01', 0, 0, '', NULL, NULL, 0, 0, 0, 'Flat', 'Residential', 'Hold', 'medium', 0.00, 5600000.00, 'Fifty Six Lakh Only', 0.00, 0.00, 0.00, 112000.00, 0, NULL, '', '', '', NULL, '', '', '', '', '2025-03-19 09:43:52', '2025-03-19 09:43:52', NULL, NULL, '219', NULL),
(186, 15, 'Mohsin Bori', 0, '', '0331-2066839', '', 2, 2, 4, '', 1000.00, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 208, '', '', 'JDC Zahra Foundation', 'Soldier Bazar 03', 0, 0, '', NULL, NULL, 0, 0, 0, 'Flat', 'Residential', 'Available', 'medium', 0.00, 11500000.00, 'One Crore Fifteen Lakh Only', 0.00, 0.00, 0.00, 230000.00, 0, NULL, '', '', '', NULL, '', '', NULL, '', '2025-03-23 07:22:35', '2025-03-23 07:33:43', NULL, NULL, '230', NULL),
(187, 15, 'Mrs Hassan', 0, '', '0333-2199255', '', 2, 2, 3, '', 0.00, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 209, '', '', 'Shell Petrol Pump', 'Jamshed Road', 0, 0, '', NULL, NULL, 0, 0, 0, 'Flat', 'Residential', 'Available', 'medium', 0.00, 11000000.00, 'One Crore Ten Lakh Only', 0.00, 0.00, 0.00, 220000.00, 0, NULL, '', '', '', NULL, '', '', '', '', '2025-03-23 07:32:16', '2025-03-23 07:32:16', NULL, NULL, '231', NULL),
(188, 15, 'Faisal Gova', 0, '', '0300-2134441', '', 2, 2, 4, '', 900.00, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 210, '', '', 'Adam Square', 'Soldier Bazar 02', 0, 0, '', NULL, NULL, 0, 0, 0, 'Flat', 'Residential', 'Available', 'medium', 0.00, 13000000.00, 'One Crore Thirty Lakh Only', 0.00, 0.00, 0.00, 260000.00, 0, NULL, '', '', '', NULL, '', '', '', '', '2025-03-23 07:40:37', '2025-03-23 07:40:37', NULL, NULL, '232', NULL),
(189, 15, 'Dr Fahad', 0, '', '0322-8456736', '', 2, 2, 0, 'G-5', 0.00, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 170, '', 'Lift,CCTV,Car Parking,Intercom,Kid Area,Waiting Area', 'Old Hussain Blood Bank', 'Parsi Colony', 0, 0, 'None', NULL, NULL, 0, 0, 0, 'Flat', 'Residential', 'Available', 'medium', 0.00, 20000000.00, 'Two Crore Only', 0.00, 0.00, 0.00, 200000.00, 0, NULL, '', '', '', NULL, '', '', '', '', '2025-03-23 07:44:19', '2025-03-23 07:44:19', NULL, NULL, '233', NULL),
(190, 15, 'Ali Haider', 0, '', '0333-3799865', '', 2, 2, 2, '202', 0.00, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 211, '', '', 'Hadi Dairy Milk', 'Soldier Bazar 02', 0, 0, '', NULL, NULL, 0, 0, 0, 'Flat', 'Residential', 'Available', 'mod', 0.00, 8500000.00, 'Eighty Five Lakh Only', 0.00, 0.00, 0.00, 170000.00, 0, NULL, '', '', '', NULL, '', '', NULL, '', '2025-03-25 06:33:12', '2025-03-25 07:09:22', NULL, NULL, '234', NULL),
(191, 15, 'Abdul Rehman', 0, '', '0321-2734285', '', 2, 2, 1, 'E-103', 1050.00, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 212, '', 'Lift,Car Parking,Bike Parking', 'Sherbano Bagh', 'Garden West', 0, 0, '', NULL, NULL, 0, 0, 0, 'Flat', 'Residential', 'Available', 'mod', 0.00, 7500000.00, 'Seventy Five Lakh Only', 0.00, 0.00, 0.00, 150000.00, 0, NULL, '', '', '', NULL, '', '', NULL, '', '2025-03-25 07:00:11', '2025-03-25 07:09:56', NULL, NULL, '235', NULL),
(192, 15, 'M.Raza Masala', 0, '', '0335-2811713', '', 2, 2, 4, '404', 1000.00, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 213, '', 'Lift,Car Parking,Generator', 'Fatimiyah Jammat Sport Complex', 'Britto Road', 0, 0, '', NULL, NULL, 0, 0, 0, 'Flat', 'Residential', 'Available', 'mod', 0.00, 30000000.00, 'Three Crore Only', 0.00, 0.00, 0.00, 600000.00, 0, NULL, '', '', '', NULL, '', '', '', '', '2025-03-25 07:03:35', '2025-03-25 07:03:35', NULL, NULL, '236', NULL),
(193, 15, 'M.Raza', 0, '', '0334-3521445', '', 2, 2, 5, '', 750.00, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 214, '', '', 'Charming Beaty Parlour', 'Soldier Bazar 01', 0, 0, '', NULL, NULL, 0, 0, 0, 'Flat', 'Residential', 'Available', 'mod', 0.00, 8000000.00, 'Eighty Lakh Only', 0.00, 0.00, 0.00, 160000.00, 0, NULL, '', '', '', NULL, '', '', '', '', '2025-03-25 07:08:35', '2025-03-25 07:08:35', NULL, NULL, '237', NULL),
(194, 15, 'Mrs Hanif', 0, '', '0331-2090746', '', 2, 2, 1, '8', 850.00, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 215, '', 'Lift,Car Parking,Bike Parking', 'Phool Wali Gali', 'Punjab Town', 0, 0, '', NULL, NULL, 0, 0, 0, 'Flat', 'Residential', 'Available', 'mod', 0.00, 15000000.00, 'One Crore Fifty Lakh Only', 0.00, 0.00, 0.00, 300000.00, 0, NULL, '', '', '', NULL, '', '', '', '', '2025-03-25 07:13:52', '2025-03-25 07:13:52', NULL, NULL, '239', NULL),
(195, 15, 'Moiz Ali Zaidi', 0, '', '0330-8413978', '', 2, 3, 3, '6', 900.00, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 216, '', '', 'Hashmani Hospital', 'Lines Area', 0, 0, '', NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, 0.00, 9500000.00, 'Ninety Five Lakh Only', 0.00, 0.00, 0.00, 190000.00, 0, NULL, '', '', '', NULL, '', '', '', '', '2025-03-25 07:16:35', '2025-03-25 07:16:35', NULL, NULL, '240', NULL),
(196, 15, 'Yaqoob', 0, '', '0333-3737041', '', 2, 2, 3, '', 0.00, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 157, '', 'Car Parking,Project Completion Certificate,Bank Loan', 'Lakhpatti hall', 'Garden East', 0, 0, 'None', NULL, NULL, 0, 0, 0, 'Flat', 'Residential', 'Available', 'medium', 0.00, 7000000.00, 'Seventy Lakh Only', 0.00, 0.00, 0.00, 140000.00, 0, NULL, '', '', '', NULL, '', '', '', '', '2025-03-25 07:34:37', '2025-03-25 07:34:37', NULL, NULL, '241', NULL),
(197, 23, 'Hasnain 5093', 0, '', '0332-9545253 / 0322-', '', 3, 3, 3, '', 1900.00, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 217, 'JM 00', 'Lift,CCTV,Car Parking', 'Near Hassan Heights', 'Soldier Bazar 03', 0, 0, '', NULL, NULL, 0, 0, 0, 'Flat', 'Residential', 'Available', 'medium', 0.00, 18000000.00, 'One Crore Eighty Lakh Only', 0.00, 0.00, 0.00, 2.00, 0, NULL, '', '', '', NULL, '', '', NULL, '', '2025-03-25 10:37:56', '2025-03-25 10:42:35', NULL, NULL, '243', NULL),
(198, 15, 'M Kashif', 0, '', '0345-9490089', '', 2, 2, 4, '402', 0.00, 1, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 219, '', '', 'Sidiqia Masjid', 'Soldier Bazar 02', 0, 0, '', NULL, NULL, 0, 0, 0, 'Flat', 'Residential', 'Available', 'mod', 0.00, 6000000.00, 'Sixty Lakh Only', 0.00, 0.00, 0.00, 120000.00, 1, NULL, '', '', '', NULL, '', '', '', '', '2025-04-07 12:27:48', '2025-04-07 12:27:48', NULL, NULL, '249', NULL),
(199, 15, 'Muzammil ', 0, '', '0315-8498386', '', 2, 2, 0, '709', 0.00, 1, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 220, '', 'Lift,Car Parking,Bike Parking,Project Completion Certificate,Bank Loan', 'Ali Medical Clinic near Nishter park ', 'Parsi Colony', 1, 1, '', NULL, NULL, 0, 0, 0, 'Flat', 'Residential', 'Available', 'mod', 0.00, 15000000.00, 'One Crore Fifty Lakh Only', 300000.00, 0.00, 0.00, 0.00, 0, NULL, '', '', '', NULL, '', '', '', '', '2025-04-07 12:38:12', '2025-04-07 12:38:12', NULL, NULL, '250', NULL),
(200, 15, 'Siraj', 0, '', '0300-2670058', '', 2, 2, 3, '302', 950.00, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 221, '', 'Project Completion Certificate,Bank Loan', 'Madina Masjid', 'Nazimabad', 1, 1, '', NULL, NULL, 0, 0, 0, 'Flat', 'Residential', 'Available', 'mod', 0.00, 6500000.00, 'Sixty Five Lakh Only', 0.00, 0.00, 0.00, 135000.00, 0, NULL, '', '', '', NULL, '', '', '', '', '2025-04-07 12:57:56', '2025-04-07 12:57:56', NULL, NULL, '251', NULL),
(201, 17, 'Ali Raza Builder (SB)', 9, '', '03012219456', '', 2, 2, 5, '501', 600.00, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 222, '', '', 'Soldier bazaar no 1 police station ', 'Soldier Bazar 01', 0, 0, 'Ali Raza Builder (SB)', NULL, NULL, 0, 0, 0, 'Flat', 'Residential', 'Available', 'mod', 0.00, 5500000.00, 'Fifty Five Lakh Only', 0.00, 0.00, 0.00, 110000.00, 0, NULL, '', '', '', NULL, '', '', '', '', '2025-04-07 13:18:08', '2025-04-07 13:18:08', NULL, NULL, '188', NULL),
(202, 17, 'Ali Raza Builder (SB)', 9, '', '03012219456', '', 2, 2, 4, '401', 600.00, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 222, '', '', 'Soldier bazaar no 1 police station ', 'Soldier Bazar 01', 0, 0, 'Ali Raza Builder (SB)', NULL, NULL, 0, 0, 0, 'Flat', 'Residential', 'Available', 'mod', 0.00, 6000000.00, 'Sixty Lakh Only', 0.00, 0.00, 0.00, 120000.00, 0, NULL, '', '', '', NULL, '', '', '', '', '2025-04-07 13:35:52', '2025-04-07 13:35:52', NULL, NULL, '188', NULL),
(203, 15, 'Khaliq Ur Rehman', 0, '', '0303-2883124', '', 2, 2, 1, 'Right hand of stairs', 550.00, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 223, '', 'Project Completion Certificate,Bank Loan', '', 'Soldier Bazar 01', 0, 0, '', NULL, NULL, 0, 0, 0, 'Flat', 'Residential', 'Sold', 'mod', 0.00, 2500000.00, 'Twenty Five Lakh Only', 0.00, 0.00, 0.00, 50000.00, 1, NULL, '', '', '', NULL, '', '', NULL, '', '2025-04-07 14:03:08', '2025-04-11 14:04:00', NULL, NULL, '252', NULL),
(205, 15, 'Asgher ghori', 0, '', '0335-3209142', '', 3, 3, 8, '', 1500.00, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 160, '', '', 'Nagori Milk', 'Soldier Bazar 02', 0, 0, '', NULL, NULL, 0, 0, 0, 'Flat', 'Residential', 'Available', 'medium', 0.00, 15000000.00, 'One Crore Fifty Lakh Only', 0.00, 0.00, 0.00, 0.00, 0, NULL, '', '', '', NULL, '', '', '', '', '2025-06-03 08:49:31', '2025-06-03 08:49:31', NULL, NULL, '293', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `seller_financials`
--

CREATE TABLE `seller_financials` (
  `id` int(11) NOT NULL,
  `seller_id` int(11) NOT NULL,
  `demand` decimal(15,2) DEFAULT NULL,
  `received` decimal(15,2) DEFAULT NULL,
  `balance` decimal(15,2) DEFAULT NULL,
  `monthly_installment` decimal(15,2) DEFAULT NULL,
  `down_payment` decimal(15,2) DEFAULT NULL,
  `possession` decimal(15,2) DEFAULT NULL,
  `booking_date` date DEFAULT NULL,
  `payment_status` enum('Paid','Partially Paid','Pending','Overdue') DEFAULT NULL,
  `payment_plan` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `seller_id_sequence`
--

CREATE TABLE `seller_id_sequence` (
  `year` int(11) NOT NULL,
  `last_sequence` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `seller_id_sequence`
--

INSERT INTO `seller_id_sequence` (`year`, `last_sequence`) VALUES
(2025, 8);

-- --------------------------------------------------------

--
-- Table structure for table `seller_projects_backup`
--

CREATE TABLE `seller_projects_backup` (
  `id` int(11) NOT NULL DEFAULT 0,
  `seller_id` int(11) NOT NULL,
  `project_id` int(11) DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  `developer` varchar(100) DEFAULT NULL,
  `features` text DEFAULT NULL,
  `description` text DEFAULT NULL,
  `project_status` enum('Under Construction','Completed','Launching Soon','On Hold') DEFAULT NULL,
  `completion_date` date DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `seller_properties`
--

CREATE TABLE `seller_properties` (
  `id` int(11) NOT NULL,
  `seller_id` int(11) NOT NULL,
  `bed_rooms` int(11) DEFAULT NULL,
  `bath` int(11) DEFAULT NULL,
  `floor` int(11) DEFAULT NULL,
  `block` varchar(50) DEFAULT NULL,
  `sqft` decimal(10,2) DEFAULT NULL,
  `drawing` tinyint(1) DEFAULT 0,
  `dining` tinyint(1) DEFAULT 0,
  `common` tinyint(1) DEFAULT 0,
  `west_open` tinyint(1) DEFAULT 0,
  `roof` tinyint(1) DEFAULT 0,
  `store` tinyint(1) DEFAULT 0,
  `back` tinyint(1) DEFAULT 0,
  `corner` tinyint(1) DEFAULT 0,
  `separate_gate` tinyint(1) DEFAULT 0,
  `basement` tinyint(1) DEFAULT 0,
  `gas` tinyint(1) DEFAULT 0,
  `front` tinyint(1) DEFAULT 0,
  `mezzanine` tinyint(1) DEFAULT 0,
  `water` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `seller_references`
--

CREATE TABLE `seller_references` (
  `id` int(11) NOT NULL,
  `seller_id` int(11) NOT NULL,
  `ref_name` varchar(100) DEFAULT NULL,
  `ref_cnic` varchar(15) DEFAULT NULL,
  `ref_contact` varchar(20) DEFAULT NULL,
  `ref_email` varchar(100) DEFAULT NULL,
  `ref_relationship` enum('Family','Friend','Colleague','Business Partner','Other') DEFAULT NULL,
  `ref_occupation` varchar(100) DEFAULT NULL,
  `ref_address` text DEFAULT NULL,
  `ref2_name` varchar(100) DEFAULT NULL,
  `ref2_cnic` varchar(15) DEFAULT NULL,
  `ref2_contact` varchar(20) DEFAULT NULL,
  `ref2_email` varchar(100) DEFAULT NULL,
  `ref2_relationship` enum('Family','Friend','Colleague','Business Partner','Other') DEFAULT NULL,
  `ref2_occupation` varchar(100) DEFAULT NULL,
  `ref2_address` text DEFAULT NULL,
  `reference_notes` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `seller_tenants`
--

CREATE TABLE `seller_tenants` (
  `id` int(11) NOT NULL,
  `seller_id` int(11) NOT NULL,
  `tenant_name` varchar(100) DEFAULT NULL,
  `tenant_cnic` varchar(15) DEFAULT NULL,
  `tenant_contact` varchar(20) DEFAULT NULL,
  `tenant_email` varchar(100) DEFAULT NULL,
  `monthly_rent` decimal(15,2) DEFAULT NULL,
  `security_deposit` decimal(15,2) DEFAULT NULL,
  `lease_start` date DEFAULT NULL,
  `lease_end` date DEFAULT NULL,
  `tenant_status` enum('Active','Inactive','Notice Period','Vacated') DEFAULT NULL,
  `payment_frequency` enum('Monthly','Quarterly','Bi-Annual','Annual') DEFAULT NULL,
  `tenant_notes` text DEFAULT NULL,
  `electricity_included` tinyint(1) DEFAULT 0,
  `water_included` tinyint(1) DEFAULT 0,
  `gas_included` tinyint(1) DEFAULT 0,
  `maintenance_included` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `statuses`
--

CREATE TABLE `statuses` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `statuses`
--

INSERT INTO `statuses` (`id`, `name`) VALUES
(19, 'approved'),
(27, 'Available'),
(28, 'Hold'),
(29, 'Sold'),
(30, 'Active'),
(31, 'Close');

-- --------------------------------------------------------

--
-- Table structure for table `sub_accounts`
--

CREATE TABLE `sub_accounts` (
  `id` int(11) NOT NULL,
  `account_head_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `sub_accounts`
--

INSERT INTO `sub_accounts` (`id`, `account_head_id`, `name`) VALUES
(1, 1, 'Narration'),
(2, 1, 'Prepaid Rent'),
(3, 1, 'Land & Building'),
(4, 1, 'Office Equipment'),
(5, 1, 'Furniture & Fixtures'),
(6, 1, 'Vehicles'),
(7, 1, 'Goodwill'),
(8, 1, 'Software License'),
(9, 1, 'Patents'),
(10, 2, 'Short-term Loan'),
(11, 2, 'Bank Loan'),
(12, 2, 'Lease Payable'),
(13, 2, 'Bonds Payable'),
(14, 3, 'Capital'),
(15, 3, 'Drawings'),
(16, 3, 'Retained Earnings'),
(17, 3, 'Reserves'),
(18, 4, 'Sales Revenue'),
(19, 4, 'Service Income'),
(20, 4, 'Consultancy Income'),
(21, 4, 'Interest Income'),
(22, 4, 'Rent Received'),
(23, 4, 'Gain on Sale of Asset'),
(24, 5, 'Utility'),
(25, 5, 'Rent Expense'),
(26, 5, 'Interest Expense'),
(27, 5, 'Loss on Asset Disposal'),
(28, 5, 'Depreciation'),
(29, 5, 'Amortization'),
(30, 1, 'Other Receivable'),
(31, 2, 'Other Payable');

-- --------------------------------------------------------

--
-- Table structure for table `tenant_entries`
--

CREATE TABLE `tenant_entries` (
  `id` int(11) NOT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `lead_id` int(11) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `property_type_id` int(11) DEFAULT NULL,
  `status_id` int(11) DEFAULT NULL,
  `priority_id` int(11) DEFAULT NULL,
  `deposit` decimal(10,2) DEFAULT NULL,
  `rent` decimal(10,2) DEFAULT NULL,
  `in_word` varchar(255) DEFAULT NULL,
  `office_charges` decimal(10,2) DEFAULT NULL,
  `bed_room` int(11) DEFAULT NULL,
  `bathroom` int(11) DEFAULT NULL,
  `floor` int(11) DEFAULT NULL,
  `drawing` tinyint(1) DEFAULT 0,
  `roof` tinyint(1) DEFAULT 0,
  `separate_gate` tinyint(1) DEFAULT 0,
  `dining` tinyint(1) DEFAULT 0,
  `store` tinyint(1) DEFAULT 0,
  `basement` tinyint(1) DEFAULT 0,
  `common` tinyint(1) DEFAULT 0,
  `mezzanine` tinyint(1) DEFAULT 0,
  `west_open` tinyint(1) DEFAULT 0,
  `gas` tinyint(1) DEFAULT 0,
  `water` tinyint(1) DEFAULT 0,
  `corner` tinyint(1) DEFAULT 0,
  `front` tinyint(1) DEFAULT 0,
  `tenant_requirement` text DEFAULT NULL,
  `reference_name` varchar(255) DEFAULT NULL,
  `reference_cnic` varchar(15) DEFAULT NULL,
  `reference_cell` varchar(15) DEFAULT NULL,
  `reference_note` text DEFAULT NULL,
  `remarks` text DEFAULT NULL,
  `photo` varchar(255) DEFAULT NULL,
  `entry_date` date DEFAULT NULL,
  `overseas` tinyint(1) DEFAULT 0,
  `investor` tinyint(1) DEFAULT 0,
  `builder` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tenant_entries`
--

INSERT INTO `tenant_entries` (`id`, `customer_id`, `lead_id`, `category_id`, `property_type_id`, `status_id`, `priority_id`, `deposit`, `rent`, `in_word`, `office_charges`, `bed_room`, `bathroom`, `floor`, `drawing`, `roof`, `separate_gate`, `dining`, `store`, `basement`, `common`, `mezzanine`, `west_open`, `gas`, `water`, `corner`, `front`, `tenant_requirement`, `reference_name`, `reference_cnic`, `reference_cell`, `reference_note`, `remarks`, `photo`, `entry_date`, `overseas`, `investor`, `builder`) VALUES
(18, 205, 19, 61, 72, 27, 18, 200000.00, 45000.00, 'Forty Five Thousand Rupees Only', 1.00, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', '', '', '', '', '', '2025-03-26', 0, 0, 0),
(19, 37, NULL, NULL, NULL, NULL, NULL, 0.00, 0.00, '', 0.00, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', '', '', '', '', '', '2025-03-26', 0, 0, 0),
(20, 245, 19, 61, 72, 30, 18, 100000.00, 50000.00, 'Fifty Thousand Rupees Only', 0.00, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', '', '', '', '', '', '2025-03-27', 0, 0, 0),
(21, 250, 9, 59, 71, 27, 22, 100000.00, 20000.00, 'Twenty Thousand Rupees Only', 20000.00, 2, 2, 3, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, '', '', '', '', '', '', '', '2025-04-07', 0, 0, 0),
(22, 251, 9, 59, 71, 27, 22, 100000.00, 35000.00, 'Thirty Five Thousand Rupees Only', 35000.00, 2, 2, 2, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 'Parking required ', '', '', '', '', '', '', '2025-04-07', 0, 0, 0),
(23, 254, 9, 59, 71, 30, NULL, 0.00, 85000.00, 'Eighty Five Thousand Rupees Only', 0.00, 3, 3, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', '', '', '', '', '', '2025-04-07', 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `unit_bookings`
--

CREATE TABLE `unit_bookings` (
  `id` int(11) NOT NULL,
  `unit_id` int(11) DEFAULT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `agent_id` int(11) DEFAULT NULL,
  `booking_date` date DEFAULT NULL,
  `token_amount` decimal(15,2) DEFAULT NULL,
  `payment_plan_id` int(11) DEFAULT NULL,
  `status` enum('active','cancelled','transferred','completed') DEFAULT 'active',
  `cancellation_reason` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `unit_payment_plans`
--

CREATE TABLE `unit_payment_plans` (
  `id` int(11) NOT NULL,
  `unit_id` int(11) DEFAULT NULL,
  `template_id` int(11) DEFAULT NULL,
  `booking_amount` decimal(15,2) DEFAULT NULL,
  `total_amount` decimal(15,2) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `unit_types`
--

CREATE TABLE `unit_types` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `bedrooms` int(11) DEFAULT NULL,
  `bathrooms` int(11) DEFAULT NULL,
  `status` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` varchar(50) DEFAULT 'user',
  `created_at` datetime DEFAULT current_timestamp(),
  `privileges` longtext DEFAULT NULL,
  `blocked` tinyint(1) DEFAULT 0,
  `last_activity` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `email` varchar(255) NOT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `first_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `role_id` int(11) DEFAULT NULL,
  `is_admin` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `role`, `created_at`, `privileges`, `blocked`, `last_activity`, `email`, `is_active`, `first_name`, `last_name`, `role_id`, `is_admin`) VALUES
(1, 'admin', '$2y$10$g9CZeFwIQw3/3MD54GbzVeULvUPSPjxUb.w1qpoQpWLBWp5uTpjyS', 'user', '2025-02-08 20:47:06', NULL, 0, '2025-06-04 14:56:04', 'admin@example.com', 1, NULL, NULL, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `user_activities`
--

CREATE TABLE `user_activities` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `activity` varchar(255) NOT NULL,
  `timestamp` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `accounts`
--
ALTER TABLE `accounts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sub_account_id` (`sub_account_id`);

--
-- Indexes for table `accounts_head`
--
ALTER TABLE `accounts_head`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `activity_log`
--
ALTER TABLE `activity_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `admin_id` (`admin_id`);

--
-- Indexes for table `areas`
--
ALTER TABLE `areas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `city_id` (`city_id`);

--
-- Indexes for table `attendance`
--
ALTER TABLE `attendance`
  ADD PRIMARY KEY (`id`),
  ADD KEY `employee_id` (`employee_id`);

--
-- Indexes for table `attendance_settings`
--
ALTER TABLE `attendance_settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `bank`
--
ALTER TABLE `bank`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `bank_info`
--
ALTER TABLE `bank_info`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `casts`
--
ALTER TABLE `casts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `created_by` (`created_by`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cell_no`
--
ALTER TABLE `cell_no`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `cell_no` (`cell_no`),
  ADD UNIQUE KEY `cell_no_2` (`cell_no`),
  ADD KEY `customer_id` (`customer_id`);

--
-- Indexes for table `cities`
--
ALTER TABLE `cities`
  ADD PRIMARY KEY (`id`),
  ADD KEY `country_id` (`country_id`);

--
-- Indexes for table `coa`
--
ALTER TABLE `coa`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `company_settings`
--
ALTER TABLE `company_settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `countries`
--
ALTER TABLE `countries`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `cnic` (`cnic`),
  ADD KEY `lead_id` (`lead_id`),
  ADD KEY `cast_id` (`cast_id`),
  ADD KEY `religion_id` (`religion_id`),
  ADD KEY `marital_status_id` (`marital_status_id`),
  ADD KEY `area_id` (`area_id`),
  ADD KEY `city_id` (`city_id`),
  ADD KEY `country_id` (`country_id`),
  ADD KEY `idx_customers_id` (`id`),
  ADD KEY `idx_customers_name` (`name`),
  ADD KEY `idx_customers_lead_id` (`lead_id`),
  ADD KEY `idx_customers_religion_id` (`religion_id`);

--
-- Indexes for table `customer_banks`
--
ALTER TABLE `customer_banks`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `iban` (`iban`),
  ADD KEY `customer_id` (`customer_id`);

--
-- Indexes for table `departments`
--
ALTER TABLE `departments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `parent_dept_id` (`parent_dept_id`),
  ADD KEY `manager_id` (`manager_id`);

--
-- Indexes for table `document_categories`
--
ALTER TABLE `document_categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `education_levels`
--
ALTER TABLE `education_levels`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `level_name` (`level_name`);

--
-- Indexes for table `employees`
--
ALTER TABLE `employees`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `employee_id` (`employee_id`),
  ADD UNIQUE KEY `barcode` (`barcode`),
  ADD KEY `department_id` (`department_id`),
  ADD KEY `hired_by` (`hired_by`),
  ADD KEY `reporting_manager_id` (`reporting_manager_id`);

--
-- Indexes for table `employee_education`
--
ALTER TABLE `employee_education`
  ADD PRIMARY KEY (`id`),
  ADD KEY `employee_id` (`employee_id`),
  ADD KEY `education_level_id` (`education_level_id`);

--
-- Indexes for table `employee_qrcodes`
--
ALTER TABLE `employee_qrcodes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `employee_id` (`employee_id`);

--
-- Indexes for table `employee_work_history`
--
ALTER TABLE `employee_work_history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `employee_id` (`employee_id`);

--
-- Indexes for table `features`
--
ALTER TABLE `features`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `feature_categories`
--
ALTER TABLE `feature_categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `leads`
--
ALTER TABLE `leads`
  ADD PRIMARY KEY (`id`),
  ADD KEY `created_by` (`created_by`);

--
-- Indexes for table `main_form`
--
ALTER TABLE `main_form`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `marital_statuses`
--
ALTER TABLE `marital_statuses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `created_by` (`created_by`);

--
-- Indexes for table `occupations`
--
ALTER TABLE `occupations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `payment_plan_templates`
--
ALTER TABLE `payment_plan_templates`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `payment_plan_template_details`
--
ALTER TABLE `payment_plan_template_details`
  ADD PRIMARY KEY (`id`),
  ADD KEY `template_id` (`template_id`);

--
-- Indexes for table `priorities`
--
ALTER TABLE `priorities`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `privileges`
--
ALTER TABLE `privileges`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `projects`
--
ALTER TABLE `projects`
  ADD PRIMARY KEY (`project_id`),
  ADD KEY `country_id` (`country_id`),
  ADD KEY `city_id` (`city_id`),
  ADD KEY `area_id` (`area_id`);

--
-- Indexes for table `projects_backup`
--
ALTER TABLE `projects_backup`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `project_documents_backup`
--
ALTER TABLE `project_documents_backup`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `project_document_categories`
--
ALTER TABLE `project_document_categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `project_features`
--
ALTER TABLE `project_features`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `project_features_backup`
--
ALTER TABLE `project_features_backup`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `project_floors_backup`
--
ALTER TABLE `project_floors_backup`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `project_landmarks_backup`
--
ALTER TABLE `project_landmarks_backup`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `project_milestones_backup`
--
ALTER TABLE `project_milestones_backup`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `project_notifications_backup`
--
ALTER TABLE `project_notifications_backup`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `project_photos_backup`
--
ALTER TABLE `project_photos_backup`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `project_selected_features`
--
ALTER TABLE `project_selected_features`
  ADD PRIMARY KEY (`id`),
  ADD KEY `project_id` (`project_id`),
  ADD KEY `feature_id` (`feature_id`);

--
-- Indexes for table `project_status_history_backup`
--
ALTER TABLE `project_status_history_backup`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `project_units_backup`
--
ALTER TABLE `project_units_backup`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `project_updates_backup`
--
ALTER TABLE `project_updates_backup`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `property_types`
--
ALTER TABLE `property_types`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `purchasers`
--
ALTER TABLE `purchasers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `purchases`
--
ALTER TABLE `purchases`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `purchase_returns`
--
ALTER TABLE `purchase_returns`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `receive_voucher`
--
ALTER TABLE `receive_voucher`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `receive_vouchers`
--
ALTER TABLE `receive_vouchers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `receive_voucher_journal`
--
ALTER TABLE `receive_voucher_journal`
  ADD PRIMARY KEY (`id`),
  ADD KEY `receive_voucher_id` (`receive_voucher_id`);

--
-- Indexes for table `ref_table`
--
ALTER TABLE `ref_table`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `religions`
--
ALTER TABLE `religions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `created_by` (`created_by`);

--
-- Indexes for table `rents`
--
ALTER TABLE `rents`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `rent_agreements`
--
ALTER TABLE `rent_agreements`
  ADD PRIMARY KEY (`id`),
  ADD KEY `owner_id` (`owner_id`),
  ADD KEY `tenant_id` (`tenant_id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `role_name` (`role_name`);

--
-- Indexes for table `salary_components`
--
ALTER TABLE `salary_components`
  ADD PRIMARY KEY (`id`),
  ADD KEY `employee_id` (`employee_id`);

--
-- Indexes for table `sales`
--
ALTER TABLE `sales`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sale_agreements`
--
ALTER TABLE `sale_agreements`
  ADD PRIMARY KEY (`id`),
  ADD KEY `seller_id` (`seller_id`),
  ADD KEY `purchaser_id` (`purchaser_id`),
  ADD KEY `seller_witness_id` (`seller_witness_id`),
  ADD KEY `purchaser_witness_id` (`purchaser_witness_id`);

--
-- Indexes for table `sale_returns`
--
ALTER TABLE `sale_returns`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sellers_backup`
--
ALTER TABLE `sellers_backup`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `seller_financials`
--
ALTER TABLE `seller_financials`
  ADD PRIMARY KEY (`id`),
  ADD KEY `seller_id` (`seller_id`);

--
-- Indexes for table `seller_id_sequence`
--
ALTER TABLE `seller_id_sequence`
  ADD PRIMARY KEY (`year`);

--
-- Indexes for table `seller_projects_backup`
--
ALTER TABLE `seller_projects_backup`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `seller_properties`
--
ALTER TABLE `seller_properties`
  ADD PRIMARY KEY (`id`),
  ADD KEY `seller_id` (`seller_id`);

--
-- Indexes for table `seller_references`
--
ALTER TABLE `seller_references`
  ADD PRIMARY KEY (`id`),
  ADD KEY `seller_id` (`seller_id`);

--
-- Indexes for table `seller_tenants`
--
ALTER TABLE `seller_tenants`
  ADD PRIMARY KEY (`id`),
  ADD KEY `seller_id` (`seller_id`);

--
-- Indexes for table `statuses`
--
ALTER TABLE `statuses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sub_accounts`
--
ALTER TABLE `sub_accounts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `account_head_id` (`account_head_id`);

--
-- Indexes for table `tenant_entries`
--
ALTER TABLE `tenant_entries`
  ADD PRIMARY KEY (`id`),
  ADD KEY `customer_id` (`customer_id`),
  ADD KEY `lead_id` (`lead_id`),
  ADD KEY `category_id` (`category_id`),
  ADD KEY `property_type_id` (`property_type_id`),
  ADD KEY `status_id` (`status_id`),
  ADD KEY `priority_id` (`priority_id`);

--
-- Indexes for table `unit_bookings`
--
ALTER TABLE `unit_bookings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `unit_id` (`unit_id`),
  ADD KEY `customer_id` (`customer_id`),
  ADD KEY `agent_id` (`agent_id`),
  ADD KEY `payment_plan_id` (`payment_plan_id`);

--
-- Indexes for table `unit_payment_plans`
--
ALTER TABLE `unit_payment_plans`
  ADD PRIMARY KEY (`id`),
  ADD KEY `unit_id` (`unit_id`),
  ADD KEY `template_id` (`template_id`);

--
-- Indexes for table `unit_types`
--
ALTER TABLE `unit_types`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD KEY `role_id` (`role_id`);

--
-- Indexes for table `user_activities`
--
ALTER TABLE `user_activities`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `accounts`
--
ALTER TABLE `accounts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `accounts_head`
--
ALTER TABLE `accounts_head`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `activity_log`
--
ALTER TABLE `activity_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `areas`
--
ALTER TABLE `areas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=50;

--
-- AUTO_INCREMENT for table `attendance`
--
ALTER TABLE `attendance`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `attendance_settings`
--
ALTER TABLE `attendance_settings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `bank`
--
ALTER TABLE `bank`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `bank_info`
--
ALTER TABLE `bank_info`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `casts`
--
ALTER TABLE `casts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=66;

--
-- AUTO_INCREMENT for table `cell_no`
--
ALTER TABLE `cell_no`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=289;

--
-- AUTO_INCREMENT for table `cities`
--
ALTER TABLE `cities`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `coa`
--
ALTER TABLE `coa`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `company_settings`
--
ALTER TABLE `company_settings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `countries`
--
ALTER TABLE `countries`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=305;

--
-- AUTO_INCREMENT for table `customer_banks`
--
ALTER TABLE `customer_banks`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `departments`
--
ALTER TABLE `departments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `document_categories`
--
ALTER TABLE `document_categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `education_levels`
--
ALTER TABLE `education_levels`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `employees`
--
ALTER TABLE `employees`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `employee_education`
--
ALTER TABLE `employee_education`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `employee_qrcodes`
--
ALTER TABLE `employee_qrcodes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `employee_work_history`
--
ALTER TABLE `employee_work_history`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `features`
--
ALTER TABLE `features`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `feature_categories`
--
ALTER TABLE `feature_categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `leads`
--
ALTER TABLE `leads`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `main_form`
--
ALTER TABLE `main_form`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=205;

--
-- AUTO_INCREMENT for table `marital_statuses`
--
ALTER TABLE `marital_statuses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `occupations`
--
ALTER TABLE `occupations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `payment_plan_templates`
--
ALTER TABLE `payment_plan_templates`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payment_plan_template_details`
--
ALTER TABLE `payment_plan_template_details`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `priorities`
--
ALTER TABLE `priorities`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `privileges`
--
ALTER TABLE `privileges`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `projects`
--
ALTER TABLE `projects`
  MODIFY `project_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=250;

--
-- AUTO_INCREMENT for table `project_document_categories`
--
ALTER TABLE `project_document_categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `project_features`
--
ALTER TABLE `project_features`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `project_selected_features`
--
ALTER TABLE `project_selected_features`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `property_types`
--
ALTER TABLE `property_types`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=73;

--
-- AUTO_INCREMENT for table `purchasers`
--
ALTER TABLE `purchasers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `purchases`
--
ALTER TABLE `purchases`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `purchase_returns`
--
ALTER TABLE `purchase_returns`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `receive_voucher`
--
ALTER TABLE `receive_voucher`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `receive_vouchers`
--
ALTER TABLE `receive_vouchers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `receive_voucher_journal`
--
ALTER TABLE `receive_voucher_journal`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ref_table`
--
ALTER TABLE `ref_table`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `religions`
--
ALTER TABLE `religions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `rents`
--
ALTER TABLE `rents`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `rent_agreements`
--
ALTER TABLE `rent_agreements`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `salary_components`
--
ALTER TABLE `salary_components`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sales`
--
ALTER TABLE `sales`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sale_agreements`
--
ALTER TABLE `sale_agreements`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `sale_returns`
--
ALTER TABLE `sale_returns`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sellers_backup`
--
ALTER TABLE `sellers_backup`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=206;

--
-- AUTO_INCREMENT for table `seller_financials`
--
ALTER TABLE `seller_financials`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `seller_properties`
--
ALTER TABLE `seller_properties`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `seller_references`
--
ALTER TABLE `seller_references`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `seller_tenants`
--
ALTER TABLE `seller_tenants`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `statuses`
--
ALTER TABLE `statuses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `sub_accounts`
--
ALTER TABLE `sub_accounts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `tenant_entries`
--
ALTER TABLE `tenant_entries`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `unit_bookings`
--
ALTER TABLE `unit_bookings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `unit_payment_plans`
--
ALTER TABLE `unit_payment_plans`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `unit_types`
--
ALTER TABLE `unit_types`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `user_activities`
--
ALTER TABLE `user_activities`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `accounts`
--
ALTER TABLE `accounts`
  ADD CONSTRAINT `accounts_ibfk_1` FOREIGN KEY (`sub_account_id`) REFERENCES `sub_accounts` (`id`);

--
-- Constraints for table `activity_log`
--
ALTER TABLE `activity_log`
  ADD CONSTRAINT `activity_log_ibfk_1` FOREIGN KEY (`admin_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `areas`
--
ALTER TABLE `areas`
  ADD CONSTRAINT `areas_ibfk_1` FOREIGN KEY (`city_id`) REFERENCES `cities` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `attendance`
--
ALTER TABLE `attendance`
  ADD CONSTRAINT `attendance_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `casts`
--
ALTER TABLE `casts`
  ADD CONSTRAINT `casts_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `cell_no`
--
ALTER TABLE `cell_no`
  ADD CONSTRAINT `cell_no_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `cities`
--
ALTER TABLE `cities`
  ADD CONSTRAINT `cities_ibfk_1` FOREIGN KEY (`country_id`) REFERENCES `countries` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `customers`
--
ALTER TABLE `customers`
  ADD CONSTRAINT `customers_ibfk_1` FOREIGN KEY (`lead_id`) REFERENCES `leads` (`id`),
  ADD CONSTRAINT `customers_ibfk_2` FOREIGN KEY (`cast_id`) REFERENCES `casts` (`id`),
  ADD CONSTRAINT `customers_ibfk_3` FOREIGN KEY (`religion_id`) REFERENCES `religions` (`id`),
  ADD CONSTRAINT `customers_ibfk_4` FOREIGN KEY (`marital_status_id`) REFERENCES `marital_statuses` (`id`),
  ADD CONSTRAINT `customers_ibfk_5` FOREIGN KEY (`area_id`) REFERENCES `areas` (`id`),
  ADD CONSTRAINT `customers_ibfk_6` FOREIGN KEY (`city_id`) REFERENCES `cities` (`id`),
  ADD CONSTRAINT `customers_ibfk_7` FOREIGN KEY (`country_id`) REFERENCES `countries` (`id`);

--
-- Constraints for table `customer_banks`
--
ALTER TABLE `customer_banks`
  ADD CONSTRAINT `customer_banks_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`);

--
-- Constraints for table `departments`
--
ALTER TABLE `departments`
  ADD CONSTRAINT `departments_ibfk_1` FOREIGN KEY (`parent_dept_id`) REFERENCES `departments` (`id`),
  ADD CONSTRAINT `departments_ibfk_2` FOREIGN KEY (`manager_id`) REFERENCES `employees` (`id`);

--
-- Constraints for table `employees`
--
ALTER TABLE `employees`
  ADD CONSTRAINT `employees_ibfk_1` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`),
  ADD CONSTRAINT `employees_ibfk_2` FOREIGN KEY (`hired_by`) REFERENCES `employees` (`id`),
  ADD CONSTRAINT `employees_ibfk_3` FOREIGN KEY (`reporting_manager_id`) REFERENCES `employees` (`id`);

--
-- Constraints for table `employee_education`
--
ALTER TABLE `employee_education`
  ADD CONSTRAINT `employee_education_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `employee_education_ibfk_2` FOREIGN KEY (`education_level_id`) REFERENCES `education_levels` (`id`);

--
-- Constraints for table `employee_qrcodes`
--
ALTER TABLE `employee_qrcodes`
  ADD CONSTRAINT `employee_qrcodes_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`employee_id`);

--
-- Constraints for table `employee_work_history`
--
ALTER TABLE `employee_work_history`
  ADD CONSTRAINT `employee_work_history_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `leads`
--
ALTER TABLE `leads`
  ADD CONSTRAINT `leads_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `marital_statuses`
--
ALTER TABLE `marital_statuses`
  ADD CONSTRAINT `marital_statuses_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `payment_plan_template_details`
--
ALTER TABLE `payment_plan_template_details`
  ADD CONSTRAINT `payment_plan_template_details_ibfk_1` FOREIGN KEY (`template_id`) REFERENCES `payment_plan_templates` (`id`);

--
-- Constraints for table `projects`
--
ALTER TABLE `projects`
  ADD CONSTRAINT `projects_ibfk_1` FOREIGN KEY (`country_id`) REFERENCES `countries` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `projects_ibfk_2` FOREIGN KEY (`city_id`) REFERENCES `cities` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `projects_ibfk_3` FOREIGN KEY (`area_id`) REFERENCES `areas` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `project_selected_features`
--
ALTER TABLE `project_selected_features`
  ADD CONSTRAINT `project_selected_features_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `projects` (`project_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `project_selected_features_ibfk_2` FOREIGN KEY (`feature_id`) REFERENCES `project_features` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `receive_voucher_journal`
--
ALTER TABLE `receive_voucher_journal`
  ADD CONSTRAINT `receive_voucher_journal_ibfk_1` FOREIGN KEY (`receive_voucher_id`) REFERENCES `receive_voucher` (`id`);

--
-- Constraints for table `religions`
--
ALTER TABLE `religions`
  ADD CONSTRAINT `religions_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `rent_agreements`
--
ALTER TABLE `rent_agreements`
  ADD CONSTRAINT `rent_agreements_ibfk_1` FOREIGN KEY (`owner_id`) REFERENCES `rents` (`id`),
  ADD CONSTRAINT `rent_agreements_ibfk_2` FOREIGN KEY (`tenant_id`) REFERENCES `customers` (`id`);

--
-- Constraints for table `salary_components`
--
ALTER TABLE `salary_components`
  ADD CONSTRAINT `salary_components_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `sale_agreements`
--
ALTER TABLE `sale_agreements`
  ADD CONSTRAINT `sale_agreements_ibfk_1` FOREIGN KEY (`seller_id`) REFERENCES `sellers_backup` (`id`),
  ADD CONSTRAINT `sale_agreements_ibfk_2` FOREIGN KEY (`purchaser_id`) REFERENCES `main_form` (`id`),
  ADD CONSTRAINT `sale_agreements_ibfk_3` FOREIGN KEY (`seller_witness_id`) REFERENCES `customers` (`id`),
  ADD CONSTRAINT `sale_agreements_ibfk_4` FOREIGN KEY (`purchaser_witness_id`) REFERENCES `customers` (`id`);

--
-- Constraints for table `seller_financials`
--
ALTER TABLE `seller_financials`
  ADD CONSTRAINT `seller_financials_ibfk_1` FOREIGN KEY (`seller_id`) REFERENCES `sellers_backup` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `seller_properties`
--
ALTER TABLE `seller_properties`
  ADD CONSTRAINT `seller_properties_ibfk_1` FOREIGN KEY (`seller_id`) REFERENCES `sellers_backup` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `seller_references`
--
ALTER TABLE `seller_references`
  ADD CONSTRAINT `seller_references_ibfk_1` FOREIGN KEY (`seller_id`) REFERENCES `sellers_backup` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `seller_tenants`
--
ALTER TABLE `seller_tenants`
  ADD CONSTRAINT `seller_tenants_ibfk_1` FOREIGN KEY (`seller_id`) REFERENCES `sellers_backup` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `sub_accounts`
--
ALTER TABLE `sub_accounts`
  ADD CONSTRAINT `sub_accounts_ibfk_1` FOREIGN KEY (`account_head_id`) REFERENCES `accounts_head` (`id`);

--
-- Constraints for table `tenant_entries`
--
ALTER TABLE `tenant_entries`
  ADD CONSTRAINT `tenant_entries_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`),
  ADD CONSTRAINT `tenant_entries_ibfk_2` FOREIGN KEY (`lead_id`) REFERENCES `leads` (`id`),
  ADD CONSTRAINT `tenant_entries_ibfk_3` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`),
  ADD CONSTRAINT `tenant_entries_ibfk_4` FOREIGN KEY (`property_type_id`) REFERENCES `property_types` (`id`),
  ADD CONSTRAINT `tenant_entries_ibfk_5` FOREIGN KEY (`status_id`) REFERENCES `statuses` (`id`),
  ADD CONSTRAINT `tenant_entries_ibfk_6` FOREIGN KEY (`priority_id`) REFERENCES `priorities` (`id`);

--
-- Constraints for table `unit_bookings`
--
ALTER TABLE `unit_bookings`
  ADD CONSTRAINT `unit_bookings_ibfk_1` FOREIGN KEY (`unit_id`) REFERENCES `project_units_backup` (`id`),
  ADD CONSTRAINT `unit_bookings_ibfk_2` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`),
  ADD CONSTRAINT `unit_bookings_ibfk_3` FOREIGN KEY (`agent_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `unit_bookings_ibfk_4` FOREIGN KEY (`payment_plan_id`) REFERENCES `unit_payment_plans` (`id`);

--
-- Constraints for table `unit_payment_plans`
--
ALTER TABLE `unit_payment_plans`
  ADD CONSTRAINT `unit_payment_plans_ibfk_1` FOREIGN KEY (`unit_id`) REFERENCES `project_units_backup` (`id`),
  ADD CONSTRAINT `unit_payment_plans_ibfk_2` FOREIGN KEY (`template_id`) REFERENCES `payment_plan_templates` (`id`);

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`);

--
-- Constraints for table `user_activities`
--
ALTER TABLE `user_activities`
  ADD CONSTRAINT `user_activities_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
