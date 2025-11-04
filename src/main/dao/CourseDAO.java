package university.dao;

import university.model.Course;
import university.util.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class CourseDAO {
    
    // Get all courses with faculty name
    public List<Course> getAllCourses() {
        List<Course> courses = new ArrayList<>();
        String sql = "SELECT c.*, f.first_name, f.last_name " +
                     "FROM courses c " +
                     "LEFT JOIN faculty f ON c.faculty_id = f.id " +
                     "ORDER BY c.course_code";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                Course course = extractCourseFromResultSet(rs);
                // Set faculty name if available
                String firstName = rs.getString("first_name");
                String lastName = rs.getString("last_name");
                if (firstName != null && lastName != null) {
                    course.setFacultyName(firstName + " " + lastName);
                }
                courses.add(course);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Error retrieving courses", e);
        }
        
        return courses;
    }
    
    
    // Add a new course
    public boolean addCourse(Course course) {
        String sql = "INSERT INTO courses (course_code, course_name, description, credits, " +
                     "department, semester, faculty_id, max_students, status) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, course.getCourseCode());
            stmt.setString(2, course.getCourseName());
            stmt.setString(3, course.getDescription());
            stmt.setInt(4, course.getCredits());
            stmt.setString(5, course.getDepartment());
            stmt.setString(6, course.getSemester());
            
            if (course.getFacultyId() > 0) {
                stmt.setInt(7, course.getFacultyId());
            } else {
                stmt.setNull(7, Types.INTEGER);
            }
            
            stmt.setInt(8, course.getMaxStudents());
            stmt.setString(9, course.getStatus());
            
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Error adding course: " + e.getMessage(), e);
        }
    }
    
    // Update an existing course
    public boolean updateCourse(Course course) {
        String sql = "UPDATE courses SET course_code = ?, course_name = ?, description = ?, " +
                     "credits = ?, department = ?, semester = ?, faculty_id = ?, " +
                     "max_students = ?, status = ? WHERE id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, course.getCourseCode());
            stmt.setString(2, course.getCourseName());
            stmt.setString(3, course.getDescription());
            stmt.setInt(4, course.getCredits());
            stmt.setString(5, course.getDepartment());
            stmt.setString(6, course.getSemester());
            
            if (course.getFacultyId() > 0) {
                stmt.setInt(7, course.getFacultyId());
            } else {
                stmt.setNull(7, Types.INTEGER);
            }
            
            stmt.setInt(8, course.getMaxStudents());
            stmt.setString(9, course.getStatus());
            stmt.setInt(10, course.getId());
            
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Error updating course: " + e.getMessage(), e);
        }
    }
    
    // Delete a course by ID
    public boolean deleteCourse(int id) {
        String sql = "DELETE FROM courses WHERE id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Error deleting course: " + e.getMessage(), e);
        }
    }
    
    // Get courses taught by a specific faculty with enrollment count - SINGLE VERSION
    public List<Course> getCoursesByFaculty(int facultyId) {
        List<Course> courses = new ArrayList<>();
        String sql = "SELECT c.*, f.first_name, f.last_name, " +
                     "COUNT(sc.student_id) as enrolled_students " +
                     "FROM courses c " +
                     "LEFT JOIN faculty f ON c.faculty_id = f.id " +
                     "LEFT JOIN student_courses sc ON c.id = sc.course_id " +
                     "WHERE c.faculty_id = ? AND c.status = 'active' " +
                     "GROUP BY c.id " +
                     "ORDER BY c.course_code";
        
        System.out.println("=== CourseDAO.getCoursesByFaculty called for faculty ID: " + facultyId + " ===");
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, facultyId);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                Course course = extractCourseFromResultSet(rs);
                
                // Set faculty name if available
                String firstName = rs.getString("first_name");
                String lastName = rs.getString("last_name");
                if (firstName != null && lastName != null) {
                    course.setFacultyName(firstName + " " + lastName);
                }
                
                // Set enrolled students count
                course.setEnrolledStudents(rs.getInt("enrolled_students"));
                
                courses.add(course);
                
                System.out.println("=== Found course: " + course.getCourseCode() + " - " + course.getCourseName() + " ===");
            }
            
            System.out.println("=== Total courses found: " + courses.size() + " ===");
            
        } catch (SQLException e) {
            System.err.println("=== Error in getCoursesByFaculty: " + e.getMessage() + " ===");
            e.printStackTrace();
            throw new RuntimeException("Error retrieving faculty courses", e);
        }
        return courses;
    }
    
    // Helper method to extract Course object from ResultSet
    private Course extractCourseFromResultSet(ResultSet rs) throws SQLException {
        Course course = new Course();
        course.setId(rs.getInt("id"));
        course.setCourseCode(rs.getString("course_code"));
        course.setCourseName(rs.getString("course_name"));
        course.setDescription(rs.getString("description"));
        course.setCredits(rs.getInt("credits"));
        course.setDepartment(rs.getString("department"));
        course.setSemester(rs.getString("semester"));
        course.setFacultyId(rs.getInt("faculty_id"));
        course.setMaxStudents(rs.getInt("max_students"));
        course.setStatus(rs.getString("status"));
        
        Timestamp createdAt = rs.getTimestamp("created_at");
        if (createdAt != null) {
            course.setCreatedAt(createdAt.toLocalDateTime());
        }
        
        return course;
    }
    
    // Get course by ID
    public Course getCourseById(int id) {
        String sql = "SELECT c.*, f.first_name, f.last_name " +
                     "FROM courses c " +
                     "LEFT JOIN faculty f ON c.faculty_id = f.id " +
                     "WHERE c.id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                Course course = extractCourseFromResultSet(rs);
                // Set faculty name if available
                String firstName = rs.getString("first_name");
                String lastName = rs.getString("last_name");
                if (firstName != null && lastName != null) {
                    course.setFacultyName(firstName + " " + lastName);
                }
                return course;
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Error retrieving course by ID: " + e.getMessage(), e);
        }
        
        return null;
    }
    
    // Check if course code already exists
    public boolean isCourseCodeExists(String courseCode) {
        return isCourseCodeExists(courseCode, 0); // 0 means new course
    }
    
    public boolean isCourseCodeExists(String courseCode, int excludeId) {
        String sql = "SELECT COUNT(*) FROM courses WHERE course_code = ? AND id != ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, courseCode);
            stmt.setInt(2, excludeId);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return false;
    }
    
    public int getTotalCourses() {
        String sql = "SELECT COUNT(*) FROM courses";
        try (Connection conn = DatabaseConnection.getConnection();
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

    public int getActiveCoursesCount() {
        String sql = "SELECT COUNT(*) FROM courses WHERE status = 'active'";
        try (Connection conn = DatabaseConnection.getConnection();
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

    public Map<String, Integer> getCoursesByDepartment() {
        Map<String, Integer> result = new HashMap<>();
        String sql = "SELECT department, COUNT(*) as count FROM courses GROUP BY department";
        try (Connection conn = DatabaseConnection.getConnection();
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

    public Map<String, Integer> getCoursesByStatus() {
        Map<String, Integer> result = new HashMap<>();
        String sql = "SELECT status, COUNT(*) as count FROM courses GROUP BY status";
        try (Connection conn = DatabaseConnection.getConnection();
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

    public Map<String, Integer> getCoursesWithoutFaculty() {
        Map<String, Integer> result = new HashMap<>();
        String sql = "SELECT department, COUNT(*) as count FROM courses WHERE faculty_id IS NULL GROUP BY department";
        try (Connection conn = DatabaseConnection.getConnection();
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

    public List<Course> getRecentCourses(int limit) {
        List<Course> courses = new ArrayList<>();
        String sql = "SELECT * FROM courses ORDER BY created_at DESC LIMIT ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, limit);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                courses.add(extractCourseFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return courses;
    }
    
    // Get all departments
    public List<String> getAllDepartments() {
        List<String> departments = new ArrayList<>();
        String sql = "SELECT DISTINCT department FROM courses WHERE department IS NOT NULL ORDER BY department";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                departments.add(rs.getString("department"));
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return departments;
    }
 // Test method to check faculty-course assignment
    public void testFacultyCourseAssignment(int facultyId) {
        System.out.println("=== TEST: Checking faculty-course assignment ===");
        
        // Test 1: Check if faculty exists
        String facultySql = "SELECT COUNT(*) as faculty_count FROM faculty WHERE id = ?";
        // Test 2: Check courses assigned to faculty
        String courseSql = "SELECT COUNT(*) as course_count FROM courses WHERE faculty_id = ? AND status = 'active'";
        // Test 3: Get detailed course info
        String detailSql = "SELECT course_code, course_name, status FROM courses WHERE faculty_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection()) {
            
            // Test 1: Faculty existence
            try (PreparedStatement stmt = conn.prepareStatement(facultySql)) {
                stmt.setInt(1, facultyId);
                ResultSet rs = stmt.executeQuery();
                if (rs.next()) {
                    int facultyCount = rs.getInt("faculty_count");
                    System.out.println("=== TEST: Faculty ID " + facultyId + " exists: " + (facultyCount > 0) + " ===");
                }
            }
            
            // Test 2: Course count
            try (PreparedStatement stmt = conn.prepareStatement(courseSql)) {
                stmt.setInt(1, facultyId);
                ResultSet rs = stmt.executeQuery();
                if (rs.next()) {
                    int courseCount = rs.getInt("course_count");
                    System.out.println("=== TEST: Faculty ID " + facultyId + " has " + courseCount + " active courses ===");
                }
            }
            
            // Test 3: Course details
            try (PreparedStatement stmt = conn.prepareStatement(detailSql)) {
                stmt.setInt(1, facultyId);
                ResultSet rs = stmt.executeQuery();
                System.out.println("=== TEST: Courses assigned to faculty " + facultyId + " ===");
                int count = 0;
                while (rs.next()) {
                    count++;
                    System.out.println("=== Course " + count + ": " + 
                        rs.getString("course_code") + " - " + 
                        rs.getString("course_name") + " (" + 
                        rs.getString("status") + ") ===");
                }
                if (count == 0) {
                    System.out.println("=== TEST: No courses found for faculty " + facultyId + " ===");
                }
            }
            
        } catch (SQLException e) {
            System.err.println("=== TEST ERROR: " + e.getMessage() + " ===");
            e.printStackTrace();
        }
    }
 // In university.dao.CourseDAO.java

    public List<Course> getCoursesByFacultyUsername(String username) {
        List<Course> courses = new ArrayList<>();
        
        // CORRECTED: Using standard string concatenation compatible with all JDK versions
        String SQL = "SELECT "
                   + "    c.id, c.course_code, c.course_name, c.description, c.credits, "
                   + "    c.department, c.semester, c.max_students, c.status "
                   + "FROM "
                   + "    courses c "
                   + "INNER JOIN "
                   + "    faculty f ON c.faculty_id = f.id "
                   + "WHERE "
                   + "    f.username = ?"; 

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(SQL)) {

            // ... rest of the code remains the same ...
            pstmt.setString(1, username);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Course course = new Course();
                    // ... mapping logic ...
                    course.setCourseId(rs.getInt("id"));
                    course.setCourseCode(rs.getString("course_code"));
                    // ... etc.
                    courses.add(course);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error fetching courses by username: " + e.getMessage());
            e.printStackTrace();
        }
        return courses;
    }
}