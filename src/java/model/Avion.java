package model;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import util.Connexion;

public class Avion {
    Integer idAvion;
    String modele;
    Date dateFabrication;

    public Avion() {}
    public Avion(Integer idAvion, String modele, Date dateFabrication) {
        this.idAvion = idAvion;
        this.modele = modele;
        this.dateFabrication = dateFabrication;
    }

    public static Avion getById(Connection conn, int id) {
        Avion avion = null;
        String sql = "SELECT id_avion, modele, date_fabrication FROM Avion WHERE id_avion = ?";
    
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id); 
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    avion = new Avion();
                    avion.setIdAvion(rs.getInt("id_avion"));
                    avion.setModele(rs.getString("modele"));
                    avion.setDateFabrication(rs.getDate("date_fabrication"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    
        return avion;
    }

    public static Avion getById(int id) {
        Connection conn = Connexion.getConnection();
        Avion avion = null;
        String sql = "SELECT id_avion, modele, date_fabrication FROM Avion WHERE id_avion = ?";
    
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id); 
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    avion = new Avion();
                    avion.setIdAvion(rs.getInt("id_avion"));
                    avion.setModele(rs.getString("modele"));
                    avion.setDateFabrication(rs.getDate("date_fabrication"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    
        return avion;
    }
    
    public static List<Avion> getAll()  {
        Connection conn = Connexion.getConnection();
        List<Avion> avions = new ArrayList<>();
        String sql = "SELECT id_avion, modele, date_fabrication FROM Avion";

        try (PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Avion avion = new Avion();
                avion.setIdAvion(rs.getInt("id_avion"));
                avion.setModele(rs.getString("modele"));
                avion.setDateFabrication(rs.getDate("date_fabrication"));

                avions.add(avion);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        finally {
            try {
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
       
        return avions;
    }

    public Integer getIdAvion() {
        return idAvion;
    }

    public void setIdAvion(Integer idAvion) {
        this.idAvion = idAvion;
    }

    public String getModele() {
        return modele;
    }

    public void setModele(String modele) {
        this.modele = modele;
    }

    public Date getDateFabrication() {
        return dateFabrication;
    }

    public void setDateFabrication(Date dateFabrication) {
        this.dateFabrication = dateFabrication;
    }
}