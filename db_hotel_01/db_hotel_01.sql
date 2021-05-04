-- phpMyAdmin SQL Dump
-- version 4.9.5
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: May 04, 2021 at 07:33 AM
-- Server version: 5.7.24
-- PHP Version: 7.4.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_hotel_01`
--

-- --------------------------------------------------------

--
-- Table structure for table `document_types`
--

CREATE TABLE `document_types` (
  `id` int(11) NOT NULL,
  `name` varchar(20) NOT NULL,
  `description` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `document_types`
--

INSERT INTO `document_types` (`id`, `name`, `description`) VALUES
(1, 'CI', 'blah blah blah blah '),
(2, 'Passport', 'blah blah blah blah '),
(3, 'Driving License', 'blah blah blah blah '),
(4, 'Amico di mio cuggino', 'blah blah blah blah ');

-- --------------------------------------------------------

--
-- Table structure for table `guests`
--

CREATE TABLE `guests` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `surname` varchar(50) NOT NULL,
  `birthdate` date NOT NULL,
  `email` varchar(50) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `document_types_id` int(11) NOT NULL,
  `document_code` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `guests`
--

INSERT INTO `guests` (`id`, `name`, `surname`, `birthdate`, `email`, `phone`, `document_types_id`, `document_code`) VALUES
(1, 'Marco', 'Giallini', '1967-05-04', 'margo.giallini@gmail.com', '3333333333', 1, '5555555555'),
(2, 'Pierfrancesco', 'Favino', '2000-05-28', 'pierfrancesco.famino@gmail.com', '3333333333', 3, '5555555555'),
(3, 'Angela', 'Finocchiaro', '2005-05-20', 'angela.finocchiaro@gmail.com', '3333333333', 2, '5555555555'),
(4, 'Paola', 'Cortellesi', '1987-05-25', 'paola cortellesi@gmail.com', '3333333333', 1, '5555555555');

-- --------------------------------------------------------

--
-- Table structure for table `payment_methods`
--

CREATE TABLE `payment_methods` (
  `id` int(11) NOT NULL,
  `name` varchar(20) NOT NULL,
  `description` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `payment_methods`
--

INSERT INTO `payment_methods` (`id`, `name`, `description`) VALUES
(1, 'cash', 'blah blah blah '),
(2, 'credit card', 'blah blah blah blah '),
(3, 'bank transfer', 'blah blah blah blah ');

-- --------------------------------------------------------

--
-- Table structure for table `reservations`
--

CREATE TABLE `reservations` (
  `id` int(11) NOT NULL,
  `status_id` int(11) NOT NULL,
  `payment_methods_id` int(11) NOT NULL,
  `payment_amount` decimal(10,0) NOT NULL,
  `paying_guest_id` int(11) NOT NULL,
  `check_in` datetime NOT NULL,
  `check_out` datetime NOT NULL,
  `annotations` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `reservations`
--

INSERT INTO `reservations` (`id`, `status_id`, `payment_methods_id`, `payment_amount`, `paying_guest_id`, `check_in`, `check_out`, `annotations`) VALUES
(1, 1, 2, '300', 2, '2021-05-02 15:33:23', '2021-05-08 15:33:23', 'blah blah blah blah '),
(2, 2, 3, '600', 3, '2021-05-09 15:34:41', '2021-05-08 15:34:41', 'blah blah blah blah '),
(3, 1, 1, '200', 1, '2021-05-23 15:35:21', '2021-05-22 15:35:21', 'blah blah blah blah '),
(4, 3, 2, '800', 4, '2021-05-16 15:33:23', '2021-05-22 15:35:50', 'blah blah blah blah ');

-- --------------------------------------------------------

--
-- Table structure for table `reservations_guests`
--

CREATE TABLE `reservations_guests` (
  `reservations_id` int(11) NOT NULL,
  `guests_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `rooms`
--

CREATE TABLE `rooms` (
  `id` int(11) NOT NULL,
  `name` varchar(20) NOT NULL,
  `bed_number` int(11) NOT NULL,
  `type` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `rooms`
--

INSERT INTO `rooms` (`id`, `name`, `bed_number`, `type`) VALUES
(1, '101', 4, 'family'),
(3, '102', 4, 'family'),
(4, '103', 2, 'double'),
(5, '104', 2, 'double'),
(6, '201', 4, 'family'),
(7, '202', 4, 'family'),
(8, '203', 2, 'double'),
(9, '204', 1, 'single'),
(10, '301', 2, 'suite'),
(11, '302', 2, 'suite');

-- --------------------------------------------------------

--
-- Table structure for table `rooms_reservations`
--

CREATE TABLE `rooms_reservations` (
  `rooms_id` int(11) NOT NULL,
  `reservations_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `rooms_reservations`
--

INSERT INTO `rooms_reservations` (`rooms_id`, `reservations_id`) VALUES
(1, 1),
(3, 1),
(4, 1),
(11, 2),
(7, 3),
(8, 3),
(1, 4),
(10, 4);

-- --------------------------------------------------------

--
-- Table structure for table `status`
--

CREATE TABLE `status` (
  `id` int(11) NOT NULL,
  `name` varchar(20) NOT NULL,
  `description` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `status`
--

INSERT INTO `status` (`id`, `name`, `description`) VALUES
(1, 'accepted', 'order taken blah blah blah'),
(2, 'pending', 'waiting for blah blah blah'),
(3, 'closed', 'blah blah blah blah ');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `document_types`
--
ALTER TABLE `document_types`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `guests`
--
ALTER TABLE `guests`
  ADD PRIMARY KEY (`id`),
  ADD KEY `document_types_id` (`document_types_id`) USING BTREE;

--
-- Indexes for table `payment_methods`
--
ALTER TABLE `payment_methods`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `reservations`
--
ALTER TABLE `reservations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `status_fk` (`status_id`),
  ADD KEY `paymant_methods_fk` (`payment_methods_id`),
  ADD KEY `guests_fk` (`paying_guest_id`);

--
-- Indexes for table `reservations_guests`
--
ALTER TABLE `reservations_guests`
  ADD PRIMARY KEY (`reservations_id`,`guests_id`),
  ADD KEY `guests_fk_1` (`guests_id`);

--
-- Indexes for table `rooms`
--
ALTER TABLE `rooms`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name_idx` (`name`);

--
-- Indexes for table `rooms_reservations`
--
ALTER TABLE `rooms_reservations`
  ADD PRIMARY KEY (`rooms_id`,`reservations_id`),
  ADD KEY `reservations_fk` (`reservations_id`);

--
-- Indexes for table `status`
--
ALTER TABLE `status`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `document_types`
--
ALTER TABLE `document_types`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `guests`
--
ALTER TABLE `guests`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `payment_methods`
--
ALTER TABLE `payment_methods`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `reservations`
--
ALTER TABLE `reservations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `rooms`
--
ALTER TABLE `rooms`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `status`
--
ALTER TABLE `status`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `guests`
--
ALTER TABLE `guests`
  ADD CONSTRAINT `document_type_id` FOREIGN KEY (`document_types_id`) REFERENCES `document_types` (`id`);

--
-- Constraints for table `reservations`
--
ALTER TABLE `reservations`
  ADD CONSTRAINT `guests_fk` FOREIGN KEY (`paying_guest_id`) REFERENCES `guests` (`id`),
  ADD CONSTRAINT `paymant_methods_fk` FOREIGN KEY (`payment_methods_id`) REFERENCES `payment_methods` (`id`),
  ADD CONSTRAINT `status_fk` FOREIGN KEY (`status_id`) REFERENCES `status` (`id`);

--
-- Constraints for table `reservations_guests`
--
ALTER TABLE `reservations_guests`
  ADD CONSTRAINT `guests_fk_1` FOREIGN KEY (`guests_id`) REFERENCES `guests` (`id`),
  ADD CONSTRAINT `reservations_fk_1` FOREIGN KEY (`reservations_id`) REFERENCES `reservations` (`id`);

--
-- Constraints for table `rooms_reservations`
--
ALTER TABLE `rooms_reservations`
  ADD CONSTRAINT `reservations_fk` FOREIGN KEY (`reservations_id`) REFERENCES `reservations` (`id`),
  ADD CONSTRAINT `rooms_fk` FOREIGN KEY (`rooms_id`) REFERENCES `rooms` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
