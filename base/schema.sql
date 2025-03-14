-- create database ticketing owner postgres;
-- \c ticketing;

DROP TABLE IF EXISTS promotion;
DROP TABLE IF EXISTS admin;
DROP TABLE IF EXISTS histo_reservation;
DROP TABLE IF EXISTS vol;
DROP TABLE IF EXISTS utilisateur;
DROP TABLE IF EXISTS nombre_siege;
DROP TABLE IF EXISTS type_siege;
DROP TABLE IF EXISTS ville;
DROP TABLE IF EXISTS avion;

CREATE TABLE avion(
   id_avion SERIAL,
   modele VARCHAR(50) ,
   date_fabrication DATE,
   PRIMARY KEY(id_avion)
);

CREATE TABLE ville(
   id_ville SERIAL,
   nom_ville VARCHAR(50) ,
   PRIMARY KEY(id_ville) 
);

CREATE TABLE type_siege(
   id_type_siege SERIAL,
   prix_type_siege NUMERIC(15,2)  ,
   nom_type_siege VARCHAR(50) ,
   PRIMARY KEY(id_type_siege)
);

CREATE TABLE nombre_siege(
   id_nombre_siege SERIAL,
   nombre INTEGER,
   id_avion INTEGER NOT NULL,
   id_type_siege INTEGER NOT NULL,
   PRIMARY KEY(id_nombre_siege),
   FOREIGN KEY(id_avion) REFERENCES avion(id_avion) ON DELETE CASCADE ON UPDATE CASCADE,
   FOREIGN KEY(id_type_siege) REFERENCES type_siege(id_type_siege) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE utilisateur(
   id_utilisateur SERIAL,
   nom VARCHAR(50) ,
   PRIMARY KEY(id_utilisateur)
);

CREATE TABLE vol(
   id_vol SERIAL,
   date_vol TIMESTAMP,
   heure_avant_annulation INTEGER,
   heure_avant_reservation INTEGER,
   id_ville INTEGER NOT NULL,
   id_ville_1 INTEGER NOT NULL,
   id_avion INTEGER NOT NULL,
   PRIMARY KEY(id_vol),
   FOREIGN KEY(id_ville) REFERENCES ville(id_ville) ON DELETE CASCADE ON UPDATE CASCADE,
   FOREIGN KEY(id_ville_1) REFERENCES ville(id_ville) ON DELETE CASCADE ON UPDATE CASCADE,
   FOREIGN KEY(id_avion) REFERENCES avion(id_avion) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE histo_reservation(
   id_histo_reservation SERIAL,
   date_histo_reservation TIMESTAMP,
   prix NUMERIC(15,2)  ,
   id_type_siege INTEGER NOT NULL,
   id_vol INTEGER NOT NULL,
   id_utilisateur INTEGER NOT NULL,
   PRIMARY KEY(id_histo_reservation),
   FOREIGN KEY(id_type_siege) REFERENCES type_siege(id_type_siege) ON DELETE CASCADE ON UPDATE CASCADE,
   FOREIGN KEY(id_vol) REFERENCES vol(id_vol) ON DELETE CASCADE ON UPDATE CASCADE,
   FOREIGN KEY(id_utilisateur) REFERENCES utilisateur(id_utilisateur) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE admin(
   id_admin SERIAL,
   username VARCHAR(50) ,
   password VARCHAR(50) ,
   PRIMARY KEY(id_admin)
);

CREATE TABLE promotion(
   id_type_siege INTEGER,
   id_vol INTEGER,
   nombre_siege INTEGER,
   pourcentage NUMERIC(15,2)  ,
   PRIMARY KEY(id_type_siege, id_vol),
   FOREIGN KEY(id_type_siege) REFERENCES type_siege(id_type_siege) ON DELETE CASCADE ON UPDATE CASCADE,
   FOREIGN KEY(id_vol) REFERENCES vol(id_vol) ON DELETE CASCADE ON UPDATE CASCADE
);
