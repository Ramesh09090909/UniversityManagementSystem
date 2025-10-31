package university.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import university.model.User;
import university.model.Faculty;
import university.dao.FacultyDAO;
import university.util.DatabaseConnection;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String role = request.getParameter("role");
        
        System.out.println("=== LOGIN ATTEMPT ===");
        System.out.println("Username: " + username);
        System.out.println("Role: " + role);
        
        // Validate input
        if (username == null || username.trim().isEmpty() || 
            password == null || password.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Username and password are required");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }
        
        try {
            // Step 1: Authenticate the user
            User user = authenticateUser(username, password, role);
            
            System.out.println("Authentication result: " + (user != null ? "SUCCESS" : "FAILED"));
            
            if (user != null) {
                // Step 2: Create/Get session and store general user data
                HttpSession session = request.getSession();
                session.setAttribute("user", user);
                session.setAttribute("username", username);
                session.setAttribute("role", role);
                session.setMaxInactiveInterval(30 * 60);

                // Step 3: Fetch and store role-specific data (Faculty)
                if ("faculty".equals(role.toLowerCase())) {
                    FacultyDAO facultyDAO = new FacultyDAO();
                    Faculty loggedInFaculty = facultyDAO.getFacultyByUsername(username); 
                    
                    if (loggedInFaculty != null) {
                        session.setAttribute("currentFaculty", loggedInFaculty); 
                        session.setAttribute("facultyId", loggedInFaculty.getId());
                        System.out.println("Successfully stored full Faculty object for: " + username);
                        System.out.println("Stored faculty ID: " + loggedInFaculty.getId());
                    } else {
                        System.out.println("WARNING: Faculty data not found in faculty table after successful login.");
                    }
                }
                
                System.out.println("Login SUCCESS - Redirecting to: " + role + " dashboard");
                
                // Step 4: Redirect based on role
                switch (role.toLowerCase()) {
                    case "admin":
                        response.sendRedirect("admin/dashboard.jsp");
                        break;
                    case "faculty":
                        response.sendRedirect("faculty/dashboard.jsp");
                        break;
                    case "student":
                        response.sendRedirect("student/dashboard.jsp");
                        break;
                    default:
                        response.sendRedirect("dashboard.jsp");
                }
            } else {
                System.out.println("Login FAILED - Invalid credentials");
                request.setAttribute("errorMessage", "Invalid username, password, or role");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("Login ERROR: " + e.getMessage());
            request.setAttribute("errorMessage", "Login failed due to a server error. Please try again.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }
    
    private User authenticateUser(String username, String password, String role) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        try {
            conn = DatabaseConnection.getConnection(); 
            System.out.println("Database connection: " + (conn != null ? "SUCCESS" : "FAILED"));
            
            if (conn == null) {
                System.out.println("Database connection is NULL!");
                return null;
            }
            
            String tableName = "";
            String sql = "";
            
            switch (role.toLowerCase()) {
                case "admin": 
                    tableName = "admins"; 
                    sql = "SELECT id, username, email FROM " + tableName + " WHERE username = ? AND password = ? AND status = 'active'";
                    break;
                case "faculty": 
                    tableName = "faculty"; 
                    sql = "SELECT id, username, email FROM " + tableName + " WHERE username = ? AND password = ? AND status = 'active'";
                    break;
                case "student": 
                    tableName = "students"; 
                    sql = "SELECT id, username, email, first_name, last_name, roll_number, department, semester FROM " + tableName + " WHERE username = ? AND password = ? AND status = 'active'";
                    break;
                default: 
                    System.out.println("Invalid role: " + role);
                    return null;
            }
            
            System.out.println("Executing SQL against table: " + tableName);
            
            try (PreparedStatement preparedStatement = conn.prepareStatement(sql)) {
                preparedStatement.setString(1, username);
                preparedStatement.setString(2, password);
                
                try (ResultSet resultSet = preparedStatement.executeQuery()) {
                    
                    if (resultSet.next()) {
                        System.out.println("User found in database!");
                        User user = new User();
                        user.setId(resultSet.getInt("id"));
                        user.setUsername(resultSet.getString("username"));
                        user.setEmail(resultSet.getString("email"));
                        user.setRole(role);
                        
                        if ("student".equals(role.toLowerCase())) {
                            user.setFirstName(resultSet.getString("first_name"));
                            user.setLastName(resultSet.getString("last_name"));
                            user.setRollNumber(resultSet.getString("roll_number"));
                            user.setDepartment(resultSet.getString("department"));
                            
                            try {
                                user.setSemester(resultSet.getString("semester"));
                            } catch (Exception e) {
                                user.setSemester("Not specified");
                            }
                            System.out.println("Student data loaded: " + user.getFirstName() + " " + user.getLastName());
                        }
                        
                        return user;
                    } else {
                        System.out.println("No user found with these credentials");
                        return null;
                    }
                }
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("Database error during authentication: " + e.getMessage());
            throw e;
        } finally {
            try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    }
}