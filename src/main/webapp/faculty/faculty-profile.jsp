<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    System.out.println("=== ACCESSING FACULTY PROFILE ===");
    System.out.println("Session ID: " + session.getId());
    System.out.println("All session attributes:");
    
    java.util.Enumeration<String> attrNames = session.getAttributeNames();
    boolean hasFacultyData = false;
    while (attrNames.hasMoreElements()) {
        String attrName = attrNames.nextElement();
        System.out.println(attrName + " = " + session.getAttribute(attrName));
        if (attrName.startsWith("faculty_")) {
            hasFacultyData = true;
        }
    }
    
    // Check if faculty is logged in - MULTIPLE CHECKS
    String facultyId = (String) session.getAttribute("faculty_id");
    System.out.println("Faculty ID from session: " + facultyId);
    
    if (facultyId == null) {
        System.out.println("=== REDIRECTING TO LOGIN ===");
        System.out.println("Reason: faculty_id is NULL in session");
        System.out.println("Has faculty data: " + hasFacultyData);
        response.sendRedirect("../login.jsp");
        return;
    }
    
    // Get faculty courses
    java.util.List<String> courses = new java.util.ArrayList<>();
    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;
    
    try {
        String url = "jdbc:mysql://localhost:3306/university";
        String dbUsername = "root";
        String dbPassword = "your_mysql_password_here"; // CHANGE THIS
        
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, dbUsername, dbPassword);
        
        String sql = "SELECT course_code, course_name FROM courses WHERE faculty_id = ? AND status = 'active'";
        stmt = conn.prepareStatement(sql);
        stmt.setInt(1, Integer.parseInt(facultyId));
        rs = stmt.executeQuery();
        
        while (rs.next()) {
            String course = rs.getString("course_code") + " - " + rs.getString("course_name");
            courses.add(course);
        }
        System.out.println("Found " + courses.size() + " courses for faculty ID: " + facultyId);
    } catch (Exception e) {
        System.out.println("Error getting courses: " + e.getMessage());
        e.printStackTrace();
    } finally {
        try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        try { if (stmt != null) stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Faculty Profile - ${faculty_firstName} ${faculty_lastName}</title>
    <style>
        /* Your existing CSS styles here */
        :root {
            --primary-color: #2c3e50;
            --secondary-color: #3498db;
            --accent-color: #e74c3c;
            --light-gray: #ecf0f1;
            --dark-gray: #7f8c8d;
        }
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            line-height: 1.6;
            color: #333;
            background-color: #f8f9fa;
        }
        
        .debug-info {
            background: #fff3cd;
            padding: 10px;
            margin: 10px;
            border-radius: 5px;
            border: 1px solid #ffeaa7;
            font-family: monospace;
            font-size: 12px;
        }
        
        .header {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: white;
            padding: 20px 0;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        
        .nav-container {
            max-width: 1200px;
            margin: 0 auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0 20px;
        }
        
        .logo {
            font-size: 1.5em;
            font-weight: bold;
        }
        
        .nav-links a {
            color: white;
            text-decoration: none;
            margin-left: 20px;
            padding: 5px 10px;
            border-radius: 3px;
            transition: background 0.3s;
        }
        
        .nav-links a:hover {
            background: rgba(255,255,255,0.2);
        }
        
        .profile-container {
            max-width: 1200px;
            margin: 30px auto;
            padding: 0 20px;
        }
        
        /* Rest of your CSS... */
    </style>
</head>
<body>
    <!-- Debug Information -->
    <div class="debug-info">
        <strong>Session Debug Info:</strong><br>
        Session ID: <%= session.getId() %><br>
        Faculty ID: <%= session.getAttribute("faculty_id") %><br>
        Faculty Name: ${faculty_firstName} ${faculty_lastName}<br>
        User Type: ${userType}<br>
        Session Created: <%= new java.util.Date(session.getCreationTime()) %><br>
        Last Accessed: <%= new java.util.Date(session.getLastAccessedTime()) %>
    </div>

    <!-- Header -->
    <div class="header">
        <div class="nav-container">
            <div class="logo">University Portal</div>
            <div class="nav-links">
                <span>Welcome, ${faculty_firstName}</span>
                <a href="../logout.jsp">Logout</a>
            </div>
        </div>
    </div>

    <!-- Rest of your profile content remains the same -->
    <div class="profile-container">
        <div class="profile-header">
            <div class="profile-image">
                ${faculty_firstName.charAt(0)}${faculty_lastName.charAt(0)}
            </div>
            <div class="profile-info">
                <h1>${faculty_firstName} ${faculty_lastName}</h1>
                <div class="title">${faculty_designation}</div>
                <div class="department">${faculty_department}</div>
                <div class="contact-info">
                    <div class="contact-item">
                        <span>📧</span>
                        <span>${faculty_email}</span>
                    </div>
                    <div class="contact-item">
                        <span>📞</span>
                        <span>${faculty_phone}</span>
                    </div>
                    <div class="contact-item">
                        <span>🆔</span>
                        <span>Employee ID: ${faculty_employeeId}</span>
                    </div>
                </div>
            </div>
        </div>

        <!-- Rest of profile content... -->
    </div>
</body>
</html>