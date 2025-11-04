<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Courses - University Management System</title>
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

        .department-badge {
            background: var(--info);
            color: white;
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-size: 0.9rem;
            font-weight: 500;
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .stat-card {
            background: white;
            padding: 1.5rem;
            border-radius: 10px;
            box-shadow: 0 2px 20px rgba(0,0,0,0.1);
            text-align: center;
            border-left: 4px solid var(--secondary);
        }

        .stat-number {
            font-size: 2.5rem;
            font-weight: bold;
            color: var(--primary);
            margin-bottom: 0.5rem;
        }

        .stat-label {
            color: #666;
            font-size: 0.9rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .courses-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .course-card {
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 20px rgba(0,0,0,0.1);
            overflow: hidden;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .course-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 25px rgba(0,0,0,0.15);
        }

        .course-header {
            background: linear-gradient(135deg, var(--primary), var(--secondary));
            color: white;
            padding: 1.5rem;
        }

        .course-code {
            font-size: 0.9rem;
            opacity: 0.9;
            margin-bottom: 0.5rem;
        }

        .course-name {
            font-size: 1.3rem;
            font-weight: 600;
            margin-bottom: 0.5rem;
        }

        .course-instructor {
            font-size: 0.9rem;
            opacity: 0.9;
        }

        .course-body {
            padding: 1.5rem;
        }

        .course-info {
            display: flex;
            justify-content: space-between;
            margin-bottom: 1rem;
            font-size: 0.9rem;
        }

        .course-info span {
            color: #666;
        }

        .course-type {
            background: var(--light);
            padding: 0.3rem 0.8rem;
            border-radius: 15px;
            font-size: 0.8rem;
            font-weight: 500;
        }

        .course-type.core {
            background: #e8f5e8;
            color: var(--success);
        }

        .course-type.elective {
            background: #fff3cd;
            color: var(--warning);
        }

        .course-type.lab {
            background: #e3f2fd;
            color: var(--info);
        }

        .course-schedule {
            background: var(--light);
            padding: 1rem;
            border-radius: 5px;
            margin-bottom: 1rem;
        }

        .schedule-item {
            display: flex;
            justify-content: space-between;
            margin-bottom: 0.5rem;
            font-size: 0.9rem;
        }

        .schedule-item:last-child {
            margin-bottom: 0;
        }

        .course-actions {
            display: flex;
            gap: 0.5rem;
        }

        .btn {
            padding: 0.5rem 1rem;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
            font-size: 0.8rem;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 0.3rem;
        }

        .btn-primary {
            background: var(--secondary);
            color: white;
        }

        .btn-primary:hover {
            background: #2980b9;
        }

        .btn-outline {
            background: transparent;
            border: 1px solid var(--secondary);
            color: var(--secondary);
        }

        .btn-outline:hover {
            background: var(--secondary);
            color: white;
        }

        .no-courses {
            text-align: center;
            padding: 3rem;
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 20px rgba(0,0,0,0.1);
        }

        .no-courses i {
            font-size: 3rem;
            margin-bottom: 1rem;
            opacity: 0.5;
        }

        .alert {
            padding: 1rem;
            border-radius: 5px;
            margin-bottom: 1rem;
        }

        .alert-info {
            background: #d1ecf1;
            color: #0c5460;
            border: 1px solid #bee5eb;
        }

        @media (max-width: 768px) {
            .courses-grid {
                grid-template-columns: 1fr;
            }
            .stats-grid {
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
            <a href="student-profile.jsp" class="nav-item">
                <i>👤</i> My Profile
            </a>
            <a href="courses.jsp" class="nav-item active">
                <i>📚</i> My Courses
            </a>
            <a href="grades.jsp" class="nav-item">
                <i>📝</i> Grades & Results
            </a>
            
        </div>

        <!-- Main Content -->
        <div class="main-content">
            <!-- Page Header -->
            <div class="page-header">
                <h2 class="page-title">My Courses</h2>
                <div>
                    <span class="department-badge">${sessionScope.user.department} Department</span>
                </div>
            </div>

            <!-- Department Specific Courses -->
            <c:choose>
                <c:when test="${sessionScope.user.department == 'Computer Science'}">
                    <!-- Computer Science Courses -->
                    <div class="stats-grid">
                        <div class="stat-card">
                            <div class="stat-number">6</div>
                            <div class="stat-label">Total Courses</div>
                        </div>
                        <div class="stat-card">
                            <div class="stat-number">18</div>
                            <div class="stat-label">Total Credits</div>
                        </div>
                        <div class="stat-card">
                            <div class="stat-number">4</div>
                            <div class="stat-label">Core Courses</div>
                        </div>
                        <div class="stat-card">
                            <div class="stat-number">2</div>
                            <div class="stat-label">Lab Courses</div>
                        </div>
                    </div>

                    <div class="alert alert-info">
                        <strong>💻 Computer Science Courses</strong> - Semester ${sessionScope.user.semester}
                    </div>

                    <div class="courses-grid">
                        <!-- CSE Course 1 -->
                        <div class="course-card">
                            <div class="course-header">
                                <div class="course-code">CSE-101</div>
                                <div class="course-name">Programming Fundamentals</div>
                                <div class="course-instructor">Dr. Smith</div>
                            </div>
                            <div class="course-body">
                                <div class="course-info">
                                    <span>Credits: 4</span>
                                    <span class="course-type core">Core</span>
                                </div>
                                <div class="course-schedule">
                                    <div class="schedule-item">
                                        <span>Mon, Wed, Fri</span>
                                        <span>9:00 - 10:00 AM</span>
                                    </div>
                                    <div class="schedule-item">
                                        <span>Room: CS-101</span>
                                        <span>Section: A</span>
                                    </div>
                                </div>
                                <div class="course-actions">
                                    <button class="btn btn-primary" onclick="viewCourseMaterials('CSE-101')">
                                        <i>📖</i> Materials
                                    </button>
                                    <button class="btn btn-outline" onclick="viewAssignments('CSE-101')">
                                        <i>📋</i> Assignments
                                    </button>
                                </div>
                            </div>
                        </div>

                        <!-- CSE Course 2 -->
                        <div class="course-card">
                            <div class="course-header">
                                <div class="course-code">CSE-201</div>
                                <div class="course-name">Data Structures</div>
                                <div class="course-instructor">Prof. Johnson</div>
                            </div>
                            <div class="course-body">
                                <div class="course-info">
                                    <span>Credits: 3</span>
                                    <span class="course-type core">Core</span>
                                </div>
                                <div class="course-schedule">
                                    <div class="schedule-item">
                                        <span>Tue, Thu</span>
                                        <span>11:00 - 12:30 PM</span>
                                    </div>
                                    <div class="schedule-item">
                                        <span>Room: CS-201</span>
                                        <span>Section: B</span>
                                    </div>
                                </div>
                                <div class="course-actions">
                                    <button class="btn btn-primary" onclick="viewCourseMaterials('CSE-201')">
                                        <i>📖</i> Materials
                                    </button>
                                    <button class="btn btn-outline" onclick="viewAssignments('CSE-201')">
                                        <i>📋</i> Assignments
                                    </button>
                                </div>
                            </div>
                        </div>

                        <!-- CSE Course 3 -->
                        <div class="course-card">
                            <div class="course-header">
                                <div class="course-code">CSE-301</div>
                                <div class="course-name">Database Management</div>
                                <div class="course-instructor">Dr. Brown</div>
                            </div>
                            <div class="course-body">
                                <div class="course-info">
                                    <span>Credits: 3</span>
                                    <span class="course-type core">Core</span>
                                </div>
                                <div class="course-schedule">
                                    <div class="schedule-item">
                                        <span>Mon, Wed</span>
                                        <span>2:00 - 3:30 PM</span>
                                    </div>
                                    <div class="schedule-item">
                                        <span>Room: CS-301</span>
                                        <span>Section: A</span>
                                    </div>
                                </div>
                                <div class="course-actions">
                                    <button class="btn btn-primary" onclick="viewCourseMaterials('CSE-301')">
                                        <i>📖</i> Materials
                                    </button>
                                    <button class="btn btn-outline" onclick="viewAssignments('CSE-301')">
                                        <i>📋</i> Assignments
                                    </button>
                                </div>
                            </div>
                        </div>

                        <!-- CSE Course 4 -->
                        <div class="course-card">
                            <div class="course-header">
                                <div class="course-code">CSE-401</div>
                                <div class="course-name">Web Technologies</div>
                                <div class="course-instructor">Prof. Davis</div>
                            </div>
                            <div class="course-body">
                                <div class="course-info">
                                    <span>Credits: 3</span>
                                    <span class="course-type core">Core</span>
                                </div>
                                <div class="course-schedule">
                                    <div class="schedule-item">
                                        <span>Tue, Fri</span>
                                        <span>10:00 - 11:30 AM</span>
                                    </div>
                                    <div class="schedule-item">
                                        <span>Room: CS-Lab</span>
                                        <span>Section: C</span>
                                    </div>
                                </div>
                                <div class="course-actions">
                                    <button class="btn btn-primary" onclick="viewCourseMaterials('CSE-401')">
                                        <i>📖</i> Materials
                                    </button>
                                    <button class="btn btn-outline" onclick="viewAssignments('CSE-401')">
                                        <i>📋</i> Assignments
                                    </button>
                                </div>
                            </div>
                        </div>

                        <!-- CSE Lab Course 1 -->
                        <div class="course-card">
                            <div class="course-header">
                                <div class="course-code">CSE-L101</div>
                                <div class="course-name">Programming Lab</div>
                                <div class="course-instructor">Dr. Wilson</div>
                            </div>
                            <div class="course-body">
                                <div class="course-info">
                                    <span>Credits: 2</span>
                                    <span class="course-type lab">Lab</span>
                                </div>
                                <div class="course-schedule">
                                    <div class="schedule-item">
                                        <span>Thursday</span>
                                        <span>1:00 - 4:00 PM</span>
                                    </div>
                                    <div class="schedule-item">
                                        <span>Room: CS-Lab-1</span>
                                        <span>Section: A</span>
                                    </div>
                                </div>
                                <div class="course-actions">
                                    <button class="btn btn-primary" onclick="viewCourseMaterials('CSE-L101')">
                                        <i>📖</i> Materials
                                    </button>
                                    <button class="btn btn-outline" onclick="viewAssignments('CSE-L101')">
                                        <i>📋</i> Assignments
                                    </button>
                                </div>
                            </div>
                        </div>

                        <!-- CSE Elective -->
                        <div class="course-card">
                            <div class="course-header">
                                <div class="course-code">CSE-E201</div>
                                <div class="course-name">Artificial Intelligence</div>
                                <div class="course-instructor">Dr. Taylor</div>
                            </div>
                            <div class="course-body">
                                <div class="course-info">
                                    <span>Credits: 3</span>
                                    <span class="course-type elective">Elective</span>
                                </div>
                                <div class="course-schedule">
                                    <div class="schedule-item">
                                        <span>Wednesday</span>
                                        <span>3:00 - 6:00 PM</span>
                                    </div>
                                    <div class="schedule-item">
                                        <span>Room: CS-401</span>
                                        <span>Section: A</span>
                                    </div>
                                </div>
                                <div class="course-actions">
                                    <button class="btn btn-primary" onclick="viewCourseMaterials('CSE-E201')">
                                        <i>📖</i> Materials
                                    </button>
                                    <button class="btn btn-outline" onclick="viewAssignments('CSE-E201')">
                                        <i>📋</i> Assignments
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:when>

                <c:when test="${sessionScope.user.department == 'Civil Engineering'}">
                    <!-- Civil Engineering Courses -->
                    <div class="stats-grid">
                        <div class="stat-card">
                            <div class="stat-number">5</div>
                            <div class="stat-label">Total Courses</div>
                        </div>
                        <div class="stat-card">
                            <div class="stat-number">16</div>
                            <div class="stat-label">Total Credits</div>
                        </div>
                        <div class="stat-card">
                            <div class="stat-number">4</div>
                            <div class="stat-label">Core Courses</div>
                        </div>
                        <div class="stat-card">
                            <div class="stat-number">1</div>
                            <div class="stat-label">Lab Course</div>
                        </div>
                    </div>

                    <div class="alert alert-info">
                        <strong>🏗️ Civil Engineering Courses</strong> - Semester ${sessionScope.user.semester}
                    </div>

                    <div class="courses-grid">
                        <!-- Civil Course 1 -->
                        <div class="course-card">
                            <div class="course-header">
                                <div class="course-code">CIV-101</div>
                                <div class="course-name">Structural Analysis</div>
                                <div class="course-instructor">Dr. Anderson</div>
                            </div>
                            <div class="course-body">
                                <div class="course-info">
                                    <span>Credits: 4</span>
                                    <span class="course-type core">Core</span>
                                </div>
                                <div class="course-schedule">
                                    <div class="schedule-item">
                                        <span>Mon, Wed, Fri</span>
                                        <span>8:00 - 9:00 AM</span>
                                    </div>
                                    <div class="schedule-item">
                                        <span>Room: CIV-101</span>
                                        <span>Section: A</span>
                                    </div>
                                </div>
                                <div class="course-actions">
                                    <button class="btn btn-primary" onclick="viewCourseMaterials('CIV-101')">
                                        <i>📖</i> Materials
                                    </button>
                                    <button class="btn btn-outline" onclick="viewAssignments('CIV-101')">
                                        <i>📋</i> Assignments
                                    </button>
                                </div>
                            </div>
                        </div>

                        <!-- Civil Course 2 -->
                        <div class="course-card">
                            <div class="course-header">
                                <div class="course-code">CIV-201</div>
                                <div class="course-name">Concrete Technology</div>
                                <div class="course-instructor">Prof. Clark</div>
                            </div>
                            <div class="course-body">
                                <div class="course-info">
                                    <span>Credits: 3</span>
                                    <span class="course-type core">Core</span>
                                </div>
                                <div class="course-schedule">
                                    <div class="schedule-item">
                                        <span>Tue, Thu</span>
                                        <span>10:00 - 11:30 AM</span>
                                    </div>
                                    <div class="schedule-item">
                                        <span>Room: CIV-201</span>
                                        <span>Section: B</span>
                                    </div>
                                </div>
                                <div class="course-actions">
                                    <button class="btn btn-primary" onclick="viewCourseMaterials('CIV-201')">
                                        <i>📖</i> Materials
                                    </button>
                                    <button class="btn btn-outline" onclick="viewAssignments('CIV-201')">
                                        <i>📋</i> Assignments
                                    </button>
                                </div>
                            </div>
                        </div>

                        <!-- Civil Course 3 -->
                        <div class="course-card">
                            <div class="course-header">
                                <div class="course-code">CIV-301</div>
                                <div class="course-name">Geotechnical Engineering</div>
                                <div class="course-instructor">Dr. White</div>
                            </div>
                            <div class="course-body">
                                <div class="course-info">
                                    <span>Credits: 3</span>
                                    <span class="course-type core">Core</span>
                                </div>
                                <div class="course-schedule">
                                    <div class="schedule-item">
                                        <span>Mon, Wed</span>
                                        <span>1:00 - 2:30 PM</span>
                                    </div>
                                    <div class="schedule-item">
                                        <span>Room: CIV-301</span>
                                        <span>Section: A</span>
                                    </div>
                                </div>
                                <div class="course-actions">
                                    <button class="btn btn-primary" onclick="viewCourseMaterials('CIV-301')">
                                        <i>📖</i> Materials
                                    </button>
                                    <button class="btn btn-outline" onclick="viewAssignments('CIV-301')">
                                        <i>📋</i> Assignments
                                    </button>
                                </div>
                            </div>
                        </div>

                        <!-- Civil Course 4 -->
                        <div class="course-card">
                            <div class="course-header">
                                <div class="course-code">CIV-401</div>
                                <div class="course-name">Transportation Engineering</div>
                                <div class="course-instructor">Prof. Harris</div>
                            </div>
                            <div class="course-body">
                                <div class="course-info">
                                    <span>Credits: 3</span>
                                    <span class="course-type core">Core</span>
                                </div>
                                <div class="course-schedule">
                                    <div class="schedule-item">
                                        <span>Tue, Fri</span>
                                        <span>11:00 - 12:30 PM</span>
                                    </div>
                                    <div class="schedule-item">
                                        <span>Room: CIV-401</span>
                                        <span>Section: C</span>
                                    </div>
                                </div>
                                <div class="course-actions">
                                    <button class="btn btn-primary" onclick="viewCourseMaterials('CIV-401')">
                                        <i>📖</i> Materials
                                    </button>
                                    <button class="btn btn-outline" onclick="viewAssignments('CIV-401')">
                                        <i>📋</i> Assignments
                                    </button>
                                </div>
                            </div>
                        </div>

                        <!-- Civil Lab Course -->
                        <div class="course-card">
                            <div class="course-header">
                                <div class="course-code">CIV-L101</div>
                                <div class="course-name">Surveying Lab</div>
                                <div class="course-instructor">Dr. Martin</div>
                            </div>
                            <div class="course-body">
                                <div class="course-info">
                                    <span>Credits: 3</span>
                                    <span class="course-type lab">Lab</span>
                                </div>
                                <div class="course-schedule">
                                    <div class="schedule-item">
                                        <span>Thursday</span>
                                        <span>2:00 - 5:00 PM</span>
                                    </div>
                                    <div class="schedule-item">
                                        <span>Room: CIV-Lab</span>
                                        <span>Section: A</span>
                                    </div>
                                </div>
                                <div class="course-actions">
                                    <button class="btn btn-primary" onclick="viewCourseMaterials('CIV-L101')">
                                        <i>📖</i> Materials
                                    </button>
                                    <button class="btn btn-outline" onclick="viewAssignments('CIV-L101')">
                                        <i>📋</i> Assignments
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:when>

                <c:when test="${sessionScope.user.department == 'Business Administration'}">
                    <!-- Business Administration Courses -->
                    <div class="stats-grid">
                        <div class="stat-card">
                            <div class="stat-number">5</div>
                            <div class="stat-label">Total Courses</div>
                        </div>
                        <div class="stat-card">
                            <div class="stat-number">15</div>
                            <div class="stat-label">Total Credits</div>
                        </div>
                        <div class="stat-card">
                            <div class="stat-number">4</div>
                            <div class="stat-label">Core Courses</div>
                        </div>
                        <div class="stat-card">
                            <div class="stat-number">1</div>
                            <div class="stat-label">Elective Course</div>
                        </div>
                    </div>

                    <div class="alert alert-info">
                        <strong>💼 Business Administration Courses</strong> - Semester ${sessionScope.user.semester}
                    </div>

                    <div class="courses-grid">
                        <!-- Business Course 1 -->
                        <div class="course-card">
                            <div class="course-header">
                                <div class="course-code">BUS-101</div>
                                <div class="course-name">Principles of Management</div>
                                <div class="course-instructor">Dr. Roberts</div>
                            </div>
                            <div class="course-body">
                                <div class="course-info">
                                    <span>Credits: 3</span>
                                    <span class="course-type core">Core</span>
                                </div>
                                <div class="course-schedule">
                                    <div class="schedule-item">
                                        <span>Mon, Wed</span>
                                        <span>9:30 - 11:00 AM</span>
                                    </div>
                                    <div class="schedule-item">
                                        <span>Room: BUS-101</span>
                                        <span>Section: A</span>
                                    </div>
                                </div>
                                <div class="course-actions">
                                    <button class="btn btn-primary" onclick="viewCourseMaterials('BUS-101')">
                                        <i>📖</i> Materials
                                    </button>
                                    <button class="btn btn-outline" onclick="viewAssignments('BUS-101')">
                                        <i>📋</i> Assignments
                                    </button>
                                </div>
                            </div>
                        </div>

                        <!-- Business Course 2 -->
                        <div class="course-card">
                            <div class="course-header">
                                <div class="course-code">BUS-201</div>
                                <div class="course-name">Financial Accounting</div>
                                <div class="course-instructor">Prof. Lee</div>
                            </div>
                            <div class="course-body">
                                <div class="course-info">
                                    <span>Credits: 3</span>
                                    <span class="course-type core">Core</span>
                                </div>
                                <div class="course-schedule">
                                    <div class="schedule-item">
                                        <span>Tue, Thu</span>
                                        <span>10:00 - 11:30 AM</span>
                                    </div>
                                    <div class="schedule-item">
                                        <span>Room: BUS-201</span>
                                        <span>Section: B</span>
                                    </div>
                                </div>
                                <div class="course-actions">
                                    <button class="btn btn-primary" onclick="viewCourseMaterials('BUS-201')">
                                        <i>📖</i> Materials
                                    </button>
                                    <button class="btn btn-outline" onclick="viewAssignments('BUS-201')">
                                        <i>📋</i> Assignments
                                    </button>
                                </div>
                            </div>
                        </div>

                        <!-- Business Course 3 -->
                        <div class="course-card">
                            <div class="course-header">
                                <div class="course-code">BUS-301</div>
                                <div class="course-name">Marketing Management</div>
                                <div class="course-instructor">Dr. Garcia</div>
                            </div>
                            <div class="course-body">
                                <div class="course-info">
                                    <span>Credits: 3</span>
                                    <span class="course-type core">Core</span>
                                </div>
                                <div class="course-schedule">
                                    <div class="schedule-item">
                                        <span>Mon, Fri</span>
                                        <span>1:00 - 2:30 PM</span>
                                    </div>
                                    <div class="schedule-item">
                                        <span>Room: BUS-301</span>
                                        <span>Section: A</span>
                                    </div>
                                </div>
                                <div class="course-actions">
                                    <button class="btn btn-primary" onclick="viewCourseMaterials('BUS-301')">
                                        <i>📖</i> Materials
                                    </button>
                                    <button class="btn btn-outline" onclick="viewAssignments('BUS-301')">
                                        <i>📋</i> Assignments
                                    </button>
                                </div>
                            </div>
                        </div>

                        <!-- Business Course 4 -->
                        <div class="course-card">
                            <div class="course-header">
                                <div class="course-code">BUS-401</div>
                                <div class="course-name">Business Statistics</div>
                                <div class="course-instructor">Prof. Martinez</div>
                            </div>
                            <div class="course-body">
                                <div class="course-info">
                                    <span>Credits: 3</span>
                                    <span class="course-type core">Core</span>
                                </div>
                                <div class="course-schedule">
                                    <div class="schedule-item">
                                        <span>Wed, Thu</span>
                                        <span>11:00 - 12:30 PM</span>
                                    </div>
                                    <div class="schedule-item">
                                        <span>Room: BUS-401</span>
                                        <span>Section: C</span>
                                    </div>
                                </div>
                                <div class="course-actions">
                                    <button class="btn btn-primary" onclick="viewCourseMaterials('BUS-401')">
                                        <i>📖</i> Materials
                                    </button>
                                    <button class="btn btn-outline" onclick="viewAssignments('BUS-401')">
                                        <i>📋</i> Assignments
                                    </button>
                                </div>
                            </div>
                        </div>

                        <!-- Business Elective -->
                        <div class="course-card">
                            <div class="course-header">
                                <div class="course-code">BUS-E101</div>
                                <div class="course-name">Entrepreneurship</div>
                                <div class="course-instructor">Dr. Thompson</div>
                            </div>
                            <div class="course-body">
                                <div class="course-info">
                                    <span>Credits: 3</span>
                                    <span class="course-type elective">Elective</span>
                                </div>
                                <div class="course-schedule">
                                    <div class="schedule-item">
                                        <span>Tuesday</span>
                                        <span>3:00 - 6:00 PM</span>
                                    </div>
                                    <div class="schedule-item">
                                        <span>Room: BUS-501</span>
                                        <span>Section: A</span>
                                    </div>
                                </div>
                                <div class="course-actions">
                                    <button class="btn btn-primary" onclick="viewCourseMaterials('BUS-E101')">
                                        <i>📖</i> Materials
                                    </button>
                                    <button class="btn btn-outline" onclick="viewAssignments('BUS-E101')">
                                        <i>📋</i> Assignments
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:when>

                <c:otherwise>
                    <!-- Default/Other Departments -->
                    <div class="stats-grid">
                        <div class="stat-card">
                            <div class="stat-number">4</div>
                            <div class="stat-label">Total Courses</div>
                        </div>
                        <div class="stat-card">
                            <div class="stat-number">12</div>
                            <div class="stat-label">Total Credits</div>
                        </div>
                        <div class="stat-card">
                            <div class="stat-number">3</div>
                            <div class="stat-label">Core Courses</div>
                        </div>
                        <div class="stat-card">
                            <div class="stat-number">1</div>
                            <div class="stat-label">Elective Course</div>
                        </div>
                    </div>

                    <div class="alert alert-info">
                        <strong>📚 ${sessionScope.user.department} Courses</strong> - Semester ${sessionScope.user.semester}
                    </div>

                    <div class="courses-grid">
                        <!-- Generic Course 1 -->
                        <div class="course-card">
                            <div class="course-header">
                                <div class="course-code">GEN-101</div>
                                <div class="course-name">Department Core I</div>
                                <div class="course-instructor">Department Faculty</div>
                            </div>
                            <div class="course-body">
                                <div class="course-info">
                                    <span>Credits: 3</span>
                                    <span class="course-type core">Core</span>
                                </div>
                                <div class="course-schedule">
                                    <div class="schedule-item">
                                        <span>Mon, Wed</span>
                                        <span>9:00 - 10:30 AM</span>
                                    </div>
                                    <div class="schedule-item">
                                        <span>Room: MAIN-101</span>
                                        <span>Section: A</span>
                                    </div>
                                </div>
                                <div class="course-actions">
                                    <button class="btn btn-primary" onclick="viewCourseMaterials('GEN-101')">
                                        <i>📖</i> Materials
                                    </button>
                                    <button class="btn btn-outline" onclick="viewAssignments('GEN-101')">
                                        <i>📋</i> Assignments
                                    </button>
                                </div>
                            </div>
                        </div>

                        <!-- Generic Course 2 -->
                        <div class="course-card">
                            <div class="course-header">
                                <div class="course-code">GEN-201</div>
                                <div class="course-name">Department Core II</div>
                                <div class="course-instructor">Department Faculty</div>
                            </div>
                            <div class="course-body">
                                <div class="course-info">
                                    <span>Credits: 3</span>
                                    <span class="course-type core">Core</span>
                                </div>
                                <div class="course-schedule">
                                    <div class="schedule-item">
                                        <span>Tue, Thu</span>
                                        <span>11:00 - 12:30 PM</span>
                                    </div>
                                    <div class="schedule-item">
                                        <span>Room: MAIN-201</span>
                                        <span>Section: B</span>
                                    </div>
                                </div>
                                <div class="course-actions">
                                    <button class="btn btn-primary" onclick="viewCourseMaterials('GEN-201')">
                                        <i>📖</i> Materials
                                    </button>
                                    <button class="btn btn-outline" onclick="viewAssignments('GEN-201')">
                                        <i>📋</i> Assignments
                                    </button>
                                </div>
                            </div>
                        </div>

                        <!-- Generic Course 3 -->
                        <div class="course-card">
                            <div class="course-header">
                                <div class="course-code">GEN-301</div>
                                <div class="course-name">Department Core III</div>
                                <div class="course-instructor">Department Faculty</div>
                            </div>
                            <div class="course-body">
                                <div class="course-info">
                                    <span>Credits: 3</span>
                                    <span class="course-type core">Core</span>
                                </div>
                                <div class="course-schedule">
                                    <div class="schedule-item">
                                        <span>Mon, Fri</span>
                                        <span>2:00 - 3:30 PM</span>
                                    </div>
                                    <div class="schedule-item">
                                        <span>Room: MAIN-301</span>
                                        <span>Section: A</span>
                                    </div>
                                </div>
                                <div class="course-actions">
                                    <button class="btn btn-primary" onclick="viewCourseMaterials('GEN-301')">
                                        <i>📖</i> Materials
                                    </button>
                                    <button class="btn btn-outline" onclick="viewAssignments('GEN-301')">
                                        <i>📋</i> Assignments
                                    </button>
                                </div>
                            </div>
                        </div>

                        <!-- Generic Elective -->
                        <div class="course-card">
                            <div class="course-header">
                                <div class="course-code">GEN-E101</div>
                                <div class="course-name">Department Elective</div>
                                <div class="course-instructor">Department Faculty</div>
                            </div>
                            <div class="course-body">
                                <div class="course-info">
                                    <span>Credits: 3</span>
                                    <span class="course-type elective">Elective</span>
                                </div>
                                <div class="course-schedule">
                                    <div class="schedule-item">
                                        <span>Wednesday</span>
                                        <span>3:00 - 6:00 PM</span>
                                    </div>
                                    <div class="schedule-item">
                                        <span>Room: MAIN-401</span>
                                        <span>Section: A</span>
                                    </div>
                                </div>
                                <div class="course-actions">
                                    <button class="btn btn-primary" onclick="viewCourseMaterials('GEN-E101')">
                                        <i>📖</i> Materials
                                    </button>
                                    <button class="btn btn-outline" onclick="viewAssignments('GEN-E101')">
                                        <i>📋</i> Assignments
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <script>
        function viewCourseMaterials(courseCode) {
            alert('Opening course materials for: ' + courseCode);
            // window.location.href = 'course-materials.jsp?course=' + courseCode;
        }

        function viewAssignments(courseCode) {
            alert('Viewing assignments for: ' + courseCode);
            // window.location.href = 'assignments.jsp?course=' + courseCode;
        }

        // Auto-hide alerts after 5 seconds
        setTimeout(function() {
            document.querySelectorAll('.alert').forEach(alert => {
                alert.style.display = 'none';
            });
        }, 5000);
    </script>
</body>
</html>