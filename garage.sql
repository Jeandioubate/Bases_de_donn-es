-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : mer. 26 nov. 2025 à 01:34
-- Version du serveur : 8.4.7
-- Version de PHP : 8.3.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `garage`
--

-- --------------------------------------------------------

--
-- Structure de la table `g_article`
--

DROP TABLE IF EXISTS `g_article`;
CREATE TABLE IF NOT EXISTS `g_article` (
  `a_id` int NOT NULL AUTO_INCREMENT,
  `a_reference` varchar(50) NOT NULL,
  `a_designation` varchar(50) NOT NULL,
  `a_marque` varchar(50) NOT NULL,
  `a_quantite` int NOT NULL,
  PRIMARY KEY (`a_id`),
  UNIQUE KEY `uk_reference` (`a_reference`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `g_article`
--

INSERT INTO `g_article` (`a_id`, `a_reference`, `a_designation`, `a_marque`, `a_quantite`) VALUES
(1, '6464641', 'filtre à air', 'MAN FILTER', 120),
(2, '6464642', 'filtre pollen', 'BOSCH', 52),
(3, '6464643', 'filtre à air', 'MAN FILTER', 25),
(4, '6464644', 'filtre pollen', 'BOSCH', 77),
(5, '6464645', 'filtre pollen', 'BOSCH', 149),
(6, '6464646', 'filtre à air', 'MAN FILTER', 35),
(7, '6464647', 'filtre à huile', 'MAN FILTER', 18),
(9, '6464649', 'filtre à air', 'MAN FILTER', 23),
(10, '6464650', 'filtre pollen', 'BOSCH', 45);

-- --------------------------------------------------------

--
-- Structure de la table `g_voiture`
--

DROP TABLE IF EXISTS `g_voiture`;
CREATE TABLE IF NOT EXISTS `g_voiture` (
  `v_id` int NOT NULL AUTO_INCREMENT,
  `v_marque` varchar(50) NOT NULL,
  `v_type` varchar(50) NOT NULL,
  `v_energie` varchar(50) NOT NULL,
  `v_fk_article_id` int NOT NULL,
  PRIMARY KEY (`v_id`),
  KEY `article_fk` (`v_fk_article_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `g_voiture`
--

INSERT INTO `g_voiture` (`v_id`, `v_marque`, `v_type`, `v_energie`, `v_fk_article_id`) VALUES
(1, 'FIAT', '500', 'ESSENCE', 1),
(2, 'TOYOTA', 'YARIS', 'DIESEL', 2),
(3, 'PEUGEOT', '208', 'ESSENCE', 3),
(4, 'RENAULT', 'CLIO', 'ESSENCE', 4),
(5, 'RENAULT', 'MEGANE', 'ESSENCE', 5),
(6, 'CITROEN', 'C3', 'ESSENCE', 6),
(7, 'PEUGEOT', '308', 'DIESEL', 7),
(10, 'MERCEDES', 'A180', 'DIESEL', 9);

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `g_voiture`
--
ALTER TABLE `g_voiture`
  ADD CONSTRAINT `article_fk` FOREIGN KEY (`v_fk_article_id`) REFERENCES `g_article` (`a_id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
