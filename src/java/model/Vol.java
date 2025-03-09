package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;
import util.Connexion;
import validation.annotation.NotEmpty;
import validation.annotation.Min;

public class Vol {
    Integer idVol;

    @NotEmpty
    LocalDateTime dateVol;
    
    @Min(1)
    Integer heureAvantReservation;

    @Min(1)
    Integer heureAvantAnnulation;
    
    Integer idAvion;
    Integer idVille;
    Integer idVille_1;
    
    public Vol() {}
    public Vol(Integer idVol, LocalDateTime dateVol, Integer heureAvantReservation, Integer heureAvantAnnulation, Integer idAvion,
            Integer idVille, Integer idVille_1) {
        this.idVol = idVol;
        this.dateVol = dateVol;
        this.heureAvantReservation = heureAvantReservation;
        this.heureAvantAnnulation = heureAvantAnnulation;
        this.idAvion = idAvion;
        this.idVille = idVille;
        this.idVille_1 = idVille_1;
    }

    public static Vol getById(Connection conn, Integer idVol) throws Exception {
        Vol vol = null;
        String sql = "SELECT id_vol, date_vol, heure_avant_reservation, heure_avant_annulation, id_avion, id_ville, id_ville_1 FROM Vol WHERE id_vol = ?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        try {
            stmt.setInt(1, idVol); 
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    vol = new Vol();
                    vol.setIdVol(rs.getInt("id_vol"));
                    Timestamp timestamp = rs.getTimestamp("date_vol");
                    if (timestamp != null) {
                        vol.setDateVol(timestamp.toLocalDateTime());
                    }
                    vol.setHeureAvantReservation(rs.getObject("heure_avant_reservation", Integer.class));
                    vol.setHeureAvantAnnulation(rs.getObject("heure_avant_annulation", Integer.class));
                    vol.setIdAvion(rs.getObject("id_avion", Integer.class));
                    vol.setIdVille(rs.getObject("id_ville", Integer.class));
                    vol.setIdVille_1(rs.getObject("id_ville_1", Integer.class));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        finally {
            stmt.close();
        }
    
        return vol;
    }


    public static List<Vol> getAllFilteredByIdVille(Integer idVille) {
        List<Vol> vols = new ArrayList<>();
        String sql = "SELECT id_vol, date_vol, heure_avant_reservation, heure_avant_annulation, id_avion, id_ville, id_ville_1 FROM Vol WHERE id_ville = ?";

        try (Connection conn = Connexion.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, idVille);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Vol vol = new Vol();
                    vol.setIdVol(rs.getInt("id_vol"));
                    Timestamp timestamp = rs.getTimestamp("date_vol");
                    if (timestamp != null) {
                        vol.setDateVol(timestamp.toLocalDateTime());
                    }
                    vol.setHeureAvantReservation(rs.getObject("heure_avant_reservation", Integer.class));
                    vol.setHeureAvantAnnulation(rs.getObject("heure_avant_annulation", Integer.class));
                    vol.setIdAvion(rs.getObject("id_avion", Integer.class));
                    vol.setIdVille(rs.getObject("id_ville", Integer.class));
                    vol.setIdVille_1(rs.getObject("id_ville_1", Integer.class));
    
                    vols.add(vol);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return vols;
    }


    public static boolean update(Integer idVol, Vol vol) {
        String sql = "UPDATE vol SET date_vol = ?, heure_avant_reservation = ?, heure_avant_annulation = ?, id_avion = ?, id_ville = ?, id_ville_1 = ? WHERE id_vol = ?";
        
        try (Connection conn = Connexion.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setTimestamp(1, Timestamp.valueOf(vol.getDateVol()));
            stmt.setObject(2, vol.getHeureAvantReservation());
            stmt.setObject(3, vol.getHeureAvantAnnulation());
            stmt.setObject(4, vol.getIdAvion());
            stmt.setObject(5, vol.getIdVille());
            stmt.setObject(6, vol.getIdVille_1());
            stmt.setInt(7, idVol);
    
            int affectedRows = stmt.executeUpdate();
            return affectedRows > 0;             
        } catch (SQLException e) {
            e.printStackTrace();
            return false; 
        }
    }


    public static boolean delete(Integer idVol) {
        String sql = "DELETE FROM Vol WHERE id_vol = ?";
        
        try (Connection conn = Connexion.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, idVol);
            int affectedRows = stmt.executeUpdate();
            
            return affectedRows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false; 
        }
    }    

    
    public Vol save(Connection conn) throws Exception {
        String sql = "INSERT INTO Vol (date_vol, heure_avant_reservation, heure_avant_annulation, id_avion, id_ville, id_ville_1) VALUES (?, ?, ?, ?, ?, ?)";
        
        try (PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setTimestamp(1, Timestamp.valueOf(this.getDateVol()));
            stmt.setObject(2, this.getHeureAvantReservation());
            stmt.setObject(3, this.getHeureAvantAnnulation());
            stmt.setObject(4, this.getIdAvion());
            stmt.setObject(5, this.getIdVille());
            stmt.setObject(6, this.getIdVille_1());
            
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


    public static List<Vol> getAll() {
        List<Vol> vols = new ArrayList<>();
        String sql = "SELECT id_vol, date_vol, heure_avant_reservation, heure_avant_annulation, id_avion, id_ville, id_ville_1 FROM Vol";

        try (Connection conn = Connexion.getConnection();
        PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Vol vol = new Vol();
                vol.setIdVol(rs.getInt("id_vol"));
                Timestamp timestamp = rs.getTimestamp("date_vol");
                if (timestamp != null) {
                    vol.setDateVol(timestamp.toLocalDateTime());
                }
                vol.setHeureAvantReservation(rs.getObject("heure_avant_reservation", Integer.class));
                vol.setHeureAvantAnnulation(rs.getObject("heure_avant_annulation", Integer.class));
                vol.setIdAvion(rs.getObject("id_avion", Integer.class));
                vol.setIdVille(rs.getObject("id_ville", Integer.class));
                vol.setIdVille_1(rs.getObject("id_ville_1", Integer.class));

                vols.add(vol);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return vols;
    }

    public Integer getIdVol() {
        return idVol;
    }
    public void setIdVol(Integer idVol) {
        this.idVol = idVol;
    }
    public LocalDateTime getDateVol() {
        return dateVol;
    }
    public void setDateVol(LocalDateTime dateVol) {
        this.dateVol = dateVol;
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
    public Integer getIdAvion() {
        return idAvion;
    }
    public void setIdAvion(Integer idAvion) {
        this.idAvion = idAvion;
    }
    public Integer getIdVille() {
        return idVille;
    }
    public void setIdVille(Integer idVille) {
        this.idVille = idVille;
    }
    public void setIdVille_1(Integer idVille_1) {
        this.idVille_1 = idVille_1;
    }
    public Integer getIdVille_1() {
        return idVille_1;
    }
}
