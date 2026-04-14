-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Jun 17, 2025 at 07:52 AM
-- Server version: 8.0.40
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `catcafedb2`
--

-- --------------------------------------------------------

--
-- Table structure for table `bookings`
--

CREATE TABLE `bookings` (
  `bookingID` int NOT NULL,
  `customerId` int DEFAULT NULL,
  `tableID` int DEFAULT NULL,
  `bookingDate` date NOT NULL,
  `status` enum('CONFIRMED','CANCELLED','COMPLETED') COLLATE utf8mb4_general_ci DEFAULT 'CONFIRMED',
  `bookingType` enum('DINE_IN','TAKEAWAY') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'DINE_IN'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `bookings`
--

INSERT INTO `bookings` (`bookingID`, `customerId`, `tableID`, `bookingDate`, `status`, `bookingType`) VALUES
(1, 10, 1, '2025-06-17', 'CONFIRMED', 'DINE_IN'),
(2, 10, 2, '2025-06-17', 'CONFIRMED', 'DINE_IN'),
(3, 10, 1, '2025-07-31', 'CONFIRMED', 'DINE_IN'),
(4, 10, 2, '2025-07-31', 'CONFIRMED', 'DINE_IN'),
(5, 10, 3, '2025-07-31', 'CONFIRMED', 'DINE_IN');

-- --------------------------------------------------------

--
-- Table structure for table `cafe_tables`
--

CREATE TABLE `cafe_tables` (
  `tableID` int NOT NULL,
  `tableNumber` varchar(10) COLLATE utf8mb4_general_ci NOT NULL,
  `tableType` enum('SINGLE','DOUBLE') COLLATE utf8mb4_general_ci NOT NULL,
  `status` enum('AVAILABLE','OCCUPIED','MAINTENANCE') COLLATE utf8mb4_general_ci DEFAULT 'AVAILABLE'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `cafe_tables`
--

INSERT INTO `cafe_tables` (`tableID`, `tableNumber`, `tableType`, `status`) VALUES
(1, 'S1', 'SINGLE', 'AVAILABLE'),
(2, 'S2', 'SINGLE', 'AVAILABLE'),
(3, 'S3', 'SINGLE', 'AVAILABLE'),
(4, 'S4', 'SINGLE', 'AVAILABLE'),
(5, 'D1', 'DOUBLE', 'AVAILABLE'),
(6, 'D2', 'DOUBLE', 'AVAILABLE'),
(7, 'D3', 'DOUBLE', 'AVAILABLE'),
(8, 'D4', 'DOUBLE', 'AVAILABLE');

-- --------------------------------------------------------

--
-- Table structure for table `cat_feeding`
--

CREATE TABLE `cat_feeding` (
  `feeding_id` int NOT NULL,
  `cat_id` int NOT NULL,
  `food_id` int NOT NULL,
  `amount` int NOT NULL,
  `feeding_date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `cat_feeding`
--

INSERT INTO `cat_feeding` (`feeding_id`, `cat_id`, `food_id`, `amount`, `feeding_date`) VALUES
(1, 1, 1, 2, '2025-05-18'),
(2, 2, 2, 1, '2025-05-18'),
(4, 4, 4, 1, '2025-05-18'),
(5, 5, 5, 2, '2025-05-18'),
(6, 1, 2, 1, '2025-05-19'),
(7, 2, 1, 2, '2025-05-19'),
(9, 4, 4, 1, '2025-05-19'),
(10, 5, 5, 1, '2025-05-19');

-- --------------------------------------------------------

--
-- Table structure for table `cat_food`
--

CREATE TABLE `cat_food` (
  `food_id` int NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `quantity` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `cat_food`
--

INSERT INTO `cat_food` (`food_id`, `name`, `quantity`) VALUES
(1, 'Salmon Treats', 55),
(2, 'Chicken Delight', 90),
(4, 'Meow Mix Salmon', 36),
(5, 'Fancy Feast Beef', 20),
(6, 'Purina Chicken', 45),
(7, 'Chicken Dinner', 12),
(9, 'Whiskas Tuna', 60),
(11, 'fancy beef', 55);

-- --------------------------------------------------------

--
-- Table structure for table `cat_profiles`
--

CREATE TABLE `cat_profiles` (
  `cat_id` int NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `image` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `breed` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `age` int NOT NULL,
  `gender` enum('Male','Female') COLLATE utf8mb4_general_ci NOT NULL,
  `health_status` text COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `cat_profiles`
--

INSERT INTO `cat_profiles` (`cat_id`, `name`, `image`, `breed`, `age`, `gender`, `health_status`) VALUES
(1, 'Mochiiii', 'images/mochi.jpg', 'Persian', 2, 'Female', 'Healthy'),
(2, 'Simbaaaa', 'images/simba.jpg', 'Maine Coon', 4, 'Male', 'Mild allergies'),
(3, 'Luna', 'images/luna.jpg', 'British Shorthair', 3, 'Female', 'Healthy'),
(4, 'Oliver', 'images/oliver.jpg', 'Siamese', 5, 'Male', 'Requires special diet'),
(5, 'Nala', 'images/nala.jpg', 'Ragdoll', 1, 'Female', 'Recovering from surgery');

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `customerId` int NOT NULL,
  `customer_name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `customer_birth_date` date NOT NULL,
  `customer_date_registered` date NOT NULL,
  `customer_phone_number` varchar(30) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `customer_email` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `customer_password` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `customer_status` enum('active','deactivated') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'active',
  `customer_username` varchar(255) COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`customerId`, `customer_name`, `customer_birth_date`, `customer_date_registered`, `customer_phone_number`, `customer_email`, `customer_password`, `customer_status`, `customer_username`) VALUES
(1, 'Muhammad Syakil bin Mohd Zaidi', '2002-08-19', '2025-05-26', '0199120557', 'syakil135@gmail.com', '88888888', 'active', 'LurdK'),
(2, 'Test', '2025-05-26', '2025-05-26', '0112345678', 'you@example.com', 'test123', 'active', 'test123'),
(3, 'Muhammad Nor Firdaus', '2025-10-03', '2025-05-26', '0123456789', 'daus@gmail.com', 'creamy098', 'active', 'creamy'),
(4, 'Puteri Nur Jannah', '2025-06-03', '2025-05-26', '0198765432', 'jannah@gmail.com', 'jannah098', 'active', 'jannah'),
(5, 'Nur Syakilah Binti Mohd Zaidi', '2003-09-29', '2025-05-26', '0199120449', 'syakilahzd@gmail.com', '123445', 'active', 'Kilah'),
(9, 'Muhammad Syamil bin Mohd Zaidi', '2025-05-26', '2025-05-26', '0199120949', 'syamilzd@gmail.com', '1234', 'active', 'saymil'),
(10, 'Hatsune Miku', '2025-05-27', '2025-05-27', '0199120889', 'miku@gmail.com', '1234', 'active', 'Miku'),
(11, 'Hatsune Miku', '2025-05-27', '2025-05-27', '0199120889', 'miku@yahoo.com', '1234', 'active', 'Hatsune'),
(12, 'Fikriyah', '2025-06-17', '2025-06-17', '011-23122923', 's71806@ocean.umt.edu.my', 'fik123', 'active', 'fik33'),
(13, 'Fikriyah', '2025-06-17', '2025-06-17', '011-23122923', 's71805@ocean.umt.edu.my', 'fik123', 'active', 'fik');

-- --------------------------------------------------------

--
-- Table structure for table `menu`
--

CREATE TABLE `menu` (
  `menuID` int NOT NULL,
  `menuName` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `menuPrice` decimal(10,2) NOT NULL,
  `category` enum('FOOD','BEVERAGE','DESSERT') COLLATE utf8mb4_general_ci NOT NULL,
  `image_url` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `is_available` tinyint(1) DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `menu`
--

INSERT INTO `menu` (`menuID`, `menuName`, `menuPrice`, `category`, `image_url`, `is_available`) VALUES
(1, 'Chicken Chop', 15.90, 'FOOD', 'images/ChickenChop.jpg', 1),
(2, 'Iced Lemon Tea', 4.50, 'BEVERAGE', 'images/IceLemonTea.jpg', 1),
(3, 'Chocolate Lava Cake', 8.90, 'DESSERT', 'images/LavaCake.jpg', 1),
(16, 'Pizza', 100.00, 'FOOD', 'images/pizza.jpeg', 1),
(18, 'Cheesy Wedges', 100.00, 'FOOD', 'images/CheesyWedges.png', 1),
(19, 'Chicken Wrap', 100.00, 'FOOD', 'images/ChickenWrap.png', 1);

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `orderID` int NOT NULL,
  `customerId` int DEFAULT NULL,
  `orderType` enum('DINE_IN','TAKEAWAY') COLLATE utf8mb4_general_ci NOT NULL,
  `orderDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` enum('PENDING','PAID','CANCELLED','COMPLETED') COLLATE utf8mb4_general_ci DEFAULT 'PENDING',
  `total_amount` decimal(10,2) DEFAULT NULL,
  `tableID` int DEFAULT NULL,
  `payment_method` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`orderID`, `customerId`, `orderType`, `orderDate`, `status`, `total_amount`, `tableID`, `payment_method`) VALUES
(1, 10, 'TAKEAWAY', '2025-06-17 04:47:25', 'PAID', 15.90, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `order_items`
--

CREATE TABLE `order_items` (
  `order_itemID` int NOT NULL,
  `orderID` int NOT NULL,
  `menuID` int NOT NULL,
  `quantity` int NOT NULL DEFAULT '1',
  `price` decimal(10,2) NOT NULL,
  `special_requests` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `order_items`
--

INSERT INTO `order_items` (`order_itemID`, `orderID`, `menuID`, `quantity`, `price`, `special_requests`) VALUES
(1, 1, 1, 1, 15.90, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `special_access`
--

CREATE TABLE `special_access` (
  `special_access_id` int NOT NULL,
  `special_access_type` enum('admin','staff') COLLATE utf8mb4_general_ci NOT NULL,
  `special_access_name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `special_access_password` varchar(255) COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `special_access`
--

INSERT INTO `special_access` (`special_access_id`, `special_access_type`, `special_access_name`, `special_access_password`) VALUES
(2, 'admin', 'admin', '$2a$10$HVAhxj8yPDPxBUw9LX5zSO2HbzrKEDUqKLgX6qRxW8QmGVAiwV80u'),
(3, 'staff', 'staff', '$2a$10$HCMiRTpWc1va6TaRVzRxJeY/eqRuffaSBnlwCiDSX2Rw/qDBJ1WQW');

-- --------------------------------------------------------

--
-- Table structure for table `staff`
--

CREATE TABLE `staff` (
  `staff_id` varchar(10) NOT NULL,
  `name` varchar(255) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` varchar(10) NOT NULL DEFAULT 'staff'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `staff`
--

INSERT INTO `staff` (`staff_id`, `name`, `username`, `password`, `role`) VALUES
('S001', 'Admin User', 'admin', 'admin123', 'admin'),
('S101', 'Fik', 'Fikriyah', 'fik123', 'staff'),
('S102', 'Syakil', 'Syakil', 'syakil123', 'staff'),
('S103', 'Ariiq', 'Ariiq', 'ariiq123', 'staff');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `bookings`
--
ALTER TABLE `bookings`
  ADD PRIMARY KEY (`bookingID`),
  ADD KEY `customerId` (`customerId`),
  ADD KEY `tableID` (`tableID`),
  ADD KEY `bookingDate` (`bookingDate`,`status`);

--
-- Indexes for table `cafe_tables`
--
ALTER TABLE `cafe_tables`
  ADD PRIMARY KEY (`tableID`),
  ADD UNIQUE KEY `tableNumber` (`tableNumber`);

--
-- Indexes for table `cat_feeding`
--
ALTER TABLE `cat_feeding`
  ADD PRIMARY KEY (`feeding_id`),
  ADD KEY `fk_food` (`food_id`),
  ADD KEY `fk_cat` (`cat_id`);

--
-- Indexes for table `cat_food`
--
ALTER TABLE `cat_food`
  ADD PRIMARY KEY (`food_id`);

--
-- Indexes for table `cat_profiles`
--
ALTER TABLE `cat_profiles`
  ADD PRIMARY KEY (`cat_id`);

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`customerId`),
  ADD UNIQUE KEY `customer_username` (`customer_username`),
  ADD UNIQUE KEY `customer_email` (`customer_email`);

--
-- Indexes for table `menu`
--
ALTER TABLE `menu`
  ADD PRIMARY KEY (`menuID`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`orderID`),
  ADD KEY `customerId` (`customerId`),
  ADD KEY `tableID` (`tableID`);

--
-- Indexes for table `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`order_itemID`),
  ADD KEY `orderID` (`orderID`),
  ADD KEY `menuID` (`menuID`);

--
-- Indexes for table `special_access`
--
ALTER TABLE `special_access`
  ADD PRIMARY KEY (`special_access_id`);

--
-- Indexes for table `staff`
--
ALTER TABLE `staff`
  ADD PRIMARY KEY (`staff_id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `bookings`
--
ALTER TABLE `bookings`
  MODIFY `bookingID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `cafe_tables`
--
ALTER TABLE `cafe_tables`
  MODIFY `tableID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `cat_feeding`
--
ALTER TABLE `cat_feeding`
  MODIFY `feeding_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `cat_food`
--
ALTER TABLE `cat_food`
  MODIFY `food_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `cat_profiles`
--
ALTER TABLE `cat_profiles`
  MODIFY `cat_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `customerId` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `menu`
--
ALTER TABLE `menu`
  MODIFY `menuID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `orderID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `order_items`
--
ALTER TABLE `order_items`
  MODIFY `order_itemID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `special_access`
--
ALTER TABLE `special_access`
  MODIFY `special_access_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `bookings`
--
ALTER TABLE `bookings`
  ADD CONSTRAINT `bookings_ibfk_1` FOREIGN KEY (`customerId`) REFERENCES `customers` (`customerId`),
  ADD CONSTRAINT `bookings_ibfk_2` FOREIGN KEY (`tableID`) REFERENCES `cafe_tables` (`tableID`);

--
-- Constraints for table `cat_feeding`
--
ALTER TABLE `cat_feeding`
  ADD CONSTRAINT `fk_cat` FOREIGN KEY (`cat_id`) REFERENCES `cat_profiles` (`cat_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_food` FOREIGN KEY (`food_id`) REFERENCES `cat_food` (`food_id`) ON DELETE CASCADE;

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`customerId`) REFERENCES `customers` (`customerId`),
  ADD CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`tableID`) REFERENCES `cafe_tables` (`tableID`);

--
-- Constraints for table `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`orderID`) REFERENCES `orders` (`orderID`),
  ADD CONSTRAINT `order_items_ibfk_2` FOREIGN KEY (`menuID`) REFERENCES `menu` (`menuID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
