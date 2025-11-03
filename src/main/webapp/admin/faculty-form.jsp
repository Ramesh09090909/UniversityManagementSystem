<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Faculty - University Management System</title>
    <style>
        /* Add the same CSS styles from add-faculty.jsp here */
        /* ... copy all the CSS from add-faculty.jsp ... */
    </style>
</head>
<body>
    <!-- Session Check -->
    
    
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
            <a href="faculty.jsp" class="nav-item active">
                <i>👨‍🏫</i> Manage Faculty
            </a>
            <a href="courses.jsp" class="nav-item">
                <i>📚</i> Courses
            </a>
            <a href="reports.jsp" class="nav-item">
                <i>📈</i> Reports
            </a>
        </div>

        <!-- Main Content -->
        <div class="main-content">
            <!-- Page Header -->
            <div class="page-header">
                <h2 class="page-title">Edit Faculty</h2>
                <a href="faculty.jsp" class="btn btn-secondary">
                    <i>←</i> Back to Faculty List
                </a>
            </div>

            <!-- Edit Faculty Form -->
            <div class="form-container">
                <form action="${pageContext.request.contextPath}/FacultyServlet" method="post">
                    <input type="hidden" name="action" value="update">
                    <input type="hidden" name="facultyId" value="${faculty.id}">
                    
                    <div class="form-grid">
                        <!-- Personal Information -->
                        <div class="form-group">
                            <label for="firstName">First Name *</label>
                            <input type="text" id="firstName" name="firstName" class="form-control" 
                                   value="${faculty.firstName}" required>
                        </div>
                        
                        <div class="form-group">
                            <label for="lastName">Last Name *</label>
                            <input type="text" id="lastName" name="lastName" class="form-control" 
                                   value="${faculty.lastName}" required>
                        </div>
                        
                        <div class="form-group">
                            <label for="email">Email *</label>
                            <input type="email" id="email" name="email" class="form-control" 
                                   value="${faculty.email}" required>
                        </div>
                        
                        <div class="form-group">
                            <label for="phone">Phone Number *</label>
                            <input type="tel" id="phone" name="phone" class="form-control" 
                                   value="${faculty.phone}" required>
                        </div>

                        <!-- Login Credentials -->
                        <div class="form-group">
                            <label for="username">Username *</label>
                            <input type="text" id="username" name="username" class="form-control" 
                                   value="${faculty.username}" required>
                        </div>
                        
                        <div class="form-group">
                            <label for="employeeId">Employee ID *</label>
                            <input type="text" id="employeeId" name="employeeId" class="form-control" 
                                   value="${faculty.employeeId}" required readonly>
                        </div>

                        <!-- Professional Information -->
                        <div class="form-group">
                            <label for="department">Department *</label>
                            <select id="department" name="department" class="form-control" required>
                                <option value="">Select Department</option>
                                <option value="Computer Science" ${faculty.department == 'Computer Science' ? 'selected' : ''}>Computer Science</option>
                                <option value="Electrical Engineering" ${faculty.department == 'Electrical Engineering' ? 'selected' : ''}>Electrical Engineering</option>
                                <option value="Mechanical Engineering" ${faculty.department == 'Mechanical Engineering' ? 'selected' : ''}>Mechanical Engineering</option>
                                <option value="Civil Engineering" ${faculty.department == 'Civil Engineering' ? 'selected' : ''}>Civil Engineering</option>
                                <option value="Mathematics" ${faculty.department == 'Mathematics' ? 'selected' : ''}>Mathematics</option>
                                <option value="Physics" ${faculty.department == 'Physics' ? 'selected' : ''}>Physics</option>
                            </select>
                        </div>
                        
                        <div class="form-group">
                            <label for="designation">Designation *</label>
                            <select id="designation" name="designation" class="form-control" required>
                                <option value="">Select Designation</option>
                                <option value="Professor" ${faculty.designation == 'Professor' ? 'selected' : ''}>Professor</option>
                                <option value="Associate Professor" ${faculty.designation == 'Associate Professor' ? 'selected' : ''}>Associate Professor</option>
                                <option value="Assistant Professor" ${faculty.designation == 'Assistant Professor' ? 'selected' : ''}>Assistant Professor</option>
                                <option value="Lecturer" ${faculty.designation == 'Lecturer' ? 'selected' : ''}>Lecturer</option>
                                <option value="Visiting Faculty" ${faculty.designation == 'Visiting Faculty' ? 'selected' : ''}>Visiting Faculty</option>
                            </select>
                        </div>
                        
                        <div class="form-group">
                            <label for="qualification">Qualification *</label>
                            <input type="text" id="qualification" name="qualification" class="form-control" 
                                   value="${faculty.qualification}" required>
                        </div>
                        
                        <div class="form-group">
                            <label for="joinDate">Join Date *</label>
                            <input type="date" id="joinDate" name="joinDate" class="form-control" 
                                   value="${faculty.joinDate}" required>
                        </div>
                        
                        <div class="form-group">
                            <label for="status">Status *</label>
                            <select id="status" name="status" class="form-control" required>
                                <option value="active" ${faculty.status == 'active' ? 'selected' : ''}>Active</option>
                                <option value="inactive" ${faculty.status == 'inactive' ? 'selected' : ''}>Inactive</option>
                            </select>
                        </div>

                        <!-- Form Actions -->
                        <div class="form-actions">
                            <a href="faculty.jsp" class="btn btn-secondary">Cancel</a>
                            <button type="submit" class="btn btn-primary">Update Faculty</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</body>
</html>