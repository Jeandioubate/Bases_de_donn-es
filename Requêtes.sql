
-- QUELQUES REQUETES --

-- EXO 2 --
/* Permettre au concessionnaire de consulter son stock d'articles et savoir à quel véhicule l'article correspond en saisissant la référence */

SELECT a_designation, a_marque, a_quantite, v_marque, v_type, v_energie
FROM g_article
INNER JOIN g_voiture ON v_fk_article_id = a_id
WHERE a_reference = '6464643';

/* Trouver les données du client à partir de son nom ou sa plaque d'immatriculation */
--On procède d'abord à l'ajout des colonnes annee et plaque d'immatriculation à la table voiture--

ALTER TABLE `g_voiture` 
ADD `v_annee` INT NOT NULL,
ADD `v_num_plaque` VARCHAR(10) NOT NULL;

--Ensuite, la vraie requête--

SELECT c_nom, c_num_telephone, c_adresse
FROM g_client
WHERE c_nom = 'Martin';

SELECT c_nom, c_num_telephone, c_adresse
FROM `g_client`
INNER JOIN `g_client_voiture` cv ON c_id = cv.vc_fk_client_id
INNER JOIN `g_voiture` v ON cv.vc_fk_voiture_id = v.v_id 
WHERE v.v_num_plaque = 'AB-123-CD'

/* Trouver les données de son véhicule et la référence des articles qui se montent sur ce véhicule en saisissant nom ou plaque d'immatriculation */

SELECT c_nom, v_marque, v_type, v_energie, v_annee, v_num_plaque, a_reference, a_designation, a_marque, a_quantite
FROM `g_client` c
INNER JOIN `g_client_voiture` cv ON c_id = cv.vc_fk_client_id
INNER JOIN `g_voiture` v ON cv.vc_fk_voiture_id = v.v_id
LEFT JOIN `g_article` a ON v.v_fk_article_id = a.a_id
WHERE c_nom = 'Martin';

SELECT c_nom, v_marque, v_type, v_energie, v_annee, v_num_plaque, a_reference, a_designation, a_marque, a_quantite
FROM `g_client` c
INNER JOIN `g_client_voiture` cv ON c_id = cv.vc_fk_client_id
INNER JOIN `g_voiture` v ON cv.vc_fk_voiture_id = v.v_id
LEFT JOIN `g_article` a ON v.v_fk_article_id = a.a_id
WHERE v_num_plaque = 'AB-123-CD';

/* Trouver les données concernant les réparations (OR) en saisissant nom ou plaque d'immatriculation */
--On procède avant à l'ajout de la colonne montant à la table ordre--

ALTER TABLE `g_ordre` 
ADD `o_montant` FLOAT NOT NULL;

--Ensuite, la vraie requête--

SELECT o_temps, o_montant, a_reference      
FROM `g_client` c
INNER JOIN `g_ordre` o ON c.c_id = o.o_fk_client_id
LEFT JOIN `g_client_voiture` cv ON c_id = cv.vc_fk_client_id
LEFT JOIN `g_voiture` v ON cv.vc_fk_voiture_id = v.v_id
LEFT JOIN `g_article` a ON v.v_fk_article_id = a.a_id
WHERE c_nom = 'Martin';

SELECT o_temps, o_montant, a_reference  
FROM `g_client` c
INNER JOIN `g_ordre` o ON c.c_id = o.o_fk_client_id
LEFT JOIN `g_client_voiture` cv ON c_id = cv.vc_fk_client_id
LEFT JOIN `g_voiture` v ON cv.vc_fk_voiture_id = v.v_id
LEFT JOIN `g_article` a ON v.v_fk_article_id = a.a_id
WHERE v_num_plaque = 'AB-123-CD';

-- EXO 3 --

/* Permettre au concessionnaire de sortir et consulter une facture avec : */
--Les infos du client, les données du véhicule, les articles utilisés, le montant unitaire, la main d'oeuvre, le montant total--

SELECT f_numero, c_nom, c_adresse, c_num_telephone, v_marque, v_type, v_annee, v_energie, v_num_plaque, o_temps, o_taux_horaire, f_montant_main_oeuvre, 
	   a_reference, a_designation, f_quantite_utilisee, f_prix_unitaire, (f_quantite_utilisee * f_prix_unitaire) as montant_articles, f_montant_total
FROM `g_facture` f
INNER JOIN `g_ordre` o ON f_fk_ordre_id = o.o_id
INNER JOIN `g_client` c ON o_fk_client_id = c.c_id
INNER JOIN `g_client_voiture` cv ON c.c_id = cv.vc_fk_client_id
INNER JOIN `g_voiture` v ON cv.vc_fk_voiture_id = v.v_id
LEFT JOIN `g_article` a ON f.f_fk_article_id = a.a_id
WHERE f_numero = 'FAC-2024-001';

--Déduction de la quantité des articles utilisés dans le stock--
-- Après création de la facture

UPDATE `g_article`
SET `a_quantite` = `a_quantite` - 2
WHERE `a_id` = 1;

-- Vérification du stock

SELECT a_designation, a_quantite
FROM g_article
WHERE a_id = 1;

-- EXO 4 --

/* Permettre au magasinier d'avoir le nombre total d'articles dans son stock et le nombre par désignation */

SELECT
    'PAR_DESIGNATION' AS type_info,
    a_designation AS designation,
    COUNT(a_designation) AS Nbre_article_designation,
    SUM(a_quantite) AS qty_totale
FROM g_article
GROUP BY a_designation

UNION ALL

SELECT
    'TOTAL' AS type_info,
    NULL AS designation,
    COUNT(a_designation) AS Nbre_total_articles,
    SUM(a_quantite) AS qty_total_stock
FROM g_article 
ORDER BY `qty_totale` ASC

/* Permettre au magasinier d'avoir la quantité par désignation et la quantité par marque */

SELECT a_designation AS désignation, COUNT(a_designation) AS Nbre_article_désignation, SUM(a_quantite) AS qty_totale
FROM g_article
GROUP BY a_designation

UNION ALL

SELECT 'TOTAL' AS désignation, COUNT(a_designation) AS Nbre_article_désignation, SUM(a_quantite) AS qty_totale
FROM g_article
ORDER BY qty_totale ASC;

SELECT a_marque AS marque, COUNT(a_marque) AS Nbre_article_marque, SUM(a_quantite) AS qty_totale
FROM g_article
GROUP BY a_marque

UNION ALL

SELECT 'TOTAL' AS marque, COUNT(a_marque) AS Nbre_article_marque, SUM(a_quantite) AS qty_totale
FROM g_article
ORDER BY qty_totale ASC;

-- EXO 5 --

/* Permettre au chef d'atelier de savoir combien de fois un même client est venue pour une même voiture dans le garage */

SELECT
    c.c_nom,
    v.v_num_plaque,
    v.v_marque,
    v.v_type,
    COUNT(o.o_id) AS nombre_interventions,
    MIN(o.o_date) AS premiere_visite,
    MAX(o.o_date) AS derniere_visite
FROM `g_ordre` o
INNER JOIN `g_client` c ON o.o_fk_client_id = c.c_id
INNER JOIN `g_client_voiture` cv ON c.c_id = cv.vc_fk_client_id
INNER JOIN `g_voiture` v ON cv.vc_fk_voiture_id = v.v_id
GROUP BY c.c_id, v.v_id
HAVING COUNT(o.o_id) > 0
ORDER BY nombre_interventions DESC;

/* Permettre au magasinier de lui sortir toutes les pièces fournit lors des interventions (OR) */

SELECT
    a.a_reference,
    a.a_designation,
    a.a_marque,
    o.o_id AS intervention,
    DATE(o.o_date) AS date_intervention
FROM `g_article` a
INNER JOIN `g_facture` f ON a.a_id = f.f_fk_article_id
INNER JOIN `g_ordre` o ON f.f_fk_ordre_id = o.o_id
ORDER BY a.a_reference, o.o_date DESC;

/* Le prix moyen de tous les filtres marques confondus */

SELECT  
	a_marque, a_prix, 
	ROUND(AVG(a_prix) OVER (), 2) AS moy_prix_filtres,
    ROUND(AVG(a_prix) OVER (PARTITION BY a_marque), 2) AS moy_prix_par_marque
FROM g_article
WHERE a_designation LIKE '%filtre%';














