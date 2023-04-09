-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 09, 2023 at 04:40 PM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 8.0.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `codingblog`
--

-- --------------------------------------------------------

--
-- Table structure for table `contacts`
--

CREATE TABLE `contacts` (
  `Sno` int(11) NOT NULL,
  `name` text NOT NULL,
  `phone_num` varchar(12) NOT NULL,
  `msg` text NOT NULL,
  `date` datetime DEFAULT current_timestamp(),
  `email` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `contacts`
--

INSERT INTO `contacts` (`Sno`, `name`, `phone_num`, `msg`, `date`, `email`) VALUES
(1, 'sfhsk', '9639538459', 'bsabfb', '2023-03-12 18:42:36', 'fja@gmail.com'),
(2, 'Shaurydeep Saxena', '9639538459', 'fnkafbka', '2023-03-12 19:48:54', 'shaurydeepsaxena@gmail.com'),
(3, 'scsk', '9639538459', 'schbsa', '2023-03-12 19:55:36', 'amansaxena5331145@gmail.com'),
(4, 'sds', '520407', '', '2023-03-20 23:56:08', 'hhkh@gmail.com'),
(5, 'ffjsf', '8415205307', 'fkjafhfha', '2023-03-22 16:04:44', 'fjahf@gmail.com'),
(6, 'ffjsf', '8415205307', 'fkjafhfha', '2023-03-22 16:05:47', 'fjahf@fka'),
(7, 'ffjsf', '841520', 'fkjafhfha', '2023-03-22 16:06:00', 'fjahf@fka'),
(8, 'ffjsf', '841520', 'fkjafhfha', '2023-03-22 16:06:50', 'fjahf@fka');

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE `posts` (
  `Sno` int(11) NOT NULL,
  `title` varchar(30) NOT NULL,
  `slug` varchar(30) NOT NULL,
  `content` text NOT NULL,
  `tagline` text NOT NULL,
  `img_file` varchar(50) DEFAULT NULL,
  `date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`Sno`, `title`, `slug`, `content`, `tagline`, `img_file`, `date`) VALUES
(1, 'Fortis Fortuna Adiuvat', 'first-post', 'John Wick is known for his exceptional fighting skills and tactical expertise, as well as his intense focus and determination. He is often described as a \"man of few words\" and is known for his stoic demeanor and steely resolve.\r\n\r\nThroughout the movies, John Wick faces a variety of challenges and enemies, including other hitmen, criminal organizations, and even his own past. Despite these obstacles, he remains steadfast in his pursuit of justice and revenge.', 'I am a man of focus, commitment and sheer will.', NULL, '2023-04-01 13:57:58'),
(3, 'sfsa', 'fsfs', 'fdssafa', 'fas', NULL, '2023-04-03 17:45:08'),
(4, 'sgfasf', 'asdf', 'adf', 'afas', NULL, '2023-04-03 17:45:32');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `contacts`
--
ALTER TABLE `contacts`
  ADD PRIMARY KEY (`Sno`);

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`Sno`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `contacts`
--
ALTER TABLE `contacts`
  MODIFY `Sno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
  MODIFY `Sno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
