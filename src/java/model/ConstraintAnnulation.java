package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import util.Connexion;
import validation.annotation.NotEmpty;

public class ConstraintAnnulation {
    Integer idConstraintAnnulation;

    @NotEmpty
    LocalDateTime heureAvantVol;
    
    public ConstraintAnnulation() {}
    public ConstraintAnnulation(Integer idConstraintAnnulation, LocalDateTime heureAvantVol) {
        this.idConstraintAnnulation = idConstraintAnnulation;
        this.heureAvantVol = heureAvantVol;
    }

    public ConstraintAnnulation save(Connection conn) throws Exception {
        String sql = "INSERT INTO constraint_annulation (heure_avant_vol) VALUES (?)";
        PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
        try  {
            stmt.setTimestamp(1, Timestamp.valueOf(this.getHeureAvantVol()));

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
                    Timestamp timestamp = rs.getTimestamp("heure_avant_vol");
                    if (timestamp != null) {
                        constraint.setHeureAvantVol(timestamp.toLocalDateTime());
                    }
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

    public LocalDateTime getHeureAvantVol() {
        return heureAvantVol;
    }

    public void setHeureAvantVol(LocalDateTime heureAvantVol) {
        this.heureAvantVol = heureAvantVol;
    }
    
}
