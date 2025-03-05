package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.time.LocalDateTime;

public class HistoReservation {
    Integer idHistoReservation;
    LocalDateTime dateHistoReservation;
    Double prix;
    Integer idTypeSiege;
    Integer idVol;
    Integer idUtilisateur;

    public HistoReservation() {}
    public HistoReservation(Integer idHistoReservation, LocalDateTime dateHistoReservation, Double prix, Integer idVol, Integer idUtilisateur) {
        this.idHistoReservation = idHistoReservation;
        this.dateHistoReservation = dateHistoReservation;
        this.prix = prix;
        this.idVol = idVol;
        this.idUtilisateur = idUtilisateur;
    }

    
    public HistoReservation save(Connection conn) throws Exception {
        String sql = "INSERT INTO histo_reservation (date_histo_reservation, prix, id_type_siege, id_vol, id_utilisateur) VALUES (?, ?, ?, ?, ?)";
        
        try (PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setTimestamp(1, Timestamp.valueOf(this.getDateHistoReservation()));
            stmt.setObject(2, this.getPrix());
            stmt.setObject(3, this.getIdTypeSiege());
            stmt.setObject(4, this.getIdVol());
            stmt.setObject(5, this.getIdUtilisateur());
            
            int affectedRows = stmt.executeUpdate();
            if (affectedRows == 0) {
                throw new SQLException("L'insertion a échoué, aucune ligne affectée.");
            }
            
            // Récupération de la clé générée (idVol)
            try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    this.setIdVol(generatedKeys.getInt(1));
                } else {
                    throw new SQLException("L'insertion a échoué, aucun ID obtenu.");
                }
            }
        } catch (SQLException e) {
            throw new Exception("L'insertion a échoué, aucun ID obtenu.");
            // e.printStackTrace();
        }

        return this;
    }


    public Integer getIdHistoReservation() {
        return idHistoReservation;
    }

    public void setIdHistoReservation(Integer idHistoReservation) {
        this.idHistoReservation = idHistoReservation;
    }

    public LocalDateTime getDateHistoReservation() {
        return dateHistoReservation;
    }

    public void setDateHistoReservation(LocalDateTime dateHistoReservation) {
        this.dateHistoReservation = dateHistoReservation;
    }

    public Double getPrix() {
        return prix;
    }

    public void setPrix(Double prix) {
        this.prix = prix;
    }

    public Integer getIdVol() {
        return idVol;
    }

    public void setIdVol(Integer idVol) {
        this.idVol = idVol;
    }

    public Integer getIdUtilisateur() {
        return idUtilisateur;
    }

    public void setIdUtilisateur(Integer idUtilisateur) {
        this.idUtilisateur = idUtilisateur;
    }

    public Integer getIdTypeSiege() {
        return idTypeSiege;
    }

    public void setIdTypeSiege(Integer idTypeSiege) {
        this.idTypeSiege = idTypeSiege;
    }
}
