<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Faculty Dashboard - University Management System</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        :root {
            --primary: #2c3e50;
            --secondary: #3498db;
            --success: #27ae60;
            --warning: #f39c12;
            --danger: #e74c3c;
            --light: #ecf0f1;
            --dark: #2c3e50;
        }

        body {
            background-color: #f5f6fa;
        }

        /* Header Styles */
        .header {
            background: linear-gradient(135deg, var(--primary), var(--secondary));
            color: white;
            padding: 1rem 2rem;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .header h1 {
            font-size: 1.8rem;
            font-weight: 600;
        }

        .user-info {
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .logout-btn {
            background: rgba(255,255,255,0.2);
            color: white;
            border: 1px solid rgba(255,255,255,0.3);
            padding: 0.5rem 1rem;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
            transition: all 0.3s ease;
        }

        .logout-btn:hover {
            background: rgba(255,255,255,0.3);
        }

        /* Main Layout */
        .container {
            display: flex;
            min-height: calc(100vh - 80px);
        }

        /* Sidebar */
        .sidebar {
            width: 250px;
            background: white;
            box-shadow: 2px 0 10px rgba(0,0,0,0.1);
            padding: 2rem 0;
        }

        .nav-item {
            padding: 1rem 2rem;
            color: var(--dark);
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 0.8rem;
            transition: all 0.3s ease;
            border-left: 4px solid transparent;
        }

        .nav-item:hover, .nav-item.active {
            background: var(--light);
            border-left-color: var(--secondary);
            color: var(--secondary);
        }

        /* Main Content */
        .main-content {
            flex: 1;
            padding: 2rem;
        }

        .welcome-section {
            background: white;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 2px 20px rgba(0,0,0,0.1);
            margin-bottom: 2rem;
        }

        .welcome-section h2 {
            color: var(--primary);
            margin-bottom: 0.5rem;
        }

        .welcome-section p {
            color: #666;
            line-height: 1.6;
        }

        /* Statistics Cards */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .stat-card {
            background: white;
            padding: 1.5rem;
            border-radius: 10px;
            box-shadow: 0 2px 20px rgba(0,0,0,0.1);
            text-align: center;
            transition: transform 0.3s ease;
        }

        .stat-card:hover {
            transform: translateY(-5px);
        }

        .stat-card.courses {
            border-top: 4px solid var(--success);
        }

        .stat-card.students {
            border-top: 4px solid var(--secondary);
        }

        .stat-card.assignments {
            border-top: 4px solid var(--warning);
        }

        .stat-card.grading {
            border-top: 4px solid var(--danger);
        }

        .stat-number {
            font-size: 2.5rem;
            font-weight: bold;
            color: var(--dark);
            display: block;
        }

        .stat-label {
            color: #666;
            font-size: 0.9rem;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        /* Quick Actions */
        .quick-actions {
            background: white;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 2px 20px rgba(0,0,0,0.1);
        }

        .quick-actions h3 {
            color: var(--primary);
            margin-bottom: 1.5rem;
            padding-bottom: 0.5rem;
            border-bottom: 2px solid var(--light);
        }

        .action-buttons {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1rem;
        }

        .action-btn {
            background: var(--light);
            color: var(--dark);
            padding: 1rem;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            text-align: center;
            text-decoration: none;
            transition: all 0.3s ease;
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 0.5rem;
        }

        .action-btn:hover {
            background: var(--secondary);
            color: white;
            transform: translateY(-2px);
        }

        .action-btn i {
            font-size: 1.5rem;
        }

        /* Faculty Info */
        .faculty-info {
            background: white;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 2px 20px rgba(0,0,0,0.1);
            margin-bottom: 2rem;
        }

        .info-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1rem;
            margin-top: 1rem;
        }

        .info-item {
            padding: 1rem;
            background: #f8f9fa;
            border-radius: 5px;
        }

        .info-label {
            font-weight: 600;
            color: var(--dark);
            display: block;
        }

        .info-value {
            color: #666;
        }

        /* Recent Activity */
        .recent-activity {
            background: white;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 2px 20px rgba(0,0,0,0.1);
            margin-top: 2rem;
        }

        .recent-activity h3 {
            color: var(--primary);
            margin-bottom: 1.5rem;
            padding-bottom: 0.5rem;
            border-bottom: 2px solid var(--light);
        }

        .activity-list {
            list-style: none;
        }

        .activity-item {
            padding: 1rem;
            border-left: 4px solid var(--secondary);
            background: var(--light);
            margin-bottom: 0.5rem;
            border-radius: 0 5px 5px 0;
        }

        .activity-time {
            color: #666;
            font-size: 0.8rem;
            float: right;
        }
    </style>
</head>
<body>
    <!-- Session Check -->
    <c:if test="${empty sessionScope.user or sessionScope.role ne 'faculty'}">
        <c:redirect url="../login.jsp" />
    </c:if>

    <!-- Header -->
    <div class="header">
        <h1>University Management System</h1>
        <div class="user-info">
            <span>Welcome, Faculty!</span>
            <a href="../logout" class="logout-btn">Logout</a>
        </div>
    </div>

    <!-- Main Container -->
    <div class="container">
        <!-- Sidebar -->
        <div class="sidebar">
            <a href="dashboard.jsp" class="nav-item active">
                <i>📊</i> Dashboard
            </a>
            
            <a href="calender.jsp" class="nav-item ">
                <i>📅</i> Academic Calender
            </a>
            <a href="my-course.jsp" class="nav-item">
                <i>📚</i> My Courses
            </a>
            <a href="student.jsp" class="nav-item">
                <i>👨‍🎓</i> Students
            </a>
            

        </div>
        
        <!-- Main Content -->
        <div class="main-content">
            <!-- Welcome Section -->
            <div class="welcome-section">
                <h2>Welcome to Faculty Dashboard</h2>
                <p>Hello, ${sessionScope.username}! Manage your courses, track student progress, and handle academic activities from this dashboard.</p>
            </div>

            <!-- Faculty Information -->
            <div class="faculty-info">
                <h3>Faculty Information</h3>
                <div class="info-grid">
                    <div class="info-item">
                        <span class="info-label">Department:</span>
                        <span class="info-value">Computer Science</span>
                    </div>
                    <div class="info-item">
                        <span class="info-label">Position:</span>
                        <span class="info-value">Professor</span>
                    </div>
                    <div class="info-item">
                        <span class="info-label">Email:</span>
                        <span class="info-value">${sessionScope.username}@university.edu</span>
                    </div>
                    <div class="info-item">
                        <span class="info-label">Office:</span>
                        <span class="info-value">CS Building, Room 301</span>
                    </div>
                </div>
            </div>
            <!-- Recent Activity -->
            <div class="recent-activity">
                <h3>Recent Activity</h3>
                <ul class="activity-list">
                    <li class="activity-item">
                        Grades submitted for Data Structures Midterm
                        <span class="activity-time">3 hours ago</span>
                    </li>
                    <li class="activity-item">
                        New assignment created: Web Development Project
                        <span class="activity-time">1 day ago</span>
                    </li>
                    <li class="activity-item">
                        Attendance marked for Algorithms class
                        <span class="activity-time">2 days ago</span>
                    </li>
                    <li class="activity-item">
                        Course material updated for Database Systems
                        <span class="activity-time">3 days ago</span>
                    </li>
                </ul>
            </div>
        </div>
    </div>

    <script>
        // Simple statistics update
        function updateDashboard() {
            console.log("Updating faculty dashboard...");
        }

        // Update every 30 seconds
        setInterval(updateDashboard, 30000);
        updateDashboard();
    </script>
</body>
</html>