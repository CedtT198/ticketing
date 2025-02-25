INSERT INTO avion (modele, date_fabrication) VALUES
('Boeing 737', '2010-04-18'),
('Airbus A350', '2016-12-12'),
('Embraer E175', '2015-05-05');

INSERT INTO ville (nom_ville) VALUES
('Antananarivo'),
('Toamasina'),
('Antsirabe'),
('Mahajanga'),
('Fianarantsoa'),
('Toliara'),
('Antsiranana'),
('Ambositra'),
('Nosy Be'),
('Manakara');

INSERT INTO type_siege (prix_type_siege, nom_type_siege) VALUES
(400000, 'Economique'),
(600000, 'Business');

INSERT INTO nombre_siege (nombre, id_avion, id_type_siege) VALUES
(150, 1, 1),  -- 150 sièges économiques dans le Boeing 737
(50, 1, 2),   -- 50 sièges première classe dans le Boeing 737
(250, 2, 1),  -- 250 sièges économiques dans l'Airbus A350
(30, 2, 2),   -- 30 sièges première classe dans l'Airbus A350
(100, 3, 1),  -- 100 sièges économiques dans l'Embraer E175
(20, 3, 2);   -- 20 sièges première classe dans l'Embraer E175

INSERT INTO admin (username, password) VALUES
('admin1', 'admin1'),
('admin2', 'admin2'),
('admin3', 'admin3');
