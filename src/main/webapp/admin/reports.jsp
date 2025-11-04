<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Reports & Analytics - University Management System</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
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

        .report-nav {
            background: white;
            padding: 1.5rem;
            border-radius: 10px;
            box-shadow: 0 2px 20px rgba(0,0,0,0.1);
            margin-bottom: 2rem;
        }

        .nav-tabs {
            display: flex;
            gap: 0.5rem;
            flex-wrap: wrap;
        }

        .nav-tab {
            padding: 0.8rem 1.5rem;
            background: #f8f9fa;
            border: 1px solid #dee2e6;
            border-radius: 5px;
            text-decoration: none;
            color: var(--dark);
            transition: all 0.3s ease;
            font-weight: 500;
        }

        .nav-tab:hover {
            background: #e9ecef;
        }

        .nav-tab.active {
            background: var(--secondary);
            color: white;
            border-color: var(--secondary);
        }

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
            border-left: 4px solid var(--secondary);
        }

        .stat-card h3 {
            color: var(--dark);
            font-size: 0.9rem;
            margin-bottom: 0.5rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .stat-number {
            font-size: 2.5rem;
            font-weight: bold;
            color: var(--primary);
            margin-bottom: 0.5rem;
        }

        .stat-description {
            color: #666;
            font-size: 0.9rem;
        }

        .chart-container {
            background: white;
            padding: 1.5rem;
            border-radius: 10px;
            box-shadow: 0 2px 20px rgba(0,0,0,0.1);
            margin-bottom: 2rem;
        }

        .chart-title {
            color: var(--primary);
            margin-bottom: 1rem;
            font-size: 1.2rem;
        }

        .data-table {
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 20px rgba(0,0,0,0.1);
            overflow: hidden;
            margin-bottom: 2rem;
        }

        .table-header {
            background: var(--primary);
            color: white;
            padding: 1rem;
            font-weight: 600;
        }

        .table-row {
            padding: 1rem;
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 1rem;
            align-items: center;
            border-bottom: 1px solid #eee;
        }

        .table-row:last-child {
            border-bottom: none;
        }

        .table-row:hover {
            background: #f8f9fa;
        }

        .alert {
            padding: 1rem;
            border-radius: 5px;
            margin-bottom: 1rem;
        }

        .alert-error {
            background: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }

        .recent-activities {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .activity-card {
            background: white;
            padding: 1.5rem;
            border-radius: 10px;
            box-shadow: 0 2px 20px rgba(0,0,0,0.1);
        }

        .activity-card h3 {
            color: var(--primary);
            margin-bottom: 1rem;
            font-size: 1.1rem;
        }

        .activity-item {
            padding: 0.8rem 0;
            border-bottom: 1px solid #eee;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .activity-item:last-child {
            border-bottom: none;
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

        .stat-card.students { border-left-color: #3498db; }
        .stat-card.faculty { border-left-color: #e74c3c; }
        .stat-card.courses { border-left-color: #27ae60; }
        .stat-card.enrollment { border-left-color: #f39c12; }

        @media (max-width: 768px) {
            .stats-grid {
                grid-template-columns: 1fr;
            }
            .nav-tabs {
                flex-direction: column;
            }
        }
    </style>
</head>
<body>
    <!-- Session Check -->
    <c:if test="${empty sessionScope.user or sessionScope.role ne 'admin'}">
        <c:redirect url="../login.jsp" />
    </c:if>

    <!-- Header -->
    <div class="header">
        <h1>University Management System</h1>
        <div class="user-info">
            <span>Welcome, Admin!</span>
            <a href="../logout" class="logout-btn">Logout</a>
        </div>
    </div>

    <!-- Main Container -->
    <div class="container">
        <!-- Sidebar -->
        <div class="sidebar">
            <a href="dashboard.jsp" class="nav-item">
                <i>📊</i> Dashboard
            </a>
            <a href="students.jsp" class="nav-item">
                <i>👨‍🎓</i> Manage Students
            </a>
            <a href="faculty.jsp" class="nav-item">
                <i>👨‍🏫</i> Manage Faculty
            </a>
            <a href="courses.jsp" class="nav-item">
                <i>📚</i> Courses
            </a>
            <a href="reports.jsp" class="nav-item active">
                <i>📈</i> Reports
            </a>
        </div>

        <!-- Main Content -->
        <div class="main-content">
            <!-- Page Header -->
            <div class="page-header">
                <h2 class="page-title">Reports & Analytics</h2>
                <div>
                    <button onclick="window.print()" class="btn btn-primary">Print Report</button>
                </div>
            </div>

            <!-- Error Messages -->
            <c:if test="${not empty errorMessage}">
                <div class="alert alert-error">❌ ${errorMessage}</div>
            </c:if>



            <c:choose>
                <c:when test="${empty reportType or reportType == 'dashboard'}">
                    <!-- Dashboard Overview -->
                    <div class="stats-grid">
                        <div class="stat-card students">
                            <h3>Total Students</h3>
                            <div class="stat-number">${reportData.totalStudents}</div>
                            <div class="stat-description">Registered in system</div>
                        </div>
                        <div class="stat-card faculty">
                            <h3>Total Faculty</h3>
                            <div class="stat-number">${reportData.totalFaculty}</div>
                            <div class="stat-description">Teaching staff</div>
                        </div>
                        <div class="stat-card courses">
                            <h3>Total Courses</h3>
                            <div class="stat-number">${reportData.totalCourses}</div>
                            <div class="stat-description">${reportData.activeCourses} active</div>
                        </div>
                        <div class="stat-card enrollment">
                            <h3>System Status</h3>
                            <div class="stat-number">Active</div>
                            <div class="stat-description">All systems operational</div>
                        </div>
                    </div>

                    <!-- Charts Section -->
                    <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 1.5rem; margin-bottom: 2rem;">
                        <div class="chart-container">
                            <h3 class="chart-title">Students by Department</h3>
                            <canvas id="studentsDeptChart"></canvas>
                        </div>
                        <div class="chart-container">
                            <h3 class="chart-title">Faculty by Department</h3>
                            <canvas id="facultyDeptChart"></canvas>
                        </div>
                    </div>

                    <div class="chart-container">
                        <h3 class="chart-title">Courses by Department</h3>
                        <canvas id="coursesDeptChart"></canvas>
                    </div>

                    <!-- Recent Activities -->
                    <div class="recent-activities">
                        <div class="activity-card">
                            <h3>Recent Students</h3>
                            <c:forEach var="student" items="${recentStudents}">
                                <div class="activity-item">
                                    <span>${student.firstName} ${student.lastName}</span>
                                    <small>${student.department}</small>
                                </div>
                            </c:forEach>
                        </div>
                        <div class="activity-card">
                            <h3>Recent Faculty</h3>
                            <c:forEach var="faculty" items="${recentFaculty}">
                                <div class="activity-item">
                                    <span>${faculty.firstName} ${faculty.lastName}</span>
                                    <small>${faculty.department}</small>
                                </div>
                            </c:forEach>
                        </div>
                        <div class="activity-card">
                            <h3>Recent Courses</h3>
                            <c:forEach var="course" items="${recentCourses}">
                                <div class="activity-item">
                                    <span>${course.courseCode}</span>
                                    <small>${course.courseName}</small>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </c:when>

                <c:when test="${reportType == 'students'}">
                    <!-- Students Report -->
                    <div class="stats-grid">
                        <div class="stat-card students">
                            <h3>Total Students</h3>
                            <div class="stat-number">${reportData.totalStudents}</div>
                            <div class="stat-description">All students</div>
                        </div>
                        <div class="stat-card students">
                            <h3>Active Students</h3>
                            <div class="stat-number">${reportData.activeStudents}</div>
                            <div class="stat-description">Currently enrolled</div>
                        </div>
                    </div>

                    <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 1.5rem; margin-bottom: 2rem;">
                        <div class="chart-container">
                            <h3 class="chart-title">Students by Department</h3>
                            <canvas id="studentsDeptChart"></canvas>
                        </div>
                        <div class="chart-container">
                            <h3 class="chart-title">Students by Status</h3>
                            <canvas id="studentsStatusChart"></canvas>
                        </div>
                    </div>

                    <div class="data-table">
                        <div class="table-header">Department-wise Student Distribution</div>
                        <c:forEach var="entry" items="${reportData.studentsByDepartment}">
                            <div class="table-row">
                                <div>${entry.key}</div>
                                <div>${entry.value} students</div>
                            </div>
                        </c:forEach>
                    </div>
                </c:when>

                <c:when test="${reportType == 'faculty'}">
                    <!-- Faculty Report -->
                    <div class="stats-grid">
                        <div class="stat-card faculty">
                            <h3>Total Faculty</h3>
                            <div class="stat-number">${reportData.totalFaculty}</div>
                            <div class="stat-description">All faculty members</div>
                        </div>
                        <div class="stat-card faculty">
                            <h3>Active Faculty</h3>
                            <div class="stat-number">${reportData.activeFaculty}</div>
                            <div class="stat-description">Currently teaching</div>
                        </div>
                    </div>

                    <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 1.5rem; margin-bottom: 2rem;">
                        <div class="chart-container">
                            <h3 class="chart-title">Faculty by Department</h3>
                            <canvas id="facultyDeptChart"></canvas>
                        </div>
                        <div class="chart-container">
                            <h3 class="chart-title">Faculty by Designation</h3>
                            <canvas id="facultyDesignationChart"></canvas>
                        </div>
                    </div>

                    <div class="data-table">
                        <div class="table-header">Department-wise Faculty Distribution</div>
                        <c:forEach var="entry" items="${reportData.facultyByDepartment}">
                            <div class="table-row">
                                <div>${entry.key}</div>
                                <div>${entry.value} faculty</div>
                            </div>
                        </c:forEach>
                    </div>
                </c:when>

                <c:when test="${reportType == 'courses'}">
                    <!-- Courses Report -->
                    <div class="stats-grid">
                        <div class="stat-card courses">
                            <h3>Total Courses</h3>
                            <div class="stat-number">${reportData.totalCourses}</div>
                            <div class="stat-description">All courses</div>
                        </div>
                        <div class="stat-card courses">
                            <h3>Active Courses</h3>
                            <div class="stat-number">${reportData.activeCourses}</div>
                            <div class="stat-description">Currently offered</div>
                        </div>
                    </div>

                    <div class="chart-container">
                        <h3 class="chart-title">Courses by Department</h3>
                        <canvas id="coursesDeptChart"></canvas>
                    </div>

                    <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 1.5rem; margin-bottom: 2rem;">
                        <div class="data-table">
                            <div class="table-header">Department-wise Course Distribution</div>
                            <c:forEach var="entry" items="${reportData.coursesByDepartment}">
                                <div class="table-row">
                                    <div>${entry.key}</div>
                                    <div>${entry.value} courses</div>
                                </div>
                            </c:forEach>
                        </div>
                        <div class="data-table">
                            <div class="table-header">Courses by Status</div>
                            <c:forEach var="entry" items="${reportData.coursesByStatus}">
                                <div class="table-row">
                                    <div>${entry.key}</div>
                                    <div>${entry.value} courses</div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </c:when>

                <c:when test="${reportType == 'enrollment'}">
                    <!-- Enrollment Report -->
                    <div class="stats-grid">
                        <c:forEach var="entry" items="${reportData.enrollmentStats}">
                            <div class="stat-card enrollment">
                                <h3>${entry.key}</h3>
                                <div class="stat-number">${entry.value}</div>
                                <div class="stat-description">Enrollment data</div>
                            </div>
                        </c:forEach>
                    </div>
                    <div class="chart-container">
                        <h3 class="chart-title">Enrollment Statistics</h3>
                        <p style="text-align: center; color: #666; padding: 2rem;">
                            Enrollment tracking will be available when student-course enrollment system is implemented.
                        </p>
                    </div>
                </c:when>
            </c:choose>
        </div>
    </div>

    <script>
        // Chart colors
        const chartColors = [
            '#3498db', '#e74c3c', '#27ae60', '#f39c12', '#9b59b6',
            '#1abc9c', '#d35400', '#c0392b', '#16a085', '#8e44ad'
        ];

        // Students by Department Chart
        <c:if test="${not empty reportData.studentsByDepartment}">
        const studentsDeptCtx = document.getElementById('studentsDeptChart')?.getContext('2d');
        if (studentsDeptCtx) {
            new Chart(studentsDeptCtx, {
                type: 'bar',
                data: {
                    labels: [<c:forEach var="entry" items="${reportData.studentsByDepartment}">'${entry.key}',</c:forEach>],
                    datasets: [{
                        label: 'Students',
                        data: [<c:forEach var="entry" items="${reportData.studentsByDepartment}">${entry.value},</c:forEach>],
                        backgroundColor: chartColors,
                        borderColor: chartColors,
                        borderWidth: 1
                    }]
                },
                options: {
                    responsive: true,
                    plugins: {
                        legend: { display: false }
                    }
                }
            });
        }
        </c:if>

        // Faculty by Department Chart
        <c:if test="${not empty reportData.facultyByDepartment}">
        const facultyDeptCtx = document.getElementById('facultyDeptChart')?.getContext('2d');
        if (facultyDeptCtx) {
            new Chart(facultyDeptCtx, {
                type: 'pie',
                data: {
                    labels: [<c:forEach var="entry" items="${reportData.facultyByDepartment}">'${entry.key}',</c:forEach>],
                    datasets: [{
                        data: [<c:forEach var="entry" items="${reportData.facultyByDepartment}">${entry.value},</c:forEach>],
                        backgroundColor: chartColors,
                        borderColor: '#fff',
                        borderWidth: 2
                    }]
                },
                options: {
                    responsive: true
                }
            });
        }
        </c:if>

        // Courses by Department Chart
        <c:if test="${not empty reportData.coursesByDepartment}">
        const coursesDeptCtx = document.getElementById('coursesDeptChart')?.getContext('2d');
        if (coursesDeptCtx) {
            new Chart(coursesDeptCtx, {
                type: 'doughnut',
                data: {
                    labels: [<c:forEach var="entry" items="${reportData.coursesByDepartment}">'${entry.key}',</c:forEach>],
                    datasets: [{
                        data: [<c:forEach var="entry" items="${reportData.coursesByDepartment}">${entry.value},</c:forEach>],
                        backgroundColor: chartColors,
                        borderColor: '#fff',
                        borderWidth: 2
                    }]
                },
                options: {
                    responsive: true
                }
            });
        }
        </c:if>

        // Students by Status Chart
        <c:if test="${not empty reportData.studentsByStatus}">
        const studentsStatusCtx = document.getElementById('studentsStatusChart')?.getContext('2d');
        if (studentsStatusCtx) {
            new Chart(studentsStatusCtx, {
                type: 'pie',
                data: {
                    labels: [<c:forEach var="entry" items="${reportData.studentsByStatus}">'${entry.key}',</c:forEach>],
                    datasets: [{
                        data: [<c:forEach var="entry" items="${reportData.studentsByStatus}">${entry.value},</c:forEach>],
                        backgroundColor: ['#27ae60', '#e74c3c'],
                        borderColor: '#fff',
                        borderWidth: 2
                    }]
                },
                options: {
                    responsive: true
                }
            });
        }
        </c:if>

        // Faculty by Designation Chart
        <c:if test="${not empty reportData.facultyByDesignation}">
        const facultyDesignationCtx = document.getElementById('facultyDesignationChart')?.getContext('2d');
        if (facultyDesignationCtx) {
            new Chart(facultyDesignationCtx, {
                type: 'bar',
                data: {
                    labels: [<c:forEach var="entry" items="${reportData.facultyByDesignation}">'${entry.key}',</c:forEach>],
                    datasets: [{
                        label: 'Faculty',
                        data: [<c:forEach var="entry" items="${reportData.facultyByDesignation}">${entry.value},</c:forEach>],
                        backgroundColor: chartColors,
                        borderColor: chartColors,
                        borderWidth: 1
                    }]
                },
                options: {
                    responsive: true,
                    plugins: {
                        legend: { display: false }
                    }
                }
            });
        }
        </c:if>
    </script>
</body>
</html>