
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

ALTER TABLE `g_voiture` 
ADD `v_annee` INT NOT NULL,
ADD `v_immatriculation` VARCHAR(10) NOT NULL;

UPDATE `g_voiture`
SET `v_annee` = 2020, `v_num_plaque` = 'AB-123-CD'
WHERE `v_id` = 1;


CREATE TABLE IF NOT EXISTS `G_CLIENT` (
c_id INT AUTO_INCREMENT NOT NULL,
c_nom VARCHAR(50) NOT NULL,
c_num_telephone VARCHAR(50) NOT NULL,
c_adresse VARCHAR(50) NOT NULL,
PRIMARY KEY(`c_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `g_client` (`c_nom`, `c_num_telephone`, `c_adresse`) VALUES
('Martin', '01 23 45 67 89', '15 Rue de la République, 75001 Paris'),
('Dubois', '01 34 56 78 90', '22 Avenue des Champs, 69002 Lyon'),
('Bernard', '02 45 67 89 01', '8 Place du Commerce, 33000 Bordeaux'),
('Moreau', '03 56 78 90 12', '45 Rue de la Gare, 31000 Toulouse'),
('Laurent', '04 67 89 01 23', '12 Boulevard Victor Hugo, 13000 Marseille'),
('Simon', '05 78 90 12 34', '27 Rue de la Paix, 44000 Nantes'),
('Michel', '06 89 01 23 45', '33 Avenue Foch, 67000 Strasbourg'),
('Petit', '07 90 12 34 56', '19 Rue de la Liberté, 59000 Lille');


CREATE TABLE IF NOT EXISTS `G_CLIENT_VOITURE` (
vc_id INT AUTO_INCREMENT PRIMARY KEY,
vc_fk_voiture_id INT NOT NULL,
vc_fk_client_id INT NOT NULL,
FOREIGN KEY (`vc_fk_voiture_id`) REFERENCES `g_voiture`(`v_id`),
FOREIGN KEY (`vc_fk_client_id`) REFERENCES `g_client`(`c_id`),
UNIQUE KEY `unique_association` (`vc_fk_voiture_id`, `vc_fk_client_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `g_client_voiture` (`vc_fk_voiture_id`, `vc_fk_client_id`) VALUES
(1, 1),  
(2, 2), 
(3, 3), 
(4, 4),  
(5, 5),  
(6, 6),  
(7, 7),  
(10, 8);  

CREATE TABLE IF NOT EXISTS `G_ORDRE` (
o_id INT AUTO_INCREMENT NOT NULL,
o_date DATE NOT NULL,
o_temps TIME NOT NULL,
o_fk_client_id INT NOT NULL,
PRIMARY KEY(`o_id`),
FOREIGN KEY (`o_fk_client_id`) REFERENCES `g_client`(`c_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


INSERT INTO `g_ordre` (`o_date`, `o_temps`, `o_fk_client_id`) VALUES
('2024-01-10', '02:30:00', 1),  
('2024-01-12', '03:15:00', 2),  
('2024-01-25', '04:30:00', 3),   
('2024-04-10', '01:45:00', 4), 
('2024-02-18', '03:45:00', 5),
('2024-03-05', '01:30:00', 6),  
('2024-03-25', '05:00:00', 7),
('2024-04-05', '02:20:00', 8); 

SELECT c_nom, c_num_telephone, c_adresse
FROM g_client;

SELECT c_nom, c_num_telephone, c_adresse
FROM g_client
WHERE c_nom = 'Martin';

SELECT c_nom, c_num_telephone, c_adresse
FROM `g_client`
INNER JOIN `g_client_voiture` cv ON c_id = cv.vc_fk_client_id
INNER JOIN `g_voiture` v ON cv.vc_fk_voiture_id = v.v_id 
WHERE v.v_num_plaque = 'AB-123-CD';

SELECT
    c_nom,
    v_marque,
    v_type,
    v_energie,
    v_annee,
    v_num_plaque,
    a_reference,
    a_designation,
    a_marque,
    a_quantite
FROM `g_client` c
JOIN `g_client_voiture` cv ON c_id = cv.vc_fk_client_id
JOIN `g_voiture` v ON cv.vc_fk_voiture_id = v.v_id
LEFT JOIN `g_article` a ON v.v_fk_article_id = a.a_id
WHERE c_nom = 'Martin';

SELECT
    c_nom,
    v_marque,
    v_type,
    v_energie,
    v_annee,
    v_num_plaque,
    a_reference,
    a_designation,
    a_marque,
    a_quantite
FROM `g_client` c
JOIN `g_client_voiture` cv ON c_id = cv.vc_fk_client_id
JOIN `g_voiture` v ON cv.vc_fk_voiture_id = v.v_id
LEFT JOIN `g_article` a ON v.v_fk_article_id = a.a_id
WHERE v_num_plaque = 'AB-123-CD';

ALTER TABLE `g_ordre` 
ADD `o_montant` INT NOT NULL;

SELECT    
    o_temps,
    o_montant,
    a_reference,      
FROM `g_client` c
JOIN `g_ordre` o ON c.c_id = o.o_fk_client_id
LEFT JOIN `g_client_voiture` cv ON c_id = cv.vc_fk_client_id
LEFT JOIN `g_voiture` v ON cv.vc_fk_voiture_id = v.v_id
LEFT JOIN `g_article` a ON v.v_fk_article_id = a.a_id
WHERE c_nom LIKE '%Martin%';