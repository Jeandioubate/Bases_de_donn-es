
-- MPD--
-- Création de la base de données "Garage" --

CREATE DATABASE IF NOT EXISTS `GARAGE`;

-- Crétation des tables et contraintes

CREATE TABLE IF NOT EXISTS `G_ARTICLE` (
a_id INT AUTO_INCREMENT NOT NULL,
a_reference VARCHAR(50) NOT NULL,
a_designation VARCHAR(50) NOT NULL,
a_marque VARCHAR(50) NOT NULL,
a_quantite INT NOT NULL,
PRIMARY KEY(`a_id`),
UNIQUE KEY `uk_reference` (`a_reference`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `G_VOITURE` (
v_id INT AUTO_INCREMENT NOT NULL,
v_marque VARCHAR(50) NOT NULL,
v_type VARCHAR(50) NOT NULL,
v_energie VARCHAR(50) NOT NULL,
v_fk_article_id INT NOT NULL,
PRIMARY KEY(`v_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

ALTER TABLE `g_voiture` ADD CONSTRAINT `article_fk` FOREIGN KEY (`v_fk_article_id`) REFERENCES `g_article`(`a_id`);

ALTER TABLE `g_voiture` 
ADD `v_annee` INT NOT NULL,
ADD `v_num_plaque` VARCHAR(50) NOT NULL;

CREATE TABLE IF NOT EXISTS `G_CLIENT` (
c_id INT AUTO_INCREMENT NOT NULL,
c_nom VARCHAR(50) NOT NULL,
c_num_telephone VARCHAR(50) NOT NULL,
c_adresse VARCHAR(50) NOT NULL,
PRIMARY KEY(`c_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `G_CLIENT_VOITURE` (
vc_id INT AUTO_INCREMENT PRIMARY KEY,
vc_fk_voiture_id INT NOT NULL,
vc_fk_client_id INT NOT NULL,
FOREIGN KEY (`vc_fk_voiture_id`) REFERENCES `g_voiture`(`v_id`),
FOREIGN KEY (`vc_fk_client_id`) REFERENCES `g_client`(`c_id`),
UNIQUE KEY `unique_association` (`vc_fk_voiture_id`, `vc_fk_client_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `G_ORDRE` (
o_id INT AUTO_INCREMENT NOT NULL,
o_date DATE NOT NULL,
o_temps TIME NOT NULL,
o_fk_client_id INT NOT NULL,
PRIMARY KEY(`o_id`),
FOREIGN KEY (`o_fk_client_id`) REFERENCES `g_client`(`c_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

ALTER TABLE `g_ordre` 
ADD `o_montant` FLOAT NOT NULL;