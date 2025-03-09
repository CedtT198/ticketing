package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;
import util.Connexion;

public class Billet{
    Integer idVol;
    LocalDateTime dateVol;
    String depart;
    String destination;
    Integer heureAvantReservation;
    Integer heureAvantAnnulation;
    String modele;
    String nomTypeSiege;
    Integer nbSiegeTotal;
    Integer nbSiegeReserve;
    Integer resteSiege;
    Double pourcentage;
    Integer nbProm;
    Integer resteSiegeProm;
    Double puSiege;
    Double puProm;

    public Billet(){}
    public Billet(Integer idVol, LocalDateTime dateVol, String depart, String destination, String modele, String nomTypeSiege,
            Integer nbSiegeTotal, Integer nbSiegeReserve, Integer resteSiege, Double pourcentage, Integer nbProm,
            Integer resteSiegeProm, Double puSiege, Double puProm, Integer heureAvantAnnulation, Integer heureAvantReservation) {
        this.idVol = idVol;
        this.dateVol = dateVol;
        this.depart = depart;
        this.destination = destination;
        this.heureAvantReservation = heureAvantReservation;
        this.heureAvantAnnulation = heureAvantAnnulation;
        this.modele = modele;
        this.nomTypeSiege = nomTypeSiege;
        this.nbSiegeTotal = nbSiegeTotal;
        this.nbSiegeReserve = nbSiegeReserve;
        this.resteSiege = resteSiege;
        this.pourcentage = pourcentage;
        this.nbProm = nbProm;
        this.resteSiegeProm = resteSiegeProm;
        this.puSiege = puSiege;
        this.puProm = puProm;
    }

    
    public static List<Billet> getAll() {
        List<Billet> billets = new ArrayList<>();
        String sql = "SELECT * from billets";

        try (Connection conn = Connexion.getConnection();
        PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Billet billet = new Billet();

                billet.setIdVol(rs.getInt("id_vol"));
                Timestamp timestamp = rs.getTimestamp("date_vol");
                if (timestamp != null) {
                    billet.setDateVol(timestamp.toLocalDateTime());
                }
                billet.setDepart(rs.getString("depart"));
                billet.setDestination(rs.getString("destination"));
                billet.setModele(rs.getString("modele"));
                billet.setHeureAvantAnnulation(rs.getInt("heure_avant_annulation"));
                billet.setHeureAvantReservation(rs.getInt("heure_avant_reservation"));
                billet.setNomTypeSiege(rs.getString("nom_type_siege"));
                billet.setNbSiegeTotal(rs.getInt("nb_total"));
                billet.setNbSiegeReserve(rs.getInt("nb_siege_reserve"));
                billet.setResteSiege(rs.getInt("reste_siege"));
                billet.setPourcentage(rs.getDouble("pourcentage"));
                billet.setNbProm(rs.getInt("nb_prom"));
                billet.setResteSiegeProm(rs.getInt("reste_siege_prom"));
                billet.setPuSiege(rs.getDouble("pu_siege"));
                billet.setPuProm(rs.getDouble("pu_prom"));

                billets.add(billet);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return billets;
    }

    public Integer getIdVol() {
        return idVol;
    }
    public void setIdVol(Integer idVol) {
        this.idVol = idVol;
    }
    public LocalDate getDateOnly() {
        return dateVol.toLocalDate();
    }
    public LocalTime getTimeOnly() {
        return dateVol.toLocalTime();
    }
    public LocalDateTime getDateVol() {
        return dateVol;
    }
    public void setDateVol(LocalDateTime dateVol) {
        this.dateVol = dateVol;
    }
    public String getDepart() {
        return depart;
    }
    public void setDepart(String depart) {
        this.depart = depart;
    }
    public String getDestination() {
        return destination;
    }
    public void setDestination(String destination) {
        this.destination = destination;
    }
    public String getModele() {
        return modele;
    }
    public void setModele(String modele) {
        this.modele = modele;
    }
    public String getNomTypeSiege() {
        return nomTypeSiege;
    }
    public void setNomTypeSiege(String nomTypeSiege) {
        this.nomTypeSiege = nomTypeSiege;
    }
    public Integer getNbSiegeTotal() {
        return nbSiegeTotal;
    }
    public void setNbSiegeTotal(Integer nbSiegeTotal) {
        this.nbSiegeTotal = nbSiegeTotal;
    }
    public Integer getNbSiegeReserve() {
        return nbSiegeReserve;
    }
    public void setNbSiegeReserve(Integer nbSiegeReserve) {
        this.nbSiegeReserve = nbSiegeReserve;
    }
    public Integer getResteSiege() {
        return resteSiege;
    }
    public void setResteSiege(Integer resteSiege) {
        this.resteSiege = resteSiege;
    }
    public Double getPourcentage() {
        return pourcentage;
    }
    public void setPourcentage(Double pourcentage) {
        this.pourcentage = pourcentage;
    }
    public Integer getNbProm() {
        return nbProm;
    }
    public void setNbProm(Integer nbProm) {
        this.nbProm = nbProm;
    }
    public Integer getResteSiegeProm() {
        return resteSiegeProm;
    }
    public void setResteSiegeProm(Integer resteSiegeProm) {
        this.resteSiegeProm = resteSiegeProm;
    }
    public Double getPuSiege() {
        return puSiege;
    }
    public void setPuSiege(Double puSiege) {
        this.puSiege = puSiege;
    }
    public Double getPuProm() {
        return puProm;
    }
    public void setPuProm(Double puProm) {
        this.puProm = puProm;
    }
    public Integer getHeureAvantAnnulation() {
        return heureAvantAnnulation;
    }
    public void setHeureAvantAnnulation(Integer heureAvantAnnulation) {
        this.heureAvantAnnulation = heureAvantAnnulation;
    }
    public Integer getHeureAvantReservation() {
        return heureAvantReservation;
    }
    public void setHeureAvantReservation(Integer heureAvantReservation) {
        this.heureAvantReservation = heureAvantReservation;
    }
}