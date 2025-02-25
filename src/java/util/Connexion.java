package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Connexion {
    private static final String URL = "jdbc:postgresql://localhost:5432/ticketing";

    private static final String USER = "postgres";
    private static final String PASSWORD = "root";
    private static Connection connection = null;

    public static Connection getConnection() {
        try {
            if (connection == null || connection.isClosed()) {
                Class.forName("org.postgresql.Driver");
                connection = DriverManager.getConnection(URL, USER, PASSWORD);
                // System.out.println("Connexion réussie à la base de données PostgreSQL !");
            }
        } catch (ClassNotFoundException e) {
            System.err.println("Driver JDBC PostgreSQL non trouvé !");
            // e.printStackTrace();
        } catch (SQLException e) {
            System.err.println("Erreur de connexion à la base de données PostgreSQL !");
            // e.printStackTrace();
        }
        return connection;
    }

    public static void closeConnection() {
        try {
            if (connection != null && !connection.isClosed()) {
                connection.close();
                System.out.println("Connexion PostgreSQL fermée !");
            }
        } catch (SQLException e) {
            System.err.println("Erreur lors de la fermeture de la connexion PostgreSQL !");
            e.printStackTrace();
        }
    }
}
