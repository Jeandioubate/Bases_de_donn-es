
CREATE DATABASE IF NOT EXISTS `GARAGE`;

CREATE TABLE IF NOT EXISTS `G_ARTICLE` (
a_id INT AUTO_INCREMENT NOT NULL,
a_reference VARCHAR(50) NOT NULL,
a_designation VARCHAR(50) NOT NULL,
a_marque VARCHAR(50) NOT NULL,
a_quantite INT NOT NULL,
PRIMARY KEY(`a_id`),
UNIQUE KEY `uk_reference` (`a_reference`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


INSERT INTO `g_article` (`a_reference`, `a_designation`, `a_marque`, `a_quantite`) VALUES
('6464641', 'filtre à air', 'MAN FILTER', 120),
('6464642', 'filtre pollen', 'BOSCH', 52),
('6464643', 'filtre à air', 'MAN FILTER', 11),
('6464644', 'filtre pollen', 'BOSCH', 77),
('6464645', 'filtre pollen', 'BOSCH', 149),
('6464646', 'filtre à air', 'MAN FILTER', 35),
('6464647', 'filtre à huile', 'MAN FILTER', 18),
('6464648', 'filtre à huile', 'BOSCH', 72),
('6464649', 'filtre à air', 'MAN FILTER', 23),
('6464650', 'filtre pollen', 'BOSCH', 45);

CREATE TABLE IF NOT EXISTS `G_VOITURE` (
v_id INT AUTO_INCREMENT NOT NULL,
v_marque VARCHAR(50) NOT NULL,
v_type VARCHAR(50) NOT NULL,
v_energie VARCHAR(50) NOT NULL,
v_fk_article_id INT NOT NULL,
PRIMARY KEY(`v_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

ALTER TABLE `g_voiture` ADD CONSTRAINT `article_fk` FOREIGN KEY (`v_fk_article_id`) REFERENCES `g_article`(`a_id`);

CREATE TABLE IF NOT EXISTS `G_VOITURE` (
v_id INT AUTO_INCREMENT NOT NULL,
v_marque VARCHAR(50) NOT NULL,
v_type VARCHAR(50) NOT NULL,
v_energie VARCHAR(50) NOT NULL,
v_fk_article_id INT NOT NULL,
PRIMARY KEY (`v_id`),
FOREIGN KEY (`v_fk_article_id`) REFERENCES `G_ARTICLE` (`a_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


INSERT INTO `g_voiture` (`v_marque`, `v_type`, `v_energie`, `v_fk_article_id`) VALUES
('FIAT', '500', 'ESSENCE', 1),
('TOYOTA', 'YARIS', 'DIESEL', 2),
('PEUGEOT', '208', 'ESSENCE', 3),
('RENAULT', 'CLIO', 'ESSENCE', 4),
('RENAULT', 'MEGANE', 'ESSENCE', 5),
('CITROEN', 'C3', 'ESSENCE', 6),
('PEUGEOT', '308', 'DIESEL', 7),
('MERCEDES', 'A180', 'DIESEL', 8);


DROP TABLE `g_article`;

DELETE FROM `g_voiture`;


SELECT v_energie, a_reference, a_marque FROM g_voiture INNER JOIN g_article ON a_id = v_fk_article_id;

SELECT a_designation, a_quantite, v_marque, v_type FROM g_article INNER JOIN g_voiture ON  a_id = v_fk_article_id WHERE a_reference = '646464646';

SELECT a_designation, a_quantite, v_marque, v_type FROM g_article INNER JOIN g_voiture ON  a_id = v_fk_article_id GROUP BY a_marque, a_designation;

SELECT a_designation, a_quantite, v_marque, v_type FROM g_article INNER JOIN g_voiture ON  a_id = v_fk_article_id GROUP BY a_marque, a_designation ORDER BY a_marque DESC;

UPDATE `g_article` SET `a_quantite` = '25' WHERE `a_id` = 3;

ALTER TABLE g_voiture DROP FOREIGN KEY article_fk;

ALTER TABLE g_voiture ADD CONSTRAINT article_fk FOREIGN KEY (v_fk_article_id) REFERENCES g_article (a_id) ON UPDATE CASCADE ON DELETE CASCADE;

DELETE FROM g_article WHERE a_id = 8;


