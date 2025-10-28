package university.dao;

import java.sql.*;
import javax.sql.DataSource;

import org.apache.tomcat.dbcp.dbcp2.BasicDataSource;

public class DBConnection {
    private static DataSource dataSource = null;
    
    // Database configuration - UPDATE THESE WITH YOUR DATABASE CREDENTIALS
    private static final String DB_URL = "jdbc:mysql://localhost:3306/university";
    private static final String DB_USERNAME = "root";  // Change to your MySQL username
    private static final String DB_PASSWORD = "Ramesh@123";  // Change to your MySQL password
    
    static {
        initializeDataSource();
    }
    
    private static void initializeDataSource() {
        try {
            BasicDataSource ds = new BasicDataSource();
            ds.setDriverClassName("com.mysql.cj.jdbc.Driver");
            ds.setUrl(DB_URL);
            ds.setUsername(DB_USERNAME);
            ds.setPassword(DB_PASSWORD);
            
            // Connection pool configuration
            ds.setInitialSize(5);           // Initial number of connections
            ds.setMaxTotal(20);             // Maximum number of connections
            ds.setMaxIdle(10);              // Maximum idle connections
            ds.setMinIdle(5);               // Minimum idle connections
            ds.setMaxWaitMillis(10000);     // Maximum wait time for connection (10 seconds)
            
            // Connection validation
            ds.setValidationQuery("SELECT 1");
            ds.setTestOnBorrow(true);
            ds.setTestWhileIdle(true);
            ds.setTimeBetweenEvictionRunsMillis(30000); // Check every 30 seconds
            
            dataSource = ds;
            System.out.println("Database connection pool initialized successfully");
            
        } catch (Exception e) {
            System.err.println("Error initializing database connection pool: " + e.getMessage());
            e.printStackTrace();
        }
    }
    
    public static Connection getConnection() {
        try {
            Connection conn = dataSource.getConnection();
            System.out.println("Database connection obtained from pool");
            return conn;
        } catch (SQLException e) {
            System.err.println("Error getting connection from pool: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }
    
    public static void closeConnection(Connection conn) {
        if (conn != null) {
            try {
                conn.close(); // Returns connection to pool, doesn't actually close it
                System.out.println("Database connection returned to pool");
            } catch (SQLException e) {
                System.err.println("Error closing connection: " + e.getMessage());
            }
        }
    }
    
    public static void closeResources(Connection conn, PreparedStatement stmt, ResultSet rs) {
        try {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (conn != null) closeConnection(conn);
        } catch (SQLException e) {
            System.err.println("Error closing database resources: " + e.getMessage());
        }
    }
    
    public static void closeResources(Connection conn, PreparedStatement stmt) {
        closeResources(conn, stmt, null);
    }
    
    // Test method to verify connection pool is working
    public static boolean testConnection() {
        Connection conn = null;
        try {
            conn = getConnection();
            if (conn != null && !conn.isClosed()) {
                System.out.println("Database connection test: SUCCESS");
                return true;
            }
        } catch (SQLException e) {
            System.err.println("Database connection test: FAILED - " + e.getMessage());
        } finally {
            closeConnection(conn);
        }
        return false;
    }
}
