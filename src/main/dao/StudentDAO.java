package university.dao;

import university.model.Student;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class StudentDAO {
    private Connection connection;

    public StudentDAO() {
        this.connection = DBConnection.getConnection();
    }

    // Add new student
    public boolean addStudent(Student student) {
        String sql = "INSERT INTO students (username, password, email, first_name, last_name, roll_number, department, semester) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, student.getUsername());
            stmt.setString(2, student.getPassword());
            stmt.setString(3, student.getEmail());
            stmt.setString(4, student.getFirstName());
            stmt.setString(5, student.getLastName());
            stmt.setString(6, student.getRollNumber());
            stmt.setString(7, student.getDepartment());
            stmt.setInt(8, student.getSemester());
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Get all students
    public List<Student> getAllStudents() {
        List<Student> students = new ArrayList<>();
        String sql = "SELECT * FROM students ORDER BY created_at DESC";
        
        try (Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                students.add(extractStudentFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return students;
    }

    // Get student by ID
    public Student getStudentById(int id) {
        String sql = "SELECT * FROM students WHERE id = ?";
        
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return extractStudentFromResultSet(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Update student
    public boolean updateStudent(Student student) {
        String sql = "UPDATE students SET username=?, email=?, first_name=?, last_name=?, roll_number=?, department=?, semester=?, status=? WHERE id=?";
        
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, student.getUsername());
            stmt.setString(2, student.getEmail());
            stmt.setString(3, student.getFirstName());
            stmt.setString(4, student.getLastName());
            stmt.setString(5, student.getRollNumber());
            stmt.setString(6, student.getDepartment());
            stmt.setInt(7, student.getSemester());
            stmt.setString(8, student.getStatus());
            stmt.setInt(9, student.getId());
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Delete student
    public boolean deleteStudent(int id) {
        String sql = "DELETE FROM students WHERE id = ?";
        
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Search students
    public List<Student> searchStudents(String keyword) {
        List<Student> students = new ArrayList<>();
        String sql = "SELECT * FROM students WHERE first_name LIKE ? OR last_name LIKE ? OR roll_number LIKE ? OR department LIKE ? ORDER BY first_name";
        
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            String searchPattern = "%" + keyword + "%";
            stmt.setString(1, searchPattern);
            stmt.setString(2, searchPattern);
            stmt.setString(3, searchPattern);
            stmt.setString(4, searchPattern);
            
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                students.add(extractStudentFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return students;
    }

    // Check if username exists
    public boolean usernameExists(String username) {
        String sql = "SELECT id FROM students WHERE username = ?";
        
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, username);
            ResultSet rs = stmt.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Check if roll number exists
    public boolean rollNumberExists(String rollNumber) {
        String sql = "SELECT id FROM students WHERE roll_number = ?";
        
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, rollNumber);
            ResultSet rs = stmt.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // ==================== REPORT METHODS ====================

    // Get total students count
    public int getTotalStudents() {
        String sql = "SELECT COUNT(*) FROM students";
        try (Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    // Get active students count
    public int getActiveStudentsCount() {
        String sql = "SELECT COUNT(*) FROM students WHERE status = 'active'";
        try (Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    // Get students by department
    public Map<String, Integer> getStudentsByDepartment() {
        Map<String, Integer> deptCount = new HashMap<>();
        String sql = "SELECT department, COUNT(*) as count FROM students GROUP BY department";
        
        try (Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                deptCount.put(rs.getString("department"), rs.getInt("count"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return deptCount;
    }

    // Get students by status
    public Map<String, Integer> getStudentsByStatus() {
        Map<String, Integer> statusCount = new HashMap<>();
        String sql = "SELECT status, COUNT(*) as count FROM students GROUP BY status";
        
        try (Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                statusCount.put(rs.getString("status"), rs.getInt("count"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return statusCount;
    }

    // Get students by semester (replacing getStudentsByYear)
    public Map<String, Integer> getStudentsBySemester() {
        Map<String, Integer> semesterCount = new HashMap<>();
        String sql = "SELECT semester, COUNT(*) as count FROM students GROUP BY semester ORDER BY semester";
        
        try (Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                semesterCount.put("Semester " + rs.getInt("semester"), rs.getInt("count"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return semesterCount;
    }

    // Get students by year (based on created_at)
    public Map<String, Integer> getStudentsByYear() {
        Map<String, Integer> yearCount = new HashMap<>();
        String sql = "SELECT YEAR(created_at) as year, COUNT(*) as count FROM students GROUP BY YEAR(created_at) ORDER BY year";
        
        try (Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                yearCount.put("Year " + rs.getInt("year"), rs.getInt("count"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return yearCount;
    }

    // Get recent students
    public List<Student> getRecentStudents(int limit) {
        List<Student> students = new ArrayList<>();
        String sql = "SELECT * FROM students ORDER BY created_at DESC LIMIT ?";
        
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, limit);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                students.add(extractStudentFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return students;
    }

    // Get students count by gender (if you have gender field)
    public Map<String, Integer> getStudentsByGender() {
        Map<String, Integer> genderCount = new HashMap<>();
        // If you don't have gender column, you can remove this method
        // or add gender column to your table
        try {
            // Check if gender column exists
            DatabaseMetaData meta = connection.getMetaData();
            ResultSet columns = meta.getColumns(null, null, "students", "gender");
            if (columns.next()) {
                String sql = "SELECT gender, COUNT(*) as count FROM students GROUP BY gender";
                try (Statement stmt = connection.createStatement();
                     ResultSet rs = stmt.executeQuery(sql)) {
                    while (rs.next()) {
                        genderCount.put(rs.getString("gender"), rs.getInt("count"));
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return genderCount;
    }

    // Get student growth by month (for charts)
    public Map<String, Integer> getStudentGrowthByMonth() {
        Map<String, Integer> growth = new HashMap<>();
        String sql = "SELECT DATE_FORMAT(created_at, '%Y-%m') as month, COUNT(*) as count " +
                    "FROM students GROUP BY DATE_FORMAT(created_at, '%Y-%m') ORDER BY month";
        
        try (Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                growth.put(rs.getString("month"), rs.getInt("count"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return growth;
    }
    
 // Search student by exact roll number
    public Student getStudentByRollNumber(String rollNumber) {
        String sql = "SELECT * FROM students WHERE roll_number = ?";
        
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, rollNumber.trim());
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return extractStudentFromResultSet(rs);
            }
        } catch (SQLException e) {
            System.err.println("Error in getStudentByRollNumber: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }
    

    // Helper method to extract student from ResultSet
    private Student extractStudentFromResultSet(ResultSet rs) throws SQLException {
        Student student = new Student();
        student.setId(rs.getInt("id"));
        student.setUsername(rs.getString("username"));
        student.setPassword(rs.getString("password"));
        student.setEmail(rs.getString("email"));
        student.setFirstName(rs.getString("first_name"));
        student.setLastName(rs.getString("last_name"));
        student.setRollNumber(rs.getString("roll_number"));
        student.setDepartment(rs.getString("department"));
        student.setSemester(rs.getInt("semester"));
        student.setStatus(rs.getString("status"));
        student.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
        return student;
    }

    // Close connection (optional)
    public void close() {
        try {
            if (connection != null && !connection.isClosed()) {
                connection.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}