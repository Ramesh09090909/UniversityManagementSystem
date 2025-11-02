package university.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import university.model.Faculty;

public class FacultyDAO {
    private Connection connection;

    public FacultyDAO() {
        this.connection = DBConnection.getConnection();
        if (this.connection != null) {
            try {
                System.out.println("FacultyDAO: Database connected successfully");
                System.out.println("FacultyDAO: Connection is valid: " + !connection.isClosed());
                System.out.println("FacultyDAO: Connection URL: " + connection.getMetaData().getURL());
            } catch (SQLException e) {
                System.err.println("FacultyDAO: Error checking connection: " + e.getMessage());
            }
        } else {
            System.err.println("FacultyDAO: Database connection is NULL!");
        }
    }

    // Add new faculty
    public boolean addFaculty(Faculty faculty) {
        String sql = "INSERT INTO faculty (first_name, last_name, email, username, password, " +
                    "employee_id, department, designation, qualification, phone, join_date, status) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        System.out.println("FacultyDAO: Attempting to add faculty - " + faculty.getEmployeeId());
        System.out.println("FacultyDAO: SQL - " + sql);
        
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, faculty.getFirstName());
            stmt.setString(2, faculty.getLastName());
            stmt.setString(3, faculty.getEmail());
            stmt.setString(4, faculty.getUsername());
            stmt.setString(5, faculty.getPassword());
            stmt.setString(6, faculty.getEmployeeId());
            stmt.setString(7, faculty.getDepartment());
            stmt.setString(8, faculty.getDesignation());
            stmt.setString(9, faculty.getQualification());
            stmt.setString(10, faculty.getPhone());
            stmt.setString(11, faculty.getJoinDate());
            stmt.setString(12, faculty.getStatus());
            
            // Debug: Print all parameter values
            System.out.println("FacultyDAO: Parameters:");
            System.out.println("  first_name: " + faculty.getFirstName());
            System.out.println("  last_name: " + faculty.getLastName());
            System.out.println("  email: " + faculty.getEmail());
            System.out.println("  username: " + faculty.getUsername());
            System.out.println("  password: " + faculty.getPassword());
            System.out.println("  employee_id: " + faculty.getEmployeeId());
            System.out.println("  department: " + faculty.getDepartment());
            System.out.println("  designation: " + faculty.getDesignation());
            System.out.println("  qualification: " + faculty.getQualification());
            System.out.println("  phone: " + faculty.getPhone());
            System.out.println("  join_date: " + faculty.getJoinDate());
            System.out.println("  status: " + faculty.getStatus());
            
            int result = stmt.executeUpdate();
            System.out.println("FacultyDAO: Insert result - " + result + " rows affected");
            
            return result > 0;
        } catch (SQLException e) {
            System.err.println("FacultyDAO: SQL Error - " + e.getMessage());
            System.err.println("FacultyDAO: SQL State - " + e.getSQLState());
            System.err.println("FacultyDAO: Error Code - " + e.getErrorCode());
            e.printStackTrace();
            return false;
        }
    }

    // Get all faculty
    public List<Faculty> getAllFaculty() {
        List<Faculty> facultyList = new ArrayList<>();
        String sql = "SELECT * FROM faculty ORDER BY id DESC";
        
        try (Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                Faculty faculty = extractFacultyFromResultSet(rs);
                facultyList.add(faculty);
            }
            System.out.println("FacultyDAO: Retrieved " + facultyList.size() + " faculty members");
        } catch (SQLException e) {
            System.err.println("FacultyDAO: Error getting all faculty - " + e.getMessage());
            e.printStackTrace();
        }
        return facultyList;
    }

    // Get faculty by ID
    public Faculty getFacultyById(int id) {
        String sql = "SELECT * FROM faculty WHERE id = ?";
        
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                Faculty faculty = extractFacultyFromResultSet(rs);
                System.out.println("FacultyDAO: Found faculty by ID " + id + " - " + faculty.getFirstName() + " " + faculty.getLastName());
                return faculty;
            }
        } catch (SQLException e) {
            System.err.println("FacultyDAO: Error getting faculty by ID " + id + " - " + e.getMessage());
        }
        System.out.println("FacultyDAO: No faculty found with ID " + id);
        return null;
    }

    // Get faculty by Employee ID
    public Faculty getFacultyByEmployeeId(String employeeId) {
        String sql = "SELECT * FROM faculty WHERE employee_id = ?";
        
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, employeeId);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                Faculty faculty = extractFacultyFromResultSet(rs);
                System.out.println("FacultyDAO: Found faculty by Employee ID " + employeeId + " - " + faculty.getFirstName() + " " + faculty.getLastName());
                return faculty;
            }
        } catch (SQLException e) {
            System.err.println("FacultyDAO: Error getting faculty by Employee ID " + employeeId + " - " + e.getMessage());
        }
        System.out.println("FacultyDAO: No faculty found with Employee ID " + employeeId);
        return null;
    }

    // Search faculty
    public List<Faculty> searchFaculty(String search, String department, String designation) {
        List<Faculty> facultyList = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM faculty WHERE 1=1");
        List<Object> parameters = new ArrayList<>();
        
        if (search != null && !search.trim().isEmpty()) {
            sql.append(" AND (first_name LIKE ? OR last_name LIKE ? OR email LIKE ? OR employee_id LIKE ?)");
            parameters.add("%" + search + "%");
            parameters.add("%" + search + "%");
            parameters.add("%" + search + "%");
            parameters.add("%" + search + "%");
        }
        
        if (department != null && !department.trim().isEmpty()) {
            sql.append(" AND department = ?");
            parameters.add(department);
        }
        
        if (designation != null && !designation.trim().isEmpty()) {
            sql.append(" AND designation = ?");
            parameters.add(designation);
        }
        
        sql.append(" ORDER BY id DESC");
        
        System.out.println("FacultyDAO: Search SQL - " + sql.toString());
        System.out.println("FacultyDAO: Search parameters - search: " + search + ", department: " + department + ", designation: " + designation);
        
        try (PreparedStatement stmt = connection.prepareStatement(sql.toString())) {
            for (int i = 0; i < parameters.size(); i++) {
                stmt.setObject(i + 1, parameters.get(i));
            }
            
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Faculty faculty = extractFacultyFromResultSet(rs);
                facultyList.add(faculty);
            }
            System.out.println("FacultyDAO: Search found " + facultyList.size() + " results");
        } catch (SQLException e) {
            System.err.println("FacultyDAO: Error searching faculty - " + e.getMessage());
            e.printStackTrace();
        }
        return facultyList;
    }

    // Update faculty
    public boolean updateFaculty(Faculty faculty) {
        String sql = "UPDATE faculty SET first_name=?, last_name=?, email=?, username=?, " +
                    "employee_id=?, department=?, designation=?, qualification=?, phone=?, " +
                    "join_date=?, status=? WHERE id=?";
        
        System.out.println("FacultyDAO: Updating faculty ID " + faculty.getId());
        
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, faculty.getFirstName());
            stmt.setString(2, faculty.getLastName());
            stmt.setString(3, faculty.getEmail());
            stmt.setString(4, faculty.getUsername());
            stmt.setString(5, faculty.getEmployeeId());
            stmt.setString(6, faculty.getDepartment());
            stmt.setString(7, faculty.getDesignation());
            stmt.setString(8, faculty.getQualification());
            stmt.setString(9, faculty.getPhone());
            stmt.setString(10, faculty.getJoinDate());
            stmt.setString(11, faculty.getStatus());
            stmt.setInt(12, faculty.getId());
            
            int result = stmt.executeUpdate();
            System.out.println("FacultyDAO: Update result - " + result + " rows affected");
            
            return result > 0;
        } catch (SQLException e) {
            System.err.println("FacultyDAO: Error updating faculty - " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    // Delete faculty
    public boolean deleteFaculty(int id) {
        String sql = "DELETE FROM faculty WHERE id = ?";
        
        System.out.println("FacultyDAO: Deleting faculty ID " + id);
        
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            int result = stmt.executeUpdate();
            System.out.println("FacultyDAO: Delete result - " + result + " rows affected");
            return result > 0;
        } catch (SQLException e) {
            System.err.println("FacultyDAO: Error deleting faculty - " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    // Check if username exists
    public boolean usernameExists(String username) {
        String sql = "SELECT COUNT(*) FROM faculty WHERE username = ?";
        
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, username);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                boolean exists = rs.getInt(1) > 0;
                System.out.println("FacultyDAO: Username '" + username + "' exists: " + exists);
                return exists;
            }
        } catch (SQLException e) {
            System.err.println("FacultyDAO: Error checking username existence - " + e.getMessage());
        }
        return false;
    }

    // Check if email exists
    public boolean emailExists(String email) {
        String sql = "SELECT COUNT(*) FROM faculty WHERE email = ?";
        
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                boolean exists = rs.getInt(1) > 0;
                System.out.println("FacultyDAO: Email '" + email + "' exists: " + exists);
                return exists;
            }
        } catch (SQLException e) {
            System.err.println("FacultyDAO: Error checking email existence - " + e.getMessage());
        }
        return false;
    }

    // Check if employee ID exists
    public boolean employeeIdExists(String employeeId) {
        String sql = "SELECT COUNT(*) FROM faculty WHERE employee_id = ?";
        
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, employeeId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                boolean exists = rs.getInt(1) > 0;
                System.out.println("FacultyDAO: Employee ID '" + employeeId + "' exists: " + exists);
                return exists;
            }
        } catch (SQLException e) {
            System.err.println("FacultyDAO: Error checking employee ID existence - " + e.getMessage());
        }
        return false;
    }

    // Get total faculty count
    public int getTotalFacultyCount() {
        String sql = "SELECT COUNT(*) FROM faculty";
        
        try (Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            if (rs.next()) {
                int count = rs.getInt(1);
                System.out.println("FacultyDAO: Total faculty count: " + count);
                return count;
            }
        } catch (SQLException e) {
            System.err.println("FacultyDAO: Error getting total faculty count - " + e.getMessage());
        }
        return 0;
    }

    // Get faculty count by department
    public int getFacultyCountByDepartment(String department) {
        String sql = "SELECT COUNT(*) FROM faculty WHERE department = ?";
        
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, department);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.err.println("FacultyDAO: Error getting faculty count by department - " + e.getMessage());
        }
        return 0;
    }

    // Get faculty count by status
    public int getFacultyCountByStatus(String status) {
        String sql = "SELECT COUNT(*) FROM faculty WHERE status = ?";
        
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, status);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.err.println("FacultyDAO: Error getting faculty count by status - " + e.getMessage());
        }
        return 0;
    }

    // Get faculty by department
    public List<Faculty> getFacultyByDepartment(String department) {
        List<Faculty> facultyList = new ArrayList<>();
        String sql = "SELECT * FROM faculty WHERE department = ? ORDER BY first_name, last_name";
        
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, department);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                Faculty faculty = extractFacultyFromResultSet(rs);
                facultyList.add(faculty);
            }
        } catch (SQLException e) {
            System.err.println("FacultyDAO: Error getting faculty by department - " + e.getMessage());
        }
        return facultyList;
    }

    // Update faculty status
    public boolean updateFacultyStatus(int id, String status) {
        String sql = "UPDATE faculty SET status = ? WHERE id = ?";
        
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, status);
            stmt.setInt(2, id);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("FacultyDAO: Error updating faculty status - " + e.getMessage());
            return false;
        }
    }

    // Verify faculty credentials (for login)
    public Faculty verifyFacultyCredentials(String username, String password) {
        String sql = "SELECT * FROM faculty WHERE username = ? AND password = ? AND status = 'active'";
        
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, username);
            stmt.setString(2, password);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return extractFacultyFromResultSet(rs);
            }
        } catch (SQLException e) {
            System.err.println("FacultyDAO: Error verifying faculty credentials - " + e.getMessage());
        }
        return null;
    }

    // Change faculty password
    public boolean changePassword(int facultyId, String newPassword) {
        String sql = "UPDATE faculty SET password = ? WHERE id = ?";
        
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, newPassword);
            stmt.setInt(2, facultyId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("FacultyDAO: Error changing password - " + e.getMessage());
            return false;
        }
    }

    // Test database connection
    public boolean testDatabase() {
        String sql = "SELECT 1";
        try (Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            System.out.println("FacultyDAO: Database test - SUCCESS");
            return true;
        } catch (SQLException e) {
            System.err.println("FacultyDAO: Database test - FAILED: " + e.getMessage());
            return false;
        }
    }

    // Check if faculty table exists
    public boolean tableExists() {
        String sql = "SELECT COUNT(*) FROM information_schema.tables WHERE table_schema = DATABASE() AND table_name = 'faculty'";
        
        try (Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            if (rs.next()) {
                boolean exists = rs.getInt(1) > 0;
                System.out.println("FacultyDAO: Table exists - " + exists);
                return exists;
            }
        } catch (SQLException e) {
            System.err.println("FacultyDAO: Error checking table existence: " + e.getMessage());
        }
        return false;
    }

    // Create faculty table if it doesn't exist
    public boolean createTable() {
        String sql = "CREATE TABLE IF NOT EXISTS faculty (" +
                    "id INT PRIMARY KEY AUTO_INCREMENT, " +
                    "first_name VARCHAR(50) NOT NULL, " +
                    "last_name VARCHAR(50) NOT NULL, " +
                    "email VARCHAR(100) UNIQUE NOT NULL, " +
                    "username VARCHAR(50) UNIQUE NOT NULL, " +
                    "password VARCHAR(255) NOT NULL, " +
                    "employee_id VARCHAR(20) UNIQUE NOT NULL, " +
                    "department VARCHAR(100) NOT NULL, " +
                    "designation VARCHAR(50) NOT NULL, " +
                    "qualification VARCHAR(200) NOT NULL, " +
                    "phone VARCHAR(15) NOT NULL, " +
                    "join_date DATE NOT NULL, " +
                    "status ENUM('active', 'inactive') DEFAULT 'active', " +
                    "created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP" +
                    ")";
        
        try (Statement stmt = connection.createStatement()) {
            stmt.executeUpdate(sql);
            System.out.println("FacultyDAO: Table created successfully");
            return true;
        } catch (SQLException e) {
            System.err.println("FacultyDAO: Error creating table: " + e.getMessage());
            return false;
        }
    }

    // Initialize database - call this in servlet init
    public boolean initializeDatabase() {
        System.out.println("FacultyDAO: Initializing database...");
        
        // Test connection
        if (!testDatabase()) {
            System.err.println("FacultyDAO: Database connection failed");
            return false;
        }
        
        // Check if table exists, create if not
        if (!tableExists()) {
            System.out.println("FacultyDAO: Table doesn't exist, creating...");
            if (!createTable()) {
                System.err.println("FacultyDAO: Failed to create table");
                return false;
            }
        } else {
            System.out.println("FacultyDAO: Table already exists");
        }
        
        System.out.println("FacultyDAO: Database initialization completed successfully");
        return true;
    }
    public int getTotalFaculty() {
        String sql = "SELECT COUNT(*) FROM faculty";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public int getActiveFacultyCount() {
        String sql = "SELECT COUNT(*) FROM faculty WHERE status = 'active'";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public Map<String, Integer> getFacultyByDepartment() {
        Map<String, Integer> result = new HashMap<>();
        String sql = "SELECT department, COUNT(*) as count FROM faculty GROUP BY department";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                result.put(rs.getString("department"), rs.getInt("count"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }

    public Map<String, Integer> getFacultyByStatus() {
        Map<String, Integer> result = new HashMap<>();
        String sql = "SELECT status, COUNT(*) as count FROM faculty GROUP BY status";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                result.put(rs.getString("status"), rs.getInt("count"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }

    public Map<String, Integer> getFacultyByDesignation() {
        Map<String, Integer> result = new HashMap<>();
        String sql = "SELECT designation, COUNT(*) as count FROM faculty GROUP BY designation";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                result.put(rs.getString("designation"), rs.getInt("count"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }

    public List<Faculty> getRecentFaculty(int limit) {
        List<Faculty> facultyList = new ArrayList<>();
        String sql = "SELECT * FROM faculty ORDER BY join_date DESC LIMIT ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, limit);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                facultyList.add(extractFacultyFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return facultyList;
    }
    
 // Get all active faculty for course assignment (dropdown)
    public List<Faculty> getActiveFacultyForAssignment() {
        List<Faculty> facultyList = new ArrayList<>();
        String sql = "SELECT id, first_name, last_name, department, designation, email " +
                     "FROM faculty WHERE status = 'active' ORDER BY first_name, last_name";
        
        System.out.println("FacultyDAO: Getting active faculty for course assignment");
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                Faculty faculty = new Faculty();
                faculty.setId(rs.getInt("id"));
                faculty.setFirstName(rs.getString("first_name"));
                faculty.setLastName(rs.getString("last_name"));
                faculty.setDepartment(rs.getString("department"));
                faculty.setDesignation(rs.getString("designation"));
                faculty.setEmail(rs.getString("email"));
                facultyList.add(faculty);
            }
            
            System.out.println("FacultyDAO: Retrieved " + facultyList.size() + " active faculty members");
            
        } catch (SQLException e) {
            System.err.println("FacultyDAO: Error getting active faculty - " + e.getMessage());
            e.printStackTrace();
        }
        return facultyList;
    }
    
 // Add to FacultyDAO.java
    public int getFacultyIdByUsername(String username) {
        String sql = "SELECT id FROM faculty WHERE username = ?";
        int facultyId = -1;
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, username);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                facultyId = rs.getInt("id");
            }
            
        } catch (SQLException e) {
            System.err.println("=== ERROR in getFacultyIdByUsername: " + e.getMessage() + " ===");
            e.printStackTrace();
        }
        
        return facultyId;
    }

    public Faculty getFacultyByUsername(String username) {
        System.out.println("DEBUG: Getting faculty by username: " + username);
        
        String sql = "SELECT id, first_name, last_name, email, username, employee_id, department, designation " +
                    "FROM faculty WHERE username = ? AND status = 'active'";
        
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, username);
            ResultSet rs = statement.executeQuery();
            
            if (rs.next()) {
                Faculty faculty = new Faculty();
                faculty.setId(rs.getInt("id"));
                faculty.setFirstName(rs.getString("first_name"));
                faculty.setLastName(rs.getString("last_name"));
                faculty.setEmail(rs.getString("email"));
                faculty.setUsername(rs.getString("username"));
                faculty.setEmployeeId(rs.getString("employee_id"));
                faculty.setDepartment(rs.getString("department"));
                faculty.setDesignation(rs.getString("designation")); // CORRECTED: designation not position
                
                System.out.println("DEBUG: Faculty found: " + faculty.getFirstName() + " " + faculty.getLastName());
                System.out.println("DEBUG: Designation: " + faculty.getDesignation());
                
                return faculty;
            } else {
                System.out.println("DEBUG: No faculty found for username: " + username);
            }
        } catch (SQLException e) {
            System.out.println("=== ERROR in getFacultyByUsername: " + e.getMessage() + " ===");
            e.printStackTrace();
        }
        return null;
    }
    
    // Add this method to verify login
    public boolean validateFaculty(String username, String password) {
        String sql = "SELECT * FROM faculty WHERE username = ? AND password = ? AND status = 'active'";
        
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, username);
            statement.setString(2, password); // In real application, use hashed passwords
            
            ResultSet rs = statement.executeQuery();
            return rs.next();
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

 // Get faculty by email
    public Faculty getFacultyByEmail(String email) {
        String sql = "SELECT * FROM faculty WHERE email = ?";
        
        System.out.println("=== FacultyDAO: Getting faculty by email: " + email + " ===");
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                Faculty faculty = extractFacultyFromResultSet(rs);
                System.out.println("✅ Found faculty by email: " + faculty.getFirstName() + " " + faculty.getLastName());
                return faculty;
            }
            
        } catch (SQLException e) {
            System.err.println("❌ Error getting faculty by email: " + e.getMessage());
        }
        return null;
    }
    // Get faculty with course count (to avoid over-assignment)
    public List<Faculty> getAvailableFacultyWithCourseCount() {
        List<Faculty> facultyList = new ArrayList<>();
        String sql = "SELECT f.id, f.first_name, f.last_name, f.department, f.designation, " +
                     "COUNT(c.id) as course_count " +
                     "FROM faculty f " +
                     "LEFT JOIN courses c ON f.id = c.faculty_id AND c.status = 'active' " +
                     "WHERE f.status = 'active' " +
                     "GROUP BY f.id, f.first_name, f.last_name, f.department, f.designation " +
                     "HAVING COUNT(c.id) < 5 " + // Limit: max 5 courses per faculty
                     "ORDER BY f.first_name, f.last_name";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                Faculty faculty = new Faculty();
                faculty.setId(rs.getInt("id"));
                faculty.setFirstName(rs.getString("first_name"));
                faculty.setLastName(rs.getString("last_name"));
                faculty.setDepartment(rs.getString("department"));
                faculty.setDesignation(rs.getString("designation"));
                facultyList.add(faculty);
            }
            
        } catch (SQLException e) {
            System.err.println("FacultyDAO: Error getting available faculty - " + e.getMessage());
            e.printStackTrace();
        }
        return facultyList;
    }

    // Helper method to extract faculty from ResultSet
    private Faculty extractFacultyFromResultSet(ResultSet rs) throws SQLException {
        Faculty faculty = new Faculty();
        faculty.setId(rs.getInt("id"));
        faculty.setFirstName(rs.getString("first_name"));
        faculty.setLastName(rs.getString("last_name"));
        faculty.setEmail(rs.getString("email"));
        faculty.setUsername(rs.getString("username"));
        faculty.setPassword(rs.getString("password"));
        faculty.setEmployeeId(rs.getString("employee_id"));
        faculty.setDepartment(rs.getString("department"));
        faculty.setDesignation(rs.getString("designation"));
        faculty.setQualification(rs.getString("qualification"));
        faculty.setPhone(rs.getString("phone"));
        faculty.setJoinDate(rs.getString("join_date"));
        faculty.setStatus(rs.getString("status"));
        return faculty;
    }
}