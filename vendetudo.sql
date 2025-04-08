-- phpMyAdmin SQL Dump
-- version 5.2.1deb1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jun 01, 2024 at 05:54 PM
-- Server version: 10.11.6-MariaDB-0+deb12u1
-- PHP Version: 8.3.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `vendetudo`
--

-- --------------------------------------------------------

--
-- Table structure for table `clientes`
--

CREATE TABLE `clientes` (
  `nome` varchar(200) NOT NULL,
  `endereco` varchar(500) NOT NULL,
  `data_nascimento` date NOT NULL,
  `cartao` bigint(11) NOT NULL,
  `cartao_validade` date NOT NULL,
  `cvv` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `clientes`
--

INSERT INTO `clientes` (`nome`, `endereco`, `data_nascimento`, `cartao`, `cartao_validade`, `cvv`) VALUES
('João Silva', 'Rua das Flores, 123', '1990-05-15', 1234567890123456, '2025-08-01', 123),
('Maria Oliveira', 'Avenida dos Girassóis, 456', '1985-10-22', 2345678901234567, '2024-12-01', 456),
('Pedro Santos', 'Travessa das Águias, 789', '1995-03-10', 3456789012345678, '2026-03-01', 789),
('Ana Costa', 'Praça das Palmeiras, 987', '1988-07-18', 4567890123456789, '2023-05-01', 234),
('Carlos Oliveira', 'Alameda dos Pinheiros, 654', '1979-12-05', 5678901234567890, '2027-07-01', 567),
('Sandra Pereira', 'Rua dos Lírios, 321', '1992-08-30', 6789012345678901, '2024-09-01', 890),
('Ricardo Santos', 'Avenida das Rosas, 876', '1983-04-25', 7890123456789012, '2025-02-01', 901),
('Mariana Costa', 'Travessa das Violetas, 543', '1998-01-12', 8901234567890123, '2026-11-01', 345),
('Paulo Pereira', 'Praça dos Cravos, 210', '1975-11-08', 9012345678901234, '2023-03-01', 678),
('Lúcia Santos', 'Alameda das Orquídeas, 111', '1980-06-20', 1234567890123456, '2027-04-01', 123),
('Joaquim Oliveira', 'Rua das Margaridas, 222', '1991-09-17', 2345678901234567, '2024-06-01', 456),
('Inês Pereira', 'Avenida das Hortênsias, 333', '1984-02-14', 3456789012345678, '2025-09-01', 789),
('Bruno Silva', 'Travessa dos Crisântemos, 444', '1993-07-01', 4567890123456789, '2023-01-01', 234),
('Fernanda Costa', 'Alameda das Acácias, 555', '1978-12-28', 5678901234567890, '2026-08-01', 567),
('Henrique Oliveira', 'Praça das Azáleas, 666', '1990-05-15', 6789012345678901, '2024-12-01', 890),
('Teresa Pereira', 'Rua das Dálias, 777', '1985-10-22', 7890123456789012, '2027-03-01', 901),
('Miguel Santos', 'Avenida das Begônias, 888', '1995-03-10', 8901234567890123, '2023-05-01', 345),
('Sofia Costa', 'Travessa das Glicínias, 999', '1988-07-18', 9012345678901234, '2025-10-01', 678),
('Alberto Oliveira', 'Alameda dos Narcisos, 1010', '1979-12-05', 1234567890123456, '2026-01-01', 123),
('Carla Pereira', 'Praça das Violetas, 1111', '1992-08-30', 2345678901234567, '2024-04-01', 456),
('Guilherme Silva', 'Rua dos Narcisos, 1212', '1983-04-25', 3456789012345678, '2027-07-01', 789),
('Raquel Costa', 'Avenida dos Jasmims, 1313', '1998-01-12', 4567890123456789, '2023-09-01', 234),
('André Oliveira', 'Travessa dos Jasmins, 1414', '1975-11-08', 5678901234567890, '2025-12-01', 567),
('Patrícia Pereira', 'Alameda dos Cravos, 1515', '1980-06-20', 6789012345678901, '2026-02-01', 890),
('Cátia Santos', 'Praça das Papoilas, 1616', '1991-09-17', 7890123456789012, '2024-05-01', 901),
('Hugo Silva', 'Rua das Orquídeas, 1717', '1984-02-14', 8901234567890123, '2027-08-01', 345),
('Vanessa Costa', 'Avenida dos Crisântemos, 1818', '1978-12-28', 9012345678901234, '2023-10-01', 678),
('Rodrigo Oliveira', 'Travessa das Margaridas, 1919', '1990-05-15', 1234567890123456, '2025-01-01', 123),
('Marta Pereira', 'Praça das Rosas, 2020', '1985-10-22', 2345678901234567, '2026-04-01', 456),
('Diogo Silva', 'Alameda das Begônias, 2121', '1995-03-10', 3456789012345678, '2024-07-01', 789),
('Carolina Costa', 'Rua dos Lírios, 2222', '1988-07-18', 4567890123456789, '2027-10-01', 234),
('Rui Oliveira', 'Avenida das Violetas, 2323', '1979-12-05', 5678901234567890, '2023-01-01', 567),
('Liliana Pereira', 'Travessa das Hortênsias, 2424', '1992-08-30', 6789012345678901, '2025-02-01', 890),
('Daniel Santos', 'Praça dos Girassóis, 2525', '1991-09-17', 7890123456789012, '2024-06-01', 901),
('Andreia Silva', 'Alameda dos Crisântemos, 2626', '1984-02-14', 8901234567890123, '2027-09-01', 345),
('Ricardo Costa', 'Rua das Margaridas, 2727', '1978-12-28', 9012345678901234, '2023-11-01', 678),
('Sara Oliveira', 'Avenida dos Lírios, 2828', '1990-05-15', 1234567890123456, '2026-02-01', 123),
('Mário Pereira', 'Travessa das Violetas, 2929', '1985-10-22', 2345678901234567, '2027-05-01', 456),
('Vânia Santos', 'Alameda dos Cravos, 3030', '1995-03-10', 3456789012345678, '2023-07-01', 789),
('Andréia Costa', 'Rua das Hortênsias, 3131', '1988-07-18', 4567890123456789, '2026-10-01', 234),
('Marcelo Oliveira', 'Avenida das Orquídeas, 3232', '1979-12-05', 5678901234567890, '2023-02-01', 567),
('Isabela Pereira', 'Travessa dos Girassóis, 3333', '1992-08-30', 6789012345678901, '2025-03-01', 890),
('Lucas Silva', 'Alameda dos Crisântemos, 3434', '1991-09-17', 7890123456789012, '2024-06-01', 901),
('Camila Costa', 'Rua das Margaridas, 3535', '1984-02-14', 8901234567890123, '2027-09-01', 345),
('Felipe Oliveira', 'Avenida dos Lírios, 3636', '1978-12-28', 9012345678901234, '2023-12-01', 678),
('Vanessa Pereira', 'Travessa das Violetas, 3737', '1990-05-15', 1234567890123456, '2026-03-01', 123),
('Gabriel Santos', 'Alameda dos Cravos, 3838', '1985-10-22', 2345678901234567, '2027-06-01', 456),
('Mariana Silva', 'Rua das Hortênsias, 3939', '1995-03-10', 3456789012345678, '2023-08-01', 789),
('Vinícius Costa', 'Avenida dos Girassóis, 4040', '1988-07-18', 4567890123456789, '2026-11-01', 234),
('Natália Oliveira', 'Travessa das Orquídeas, 4141', '1979-12-05', 5678901234567890, '2023-03-01', 567),
('Rafaela Pereira', 'Alameda dos Crisântemos, 4242', '1992-08-30', 6789012345678901, '2025-04-01', 890),
('Leonardo Silva', 'Rua das Margaridas, 4343', '1991-09-17', 7890123456789012, '2024-07-01', 901),
('Juliana Costa', 'Avenida das Begônias, 4444', '1984-02-14', 8901234567890123, '2027-10-01', 345),
('Diego Oliveira', 'Travessa dos Lírios, 4545', '1978-12-28', 9012345678901234, '2024-01-01', 678),
('Aline Pereira', 'Alameda das Violetas, 4646', '1990-05-15', 1234567890123456, '2026-04-01', 123),
('Luciana Santos', 'Rua dos Girassóis, 4747', '1985-10-22', 2345678901234567, '2027-07-01', 456),
('Thiago Silva', 'Avenida das Orquídeas, 4848', '1995-03-10', 3456789012345678, '2023-09-01', 789),
('Caroline Oliveira', 'Travessa dos Crisântemos, 4949', '1988-07-18', 4567890123456789, '2026-12-01', 234),
('Roberto Costa', 'Alameda dos Lírios, 5050', '1979-12-05', 5678901234567890, '2023-04-01', 567);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
