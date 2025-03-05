package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import util.Connexion;
import validation.annotation.NotEmpty;
import validation.annotation.Min;

public class ConstraintAnnulation {
    Integer idConstraintAnnulation;

    @NotEmpty
    @Min(1)
    Integer heureAvantVol;
    
    public ConstraintAnnulation() {}
    public ConstraintAnnulation(Integer idConstraintAnnulation, Integer heureAvantVol) {
        this.idConstraintAnnulation = idConstraintAnnulation;
        this.heureAvantVol = heureAvantVol;
    }

    public ConstraintAnnulation save(Connection conn) throws Exception {
        String sql = "INSERT INTO constraint_annulation (heure_avant_vol) VALUES (?)";
        PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
        try  {
            stmt.setObject(1, this.getHeureAvantVol());

            int affectedRows = stmt.executeUpdate();
            if (affectedRows > 0) {
                try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        this.setIdConstraintAnnulation(generatedKeys.getInt(1));
                    }
                }
            }
        } catch (SQLException e) {
            throw new Exception(e.getMessage());
        }
        stmt.close();
        return this;
    }

    public static ConstraintAnnulation getById(int id) {
        Connection conn = Connexion.getConnection();
        ConstraintAnnulation constraint = null;
        String sql = "SELECT id_constraint_annulation, heure_avant_vol FROM constraint_annulation WHERE id_constraint_annulation = ?";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);  
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    constraint = new ConstraintAnnulation();
                    constraint.setIdConstraintAnnulation(rs.getInt("id_constraint_annulation"));
                    constraint.setHeureAvantVol(rs.getInt("heure_avant_vol"));
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

        return constraint;
    }


    public Integer getIdConstraintAnnulation() {
        return idConstraintAnnulation;
    }

    public void setIdConstraintAnnulation(Integer idConstraintAnnulation) {
        this.idConstraintAnnulation = idConstraintAnnulation;
    }

    public Integer getHeureAvantVol() {
        return heureAvantVol;
    }
    public void setHeureAvantVol(Integer heureAvantVol) {
        this.heureAvantVol = heureAvantVol;
    }
    
}
