package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import util.Connexion;

public class NombreSiege {
    Integer idNombreSiege;
    Integer nombre;
    Integer idAvion;
    Integer idTypeSiege;

    public NombreSiege() {}
    public NombreSiege(Integer idNombreSiege, Integer nombre, Integer idAvion, Integer idTypeSiege) {
        this.idNombreSiege = idNombreSiege;
        this.nombre = nombre;
        this.idAvion = idAvion;
        this.idTypeSiege = idTypeSiege;
    }


    public static List<NombreSiege> getByIdAvion(Integer idAvion) {
        List<NombreSiege> sieges = new ArrayList<>();
        String sql = "SELECT id_nombre_siege, nombre, id_avion, id_type_siege FROM nombre_siege WHERE id_avion = ?";

        try (Connection conn = Connexion.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, idAvion);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    NombreSiege siege = new NombreSiege();
                    siege.setIdNombreSiege(rs.getInt("id_nombre_siege"));
                    siege.setNombre(rs.getInt("nombre"));
                    siege.setIdAvion(rs.getInt("id_avion"));
                    siege.setIdTypeSiege(rs.getInt("id_type_siege"));

                    sieges.add(siege);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return sieges;
    }

    public static boolean checkLeftSiege(Integer idAvion, Integer idTypeSiege, Integer nombre) {
        // System.out.println("Type de siege"+idTypeSiege);
        List<NombreSiege> nbSieges = getByIdAvion(idAvion);
        for (NombreSiege nbSiege : nbSieges) {
            if (nbSiege.getIdTypeSiege() == idTypeSiege) {
                return nbSiege.getNombre() > nombre;
            }
        }
        return false;
    } 

    public Integer getIdNombreSiege() {
        return idNombreSiege;
    }
    public void setIdNombreSiege(Integer idNombreSiege) {
        this.idNombreSiege = idNombreSiege;
    }
    public Integer getNombre() {
        return nombre;
    }
    public void setNombre(Integer nombre) {
        this.nombre = nombre;
    }
    public Integer getIdAvion() {
        return idAvion;
    }
    public void setIdAvion(Integer idAvion) {
        this.idAvion = idAvion;
    }
    public Integer getIdTypeSiege() {
        return idTypeSiege;
    }
    public void setIdTypeSiege(Integer idTypeSiege) {
        this.idTypeSiege = idTypeSiege;
    }
}
