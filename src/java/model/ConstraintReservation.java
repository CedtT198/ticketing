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

public class ConstraintReservation {
    Integer idConstraintReservation;

    @NotEmpty
    LocalDateTime heureAvantVol;
    
    public ConstraintReservation() {}
    public ConstraintReservation(Integer idConstraintReservation, LocalDateTime heureAvantVol) {
        this.idConstraintReservation = idConstraintReservation;
        this.heureAvantVol = heureAvantVol;
    }

    public ConstraintReservation save(Connection conn) throws Exception {
        String sql = "INSERT INTO constraint_reservation (heure_avant_vol) VALUES (?)";
        PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
        try  {
            stmt.setTimestamp(1, Timestamp.valueOf(this.getHeureAvantVol()));

            int affectedRows = stmt.executeUpdate();
            if (affectedRows > 0) {
                try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        this.setIdConstraintReservation(generatedKeys.getInt(1));
                    }
                }
            }
        } catch (SQLException e) {
            throw new Exception(e.getMessage());
        }
        stmt.close();
        return this;
    }

    public static ConstraintReservation getById(int id) {
        Connection conn = Connexion.getConnection();
        ConstraintReservation constraint = null;
        String sql = "SELECT id_constraint_reservation, heure_avant_vol FROM constraint_reservation WHERE id_constraint_reservation = ?";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    constraint = new ConstraintReservation();
                    constraint.setIdConstraintReservation(rs.getInt("id_constraint_reservation"));
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

    public Integer getIdConstraintReservation() {
        return idConstraintReservation;
    }

    public void setIdConstraintReservation(Integer idConstraintReservation) {
        this.idConstraintReservation = idConstraintReservation;
    }

    public LocalDateTime getHeureAvantVol() {
        return heureAvantVol;
    }

    public void setHeureAvantVol(LocalDateTime heureAvantVol) {
        this.heureAvantVol = heureAvantVol;
    }

}
