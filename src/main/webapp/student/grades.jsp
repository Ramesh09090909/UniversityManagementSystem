<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Grades & Results - University Management System</title>
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

        .gpa-display {
            background: linear-gradient(135deg, var(--success), #2ecc71);
            color: white;
            padding: 1.5rem;
            border-radius: 10px;
            text-align: center;
            margin-bottom: 2rem;
            box-shadow: 0 4px 15px rgba(46, 204, 113, 0.3);
        }

        .gpa-label {
            font-size: 1rem;
            opacity: 0.9;
            margin-bottom: 0.5rem;
        }

        .gpa-value {
            font-size: 3rem;
            font-weight: bold;
            margin-bottom: 0.5rem;
        }

        .gpa-description {
            font-size: 0.9rem;
            opacity: 0.9;
        }

        .semester-selector {
            background: white;
            padding: 1.5rem;
            border-radius: 10px;
            box-shadow: 0 2px 20px rgba(0,0,0,0.1);
            margin-bottom: 2rem;
        }

        .semester-tabs {
            display: flex;
            gap: 0.5rem;
            flex-wrap: wrap;
        }

        .semester-tab {
            padding: 0.8rem 1.5rem;
            background: #f8f9fa;
            border: 1px solid #dee2e6;
            border-radius: 5px;
            cursor: pointer;
            transition: all 0.3s ease;
            font-weight: 500;
        }

        .semester-tab:hover {
            background: #e9ecef;
        }

        .semester-tab.active {
            background: var(--secondary);
            color: white;
            border-color: var(--secondary);
        }

        .grades-table {
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 20px rgba(0,0,0,0.1);
            overflow: hidden;
            margin-bottom: 2rem;
        }

        .table-header {
            background: var(--primary);
            color: white;
            padding: 1.5rem;
            font-weight: 600;
            font-size: 1.1rem;
        }

        .table-row {
            display: grid;
            grid-template-columns: 2fr 1fr 1fr 1fr 1fr;
            gap: 1rem;
            padding: 1.2rem 1.5rem;
            align-items: center;
            border-bottom: 1px solid #eee;
        }

        .table-row:last-child {
            border-bottom: none;
        }

        .table-row.header {
            background: var(--light);
            font-weight: 600;
            color: var(--dark);
        }

        .table-row:hover:not(.header) {
            background: #f8f9fa;
        }

        .grade-badge {
            padding: 0.4rem 0.8rem;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 600;
            text-align: center;
        }

        .grade-A { background: #e8f5e8; color: var(--success); }
        .grade-B { background: #fff3cd; color: var(--warning); }
        .grade-C { background: #ffeaa7; color: #e67e22; }
        .grade-D { background: #f8d7da; color: var(--danger); }
        .grade-F { background: #f5b7b1; color: #c0392b; }

        .grade-point {
            font-weight: 600;
            color: var(--primary);
        }

        .result-summary {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .summary-card {
            background: white;
            padding: 1.5rem;
            border-radius: 10px;
            box-shadow: 0 2px 20px rgba(0,0,0,0.1);
            text-align: center;
        }

        .summary-value {
            font-size: 2rem;
            font-weight: bold;
            color: var(--primary);
            margin-bottom: 0.5rem;
        }

        .summary-label {
            color: #666;
            font-size: 0.9rem;
        }

        .performance-chart {
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

        .chart-placeholder {
            background: var(--light);
            height: 200px;
            border-radius: 5px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #666;
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

        .action-buttons {
            display: flex;
            gap: 1rem;
            justify-content: flex-end;
            margin-top: 2rem;
        }

        @media (max-width: 768px) {
            .stats-grid, .result-summary {
                grid-template-columns: 1fr;
            }
            .table-row {
                grid-template-columns: 1fr;
                gap: 0.5rem;
            }
            .semester-tabs {
                flex-direction: column;
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
            <a href="courses.jsp" class="nav-item">
                <i>📚</i> My Courses
            </a>
            <a href="grades.jsp" class="nav-item active">
                <i>📝</i> Grades & Results
            </a>
            
        </div>

        <!-- Main Content -->
        <div class="main-content">
            <!-- Page Header -->
            <div class="page-header">
                <h2 class="page-title">Grades & Results</h2>
                <div>
                    <span style="color: #666; font-size: 0.9rem;">
                        Roll No: ${sessionScope.user.rollNumber} | Department: ${sessionScope.user.department}
                    </span>
                </div>
            </div>


            <!-- Semester Selector -->
            <div class="semester-selector">
                <h3 style="margin-bottom: 1rem; color: var(--primary);">Select Semester</h3>
                <div class="semester-tabs">
                    <div class="semester-tab active" onclick="showSemester('sem1')">Semester 1</div>
                    <div class="semester-tab" onclick="showSemester('sem2')">Semester 2</div>
                    <div class="semester-tab" onclick="showSemester('sem3')">Semester 3</div>
                    <div class="semester-tab" onclick="showSemester('sem4')">Semester 4</div>
                    <div class="semester-tab" onclick="showSemester('sem5')">Semester 5</div>
                    <div class="semester-tab" onclick="showSemester('sem6')">Semester 6</div>
                </div>
            </div>

            <!-- Current Semester Grades -->
            <div id="sem1" class="semester-grades">
                <div class="grades-table">
                    <div class="table-header">
                        📊 Semester 1 Results - ${sessionScope.user.department}
                    </div>
                    
                    <!-- Table Header -->
                    <div class="table-row header">
                        <div>Course Name</div>
                        <div>Course Code</div>
                        <div>Credits</div>
                        <div>Grade</div>
                        <div>Grade Points</div>
                    </div>

                    <!-- Course Grades -->
                    <c:choose>
                        <c:when test="${sessionScope.user.department == 'Computer Science'}">
                            <!-- CSE Grades -->
                            <div class="table-row">
                                <div>Programming Fundamentals</div>
                                <div>CSE-101</div>
                                <div>4</div>
                                <div><span class="grade-badge grade-A">A</span></div>
                                <div class="grade-point">4.0</div>
                            </div>
                            <div class="table-row">
                                <div>Mathematics I</div>
                                <div>MATH-101</div>
                                <div>4</div>
                                <div><span class="grade-badge grade-B">B+</span></div>
                                <div class="grade-point">3.5</div>
                            </div>
                            <div class="table-row">
                                <div>Physics</div>
                                <div>PHY-101</div>
                                <div>3</div>
                                <div><span class="grade-badge grade-A">A-</span></div>
                                <div class="grade-point">3.7</div>
                            </div>
                            <div class="table-row">
                                <div>English Communication</div>
                                <div>ENG-101</div>
                                <div>2</div>
                                <div><span class="grade-badge grade-A">A</span></div>
                                <div class="grade-point">4.0</div>
                            </div>
                            <div class="table-row">
                                <div>Engineering Drawing</div>
                                <div>ED-101</div>
                                <div>3</div>
                                <div><span class="grade-badge grade-B">B</span></div>
                                <div class="grade-point">3.0</div>
                            </div>
                        </c:when>

                        <c:when test="${sessionScope.user.department == 'Civil Engineering'}">
                            <!-- Civil Engineering Grades -->
                            <div class="table-row">
                                <div>Engineering Mechanics</div>
                                <div>CIV-101</div>
                                <div>4</div>
                                <div><span class="grade-badge grade-A">A-</span></div>
                                <div class="grade-point">3.7</div>
                            </div>
                            <div class="table-row">
                                <div>Civil Engineering Materials</div>
                                <div>CIV-102</div>
                                <div>3</div>
                                <div><span class="grade-badge grade-B">B+</span></div>
                                <div class="grade-point">3.5</div>
                            </div>
                            <div class="table-row">
                                <div>Mathematics I</div>
                                <div>MATH-101</div>
                                <div>4</div>
                                <div><span class="grade-badge grade-A">A</span></div>
                                <div class="grade-point">4.0</div>
                            </div>
                            <div class="table-row">
                                <div>Surveying</div>
                                <div>CIV-103</div>
                                <div>3</div>
                                <div><span class="grade-badge grade-B">B</span></div>
                                <div class="grade-point">3.0</div>
                            </div>
                        </c:when>

                        <c:when test="${sessionScope.user.department == 'Business Administration'}">
                            <!-- Business Administration Grades -->
                            <div class="table-row">
                                <div>Principles of Management</div>
                                <div>BUS-101</div>
                                <div>3</div>
                                <div><span class="grade-badge grade-A">A</span></div>
                                <div class="grade-point">4.0</div>
                            </div>
                            <div class="table-row">
                                <div>Business Economics</div>
                                <div>BUS-102</div>
                                <div>3</div>
                                <div><span class="grade-badge grade-A">A-</span></div>
                                <div class="grade-point">3.7</div>
                            </div>
                            <div class="table-row">
                                <div>Financial Accounting</div>
                                <div>BUS-103</div>
                                <div>4</div>
                                <div><span class="grade-badge grade-B">B+</span></div>
                                <div class="grade-point">3.5</div>
                            </div>
                            <div class="table-row">
                                <div>Business Mathematics</div>
                                <div>BUS-104</div>
                                <div>3</div>
                                <div><span class="grade-badge grade-A">A</span></div>
                                <div class="grade-point">4.0</div>
                            </div>
                        </c:when>

                        <c:otherwise>
                            <!-- Default Grades for other departments -->
                            <div class="table-row">
                                <div>Department Core I</div>
                                <div>DEP-101</div>
                                <div>4</div>
                                <div><span class="grade-badge grade-A">A-</span></div>
                                <div class="grade-point">3.7</div>
                            </div>
                            <div class="table-row">
                                <div>Department Core II</div>
                                <div>DEP-102</div>
                                <div>3</div>
                                <div><span class="grade-badge grade-B">B+</span></div>
                                <div class="grade-point">3.5</div>
                            </div>
                            <div class="table-row">
                                <div>Mathematics I</div>
                                <div>MATH-101</div>
                                <div>4</div>
                                <div><span class="grade-badge grade-A">A</span></div>
                                <div class="grade-point">4.0</div>
                            </div>
                            <div class="table-row">
                                <div>Professional Communication</div>
                                <div>COM-101</div>
                                <div>2</div>
                                <div><span class="grade-badge grade-A">A</span></div>
                                <div class="grade-point">4.0</div>
                            </div>
                        </c:otherwise>
                    </c:choose>

                    <!-- Semester Summary -->
                    <div class="table-row" style="background: #f8f9fa; font-weight: 600;">
                        <div>Semester Total</div>
                        <div>-</div>
                        <div>
                            <c:choose>
                                <c:when test="${sessionScope.user.department == 'Computer Science'}">16</c:when>
                                <c:when test="${sessionScope.user.department == 'Civil Engineering'}">14</c:when>
                                <c:when test="${sessionScope.user.department == 'Business Administration'}">13</c:when>
                                <c:otherwise>13</c:otherwise>
                            </c:choose>
                        </div>
                        <div>-</div>
                        <div>
                            <c:choose>
                                <c:when test="${sessionScope.user.department == 'Computer Science'}">3.64</c:when>
                                <c:when test="${sessionScope.user.department == 'Civil Engineering'}">3.55</c:when>
                                <c:when test="${sessionScope.user.department == 'Business Administration'}">3.80</c:when>
                                <c:otherwise>3.70</c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Result Summary -->
            <div class="result-summary">
                <div class="summary-card">
                    <div class="summary-value">First Class</div>
                    <div class="summary-label">Current Division</div>
                </div>
                <div class="summary-card">
                    <div class="summary-value">85%</div>
                    <div class="summary-label">Semester Percentage</div>
                </div>
                <div class="summary-card">
                    <div class="summary-value">Rank 12</div>
                    <div class="summary-label">Class Ranking</div>
                </div>
                <div class="summary-card">
                    <div class="summary-value">Excellent</div>
                    <div class="summary-label">Remarks</div>
                </div>
            </div>

            <!-- Performance Chart Placeholder -->
            <div class="performance-chart">
                <h3 class="chart-title">Academic Performance Trend</h3>
                <div class="chart-placeholder">
                    📈 Performance Chart Will Be Displayed Here
                </div>
            </div>

            <!-- Action Buttons -->
            <div class="action-buttons">
                <button class="btn btn-primary" onclick="window.print()">
                    <i>🖨️</i> Print Grade Sheet
                </button>
                <button class="btn btn-primary" onclick="downloadTranscript()">
                    <i>📥</i> Download Transcript
                </button>
            </div>
        </div>
    </div>

    <script>
        function showSemester(semesterId) {
            // Hide all semester grades
            document.querySelectorAll('.semester-grades').forEach(sem => {
                sem.style.display = 'none';
            });
            
            // Show selected semester
            document.getElementById(semesterId).style.display = 'block';
            
            // Update active tab
            document.querySelectorAll('.semester-tab').forEach(tab => {
                tab.classList.remove('active');
            });
            event.target.classList.add('active');
        }

        function downloadTranscript() {
            alert('Transcript download functionality will be implemented here!');
            // In actual implementation, generate and download PDF transcript
        }

        // Initialize with first semester
        document.addEventListener('DOMContentLoaded', function() {
            showSemester('sem1');
        });
    </script>
</body>
</html>