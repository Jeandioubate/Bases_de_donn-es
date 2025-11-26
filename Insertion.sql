
-- Insertion dans les tables --

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

INSERT INTO `g_voiture` (`v_marque`, `v_type`, `v_energie`, `v_fk_article_id`) VALUES
('FIAT', '500', 'ESSENCE', 1),
('TOYOTA', 'YARIS', 'DIESEL', 2),
('PEUGEOT', '208', 'ESSENCE', 3),
('RENAULT', 'CLIO', 'ESSENCE', 4),
('RENAULT', 'MEGANE', 'ESSENCE', 5),
('CITROEN', 'C3', 'ESSENCE', 6),
('PEUGEOT', '308', 'DIESEL', 7),
('MERCEDES', 'A180', 'DIESEL', 8);

INSERT INTO `g_client` (`c_nom`, `c_num_telephone`, `c_adresse`) VALUES
('Martin', '01 23 45 67 89', '15 Rue de la République, 75001 Paris'),
('Dubois', '01 34 56 78 90', '22 Avenue des Champs, 69002 Lyon'),
('Bernard', '02 45 67 89 01', '8 Place du Commerce, 33000 Bordeaux'),
('Moreau', '03 56 78 90 12', '45 Rue de la Gare, 31000 Toulouse'),
('Laurent', '04 67 89 01 23', '12 Boulevard Victor Hugo, 13000 Marseille'),
('Simon', '05 78 90 12 34', '27 Rue de la Paix, 44000 Nantes'),
('Michel', '06 89 01 23 45', '33 Avenue Foch, 67000 Strasbourg'),
('Petit', '07 90 12 34 56', '19 Rue de la Liberté, 59000 Lille');

INSERT INTO `g_client_voiture` (`vc_fk_voiture_id`, `vc_fk_client_id`) VALUES
(1, 1),  
(2, 2), 
(3, 3), 
(4, 4),  
(5, 5),  
(6, 6),  
(7, 7),  
(10, 8);  

INSERT INTO `g_ordre` (`o_date`, `o_temps`,`o_montant`, `o_fk_client_id`) VALUES
('2024-01-10', '02:30:00', '325.00', 1),  
('2024-01-12', '03:15:00', '520.75', 2),  
('2024-01-25', '04:30:00', '780.25', 3),   
('2024-04-10', '01:45:00', '240.00', 4), 
('2024-02-18', '03:45:00', '450.00', 5),
('2024-03-05', '01:30:00', '180.75', 6),  
('2024-03-25', '05:00:00', '625.80', 7),
('2024-04-05', '02:20:00', '310.25', 8); 
