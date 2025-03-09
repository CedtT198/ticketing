package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import util.Connexion;

public class Utilisateur {
    Integer idUtilisateur;
    String nom;

    public Utilisateur() {}
    public Utilisateur(Integer idUtilisateur, String nom) {
        this.idUtilisateur = idUtilisateur;
        this.nom = nom;
    }

    public static List<Utilisateur> getAll() {
        List<Utilisateur> utilisateurs = new ArrayList<>();
        String query = "SELECT * FROM utilisateur";
        
        try (Connection conn = Connexion.getConnection();
        Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery(query)) {
            while (rs.next()) {
                Utilisateur utilisateur = new Utilisateur();
                utilisateur.idUtilisateur = rs.getInt("idUtilisateur");
                utilisateur.nom = rs.getString("nom");

                utilisateurs.add(utilisateur);
            }
        } catch (SQLException e) {
            e.printStackTrace(); 
        }
        
        return utilisateurs;
    }


    public Utilisateur save(Connection c) {
        String checkQuery = "SELECT id_utilisateur FROM utilisateur WHERE nom = ?";        
        try (PreparedStatement checkStmt = c.prepareStatement(checkQuery)) {
            checkStmt.setString(1, this.getNom().toLowerCase());
            try (ResultSet rs = checkStmt.executeQuery()) {
                if (rs.next()) {
                    this.setIdUtilisateur(rs.getInt("id_utilisateur"));
                    return this; 
                }
            }
        } catch (SQLException e) {
            e.printStackTrace(); 
        }

        String insertQuery = "INSERT INTO utilisateur (nom) VALUES (?)";
        try (PreparedStatement pstmt = c.prepareStatement(insertQuery, Statement.RETURN_GENERATED_KEYS)) {
            pstmt.setString(1, this.getNom().toLowerCase());
            pstmt.executeUpdate();
            
            try (ResultSet rs = pstmt.getGeneratedKeys()) {
                if (rs.next()) {
                    this.setIdUtilisateur(rs.getInt(1));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return this;
    }


    public Integer getIdUtilisateur() {
        return idUtilisateur;
    }
    public void setIdUtilisateur(Integer idUtilisateur) {
        this.idUtilisateur = idUtilisateur;
    }
    public String getNom() {
        return nom;
    }
    public void setNom(String nom) {
        this.nom = nom;
    }
}
