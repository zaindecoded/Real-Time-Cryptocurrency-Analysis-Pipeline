-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 12, 2025 at 10:19 PM
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
-- Database: `crypto_dw`
--

-- --------------------------------------------------------

--
-- Table structure for table `dim_coin`
--

CREATE TABLE `dim_coin` (
  `coin_id` int(11) NOT NULL,
  `coin_name` varchar(100) NOT NULL,
  `symbol` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dim_currency`
--

CREATE TABLE `dim_currency` (
  `symbol` varchar(20) DEFAULT NULL,
  `name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `dim_currency`
--

INSERT INTO `dim_currency` (`symbol`, `name`) VALUES
('btc', 'Bitcoin'),
('eth', 'Ethereum'),
('usdt', 'Tether'),
('xrp', 'XRP'),
('bnb', 'BNB'),
('sol', 'Solana'),
('usdc', 'USDC'),
('steth', 'Lido Staked Ether'),
('trx', 'TRON'),
('doge', 'Dogecoin'),
('btc', 'Bitcoin'),
('eth', 'Ethereum'),
('usdt', 'Tether'),
('xrp', 'XRP'),
('bnb', 'BNB'),
('sol', 'Solana'),
('usdc', 'USDC'),
('steth', 'Lido Staked Ether'),
('trx', 'TRON'),
('doge', 'Dogecoin'),
('btc', 'Bitcoin'),
('eth', 'Ethereum'),
('usdt', 'Tether'),
('xrp', 'XRP'),
('bnb', 'BNB'),
('sol', 'Solana'),
('usdc', 'USDC'),
('steth', 'Lido Staked Ether'),
('trx', 'TRON'),
('doge', 'Dogecoin'),
('BTC', 'Bitcoin'),
('ETH', 'Ethereum'),
('USDT', 'Tether'),
('XRP', 'Ripple'),
('BNB', 'Binance Coin'),
('SOL', 'Solana'),
('USDC', 'USD Coin'),
('STETH', 'Staked Ether'),
('TRX', 'Tron'),
('DOGE', 'Dogecoin');

-- --------------------------------------------------------

--
-- Table structure for table `dim_date`
--

CREATE TABLE `dim_date` (
  `date_id` int(11) NOT NULL,
  `date` varchar(20) DEFAULT NULL,
  `day` int(11) DEFAULT NULL,
  `month` int(11) DEFAULT NULL,
  `year` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fact_market_data`
--

CREATE TABLE `fact_market_data` (
  `market_id` int(11) NOT NULL,
  `currency_id` int(11) DEFAULT NULL,
  `date_id` int(11) DEFAULT NULL,
  `price_usd` float DEFAULT NULL,
  `market_cap_usd` float DEFAULT NULL,
  `volume_usd` float DEFAULT NULL,
  `current_price` double DEFAULT NULL,
  `market_cap` double DEFAULT NULL,
  `total_volume` double DEFAULT NULL,
  `high_24h` double DEFAULT NULL,
  `low_24h` double DEFAULT NULL,
  `load_time` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fact_price`
--

CREATE TABLE `fact_price` (
  `price_id` int(11) NOT NULL,
  `coin_id` int(11) DEFAULT NULL,
  `currency_id` int(11) DEFAULT NULL,
  `price` float DEFAULT NULL,
  `timestamp` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `dim_coin`
--
ALTER TABLE `dim_coin`
  ADD PRIMARY KEY (`coin_id`);

--
-- Indexes for table `dim_date`
--
ALTER TABLE `dim_date`
  ADD PRIMARY KEY (`date_id`);

--
-- Indexes for table `fact_market_data`
--
ALTER TABLE `fact_market_data`
  ADD PRIMARY KEY (`market_id`),
  ADD KEY `currency_id` (`currency_id`),
  ADD KEY `date_id` (`date_id`);

--
-- Indexes for table `fact_price`
--
ALTER TABLE `fact_price`
  ADD PRIMARY KEY (`price_id`),
  ADD KEY `coin_id` (`coin_id`),
  ADD KEY `currency_id` (`currency_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `dim_coin`
--
ALTER TABLE `dim_coin`
  MODIFY `coin_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `dim_date`
--
ALTER TABLE `dim_date`
  MODIFY `date_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fact_market_data`
--
ALTER TABLE `fact_market_data`
  MODIFY `market_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `fact_price`
--
ALTER TABLE `fact_price`
  MODIFY `price_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `fact_market_data`
--
ALTER TABLE `fact_market_data`
  ADD CONSTRAINT `fact_market_data_ibfk_2` FOREIGN KEY (`date_id`) REFERENCES `dim_date` (`date_id`);

--
-- Constraints for table `fact_price`
--
ALTER TABLE `fact_price`
  ADD CONSTRAINT `fact_price_ibfk_1` FOREIGN KEY (`coin_id`) REFERENCES `dim_coin` (`coin_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
