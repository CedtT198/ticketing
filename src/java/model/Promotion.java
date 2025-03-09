package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
// import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import util.Connexion;
import validation.annotation.Min;
import validation.annotation.Max;
import validation.annotation.NotEmpty;

public class Promotion {
    Integer idTypeSiege;
    Integer idVol;

    @NotEmpty
    @Min(1)
    Integer nombreSiege;
    
    @NotEmpty
    @Min(1)
    @Max(50)
    Double pourcentage;

    public Promotion() {}
    public Promotion(Integer idTypeSiege, Integer idVol, Integer nombreSiege, Double pourcentage) {
        this.idTypeSiege = idTypeSiege;
        this.idVol = idVol;
        this.nombreSiege = nombreSiege;
        this.pourcentage = pourcentage;
    }

    public Promotion save(Connection conn) throws Exception {
        if (conn == null || conn.isClosed()) conn = Connexion.getConnection();
        String sql = "INSERT INTO promotion (id_type_siege, id_vol, nombre_siege, pourcentage) VALUES (?, ?, ?, ?)";
        
        try (PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setInt(1, this.getIdTypeSiege());
            stmt.setInt(2, this.getIdVol());
            stmt.setInt(3, this.getNombreSiege());
            stmt.setDouble(4, this.getPourcentage());

            int affectedRows = stmt.executeUpdate();

            if (affectedRows > 0) {
                try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        this.setIdTypeSiege(generatedKeys.getInt(1)); 
                    }
                }
            }
        } catch (SQLException e) {
            throw new Exception(e.getMessage());
        }
        return this;
    }

    
    public static List<Promotion> getAllByVol(Integer idVol) {
        List<Promotion> promotions = new ArrayList<>();
        String sql = "SELECT id_vol, nombre_siege, pourcentage FROM promotion WHERE id_vol = ?";

        try (Connection conn = Connexion.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, idVol);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Promotion prom = new Promotion();
                    prom.setIdVol(rs.getInt("id_vol"));
                    prom.setNombreSiege(rs.getInt("nombre_siege"));
                    prom.setPourcentage(rs.getDouble("pourcentage"));
    
                    promotions.add(prom);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return promotions;
    }


    public Integer getIdTypeSiege() {
        return idTypeSiege;
    }

    public void setIdTypeSiege(Integer idTypeSiege) {
        this.idTypeSiege = idTypeSiege;
    }

    public Integer getIdVol() {
        return idVol;
    }

    public void setIdVol(Integer idVol) {
        this.idVol = idVol;
    }

    public Integer getNombreSiege() {
        return nombreSiege;
    }

    public void setNombreSiege(Integer nombreSiege) {
        this.nombreSiege = nombreSiege;
    }

    public Double getPourcentage() {
        return pourcentage;
    }

    public void setPourcentage(Double pourcentage) {
        this.pourcentage = pourcentage;
    }
}
