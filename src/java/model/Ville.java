package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import util.Connexion;

public class Ville {
    Integer idVille;
    String nomVille;

    public Ville() {}
    public Ville(Integer idVille, String nomVille) {
        this.idVille = idVille;
        this.nomVille = nomVille;
    }

    public static Ville getById(int id) {
        Connection conn = Connexion.getConnection();
        Ville ville = null;
        String sql = "SELECT id_ville, nom_ville FROM Ville WHERE id_ville = ?";
    
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id); 
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    ville = new Ville();
                    ville.setIdVille(rs.getInt("id_ville"));
                    ville.setNomVille(rs.getString("nom_ville"));
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
    
        return ville;
    }
    

    public static List<Ville> getAll() {
        Connection conn = Connexion.getConnection();
        List<Ville> villes = new ArrayList<>();
        String sql = "SELECT id_ville, nom_ville FROM Ville";

        try (PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Ville ville = new Ville();
                ville.setIdVille(rs.getInt("id_ville"));
                ville.setNomVille(rs.getString("nom_ville"));
                villes.add(ville);
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
        
        return villes;
    }

    public Integer getIdVille() {
        return idVille;
    }

    public void setIdVille(Integer idVille) {
        this.idVille = idVille;
    }

    public String getNomVille() {
        return nomVille;
    }

    public void setNomVille(String nomVille) {
        this.nomVille = nomVille;
    }
}
