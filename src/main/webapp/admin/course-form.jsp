<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>
        <c:choose>
            <c:when test="${not empty course}">Edit Course</c:when>
            <c:otherwise>Add New Course</c:otherwise>
        </c:choose>
        - University Management System
    </title>
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

        .btn-secondary {
            background: #6c757d;
            color: white;
        }

        .btn-secondary:hover {
            background: #5a6268;
        }

        .form-card {
            background: white;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 2px 20px rgba(0,0,0,0.1);
            max-width: 800px;
            margin: 0 auto;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-group label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 600;
            color: var(--dark);
        }

        .form-control {
            width: 100%;
            padding: 0.7rem;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 0.9rem;
            transition: border 0.3s ease;
        }

        .form-control:focus {
            outline: none;
            border-color: var(--secondary);
            box-shadow: 0 0 0 2px rgba(52, 152, 219, 0.2);
        }

        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1rem;
        }

        textarea.form-control {
            resize: vertical;
            min-height: 100px;
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

        .alert-success {
            background: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }

        .form-actions {
            display: flex;
            gap: 1rem;
            justify-content: flex-end;
            margin-top: 2rem;
            padding-top: 1rem;
            border-top: 1px solid #eee;
        }

        @media (max-width: 768px) {
            .form-row {
                grid-template-columns: 1fr;
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
            <a href="courses.jsp" class="nav-item active">
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
                <h2 class="page-title">
                    <c:choose>
                        <c:when test="${not empty course}">Edit Course</c:when>
                        <c:otherwise>Add New Course</c:otherwise>
                    </c:choose>
                </h2>
                <a href="courses.jsp" class="btn btn-secondary">
                    <i>←</i> Back to Courses
                </a>
            </div>

            <!-- Success/Error Messages -->
            <c:if test="${not empty successMessage}">
                <div class="alert alert-success">✅ ${successMessage}</div>
            </c:if>
            <c:if test="${not empty errorMessage}">
                <div class="alert alert-error">❌ ${errorMessage}</div>
            </c:if>

            <!-- Course Form -->
            <div class="form-card">
                <form action="${pageContext.request.contextPath}/CourseServlet" method="post">
                    <!-- Hidden action field - FIXED -->
                    <input type="hidden" name="action" value="${not empty course ? 'update' : 'insert'}">
                    
                    <!-- Hidden ID field for edit mode -->
                    <c:if test="${not empty course}">
                        <input type="hidden" name="id" value="${course.id}">
                    </c:if>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label for="courseCode">Course Code *</label>
                            <input type="text" id="courseCode" name="courseCode" class="form-control" 
                                   value="${course.courseCode}" placeholder="e.g., CS101" required 
                                   pattern="[A-Za-z]{2,4}[0-9]{3}" 
                                   title="Course code should be like CS101, MATH201, etc.">
                        </div>
                        
                        <div class="form-group">
                            <label for="courseName">Course Name *</label>
                            <input type="text" id="courseName" name="courseName" class="form-control" 
                                   value="${course.courseName}" placeholder="e.g., Introduction to Programming" required>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="description">Description</label>
                        <textarea id="description" name="description" class="form-control" 
                                  placeholder="Course description...">${course.description}</textarea>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label for="credits">Credits *</label>
                            <input type="number" id="credits" name="credits" class="form-control" 
                                   value="${course.credits}" min="1" max="10" required>
                        </div>
                        
                        <div class="form-group">
                            <label for="department">Department *</label>
                            <select id="department" name="department" class="form-control" required>
                                <option value="">Select Department</option>
                                <option value="Computer Science" ${course.department == 'Computer Science' ? 'selected' : ''}>Computer Science</option>
                                <option value="Electrical Engineering" ${course.department == 'Electrical Engineering' ? 'selected' : ''}>Electrical Engineering</option>
                                <option value="Mechanical Engineering" ${course.department == 'Mechanical Engineering' ? 'selected' : ''}>Mechanical Engineering</option>
                                <option value="Civil Engineering" ${course.department == 'Civil Engineering' ? 'selected' : ''}>Civil Engineering</option>
                                <option value="Mathematics" ${course.department == 'Mathematics' ? 'selected' : ''}>Mathematics</option>
                                <option value="Physics" ${course.department == 'Physics' ? 'selected' : ''}>Physics</option>
                            </select>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label for="semester">Semester</label>
                            <select id="semester" name="semester" class="form-control">
                                <option value="">Select Semester</option>
                                <option value="First Semester" ${course.semester == 'First Semester' ? 'selected' : ''}>First Semester</option>
                                <option value="Second Semester" ${course.semester == 'Second Semester' ? 'selected' : ''}>Second Semester</option>
                                <option value="Third Semester" ${course.semester == 'Third Semester' ? 'selected' : ''}>Third Semester</option>
                                <option value="Fourth Semester" ${course.semester == 'Fourth Semester' ? 'selected' : ''}>Fourth Semester</option>
                                <option value="Fiveth Semester" ${course.semester == 'Fiveth Semester' ? 'selected' : ''}>Fiveth Semester</option>
                                <option value="Sixth Semester" ${course.semester == 'Sixth Semester' ? 'selected' : ''}>Sixth Semester</option>
                                <option value="Seventh Semester" ${course.semester == 'Seventh Semester' ? 'selected' : ''}>Seventh Semester</option>
                                <option value="Eighth Semester" ${course.semester == 'Eighth Semester' ? 'selected' : ''}>Eighth Semester</option>
         
                            </select>
                        </div>
                        
                        <div class="form-group">
                            <label for="facultyId">Assigned Faculty</label>
                            <select id="facultyId" name="facultyId" class="form-control">
                                <option value="">Select Faculty</option>
                                <c:forEach var="faculty" items="${facultyList}">
                                    <option value="${faculty.id}" ${course.facultyId == faculty.id ? 'selected' : ''}>
                                        ${faculty.firstName} ${faculty.lastName} (${faculty.department})
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label for="maxStudents">Maximum Students</label>
                            <input type="number" id="maxStudents" name="maxStudents" class="form-control" 
                                   value="${course.maxStudents}" min="1" max="200" placeholder="Optional">
                        </div>
                        
                        <div class="form-group">
                            <label for="status">Status *</label>
                            <select id="status" name="status" class="form-control" required>
                                <option value="active" ${course.status == 'active' or empty course ? 'selected' : ''}>Active</option>
                                <option value="inactive" ${course.status == 'inactive' ? 'selected' : ''}>Inactive</option>
                            </select>
                        </div>
                    </div>

                    <div class="form-actions">
                        <button type="reset" class="btn btn-secondary">Reset</button>
                        <button type="submit" class="btn btn-primary">
                            <c:choose>
                                <c:when test="${not empty course}">Update Course</c:when>
                                <c:otherwise>Add Course</c:otherwise>
                            </c:choose>
                        </button>
                    </div>
                </form>
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

        // Focus on first input field
        document.getElementById('courseCode')?.focus();

        // Form validation
        document.querySelector('form').addEventListener('submit', function(e) {
            const courseCode = document.getElementById('courseCode').value;
            const courseName = document.getElementById('courseName').value;
            const credits = document.getElementById('credits').value;
            const department = document.getElementById('department').value;
            const status = document.getElementById('status').value;
            
            if (!courseCode || !courseName || !credits || !department || !status) {
                e.preventDefault();
                alert('Please fill all required fields (*)');
                return false;
            }
            
            // Course code validation
            const courseCodePattern = /^[A-Za-z]{2,4}[0-9]{3}$/;
            if (!courseCodePattern.test(courseCode)) {
                e.preventDefault();
                alert('Course code should be in format like CS101, MATH201 (2-4 letters followed by 3 numbers)');
                return false;
            }
            
            return true;
        });
    </script>
</body>
</html>