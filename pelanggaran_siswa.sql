-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 08 Des 2020 pada 04.05
-- Versi server: 10.1.36-MariaDB
-- Versi PHP: 7.2.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `pelanggaran_siswa`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `detail_pelanggaran_siswa`
--

CREATE TABLE `detail_pelanggaran_siswa` (
  `id_pelanggaran_siswa` int(11) DEFAULT NULL,
  `id_pelanggaran` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `detail_pelanggaran_siswa`
--

INSERT INTO `detail_pelanggaran_siswa` (`id_pelanggaran_siswa`, `id_pelanggaran`, `created_at`, `updated_at`) VALUES
(9, 3, '2020-01-16 08:34:49', '2020-01-16 08:34:49'),
(10, 3, '2020-01-16 09:01:58', '2020-01-16 09:01:58'),
(10, 4, '2020-01-16 09:01:58', '2020-01-16 09:01:58');

-- --------------------------------------------------------

--
-- Struktur dari tabel `pelanggaran`
--

CREATE TABLE `pelanggaran` (
  `id_pelanggaran` int(11) NOT NULL,
  `nama_pelanggaran` varchar(300) DEFAULT NULL,
  `kategori` varchar(50) NOT NULL,
  `poin` double DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `pelanggaran`
--

INSERT INTO `pelanggaran` (`id_pelanggaran`, `nama_pelanggaran`, `kategori`, `poin`, `created_at`, `updated_at`) VALUES
(2, 'terlambat', '', 27, '2020-01-16 08:43:06', '2020-01-16 08:43:06'),
(3, 'sepatu tidak sesuai', '', 20, '2020-01-16 08:50:24', '2020-01-16 08:50:24'),
(4, 'tidur di kelas', '', 5, '2020-01-16 08:49:35', '2020-01-16 08:49:35'),
(6, 'cvbnm', '', 7, '2020-01-16 09:01:42', '2020-01-16 09:01:42');

-- --------------------------------------------------------

--
-- Struktur dari tabel `pelanggaran_siswa`
--

CREATE TABLE `pelanggaran_siswa` (
  `id_pelanggaran_siswa` int(11) NOT NULL,
  `waktu` datetime DEFAULT NULL,
  `id_siswa` int(11) DEFAULT NULL,
  `id_user` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `pelanggaran_siswa`
--

INSERT INTO `pelanggaran_siswa` (`id_pelanggaran_siswa`, `waktu`, `id_siswa`, `id_user`, `created_at`, `updated_at`) VALUES
(9, '2020-01-16 08:34:49', 4, 1, '2020-01-16 08:34:49', '2020-01-16 08:34:49'),
(10, '2020-01-16 09:01:58', 4, 1, '2020-01-16 09:01:58', '2020-01-16 09:01:58');

-- --------------------------------------------------------

--
-- Struktur dari tabel `siswa`
--

CREATE TABLE `siswa` (
  `id_siswa` int(11) NOT NULL,
  `nis` varchar(20) DEFAULT NULL,
  `nama_siswa` varchar(300) DEFAULT NULL,
  `kelas` varchar(20) DEFAULT NULL,
  `poin` double DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `siswa`
--

INSERT INTO `siswa` (`id_siswa`, `nis`, `nama_siswa`, `kelas`, `poin`, `created_at`, `updated_at`) VALUES
(1, '198', 'John', 'XII RPL 10', 90, '2020-12-07 15:42:59', '2020-01-16 09:00:34'),
(4, '00099', 'lalala', 'XI RPL 7', 135, '2020-01-16 09:01:58', '2020-01-16 09:01:58'),
(5, '198', 'Peter', 'XII RPL 10', 100, '2020-12-07 15:40:01', '2020-12-07 15:40:01');

-- --------------------------------------------------------

--
-- Struktur dari tabel `user`
--

CREATE TABLE `user` (
  `id_user` int(11) NOT NULL,
  `nama_user` varchar(300) NOT NULL,
  `username` varchar(300) NOT NULL,
  `password` varchar(300) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `user`
--

INSERT INTO `user` (`id_user`, `nama_user`, `username`, `password`, `created_at`, `updated_at`) VALUES
(1, 'Jack Ma', 'jack', 'eyJpdiI6ImtLRWJmNGNHWlZTSkJ2M2x1Yys3Snc9PSIsInZhbHVlIjoic2prbTNXaVJ2SHFQWEpHMG4zQ01BZz09IiwibWFjIjoiZGNhY2I2ODE0NGVjZTQxZDdjMjMzZTBiNzlmYzk3ZGM5NDdhYzBiNGYyMTQ4YTE3OTRmNTMyMWIzODg2ZWYzYSJ9', '2019-12-06 00:18:40', '2019-12-06 00:18:40'),
(2, 'lala', '345', 'eyJpdiI6IkhCZ2hXanFRd1wvQXZzN2RcL01tWFdoQT09IiwidmFsdWUiOiJ1NDZTNTVuemFNakNXK0l6OXI5QkRBPT0iLCJtYWMiOiI5NGM4NDdiNzkyMTA0Mjc2NmRjYTI3NTljNjVmNDFmNzY0ZTQwYjQ4OWY5OWNkYmJhZmI0ZDM0MzM1MzBkNTI2In0=', '2020-01-16 08:10:29', '2020-01-16 08:10:29');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `detail_pelanggaran_siswa`
--
ALTER TABLE `detail_pelanggaran_siswa`
  ADD KEY `id_pelanggaran_siswa` (`id_pelanggaran_siswa`,`id_pelanggaran`),
  ADD KEY `id_pelanggaran` (`id_pelanggaran`);

--
-- Indeks untuk tabel `pelanggaran`
--
ALTER TABLE `pelanggaran`
  ADD PRIMARY KEY (`id_pelanggaran`);

--
-- Indeks untuk tabel `pelanggaran_siswa`
--
ALTER TABLE `pelanggaran_siswa`
  ADD PRIMARY KEY (`id_pelanggaran_siswa`),
  ADD KEY `id_siswa` (`id_siswa`);

--
-- Indeks untuk tabel `siswa`
--
ALTER TABLE `siswa`
  ADD PRIMARY KEY (`id_siswa`);

--
-- Indeks untuk tabel `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id_user`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `pelanggaran`
--
ALTER TABLE `pelanggaran`
  MODIFY `id_pelanggaran` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT untuk tabel `pelanggaran_siswa`
--
ALTER TABLE `pelanggaran_siswa`
  MODIFY `id_pelanggaran_siswa` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT untuk tabel `siswa`
--
ALTER TABLE `siswa`
  MODIFY `id_siswa` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT untuk tabel `user`
--
ALTER TABLE `user`
  MODIFY `id_user` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `detail_pelanggaran_siswa`
--
ALTER TABLE `detail_pelanggaran_siswa`
  ADD CONSTRAINT `detail_pelanggaran_siswa_ibfk_1` FOREIGN KEY (`id_pelanggaran`) REFERENCES `pelanggaran` (`id_pelanggaran`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
