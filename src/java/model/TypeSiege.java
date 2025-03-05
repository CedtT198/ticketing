package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import util.Connexion;

public class TypeSiege {
    Integer idTypeSiege;
    Double prixTypeSiege;
    String nomTypeSiege;

    public TypeSiege() {}
    public TypeSiege(Integer idTypeSiege, Double prixTypeSiege, String nomTypeSiege) {
        this.idTypeSiege = idTypeSiege;
        this.prixTypeSiege = prixTypeSiege;
        this.nomTypeSiege = nomTypeSiege;
    }

    public static List<TypeSiege> getAll() {
        List<TypeSiege> typesSiege = new ArrayList<>();
        String sql = "SELECT id_type_siege, prix_type_siege, nom_type_siege FROM type_siege";

        try (Connection conn = Connexion.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                TypeSiege typeSiege = new TypeSiege();
                typeSiege.setIdTypeSiege(rs.getInt("id_type_siege"));
                typeSiege.setPrixTypeSiege(rs.getDouble("prix_type_siege"));
                typeSiege.setNomTypeSiege(rs.getString("nom_type_siege"));

                typesSiege.add(typeSiege);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return typesSiege;
    }
    
    
    public Integer getIdTypeSiege() {
        return idTypeSiege;
    }
    public void setIdTypeSiege(Integer idTypeSiege) {
        this.idTypeSiege = idTypeSiege;
    }
    public Double getPrixTypeSiege() {
        return prixTypeSiege;
    }
    public void setPrixTypeSiege(Double prixTypeSiege) {
        this.prixTypeSiege = prixTypeSiege;
    }
    public String getNomTypeSiege() {
        return nomTypeSiege;
    }
    public void setNomTypeSiege(String nomTypeSiege) {
        this.nomTypeSiege = nomTypeSiege;
    }

    
}
