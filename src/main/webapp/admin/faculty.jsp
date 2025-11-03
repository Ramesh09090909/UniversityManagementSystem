<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manage Faculty - University Management System</title>
    <style>
        /* Add the same CSS styles from students.jsp here */
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

        .btn-success {
            background: var(--success);
            color: white;
        }

        .btn-warning {
            background: var(--warning);
            color: white;
        }

        .btn-danger {
            background: var(--danger);
            color: white;
        }

        .btn-info {
            background: #17a2b8;
            color: white;
        }

        .search-section {
            background: white;
            padding: 1.5rem;
            border-radius: 10px;
            box-shadow: 0 2px 20px rgba(0,0,0,0.1);
            margin-bottom: 2rem;
        }

        .search-form {
            display: grid;
            grid-template-columns: 2fr 1fr 1fr auto auto;
            gap: 1rem;
            align-items: end;
        }

        .form-group {
            display: flex;
            flex-direction: column;
        }

        .form-group label {
            margin-bottom: 0.5rem;
            font-weight: 600;
            color: var(--dark);
        }

        .form-control {
            padding: 0.7rem;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 0.9rem;
        }

        .faculty-table {
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 20px rgba(0,0,0,0.1);
            overflow: hidden;
        }

        .table-header {
            background: var(--primary);
            color: white;
            padding: 1rem;
            display: grid;
            grid-template-columns: 0.5fr 1fr 2fr 2fr 2fr 1fr 1fr 1fr auto;
            gap: 1rem;
            font-weight: 600;
        }

        .table-row {
            padding: 1rem;
            display: grid;
            grid-template-columns: 0.5fr 1fr 2fr 2fr 2fr 1fr 1fr 1fr auto;
            gap: 1rem;
            align-items: center;
            border-bottom: 1px solid #eee;
            transition: background 0.3s ease;
        }

        .table-row:hover {
            background: #f8f9fa;
        }

        .table-row:last-child {
            border-bottom: none;
        }

        .action-buttons {
            display: flex;
            gap: 0.5rem;
        }

        .btn-sm {
            padding: 0.4rem 0.8rem;
            font-size: 0.8rem;
        }

        .status-badge {
            padding: 0.3rem 0.8rem;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 600;
        }

        .status-active {
            background: #d4edda;
            color: #155724;
        }

        .status-inactive {
            background: #f8d7da;
            color: #721c24;
        }

        .no-data {
            text-align: center;
            padding: 3rem;
            color: #666;
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

        .view-form {
            background: white;
            padding: 1.5rem;
            border-radius: 10px;
            box-shadow: 0 2px 20px rgba(0,0,0,0.1);
            margin-bottom: 2rem;
            display: flex;
            gap: 1rem;
            align-items: end;
        }
        
        .btn-secondary {
            background: #6c757d;
            color: white;
        }
        
        .btn-secondary:hover {
            background: #5a6268;
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
            <a href="student.jsp" class="nav-item">
                <i>👨‍🎓</i> Manage Students
            </a>
            <a href="faculty.jsp" class="nav-item active">
                <i>👨‍🏫</i> Manage Faculty
            </a>
            <a href="courses.jsp" class="nav-item">
                <i>📚</i> Courses
            </a>

        </div>

        <!-- Main Content -->
        <div class="main-content">
            <!-- Page Header -->
            <div class="page-header">
                <h2 class="page-title">Faculty Management</h2>
                <a href="${pageContext.request.contextPath}/FacultyServlet?action=new" class="btn btn-primary">Add New Faculty</a>
            </div>

            <!-- Success/Error Messages -->
            <c:if test="${not empty successMessage}">
                <div class="alert alert-success">✅ ${successMessage}</div>
            </c:if>
            <c:if test="${not empty errorMessage}">
                <div class="alert alert-error">❌ ${errorMessage}</div>
            </c:if>

            <!-- View Faculty by Employee ID -->
            <div class="view-form">
                <form action="${pageContext.request.contextPath}/FacultyServlet" method="get" class="search-form" style="grid-template-columns: 2fr auto; width: 100%;">
                    <input type="hidden" name="action" value="view">
                    <div class="form-group">
                        <label for="employeeId">View Faculty by Employee ID</label>
                        <input type="text" id="employeeId" name="employeeId" class="form-control" 
                               placeholder="Enter Employee ID (e.g., EMP001)" required>
                    </div>
                    <div class="form-group">
                        <label>&nbsp;</label>
                        <button type="submit" class="btn btn-info">View Faculty</button>
                    </div>
                </form>
            </div>


            <!-- Faculty Table -->
            <div class="faculty-table">
                <div class="table-header">
                    <div>ID</div>
                    <div>Emp ID</div>
                    <div>Name</div>
                    <div>Email</div>
                    <div>Department</div>
                    <div>Designation</div>
                    <div>Phone</div>
                    <div>Status</div>
                    <div>Actions</div>
                </div>

                <c:choose>
                    <c:when test="${not empty facultyList}">
                        <c:forEach var="faculty" items="${facultyList}">
                            <div class="table-row">
                                <div>${faculty.id}</div>
                                <div>
                                    <strong>${faculty.employeeId}</strong>
                                </div>
                                <div>${faculty.firstName} ${faculty.lastName}</div>
                                <div>${faculty.email}</div>
                                <div>${faculty.department}</div>
                                <div>${faculty.designation}</div>
                                <div>${faculty.phone}</div>
                                <div>
                                    <span class="status-badge ${faculty.status == 'active' ? 'status-active' : 'status-inactive'}">
                                        ${faculty.status}
                                    </span>
                                </div>
                                <div class="action-buttons">
                                    <a href="${pageContext.request.contextPath}/FacultyServlet?action=edit&id=${faculty.id}" class="btn btn-warning btn-sm">
                                        Edit
                                    </a>
                                    <a href="${pageContext.request.contextPath}/FacultyServlet?action=delete&id=${faculty.id}" class="btn btn-danger btn-sm" 
                                       onclick="return confirm('Are you sure you want to delete this faculty member?')">
                                        Delete
                                    </a>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="no-data">
                            <p>No faculty members found.</p>
                            <c:if test="${empty param.search and empty param.department and empty param.designation}">
                                <a href="${pageContext.request.contextPath}/FacultyServlet?action=new" class="btn btn-primary">Add First Faculty Member</a>
                            </c:if>
                            <c:if test="${not empty param.search or not empty param.department or not empty param.designation}">
                                <p style="color: #666; margin-top: 10px;">Try different search criteria</p>
                            </c:if>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

    <script>
        // Auto-hide success/error messages after 5 seconds
        setTimeout(function() {
            const alerts = document.querySelectorAll('.alert');
            alerts.forEach(alert => {
                alert.style.display = 'none';
            });
        }, 5000);

        // Focus on employee ID field
        document.getElementById('employeeId')?.focus();
    </script>
</body>
</html>