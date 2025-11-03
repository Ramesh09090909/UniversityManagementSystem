<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>University Management System - Student Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        .header-section {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 2rem 0;
            margin-bottom: 2rem;
        }
        .card {
            border: none;
            box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.15);
            margin-bottom: 1.5rem;
            border-radius: 0.5rem;
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
        }
        .card-header {
            background-color: #f5f6fa;
            border-bottom: 1px solid #e3e6f0;
            font-weight: 600;
            padding: 1rem 1.5rem;
        }
        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            border-radius: 0.35rem;
        }
        .btn-primary:hover {
            background: linear-gradient(135deg, #5a6fd8 0%, #6a4190 100%);
            transform: translateY(-1px);
        }
        .table th {
            border-top: none;
            font-weight: 600;
            color: #6e707e;
            background-color: #f8f9fc;
            padding: 1rem 0.75rem;
        }
        .table td {
            padding: 1rem 0.75rem;
            vertical-align: middle;
        }
        .search-box {
            border: 1px solid #e3e6f0;
            border-radius: 0.35rem;
            padding: 0.75rem;
        }
        .navbar-brand {
            font-weight: 700;
        }
        .avatar-sm {
            width: 32px;
            height: 32px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 600;
        }
    </style>
</head>
<body>
    <!-- Navigation Bar -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container-fluid">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/admin/dashboard.jsp">
                <i class="fas fa-university me-2"></i>University Management System
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/admin/dashboard.jsp">
                            <i class="fas fa-tachometer-alt me-1"></i>Dashboard
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="${pageContext.request.contextPath}/admin/students">
                            <i class="fas fa-users me-1"></i>Students
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/admin/faculty">
                            <i class="fas fa-chalkboard-teacher me-1"></i>Faculty
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/admin/courses">
                            <i class="fas fa-book me-1"></i>Courses
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/ReportServlet">
                            <i class="fas fa-chart-bar me-1"></i>Reports
                        </a>
                    </li>
                </ul>
                <ul class="navbar-nav">
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown">
                            <i class="fas fa-user-circle me-1"></i>Admin
                        </a>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href="#"><i class="fas fa-user me-2"></i>Profile</a></li>
                            <li><a class="dropdown-item" href="#"><i class="fas fa-cog me-2"></i>Settings</a></li>
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/LogoutServlet">
                                <i class="fas fa-sign-out-alt me-2"></i>Logout</a>
                            </li>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Header Section -->
    <div class="header-section">
        <div class="container-fluid">
            <div class="row align-items-center">
                <div class="col">
                    <h1 class="h2 mb-1">Student Management</h1>
                    <p class="mb-0 opacity-75">Manage student records, enrollments, and information</p>
                </div>
                <div class="col-auto">
                    <a href="students?action=new" class="btn btn-light">
                        <i class="fas fa-plus me-2"></i> Add New Student
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/dashboard.jsp" class="btn btn-outline-light ms-2">
                        <i class="fas fa-arrow-left me-2"></i> Back to Dashboard
                    </a>
                </div>
            </div>
        </div>
    </div>

    <div class="container-fluid">
        <!-- Messages -->
        <c:if test="${not empty param.message}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="fas fa-check-circle me-2"></i>${param.message}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <c:if test="${not empty param.error}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="fas fa-exclamation-circle me-2"></i>${param.error}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <!-- Student Lookup Card -->
        <div class="card">
            <div class="card-header">
                <h5 class="mb-0"><i class="fas fa-search me-2"></i>View Student by Roll Number</h5>
            </div>
            <div class="card-body">
                <form action="students" method="get" class="row g-3 align-items-end">
                    <input type="hidden" name="action" value="search">
                    <div class="col-md-8">
                        <label class="form-label fw-bold">Enter Roll Number</label>
                        <input type="text" name="keyword" class="form-control search-box" 
                               placeholder="Enter student roll number (e.g., ROLL001)" value="${searchKeyword}">
                    </div>
                    <div class="col-md-4">
                        <button type="submit" class="btn btn-primary w-100 py-2">
                            <i class="fas fa-search me-2"></i>Search Student
                        </button>
                    </div>
                </form>
            </div>
        </div>

        <!-- Search Students Card -->
        <div class="card">
            <div class="card-header d-flex justify-content-between align-items-center">
                <h5 class="mb-0"><i class="fas fa-users me-2"></i>All Students</h5>
                <span class="badge bg-primary fs-6">${students.size()} students</span>
            </div>
            
                <!-- Students Table -->
                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Roll No.</th>
                                <th>Name</th>
                                <th>Username</th>
                                <th>Email</th>
                                <th>Department</th>
                                <th>Semester</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="student" items="${students}">
                                <tr>
                                    <td><strong>#${student.id}</strong></td>
                                    <td>
                                        <span class="badge bg-dark fs-6">${student.rollNumber}</span>
                                    </td>
                                    <td>
                                        <div class="d-flex align-items-center">
                                            <div class="avatar-sm bg-primary rounded-circle me-3">
                                                <span class="text-white">${student.firstName.charAt(0)}</span>
                                            </div>
                                            <div>
                                                <div class="fw-bold">${student.firstName} ${student.lastName}</div>
                                                <small class="text-muted">${student.department}</small>
                                            </div>
                                        </div>
                                    </td>
                                    <td>${student.username}</td>
                                    <td>${student.email}</td>
                                    <td>
                                        <span class="badge bg-light text-dark border">${student.department}</span>
                                    </td>
                                    <td>
                                        <span class="badge bg-info">Semester ${student.semester}</span>
                                    </td>
                                    <td>
                                        <span class="badge ${student.status == 'active' ? 'bg-success' : 'bg-danger'}">
                                            <i class="fas fa-circle me-1" style="font-size: 0.5rem;"></i>
                                            ${student.status}
                                        </span>
                                    </td>
                                    <td>
                                        <div class="btn-group" role="group">
                                            <a href="students?action=edit&id=${student.id}" 
                                               class="btn btn-sm btn-outline-primary" 
                                               data-bs-toggle="tooltip" title="Edit Student">
                                                <i class="fas fa-edit"></i>
                                            </a>
                                            <a href="students?action=delete&id=${student.id}" 
                                               class="btn btn-sm btn-outline-danger" 
                                               onclick="return confirm('Are you sure you want to delete ${student.firstName} ${student.lastName}?')"
                                               data-bs-toggle="tooltip" title="Delete Student">
                                                <i class="fas fa-trash"></i>
                                            </a>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty students}">
                                <tr>
                                    <td colspan="9" class="text-center py-5">
                                        <div class="text-muted">
                                            <i class="fas fa-users fa-4x mb-3 opacity-25"></i>
                                            <h4>No Students Found</h4>
                                            <p class="mb-4">There are no students in the system yet.</p>
                                            <a href="students?action=new" class="btn btn-primary btn-lg">
                                                <i class="fas fa-user-plus me-2"></i>Add First Student
                                            </a>
                                        </div>
                                    </td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <!-- Quick Actions Card -->
        <div class="row">
            <div class="col-md-6">
                <div class="card">
                    <div class="card-header">
                        <h5 class="mb-0"><i class="fas fa-user-plus me-2"></i>Add New Student</h5>
                    </div>
                    <div class="card-body">
                        <p class="text-muted mb-3">Register a new student in the university system with complete profile information.</p>
                        <a href="students?action=new" class="btn btn-primary w-100">
                            <i class="fas fa-user-plus me-2"></i>Create New Student Profile
                        </a>
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="card">
                    <div class="card-header">
                        <h5 class="mb-0"><i class="fas fa-file-export me-2"></i>Export Data</h5>
                    </div>
                    <div class="card-body">
                        <p class="text-muted mb-3">Export student data for reporting and analysis purposes.</p>
                        <a href="${pageContext.request.contextPath}/ReportServlet?action=students" class="btn btn-outline-primary w-100">
                            <i class="fas fa-download me-2"></i>Generate Student Report
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Initialize tooltips
        var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
        var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
            return new bootstrap.Tooltip(tooltipTriggerEl)
        });
    </script>
</body>
</html>