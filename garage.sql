-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : ven. 28 nov. 2025 à 11:42
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
  `a_prix` decimal(10,2) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`a_id`),
  UNIQUE KEY `uk_reference` (`a_reference`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `g_article`
--

INSERT INTO `g_article` (`a_id`, `a_reference`, `a_designation`, `a_marque`, `a_quantite`, `a_prix`) VALUES
(1, '6464641', 'filtre à air', 'MAN FILTER', 120, 10.00),
(2, '6464642', 'filtre pollen', 'BOSCH', 52, 11.00),
(3, '6464643', 'filtre à air', 'MAN FILTER', 25, 12.00),
(4, '6464644', 'filtre pollen', 'BOSCH', 77, 13.00),
(5, '6464645', 'filtre pollen', 'BOSCH', 149, 14.00),
(6, '6464646', 'filtre à air', 'MAN FILTER', 35, 15.00),
(7, '6464647', 'filtre à huile', 'MAN FILTER', 18, 16.00),
(9, '6464649', 'filtre à air', 'MAN FILTER', 23, 17.00),
(10, '6464650', 'filtre pollen', 'BOSCH', 45, 18.00);

-- --------------------------------------------------------

--
-- Structure de la table `g_client`
--

DROP TABLE IF EXISTS `g_client`;
CREATE TABLE IF NOT EXISTS `g_client` (
  `c_id` int NOT NULL AUTO_INCREMENT,
  `c_nom` varchar(50) NOT NULL,
  `c_num_telephone` varchar(50) NOT NULL,
  `c_adresse` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`c_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `g_client`
--

INSERT INTO `g_client` (`c_id`, `c_nom`, `c_num_telephone`, `c_adresse`) VALUES
(1, 'Martin', '01 23 45 67 89', '15 Rue de la République, 75001 Paris'),
(2, 'Dubois', '01 34 56 78 90', '22 Avenue des Champs, 69002 Lyon'),
(3, 'Bernard', '02 45 67 89 01', '8 Place du Commerce, 33000 Bordeaux'),
(4, 'Moreau', '03 56 78 90 12', '45 Rue de la Gare, 31000 Toulouse'),
(5, 'Laurent', '04 67 89 01 23', '12 Boulevard Victor Hugo, 13000 Marseille'),
(6, 'Simon', '05 78 90 12 34', '27 Rue de la Paix, 44000 Nantes'),
(7, 'Michel', '06 89 01 23 45', '33 Avenue Foch, 67000 Strasbourg'),
(8, 'Petit', '07 90 12 34 56', '19 Rue de la Liberté, 59000 Lille'),
(9, 'Jean', '07 91 14 36 58', '2 Rue Trois cocu, 31400 Toulouse');

-- --------------------------------------------------------

--
-- Structure de la table `g_client_voiture`
--

DROP TABLE IF EXISTS `g_client_voiture`;
CREATE TABLE IF NOT EXISTS `g_client_voiture` (
  `vc_id` int NOT NULL AUTO_INCREMENT,
  `vc_fk_voiture_id` int NOT NULL,
  `vc_fk_client_id` int NOT NULL,
  PRIMARY KEY (`vc_id`),
  UNIQUE KEY `unique_association` (`vc_fk_voiture_id`,`vc_fk_client_id`),
  KEY `vc_fk_client_id` (`vc_fk_client_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `g_client_voiture`
--

INSERT INTO `g_client_voiture` (`vc_id`, `vc_fk_voiture_id`, `vc_fk_client_id`) VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 3),
(4, 4, 4),
(5, 5, 5),
(6, 6, 6),
(7, 7, 7),
(8, 10, 8);

-- --------------------------------------------------------

--
-- Structure de la table `g_facture`
--

DROP TABLE IF EXISTS `g_facture`;
CREATE TABLE IF NOT EXISTS `g_facture` (
  `f_id` int NOT NULL AUTO_INCREMENT,
  `f_numero` varchar(20) NOT NULL,
  `f_montant_main_oeuvre` decimal(10,2) NOT NULL,
  `f_quantite_utilisee` int NOT NULL DEFAULT '1',
  `f_prix_unitaire` decimal(10,2) NOT NULL,
  `f_montant_total` decimal(10,2) NOT NULL,
  `f_fk_article_id` int DEFAULT NULL,
  `f_fk_ordre_id` int NOT NULL,
  PRIMARY KEY (`f_id`),
  UNIQUE KEY `f_numero` (`f_numero`),
  UNIQUE KEY `f_fk_ordre_id` (`f_fk_ordre_id`),
  KEY `f_fk_article_id` (`f_fk_article_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `g_facture`
--

INSERT INTO `g_facture` (`f_id`, `f_numero`, `f_montant_main_oeuvre`, `f_quantite_utilisee`, `f_prix_unitaire`, `f_montant_total`, `f_fk_article_id`, `f_fk_ordre_id`) VALUES
(1, 'FAC-2024-001', 187.50, 2, 45.00, 277.50, 1, 1),
(2, 'FAC-2024-002', 188.50, 4, 46.00, 278.50, 2, 2),
(3, 'FAC-2024-003', 189.50, 3, 47.00, 279.50, 3, 3),
(4, 'FAC-2024-004', 190.50, 2, 48.00, 280.50, 4, 4),
(5, 'FAC-2024-005', 191.50, 5, 49.00, 281.50, 5, 5),
(6, 'FAC-2024-006', 192.50, 3, 50.00, 282.50, 6, 6),
(7, 'FAC-2024-007', 193.50, 4, 51.00, 283.50, 7, 7),
(8, 'FAC-2024-008', 194.50, 5, 52.00, 284.50, 9, 8),
(9, 'FAC-2024-009', 195.50, 6, 53.00, 285.50, 10, 10);

-- --------------------------------------------------------

--
-- Structure de la table `g_ordre`
--

DROP TABLE IF EXISTS `g_ordre`;
CREATE TABLE IF NOT EXISTS `g_ordre` (
  `o_id` int NOT NULL AUTO_INCREMENT,
  `o_date` date NOT NULL,
  `o_temps` time NOT NULL,
  `o_montant` float NOT NULL,
  `o_taux_horaire` decimal(8,2) NOT NULL DEFAULT '75.00',
  `o_fk_client_id` int NOT NULL,
  PRIMARY KEY (`o_id`),
  KEY `o_fk_client_id` (`o_fk_client_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `g_ordre`
--

INSERT INTO `g_ordre` (`o_id`, `o_date`, `o_temps`, `o_montant`, `o_taux_horaire`, `o_fk_client_id`) VALUES
(1, '2024-01-10', '02:30:00', 325, 75.00, 1),
(2, '2024-01-12', '03:15:00', 520.75, 75.00, 2),
(3, '2024-01-25', '04:30:00', 780.25, 75.00, 3),
(4, '2024-04-10', '01:45:00', 240, 75.00, 4),
(5, '2024-02-18', '03:45:00', 450, 75.00, 5),
(6, '2024-03-05', '01:30:00', 180.75, 75.00, 6),
(7, '2024-03-25', '05:00:00', 625.8, 75.00, 7),
(8, '2024-04-05', '02:20:00', 310.25, 75.00, 8),
(10, '2024-05-15', '00:00:00', 410.25, 75.00, 9);

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
  `v_annee` int NOT NULL,
  `v_num_plaque` varchar(10) NOT NULL,
  `v_fk_article_id` int NOT NULL,
  PRIMARY KEY (`v_id`),
  KEY `article_fk` (`v_fk_article_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `g_voiture`
--

INSERT INTO `g_voiture` (`v_id`, `v_marque`, `v_type`, `v_energie`, `v_annee`, `v_num_plaque`, `v_fk_article_id`) VALUES
(1, 'FIAT', '500', 'ESSENCE', 2020, 'AB-123-CD', 1),
(2, 'TOYOTA', 'YARIS', 'DIESEL', 2022, 'EF-456-GH', 2),
(3, 'PEUGEOT', '208', 'ESSENCE', 2019, 'IJ-789-KL', 3),
(4, 'RENAULT', 'CLIO', 'ESSENCE', 2021, 'MN-012-OP', 4),
(5, 'RENAULT', 'MEGANE', 'ESSENCE', 2023, 'QR-345-ST', 5),
(6, 'CITROEN', 'C3', 'ESSENCE', 2018, 'UV-678-WX', 6),
(7, 'PEUGEOT', '308', 'DIESEL', 2022, 'YZ-901-BC', 7),
(10, 'MERCEDES', 'A180', 'DIESEL', 2021, 'DE-234-FG', 9);

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `g_client_voiture`
--
ALTER TABLE `g_client_voiture`
  ADD CONSTRAINT `g_client_voiture_ibfk_1` FOREIGN KEY (`vc_fk_voiture_id`) REFERENCES `g_voiture` (`v_id`),
  ADD CONSTRAINT `g_client_voiture_ibfk_2` FOREIGN KEY (`vc_fk_client_id`) REFERENCES `g_client` (`c_id`);

--
-- Contraintes pour la table `g_facture`
--
ALTER TABLE `g_facture`
  ADD CONSTRAINT `g_facture_ibfk_1` FOREIGN KEY (`f_fk_ordre_id`) REFERENCES `g_ordre` (`o_id`),
  ADD CONSTRAINT `g_facture_ibfk_2` FOREIGN KEY (`f_fk_article_id`) REFERENCES `g_article` (`a_id`);

--
-- Contraintes pour la table `g_ordre`
--
ALTER TABLE `g_ordre`
  ADD CONSTRAINT `g_ordre_ibfk_1` FOREIGN KEY (`o_fk_client_id`) REFERENCES `g_client` (`c_id`);

--
-- Contraintes pour la table `g_voiture`
--
ALTER TABLE `g_voiture`
  ADD CONSTRAINT `article_fk` FOREIGN KEY (`v_fk_article_id`) REFERENCES `g_article` (`a_id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
