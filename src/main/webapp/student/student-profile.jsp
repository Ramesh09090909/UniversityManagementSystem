<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Student Profile - University Management System</title>
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
            --info: #17a2b8;
            --light: #ecf0f1;
            --dark: #2c3e50;
        }

        body {
            background-color: #f5f6fa;
        }

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

        .container {
            display: flex;
            min-height: calc(100vh - 80px);
        }

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

        .main-content {
            flex: 1;
            padding: 2rem;
        }

        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
        }

        .page-title {
            color: var(--primary);
            font-size: 1.8rem;
        }

        .profile-container {
            display: grid;
            grid-template-columns: 300px 1fr;
            gap: 2rem;
        }

        .profile-sidebar {
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 20px rgba(0,0,0,0.1);
            padding: 2rem;
            text-align: center;
        }

        .profile-picture {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            background: linear-gradient(135deg, var(--secondary), var(--primary));
            margin: 0 auto 1.5rem;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 3rem;
            font-weight: bold;
        }

        .student-name {
            font-size: 1.5rem;
            font-weight: 600;
            color: var(--primary);
            margin-bottom: 0.5rem;
        }

        .student-id {
            color: #666;
            margin-bottom: 1.5rem;
        }

        .profile-details {
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 20px rgba(0,0,0,0.1);
            padding: 2rem;
        }

        .section-title {
            color: var(--primary);
            font-size: 1.3rem;
            margin-bottom: 1.5rem;
            padding-bottom: 0.5rem;
            border-bottom: 2px solid var(--light);
        }

        .info-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .info-card {
            background: var(--light);
            padding: 1.5rem;
            border-radius: 8px;
            border-left: 4px solid var(--secondary);
        }

        .info-label {
            font-size: 0.9rem;
            color: #666;
            margin-bottom: 0.5rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .info-value {
            font-size: 1.1rem;
            font-weight: 600;
            color: var(--primary);
        }

        .department-card {
            background: var(--light);
            padding: 1.5rem;
            border-radius: 8px;
            border-left: 4px solid var(--success);
            margin-bottom: 1.5rem;
        }

        .department-label {
            font-size: 0.9rem;
            color: #666;
            margin-bottom: 0.5rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .department-value {
            font-size: 1.3rem;
            font-weight: 700;
            color: var(--success);
        }

        .btn {
            padding: 0.7rem 1.5rem;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
            font-size: 0.9rem;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }

        .btn-primary {
            background: var(--secondary);
            color: white;
        }

        .btn-primary:hover {
            background: #2980b9;
        }

        .alert {
            padding: 1rem;
            border-radius: 5px;
            margin-bottom: 1rem;
        }

        .alert-success {
            background: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }

        .alert-error {
            background: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }

        .view-only-badge {
            background: var(--info);
            color: white;
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-size: 0.8rem;
            display: inline-block;
            margin-bottom: 1rem;
        }

        @media (max-width: 768px) {
            .profile-container {
                grid-template-columns: 1fr;
            }
            .info-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <!-- Session Check for Student -->
    <c:if test="${empty sessionScope.user or sessionScope.role ne 'student'}">
        <c:redirect url="../login.jsp" />
    </c:if>

    <!-- Header -->
    <div class="header">
        <h1>University Management System</h1>
        <div class="user-info">
            <span>Welcome, ${sessionScope.user.firstName}!</span>
            <a href="../logout" class="logout-btn">Logout</a>
        </div>
    </div>

    <!-- Main Container -->
    <div class="container">
        <!-- Sidebar Navigation -->
        <div class="sidebar">
            <a href="dashboard.jsp" class="nav-item">
                <i>📊</i> Dashboard
            </a>
            <a href="student-profile.jsp" class="nav-item active">
                <i>👤</i> My Profile
            </a>
            <a href="courses.jsp" class="nav-item">
                <i>📚</i> My Courses
            </a>
            <a href="grades.jsp" class="nav-item">
                <i>📝</i> Grades & Results
            </a>

            <a href="Holiday.jsp" class="nav-item">
                <i>📋</i> Holiday
            </a>
        </div>

        <!-- Main Content -->
        <div class="main-content">
            <!-- Page Header -->
            <div class="page-header">
                <h2 class="page-title">My Profile</h2>
                <div>
                    <span class="view-only-badge">👁️ View Only - Contact Admin for Updates</span>
                    <button class="btn btn-primary" onclick="window.print()">
                        <i>🖨️</i> Print Profile
                    </button>
                </div>
            </div>

            <!-- Success/Error Messages -->
            <c:if test="${not empty successMessage}">
                <div class="alert alert-success">✅ ${successMessage}</div>
            </c:if>
            <c:if test="${not empty errorMessage}">
                <div class="alert alert-error">❌ ${errorMessage}</div>
            </c:if>

            <!-- Profile Content -->
            <div class="profile-container">
                <!-- Profile Sidebar -->
                <div class="profile-sidebar">
                    <div class="profile-picture">
                        <c:choose>
                            <c:when test="${not empty sessionScope.user.firstName and not empty sessionScope.user.lastName}">
                                ${sessionScope.user.firstName.charAt(0)}${sessionScope.user.lastName.charAt(0)}
                            </c:when>
                            <c:otherwise>
                                👤
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <h3 class="student-name">
                        <c:choose>
                            <c:when test="${not empty sessionScope.user.firstName and not empty sessionScope.user.lastName}">
                                ${sessionScope.user.firstName} ${sessionScope.user.lastName}
                            </c:when>
                            <c:otherwise>
                                ${sessionScope.user.username}
                            </c:otherwise>
                        </c:choose>
                    </h3>
                    <p class="student-id">
                        <c:choose>
                            <c:when test="${not empty sessionScope.user.rollNumber}">
                                ${sessionScope.user.rollNumber}
                            </c:when>
                            <c:when test="${not empty sessionScope.user.username}">
                                ${sessionScope.user.username}
                            </c:when>
                            <c:otherwise>
                                Student ID
                            </c:otherwise>
                        </c:choose>
                    </p>
                    <div class="student-status">
                        <span style="background: var(--success); color: white; padding: 0.3rem 0.8rem; border-radius: 20px; font-size: 0.8rem;">
                            ✅ Active Student
                        </span>
                    </div>
                </div>

                <!-- Profile Details -->
                <div class="profile-details">
                    <!-- Personal Information -->
                    <h3 class="section-title">Personal Information</h3>
                    <div class="info-grid">
                        <div class="info-card">
                            <div class="info-label">Full Name</div>
                            <div class="info-value">
                                <c:choose>
                                    <c:when test="${not empty sessionScope.user.firstName and not empty sessionScope.user.lastName}">
                                        ${sessionScope.user.firstName} ${sessionScope.user.lastName}
                                    </c:when>
                                    <c:otherwise>
                                        Not available
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                        <div class="info-card">
                            <div class="info-label">Student ID / Roll Number</div>
                            <div class="info-value">
                                <c:choose>
                                    <c:when test="${not empty sessionScope.user.rollNumber}">
                                        ${sessionScope.user.rollNumber}
                                    </c:when>
                                    <c:otherwise>
                                        Not assigned
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                        <div class="info-card">
                            <div class="info-label">Email Address</div>
                            <div class="info-value">
                                <c:choose>
                                    <c:when test="${not empty sessionScope.user.email}">
                                        ${sessionScope.user.email}
                                    </c:when>
                                    <c:otherwise>
                                        Not available
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>

                    <!-- Academic Information -->
                    <h3 class="section-title">Academic Information</h3>
                    
                    <!-- Department Card (Highlighted) -->
                    <div class="department-card">
                        <div class="department-label">Department</div>
                        <div class="department-value">
                            <c:choose>
                                <c:when test="${not empty sessionScope.user.department}">
                                    ${sessionScope.user.department}
                                </c:when>
                                <c:otherwise>
                                    Not assigned
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                    
                    <!-- Other Academic Details -->
                    <div class="info-grid">
                        <div class="info-card">
                            <div class="info-label">Program</div>
                            <div class="info-value">
                                <c:choose>
                                    <c:when test="${not empty sessionScope.user.program}">
                                        ${sessionScope.user.program}
                                    </c:when>
                                    <c:otherwise>
                                        Not assigned
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                        <div class="info-card">
                            <div class="info-label">Semester</div>
                            <div class="info-value">
                                <c:choose>
                                    <c:when test="${not empty sessionScope.user.semester}">
                                        ${sessionScope.user.semester}
                                    </c:when>
                                    <c:otherwise>
                                        Not assigned
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                        <div class="info-card">
                            <div class="info-label">Academic Year</div>
                            <div class="info-value">
                                <c:choose>
                                    <c:when test="${not empty sessionScope.user.academicYear}">
                                        ${sessionScope.user.academicYear}
                                    </c:when>
                                    <c:otherwise>
                                        Not assigned
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        // Auto-hide alerts after 5 seconds
        setTimeout(function() {
            document.querySelectorAll('.alert').forEach(alert => {
                alert.style.display = 'none';
            });
        }, 5000);
    </script>
</body>
</html>