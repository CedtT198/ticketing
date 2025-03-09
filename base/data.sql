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



INSERT INTO utilisateur (nom) VALUES ('Cedric');
INSERT INTO histo_reservation (date_histo_reservation, prix, id_type_siege, id_vol, id_utilisateur) VALUES ('2015-05-05', 2500, 1, 1, 1);
INSERT INTO histo_reservation (date_histo_reservation, prix, id_type_siege, id_vol, id_utilisateur) VALUES ('2015-05-05', 2500, 1, 1, 1);
INSERT INTO histo_reservation (date_histo_reservation, prix, id_type_siege, id_vol, id_utilisateur) VALUES ('2015-05-05', 2500, 1, 1, 1);
INSERT INTO histo_reservation (date_histo_reservation, prix, id_type_siege, id_vol, id_utilisateur) VALUES ('2015-05-05', 2500, 2, 1, 1);
INSERT INTO histo_reservation (date_histo_reservation, prix, id_type_siege, id_vol, id_utilisateur) VALUES ('2015-05-05', 2500, 2, 1, 1);
INSERT INTO promotion (id_type_siege, id_vol, nombre_siege, pourcentage) VALUES (1, 1, 5, 10);
INSERT INTO promotion (id_type_siege, id_vol, nombre_siege, pourcentage) VALUES (2, 1, 3, 5);


create or replace view siege_reserve as
select ts.id_type_siege, v.id_vol as id_vol, count(hs.id_histo_reservation) as nombre
from vol v cross join type_siege ts
left join histo_reservation hs on hs.id_type_siege=ts.id_type_siege
group by ts.id_type_siege, v.id_vol, hs.id_vol order by ts.id_type_siege;


create or replace view billets as
select vo.id_vol, date_vol, vi.nom_ville as depart, vi1.nom_ville as destination, a.modele,
vo.heure_avant_reservation, vo.heure_avant_annulation,
ts.nom_type_siege, ns.nombre as nb_total, rs.nombre as nb_siege_reserve, ns.nombre-rs.nombre as reste_siege,
p.pourcentage, p.nombre_siege as nb_prom, p.nombre_siege-rs.nombre as reste_siege_prom,
ts.prix_type_siege as pu_siege, ts.prix_type_siege*p.pourcentage/100 as pu_prom
from vol vo join nombre_siege ns on vo.id_avion=ns.id_avion
join type_siege ts on ns.id_type_siege=ts.id_type_siege
left join promotion p on p.id_type_siege=ts.id_type_siege
join siege_reserve rs on rs.id_type_siege=ts.id_type_siege
join avion a on a.id_avion=vo.id_avion
join ville vi on vi.id_ville=vo.id_ville 
join ville  vi1 on vi1.id_ville=vo.id_ville_1
order by nb_total desc;


