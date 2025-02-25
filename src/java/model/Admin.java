package model;

import java.sql.Connection;
import validation.annotation.NotEmpty;

public class Admin {
    Integer idAdmin;

    @NotEmpty
    String username;

    @NotEmpty
    String password;


    public Admin() {}
    public Admin(Integer idAdmin, String username, String password) {
        this.idAdmin = idAdmin;
        this.username = username;
        this.password = password;
    }


    public Integer auth(Connection conn) throws Exception {
        Integer response = 0;
        String query = "SELECT id_admin, username, password FROM admin WHERE username = ?";
        try (java.sql.PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, username);
            try (java.sql.ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    String storedPassword = rs.getString("password");
                    if (storedPassword.equals(password)) {
                        response = rs.getInt("id_admin");
                    } else {
                        throw new Exception("Password incorrect");
                    }
                } else {
                    throw new Exception("Admin does not exist");
                }
            }
        } catch (java.sql.SQLException ex) {
            ex.printStackTrace();
        }
        return response;
    }

    
    public Integer getIdAdmin() {
        return idAdmin;
    }
    public void setIdAdmin(Integer idAdmin) {
        this.idAdmin = idAdmin;
    }
    public String getUsername() {
        return username;
    }
    public void setUsername(String username) {
        this.username = username;
    }
    public String getPassword() {
        return password;
    }
    public void setPassword(String password) {
        this.password = password;
    }

    
}
