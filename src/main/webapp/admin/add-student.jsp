<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>University Management System - ${student == null ? 'Add Student' : 'Edit Student'}</title>
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
        .card-header {
            background-color: #f8f9fc;
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
        .form-control, .form-select {
            border: 1px solid #e3e6f0;
            border-radius: 0.35rem;
            padding: 0.75rem;
        }
        .navbar-brand {
            font-weight: 700;
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
                    <h1 class="h2 mb-1">${student == null ? 'Add New Student' : 'Edit Student'}</h1>
                    <p class="mb-0 opacity-75">
                        ${student == null ? 'Register a new student in the system' : 'Update student information and details'}
                    </p>
                </div>
                <div class="col-auto">
                    <a href="${pageContext.request.contextPath}/admin/students" class="btn btn-light">
                        <i class="fas fa-arrow-left me-2"></i> Back to Students
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/dashboard.jsp" class="btn btn-outline-light ms-2">
                        <i class="fas fa-tachometer-alt me-2"></i> Dashboard
                    </a>
                </div>
            </div>
        </div>
    </div>

    <div class="container-fluid">
        <!-- Error Message -->
        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="fas fa-exclamation-circle me-2"></i>${error}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <!-- Student Form Card -->
        <div class="card">
            <div class="card-header">
                <h5 class="mb-0">
                    <i class="fas ${student == null ? 'fa-user-plus' : 'fa-edit'} me-2"></i>
                    ${student == null ? 'Student Registration Form' : 'Edit Student Information'}
                </h5>
            </div>
            <div class="card-body">
                <form action="students" method="post">
                    <c:if test="${student != null}">
                        <input type="hidden" name="id" value="${student.id}">
                        <input type="hidden" name="action" value="update">
                    </c:if>
                    <c:if test="${student == null}">
                        <input type="hidden" name="action" value="insert">
                    </c:if>

                    <!-- Personal Information -->
                    <h6 class="mb-3 text-primary">
                        <i class="fas fa-user me-2"></i>Personal Information
                    </h6>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="firstName" class="form-label fw-bold">First Name *</label>
                                <input type="text" class="form-control" id="firstName" name="firstName" 
                                       value="${student.firstName}" required placeholder="Enter first name">
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="lastName" class="form-label fw-bold">Last Name *</label>
                                <input type="text" class="form-control" id="lastName" name="lastName" 
                                       value="${student.lastName}" required placeholder="Enter last name">
                            </div>
                        </div>
                    </div>

                    <!-- Account Information -->
                    <h6 class="mb-3 text-primary mt-4">
                        <i class="fas fa-key me-2"></i>Account Information
                    </h6>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="username" class="form-label fw-bold">Username *</label>
                                <input type="text" class="form-control" id="username" name="username" 
                                       value="${student.username}" required placeholder="Choose a username">
                                <div class="form-text">Username must be unique</div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <c:if test="${student == null}">
                                <div class="mb-3">
                                    <label for="password" class="form-label fw-bold">Password *</label>
                                    <input type="password" class="form-control" id="password" name="password" 
                                           required placeholder="Enter password">
                                    <div class="form-text">Minimum 6 characters</div>
                                </div>
                            </c:if>
                        </div>
                    </div>

                    <!-- Contact Information -->
                    <h6 class="mb-3 text-primary mt-4">
                        <i class="fas fa-envelope me-2"></i>Contact Information
                    </h6>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="email" class="form-label fw-bold">Email Address *</label>
                                <input type="email" class="form-control" id="email" name="email" 
                                       value="${student.email}" required placeholder="student@university.edu">
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="rollNumber" class="form-label fw-bold">Roll Number *</label>
                                <input type="text" class="form-control" id="rollNumber" name="rollNumber" 
                                       value="${student.rollNumber}" required placeholder="e.g., ROLL001">
                                <div class="form-text">Unique identifier for the student</div>
                            </div>
                        </div>
                    </div>

                    <!-- Academic Information -->
                    <h6 class="mb-3 text-primary mt-4">
                        <i class="fas fa-graduation-cap me-2"></i>Academic Information
                    </h6>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="department" class="form-label fw-bold">Department *</label>
                                <select class="form-select" id="department" name="department" required>
                                    <option value="">Select Department</option>
                                    <option value="Computer Science" ${student.department == 'Computer Science' ? 'selected' : ''}>Computer Science</option>
                                    <option value="Electrical Engineering" ${student.department == 'Electrical Engineering' ? 'selected' : ''}>Electrical Engineering</option>
                                    <option value="Mechanical Engineering" ${student.department == 'Mechanical Engineering' ? 'selected' : ''}>Mechanical Engineering</option>
                                    <option value="Civil Engineering" ${student.department == 'Civil Engineering' ? 'selected' : ''}>Civil Engineering</option>
                                    <option value="Business Administration" ${student.department == 'Business Administration' ? 'selected' : ''}>Business Administration</option>
                                </select>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="semester" class="form-label fw-bold">Semester *</label>
                                <select class="form-select" id="semester" name="semester" required>
                                    <option value="">Select Semester</option>
                                    <c:forEach var="i" begin="1" end="8">
                                        <option value="${i}" ${student.semester == i ? 'selected' : ''}>Semester ${i}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                    </div>

                    <!-- Status (for edit mode only) -->
                    <c:if test="${student != null}">
                        <h6 class="mb-3 text-primary mt-4">
                            <i class="fas fa-cog me-2"></i>Account Settings
                        </h6>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="status" class="form-label fw-bold">Account Status</label>
                                    <select class="form-select" id="status" name="status">
                                        <option value="active" ${student.status == 'active' ? 'selected' : ''}>Active</option>
                                        <option value="inactive" ${student.status == 'inactive' ? 'selected' : ''}>Inactive</option>
                                    </select>
                                    <div class="form-text">Set student account status</div>
                                </div>
                            </div>
                        </div>
                    </c:if>

                    <!-- Form Actions -->
                    <div class="row mt-4">
                        <div class="col-12">
                            <div class="d-flex gap-2 justify-content-end">
                                <a href="${pageContext.request.contextPath}/admin/students" class="btn btn-secondary">
                                    <i class="fas fa-times me-2"></i> Cancel
                                </a>
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-save me-2"></i> 
                                    ${student == null ? 'Add Student' : 'Update Student'}
                                </button>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>