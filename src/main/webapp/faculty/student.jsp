<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="university.model.Student" %>
<%@ page import="university.dao.StudentDAO" %>
<%
    // Get all students from database using your existing StudentDAO
    StudentDAO studentDAO = new StudentDAO();
    List<Student> students = studentDAO.getAllStudents();
    
    // Get statistics
    int totalStudents = studentDAO.getTotalStudents();
    int activeStudents = studentDAO.getActiveStudentsCount();
    Map<String, Integer> deptStats = studentDAO.getStudentsByDepartment();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Management - Faculty Dashboard</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        body {
            background-color: #f5f7fa;
            color: #333;
        }
        
        .dashboard-container {
            display: flex;
            min-height: 100vh;
        }
        
        .sidebar {
            width: 250px;
            background: linear-gradient(180deg, #2c3e50, #1a2530);
            color: white;
            padding: 20px 0;
            box-shadow: 2px 0 10px rgba(0,0,0,0.1);
        }
        
        .sidebar-header {
            padding: 0 20px 20px;
            border-bottom: 1px solid rgba(255,255,255,0.1);
            margin-bottom: 20px;
        }
        
        .sidebar-header h2 {
            font-size: 1.5rem;
            font-weight: 600;
        }
        
        .sidebar-menu {
            list-style: none;
        }
        
        .sidebar-menu li {
            margin-bottom: 5px;
        }
        
        .sidebar-menu a {
            display: flex;
            align-items: center;
            padding: 12px 20px;
            color: #b0b7c3;
            text-decoration: none;
            transition: all 0.3s;
        }
        
        .sidebar-menu a:hover {
            background-color: rgba(255,255,255,0.1);
            color: white;
        }
        
        .sidebar-menu a.active {
            background-color: #3498db;
            color: white;
        }
        
        .sidebar-menu i {
            margin-right: 10px;
            width: 20px;
            text-align: center;
        }
        
        .main-content {
            flex: 1;
            padding: 20px;
        }
        
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            padding-bottom: 15px;
            border-bottom: 1px solid #e0e0e0;
        }
        
        .header h1 {
            color: #2c3e50;
            font-size: 1.8rem;
        }
        
        .user-info {
            display: flex;
            align-items: center;
            gap: 15px;
        }
        
        .user-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background-color: #3498db;
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
        }
        
        .logout-btn {
            background: #e74c3c;
            color: white;
            border: none;
            padding: 8px 15px;
            border-radius: 4px;
            cursor: pointer;
            text-decoration: none;
            font-size: 0.9rem;
        }
        
        .logout-btn:hover {
            background: #c0392b;
        }
        
        /* Student Management Styles */
        .students-container {
            background: white;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.1);
            overflow: hidden;
        }
        
        .students-header {
            background: linear-gradient(135deg, #2c3e50, #3498db);
            color: white;
            padding: 25px 30px;
        }
        
        .students-header h1 {
            font-size: 2rem;
            margin-bottom: 10px;
        }
        
        .students-header p {
            opacity: 0.9;
            font-size: 1.1rem;
        }
        
        .students-actions {
            background: #34495e;
            padding: 15px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 15px;
        }
        
        .search-box {
            display: flex;
            gap: 10px;
        }
        
        .search-input {
            padding: 8px 15px;
            border: 1px solid #bdc3c7;
            border-radius: 4px;
            width: 300px;
            font-size: 0.9rem;
        }
        
        .search-btn {
            background: #3498db;
            color: white;
            border: none;
            padding: 8px 15px;
            border-radius: 4px;
            cursor: pointer;
        }
        
        .filter-group {
            display: flex;
            gap: 10px;
            align-items: center;
        }
        
        .filter-select {
            padding: 8px 12px;
            border: 1px solid #bdc3c7;
            border-radius: 4px;
            background: white;
            font-size: 0.9rem;
        }
        
        .students-content {
            padding: 30px;
        }
        
        .students-stats {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }
        
        .stat-card {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 8px;
            text-align: center;
            border-left: 4px solid #3498db;
        }
        
        .stat-number {
            font-size: 2rem;
            font-weight: bold;
            color: #2c3e50;
            margin-bottom: 5px;
        }
        
        .stat-label {
            color: #7f8c8d;
            font-size: 0.9rem;
        }
        
        .students-table-container {
            overflow-x: auto;
        }
        
        .students-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            border-radius: 8px;
            overflow: hidden;
        }
        
        .students-table th {
            background: #2c3e50;
            color: white;
            padding: 15px;
            text-align: left;
            font-weight: 600;
            border: none;
        }
        
        .students-table td {
            padding: 15px;
            border-bottom: 1px solid #e0e0e0;
            vertical-align: middle;
        }
        
        .students-table tr:hover {
            background: #f8f9fa;
        }
        
        .students-table tr:last-child td {
            border-bottom: none;
        }
        
        .student-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: #3498db;
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            font-size: 1rem;
        }
        
        .student-name {
            font-weight: 600;
            color: #2c3e50;
        }
        
        .student-roll {
            color: #7f8c8d;
            font-size: 0.85rem;
        }
        
        .student-email {
            color: #3498db;
            font-size: 0.9rem;
        }
        
        .student-department {
            background: #ecf0f1;
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 0.8rem;
            color: #2c3e50;
        }
        
        .student-semester {
            background: #e8f4fd;
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 0.8rem;
            color: #3498db;
            text-align: center;
        }
        
        .student-status {
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 0.8rem;
            font-weight: 500;
            text-align: center;
        }
        
        .status-active {
            background: #d4edda;
            color: #155724;
        }
        
        .status-inactive {
            background: #f8d7da;
            color: #721c24;
        }
        
        .action-buttons {
            display: flex;
            gap: 8px;
        }
        
        .btn {
            padding: 6px 12px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 0.8rem;
            text-decoration: none;
            display: inline-block;
            text-align: center;
        }
        
        .btn-view {
            background: #3498db;
            color: white;
        }
        
        .btn-edit {
            background: #f39c12;
            color: white;
        }
        
        .btn-delete {
            background: #e74c3c;
            color: white;
        }
        
        .no-students {
            text-align: center;
            padding: 40px;
            color: #7f8c8d;
            font-size: 1.1rem;
        }
        
        @media (max-width: 768px) {
            .dashboard-container {
                flex-direction: column;
            }
            
            .sidebar {
                width: 100%;
            }
            
            .students-actions {
                flex-direction: column;
                align-items: stretch;
            }
            
            .search-box {
                width: 100%;
            }
            
            .search-input {
                width: 100%;
            }
            
            .action-buttons {
                flex-direction: column;
            }
            
            .students-table {
                font-size: 0.8rem;
            }
            
            .students-table th,
            .students-table td {
                padding: 8px 4px;
            }
        }
    </style>
</head>
<body>
    <div class="dashboard-container">
        <!-- Sidebar -->
        <div class="sidebar">
            <div class="sidebar-header">
                <h2>Faculty Portal</h2>
            </div>
            <ul class="sidebar-menu">
                <li><a href="dashboard.jsp"><i>📊</i> Dashboard</a></li>
                <li><a href="calender.jsp"><i>📅</i> Academic Calendar</a></li>
                <li><a href="my-course.jsp"><i>📚</i> My Courses</a></li>
                <li><a href="students.jsp" class="active"><i>👨‍🎓</i> Students</a></li>
            </ul>
        </div>
        
        <!-- Main Content -->
        <div class="main-content">
            <div class="header">
                <h1>Student Management</h1>
                <div class="user-info">
                    <div class="user-avatar">A12</div>
                    <span>Welcome, Ashish12</span>
                    <a href="logout.jsp" class="logout-btn">Logout</a>
                </div>
            </div>
            
            <!-- Students Container -->
            <div class="students-container">
                <!-- Header -->
                <div class="students-header">
                    <h1>Student Database</h1>
                    <p>Manage and view all registered students in the system</p>
                </div>
                
                <!-- Actions Bar -->
                <div class="students-actions">
                    <div class="search-box">
                        <input type="text" class="search-input" placeholder="Search students by name, roll number, or email...">
                        <button class="search-btn">Search</button>
                    </div>
                    <div class="filter-group">
                        <select class="filter-select" id="department-filter">
                            <option value="">All Departments</option>
                            <option value="Mechanical Engineering">Mechanical Engineering</option>
                            <option value="Civil Engineering">Civil Engineering</option>
                            <option value="Computer Science">Computer Science</option>
                            <option value="Electrical Engineering">Electrical Engineering</option>
                        </select>
                        <select class="filter-select" id="semester-filter">
                            <option value="">All Semesters</option>
                            <option value="1">Semester 1</option>
                            <option value="2">Semester 2</option>
                            <option value="3">Semester 3</option>
                            <option value="4">Semester 4</option>
                            <option value="5">Semester 5</option>
                            <option value="6">Semester 6</option>
                        </select>
                        <select class="filter-select" id="status-filter">
                            <option value="">All Status</option>
                            <option value="active">Active</option>
                            <option value="inactive">Inactive</option>
                        </select>
                    </div>
                </div>
                
                <!-- Content -->
                <div class="students-content">
                    <!-- Statistics -->
                    <div class="students-stats">
                        <div class="stat-card">
                            <div class="stat-number"><%= totalStudents %></div>
                            <div class="stat-label">Total Students</div>
                        </div>
                        <div class="stat-card">
                            <div class="stat-number"><%= activeStudents %></div>
                            <div class="stat-label">Active Students</div>
                        </div>
                        <div class="stat-card">
                            <div class="stat-number">
                                <%= deptStats.getOrDefault("Mechanical Engineering", 0) %>
                            </div>
                            <div class="stat-label">Mechanical Engineering</div>
                        </div>
                        <div class="stat-card">
                            <div class="stat-number">
                                <%= deptStats.getOrDefault("Civil Engineering", 0) %>
                            </div>
                            <div class="stat-label">Civil Engineering</div>
                        </div>
                    </div>
                    
                    <!-- Students Table -->
                    <div class="students-table-container">
                        <table class="students-table">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Student Name</th>
                                    <th>Username</th>
                                    <th>Email</th>
                                    <th>Roll Number</th>
                                    <th>Department</th>
                                    <th>Semester</th>
                                    <th>Status</th>
                                    
                                </tr>
                            </thead>
                            <tbody>
                                <% if (students != null && !students.isEmpty()) { %>
                                    <% for (Student student : students) { %>
                                        <tr>
                                            <td><%= student.getId() %></td>
                                            <td>
                                                <div style="display: flex; align-items: center; gap: 10px;">
                                                    <div class="student-avatar">
                                                        <%= student.getFirstName().charAt(0) %><%= student.getLastName().charAt(0) %>
                                                    </div>
                                                    <div>
                                                        <div class="student-name">
                                                            <%= student.getFirstName() %> <%= student.getLastName() %>
                                                        </div>
                                                    </div>
                                                </div>
                                            </td>
                                            <td><%= student.getUsername() %></td>
                                            <td>
                                                <div class="student-email"><%= student.getEmail() %></div>
                                            </td>
                                            <td>
                                                <div class="student-roll"><%= student.getRollNumber() %></div>
                                            </td>
                                            <td>
                                                <div class="student-department"><%= student.getDepartment() %></div>
                                            </td>
                                            <td>
                                                <div class="student-semester">Semester <%= student.getSemester() %></div>
                                            </td>
                                            <td>
                                                <div class="student-status <%= "active".equals(student.getStatus()) ? "status-active" : "status-inactive" %>">
                                                    <%= student.getStatus() != null ? student.getStatus() : "active" %>
                                                </div>
                                            </td>
                                            
                                        </tr>
                                    <% } %>
                                <% } else { %>
                                    <tr>
                                        <td colspan="9" class="no-students">
                                            No students found in the database.
                                        </td>
                                    </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        function viewStudent(studentId) {
            // Redirect to student details page
            window.location.href = 'student-details.jsp?id=' + studentId;
        }
        
        function editStudent(studentId) {
            // Redirect to edit student page
            window.location.href = 'edit-student.jsp?id=' + studentId;
        }
        
        function deleteStudent(studentId) {
            if (confirm('Are you sure you want to delete student with ID ' + studentId + '?')) {
                // Submit form to delete student
                const form = document.createElement('form');
                form.method = 'POST';
                form.action = 'DeleteStudentServlet';
                
                const input = document.createElement('input');
                input.type = 'hidden';
                input.name = 'studentId';
                input.value = studentId;
                
                form.appendChild(input);
                document.body.appendChild(form);
                form.submit();
            }
        }
        
        // Search functionality
        document.querySelector('.search-btn').addEventListener('click', function() {
            const searchTerm = document.querySelector('.search-input').value.trim();
            if (searchTerm) {
                window.location.href = 'students.jsp?search=' + encodeURIComponent(searchTerm);
            }
        });
        
        // Filter functionality
        document.getElementById('department-filter').addEventListener('change', function() {
            applyFilters();
        });
        
        document.getElementById('semester-filter').addEventListener('change', function() {
            applyFilters();
        });
        
        document.getElementById('status-filter').addEventListener('change', function() {
            applyFilters();
        });
        
        function applyFilters() {
            const department = document.getElementById('department-filter').value;
            const semester = document.getElementById('semester-filter').value;
            const status = document.getElementById('status-filter').value;
            
            let url = 'students.jsp?';
            const params = [];
            
            if (department) params.push('department=' + encodeURIComponent(department));
            if (semester) params.push('semester=' + encodeURIComponent(semester));
            if (status) params.push('status=' + encodeURIComponent(status));
            
            if (params.length > 0) {
                window.location.href = url + params.join('&');
            } else {
                window.location.href = 'students.jsp';
            }
        }
        
        // Enter key search
        document.querySelector('.search-input').addEventListener('keypress', function(e) {
            if (e.key === 'Enter') {
                document.querySelector('.search-btn').click();
            }
        });
    </script>
</body>
</html>