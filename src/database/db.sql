-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: mysql-turnosgs.alwaysdata.net
-- Generation Time: Jul 09, 2024 at 09:11 PM
-- Server version: 10.11.8-MariaDB
-- PHP Version: 7.4.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `turnosgs_grupo11`
--
CREATE DATABASE IF NOT EXISTS `turnosgs_grupo11` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `turnosgs_grupo11`;

-- --------------------------------------------------------

--
-- Table structure for table `Especialidades`
--

CREATE TABLE `Especialidades` (
  `idEspecialidades` int(11) NOT NULL,
  `NombreEspecialidad` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Especialidades`
--

INSERT INTO `Especialidades` (`idEspecialidades`, `NombreEspecialidad`) VALUES
(1, 'Clinica General'),
(2, 'Cirugia'),
(3, 'Traumotologia');

-- --------------------------------------------------------

--
-- Table structure for table `ObraSocial`
--

CREATE TABLE `ObraSocial` (
  `idObraSocial` int(8) NOT NULL,
  `NombreObraSocial` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `ObraSocial`
--

INSERT INTO `ObraSocial` (`idObraSocial`, `NombreObraSocial`) VALUES
(1, 'PAMI'),
(2, 'OSDE'),
(3, 'IOMA');

-- --------------------------------------------------------

--
-- Table structure for table `Pacientes`
--

CREATE TABLE `Pacientes` (
  `idPacientes` int(8) NOT NULL,
  `NombrePaciente` varchar(45) DEFAULT NULL,
  `DocumentoPaciente` int(8) DEFAULT NULL,
  `IdObraSocial` int(8) DEFAULT NULL,
  `MailPaciente` varchar(45) DEFAULT NULL,
  `TelefonoPaciente` int(11) DEFAULT NULL,
  `NroAfiliadoPaciente` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Pacientes`
--

INSERT INTO `Pacientes` (`idPacientes`, `NombrePaciente`, `DocumentoPaciente`, `IdObraSocial`, `MailPaciente`, `TelefonoPaciente`, `NroAfiliadoPaciente`) VALUES
(1, 'Juan Perez', 18888888, 1, 'juanperez@gmail.com', 1155555555, '123456'),
(2, 'Pedro Gomez', 19999999, 2, 'pedrogomez@gmail.com', 1166666666, '11223344'),
(3, 'Maria Lopez', 16666666, 3, 'marialopez@hotmail.com', 1577777777, '16666666');

-- --------------------------------------------------------

--
-- Table structure for table `Profesionales`
--

CREATE TABLE `Profesionales` (
  `idProfesional` int(8) NOT NULL,
  `NombreProfesional` varchar(45) DEFAULT NULL,
  `CodigoDeEspecialdad` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Profesionales`
--

INSERT INTO `Profesionales` (`idProfesional`, `NombreProfesional`, `CodigoDeEspecialdad`) VALUES
(1, 'Carlos Gonzalez', 1),
(2, 'Abel Rodriguez', 2);

-- --------------------------------------------------------

--
-- Table structure for table `Turnos`
--

CREATE TABLE `Turnos` (
  `idTurnos` int(11) NOT NULL,
  `FechaTurno` date DEFAULT NULL,
  `HorarioTurno` time DEFAULT NULL,
  `ProfesionalIdTurno` int(11) DEFAULT NULL,
  `PacienteId` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Turnos`
--

INSERT INTO `Turnos` (`idTurnos`, `FechaTurno`, `HorarioTurno`, `ProfesionalIdTurno`, `PacienteId`) VALUES
(1, '2024-07-18', '10:29:00', 1, 3),
(2, '2024-07-18', '09:38:00', 1, 1),
(3, '2024-07-24', '18:31:00', 2, 2);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Especialidades`
--
ALTER TABLE `Especialidades`
  ADD PRIMARY KEY (`idEspecialidades`);

--
-- Indexes for table `ObraSocial`
--
ALTER TABLE `ObraSocial`
  ADD PRIMARY KEY (`idObraSocial`);

--
-- Indexes for table `Pacientes`
--
ALTER TABLE `Pacientes`
  ADD PRIMARY KEY (`idPacientes`),
  ADD KEY `idObraSocial_idx` (`IdObraSocial`);

--
-- Indexes for table `Profesionales`
--
ALTER TABLE `Profesionales`
  ADD PRIMARY KEY (`idProfesional`),
  ADD KEY `EspecialidadId_idx` (`CodigoDeEspecialdad`);

--
-- Indexes for table `Turnos`
--
ALTER TABLE `Turnos`
  ADD PRIMARY KEY (`idTurnos`),
  ADD KEY `idprofesional_idx` (`ProfesionalIdTurno`),
  ADD KEY `idPaciente_idx` (`PacienteId`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `Pacientes`
--
ALTER TABLE `Pacientes`
  ADD CONSTRAINT `idObraSocial` FOREIGN KEY (`IdObraSocial`) REFERENCES `ObraSocial` (`idObraSocial`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `Profesionales`
--
ALTER TABLE `Profesionales`
  ADD CONSTRAINT `EspecialidadId` FOREIGN KEY (`CodigoDeEspecialdad`) REFERENCES `Especialidades` (`idEspecialidades`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `Turnos`
--
ALTER TABLE `Turnos`
  ADD CONSTRAINT `idPaciente` FOREIGN KEY (`PacienteId`) REFERENCES `Pacientes` (`idPacientes`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `idprofesional` FOREIGN KEY (`ProfesionalIdTurno`) REFERENCES `Profesionales` (`idProfesional`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
