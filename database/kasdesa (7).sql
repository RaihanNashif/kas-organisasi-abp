-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jun 26, 2026 at 09:52 AM
-- Server version: 8.4.3
-- PHP Version: 8.3.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `kasdesa`
--

-- --------------------------------------------------------

--
-- Table structure for table `laporan`
--

CREATE TABLE `laporan` (
  `id_laporan` int NOT NULL,
  `total_pemasukan` float DEFAULT NULL,
  `total_pengeluaran` float DEFAULT NULL,
  `saldo_akhir` float DEFAULT NULL,
  `periode` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `id_users` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `laporan`
--

INSERT INTO `laporan` (`id_laporan`, `total_pemasukan`, `total_pengeluaran`, `saldo_akhir`, `periode`, `id_users`) VALUES
(1, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `pemasukan`
--

CREATE TABLE `pemasukan` (
  `id_pemasukan` int NOT NULL,
  `tanggal` date NOT NULL,
  `sumber` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `jumlah` decimal(12,2) NOT NULL,
  `keterangan` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `id_users` int DEFAULT NULL,
  `input_by` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pemasukan`
--

INSERT INTO `pemasukan` (`id_pemasukan`, `tanggal`, `sumber`, `jumlah`, `keterangan`, `id_users`, `input_by`) VALUES
(12, '2025-12-18', 'Iuran Warga', 50000.00, 'iuran desember', 10, 1),
(15, '2025-12-19', 'Iuran Warga', 50000.00, 'iuran desember', 13, 1),
(16, '2025-12-19', 'Iuran Warga', 50000.00, 'Iuran Desember', 5, 1),
(17, '2025-12-19', 'Iuran Warga', 50000.00, 'Iuran Desember', 9, 1),
(18, '2025-12-19', 'Iuran Warga', 50000.00, 'Iuran Desember', 4, 1),
(19, '2025-12-19', 'Iuran Warga', 50000.00, 'Iuran Desember', 14, 2),
(20, '2026-06-26', 'Iuran Warga', 50000.00, 'Iuran Juni', NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `pengeluaran`
--

CREATE TABLE `pengeluaran` (
  `id_pengeluaran` int NOT NULL,
  `tanggal` date NOT NULL,
  `keperluan` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `jumlah` decimal(12,2) NOT NULL,
  `keterangan` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `id_users` int DEFAULT NULL,
  `input_by` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pengeluaran`
--

INSERT INTO `pengeluaran` (`id_pengeluaran`, `tanggal`, `keperluan`, `jumlah`, `keterangan`, `id_users`, `input_by`) VALUES
(1, '2025-10-30', 'Beli Lampu Jalan', 10000.00, '1 pack', 4, 1),
(3, '2025-12-18', 'beli plastik sampah', 20000.00, '2 pack\r\n', 10, 1),
(4, '2025-12-19', 'Beli Konsumsi Rapat', 50000.00, '2 dus mineral', 14, 2);

-- --------------------------------------------------------

--
-- Table structure for table `status_pembayaran`
--

CREATE TABLE `status_pembayaran` (
  `id_status` int NOT NULL,
  `id_users` int DEFAULT NULL,
  `bulan` varchar(20) COLLATE utf8mb4_general_ci NOT NULL,
  `tahun` int NOT NULL,
  `jumlah` decimal(15,2) NOT NULL DEFAULT '0.00',
  `status` enum('Lunas','Belum Lunas') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'Belum Lunas',
  `tanggal_bayar` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `status_pembayaran`
--

INSERT INTO `status_pembayaran` (`id_status`, `id_users`, `bulan`, `tahun`, `jumlah`, `status`, `tanggal_bayar`) VALUES
(9, 10, 'Desember', 2025, 50000.00, 'Lunas', '2025-12-18'),
(18, 13, 'Desember', 2025, 50000.00, 'Lunas', '2025-12-19'),
(19, 4, 'Januari', 2025, 50000.00, 'Belum Lunas', NULL),
(20, 5, 'Januari', 2025, 50000.00, 'Belum Lunas', NULL),
(21, 6, 'Januari', 2025, 50000.00, 'Belum Lunas', NULL),
(22, 9, 'Januari', 2025, 50000.00, 'Belum Lunas', NULL),
(23, 10, 'Januari', 2025, 50000.00, 'Belum Lunas', NULL),
(24, 13, 'Januari', 2025, 50000.00, 'Belum Lunas', NULL),
(25, 4, 'November', 2025, 50000.00, 'Belum Lunas', NULL),
(26, 5, 'November', 2025, 50000.00, 'Belum Lunas', NULL),
(27, 6, 'November', 2025, 50000.00, 'Belum Lunas', NULL),
(28, 9, 'November', 2025, 50000.00, 'Belum Lunas', NULL),
(29, 10, 'November', 2025, 50000.00, 'Belum Lunas', NULL),
(30, 13, 'November', 2025, 50000.00, 'Belum Lunas', NULL),
(31, 4, 'November', 2026, 50000.00, 'Belum Lunas', NULL),
(32, 5, 'November', 2026, 50000.00, 'Belum Lunas', NULL),
(33, 6, 'November', 2026, 50000.00, 'Belum Lunas', NULL),
(34, 9, 'November', 2026, 50000.00, 'Belum Lunas', NULL),
(35, 10, 'November', 2026, 50000.00, 'Belum Lunas', NULL),
(36, 13, 'November', 2026, 50000.00, 'Belum Lunas', NULL),
(37, 4, 'Desember', 2026, 50000.00, 'Belum Lunas', NULL),
(38, 5, 'Desember', 2026, 50000.00, 'Belum Lunas', NULL),
(39, 6, 'Desember', 2026, 50000.00, 'Belum Lunas', NULL),
(40, 9, 'Desember', 2026, 50000.00, 'Belum Lunas', NULL),
(41, 10, 'Desember', 2026, 50000.00, 'Belum Lunas', NULL),
(42, 13, 'Desember', 2026, 50000.00, 'Belum Lunas', NULL),
(44, 5, 'Desember', 2025, 50000.00, 'Lunas', '2025-12-19'),
(45, 6, 'Desember', 2025, 50000.00, 'Belum Lunas', NULL),
(46, 9, 'Desember', 2025, 50000.00, 'Lunas', '2025-12-19'),
(47, 4, 'Desember', 2025, 50000.00, 'Lunas', '2025-12-19'),
(48, 14, 'Desember', 2025, 50000.00, 'Lunas', '2025-12-19'),
(49, 4, 'Februari', 2025, 50000.00, 'Belum Lunas', NULL),
(50, 5, 'Februari', 2025, 50000.00, 'Belum Lunas', NULL),
(51, 6, 'Februari', 2025, 50000.00, 'Belum Lunas', NULL),
(52, 9, 'Februari', 2025, 50000.00, 'Belum Lunas', NULL),
(53, 10, 'Februari', 2025, 50000.00, 'Belum Lunas', NULL),
(54, 13, 'Februari', 2025, 50000.00, 'Belum Lunas', NULL),
(55, 14, 'Februari', 2025, 50000.00, 'Belum Lunas', NULL),
(56, 4, 'Maret', 2025, 50000.00, 'Belum Lunas', NULL),
(57, 5, 'Maret', 2025, 50000.00, 'Belum Lunas', NULL),
(58, 6, 'Maret', 2025, 50000.00, 'Belum Lunas', NULL),
(59, 9, 'Maret', 2025, 50000.00, 'Belum Lunas', NULL),
(60, 10, 'Maret', 2025, 50000.00, 'Belum Lunas', NULL),
(61, 13, 'Maret', 2025, 50000.00, 'Belum Lunas', NULL),
(62, 14, 'Maret', 2025, 50000.00, 'Belum Lunas', NULL),
(63, 4, 'April', 2025, 50000.00, 'Belum Lunas', NULL),
(64, 5, 'April', 2025, 50000.00, 'Belum Lunas', NULL),
(65, 6, 'April', 2025, 50000.00, 'Belum Lunas', NULL),
(66, 9, 'April', 2025, 50000.00, 'Belum Lunas', NULL),
(67, 10, 'April', 2025, 50000.00, 'Belum Lunas', NULL),
(68, 13, 'April', 2025, 50000.00, 'Belum Lunas', NULL),
(69, 14, 'April', 2025, 50000.00, 'Belum Lunas', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id_users` int NOT NULL,
  `nama` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `username` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `role` enum('superadmin','admin','anggota') COLLATE utf8mb4_general_ci NOT NULL,
  `alamat` varchar(200) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `no_hp` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id_users`, `nama`, `username`, `password`, `role`, `alamat`, `no_hp`) VALUES
(1, 'Raihan Nashif', 'rehan', '12345', 'superadmin', NULL, '081111111111'),
(2, 'Ahmad Fadhlan', 'fadhlan', '54321', 'admin', NULL, '081222222222'),
(4, 'Budi Santoso', 'budi', '12345', 'anggota', 'Jl. Melati No. 12', '081234569998'),
(5, 'Siti Aminah', 'siti', '12345', 'anggota', 'Jl. Kenanga No. 7', '08213456780'),
(6, 'Rahmat Hidayat', 'rahmat', '12345', 'anggota', 'Jl. Dahlia No. 21', '08125678901'),
(9, 'kevin bangun', 'kornel', '54321', 'anggota', 'Jl. Jambangan', '081234567890'),
(10, 'budi gaming', 'budbud', '11111', 'anggota', 'Jl. Kentintang baru', '081222222222'),
(11, 'Fitria Nur', 'Wika', '55555', 'admin', NULL, '081233333333'),
(13, 'Michael Valentino', 'Mike', '22222', 'anggota', '-', '088888888888'),
(14, 'teguh ryan', 'teguh', '33333', 'anggota', 'dimana saja', '089898989898');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `laporan`
--
ALTER TABLE `laporan`
  ADD PRIMARY KEY (`id_laporan`),
  ADD KEY `fk_laporan_admin` (`id_users`);

--
-- Indexes for table `pemasukan`
--
ALTER TABLE `pemasukan`
  ADD PRIMARY KEY (`id_pemasukan`),
  ADD KEY `id_anggota` (`id_users`);

--
-- Indexes for table `pengeluaran`
--
ALTER TABLE `pengeluaran`
  ADD PRIMARY KEY (`id_pengeluaran`),
  ADD KEY `fk_pengeluaran_admin` (`id_users`);

--
-- Indexes for table `status_pembayaran`
--
ALTER TABLE `status_pembayaran`
  ADD PRIMARY KEY (`id_status`),
  ADD UNIQUE KEY `uniq_status` (`id_users`,`bulan`,`tahun`),
  ADD KEY `id_anggota` (`id_users`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id_users`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `laporan`
--
ALTER TABLE `laporan`
  MODIFY `id_laporan` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `pemasukan`
--
ALTER TABLE `pemasukan`
  MODIFY `id_pemasukan` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `pengeluaran`
--
ALTER TABLE `pengeluaran`
  MODIFY `id_pengeluaran` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `status_pembayaran`
--
ALTER TABLE `status_pembayaran`
  MODIFY `id_status` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=70;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id_users` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `laporan`
--
ALTER TABLE `laporan`
  ADD CONSTRAINT `fk_laporan_user` FOREIGN KEY (`id_users`) REFERENCES `users` (`id_users`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `pemasukan`
--
ALTER TABLE `pemasukan`
  ADD CONSTRAINT `fk_pemasukan_user` FOREIGN KEY (`id_users`) REFERENCES `users` (`id_users`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `pengeluaran`
--
ALTER TABLE `pengeluaran`
  ADD CONSTRAINT `fk_pengeluaran_user` FOREIGN KEY (`id_users`) REFERENCES `users` (`id_users`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `status_pembayaran`
--
ALTER TABLE `status_pembayaran`
  ADD CONSTRAINT `fk_status_anggota` FOREIGN KEY (`id_users`) REFERENCES `users` (`id_users`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
