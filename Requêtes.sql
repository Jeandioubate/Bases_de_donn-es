
-- Quelques requêtes --

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
ADD `v_num_plaque` VARCHAR(10) NOT NULL;

UPDATE `g_voiture`
SET `v_annee` = 2020, `v_num_plaque` = 'AB-123-CD'
WHERE `v_id` = 1;

-- Trouver les données du client --
SELECT c_nom, c_num_telephone, c_adresse
FROM g_client;

-- Trouver les données du client à partir de son nom ou sa plaque d'immatriculation --
SELECT c_nom, c_num_telephone, c_adresse
FROM g_client
WHERE c_nom = 'Martin';

SELECT c_nom, c_num_telephone, c_adresse
FROM `g_client`
INNER JOIN `g_client_voiture` cv ON c_id = cv.vc_fk_client_id
INNER JOIN `g_voiture` v ON cv.vc_fk_voiture_id = v.v_id 
WHERE v.v_num_plaque = 'AB-123-CD';

-- Trouver les données de son véhicule et les articles qui se montent sur ce véhicule en saisissant nom ou plaque d'immatriculation --
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

-- Trouver les données concernant les réparations (OR) en saisissant nom ou plaque d'immatriculation --
ALTER TABLE `g_ordre` 
ADD `o_montant` FLOAT NOT NULL;

SELECT    
    o_temps,
    o_montant,
    a_reference,      
FROM `g_client` c
JOIN `g_ordre` o ON c.c_id = o.o_fk_client_id
LEFT JOIN `g_client_voiture` cv ON c_id = cv.vc_fk_client_id
LEFT JOIN `g_voiture` v ON cv.vc_fk_voiture_id = v.v_id
LEFT JOIN `g_article` a ON v.v_fk_article_id = a.a_id
WHERE c_nom = 'Martin';

SELECT    
    o_temps,
    o_montant,
    a_reference      
FROM `g_client` c
JOIN `g_ordre` o ON c.c_id = o.o_fk_client_id
LEFT JOIN `g_client_voiture` cv ON c_id = cv.vc_fk_client_id
LEFT JOIN `g_voiture` v ON cv.vc_fk_voiture_id = v.v_id
LEFT JOIN `g_article` a ON v.v_fk_article_id = a.a_id
WHERE v_num_plaque = 'AB-123-CD';
