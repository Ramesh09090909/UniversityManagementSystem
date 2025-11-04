<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%
// Initialize courses in application scope if not exists
List<Map<String, String>> courses = (List<Map<String, String>>) application.getAttribute("facultyCourses");
if (courses == null) {
    courses = new ArrayList<>();
    
    // Add sample courses for different departments
    Map<String, String> course1 = new HashMap<>();
    course1.put("id", "1");
    course1.put("course_code", "CS101");
    course1.put("course_name", "Introduction to Programming");
    course1.put("department", "Computer Science");
    course1.put("credits", "4");
    course1.put("semester", "1");
    course1.put("description", "Basic programming concepts using Java");
    course1.put("faculty_id", "FAC001");
    courses.add(course1);
    
    Map<String, String> course2 = new HashMap<>();
    course2.put("id", "2");
    course2.put("course_code", "EE201");
    course2.put("course_name", "Circuit Analysis");
    course2.put("department", "Electrical Engineering");
    course2.put("credits", "3");
    course2.put("semester", "3");
    course2.put("description", "Analysis of electrical circuits");
    course2.put("faculty_id", "FAC002");
    courses.add(course2);
    
    application.setAttribute("facultyCourses", courses);
}

String faculty_id = (String) session.getAttribute("faculty_id");
String faculty_dept = (String) session.getAttribute("department");

// Set default faculty if not in session
if (faculty_id == null) {
    faculty_id = "FAC001";
    faculty_dept = "Computer Science";
    session.setAttribute("faculty_id", faculty_id);
    session.setAttribute("department", faculty_dept);
}

// Handle form actions
if ("POST".equalsIgnoreCase(request.getMethod())) {
    String action = request.getParameter("action");
    
    if ("add".equals(action)) {
        // Add new course
        Map<String, String> newCourse = new HashMap<>();
        newCourse.put("id", String.valueOf(System.currentTimeMillis()));
        newCourse.put("course_code", request.getParameter("course_code"));
        newCourse.put("course_name", request.getParameter("course_name"));
        newCourse.put("department", faculty_dept);
        newCourse.put("credits", request.getParameter("credits"));
        newCourse.put("semester", request.getParameter("semester"));
        newCourse.put("description", request.getParameter("description"));
        newCourse.put("faculty_id", faculty_id);
        
        courses.add(newCourse);
        application.setAttribute("facultyCourses", courses);
        
    } else if ("update".equals(action)) {
        // Update existing course
        String courseId = request.getParameter("course_id");
        for (Map<String, String> course : courses) {
            if (courseId.equals(course.get("id"))) {
                course.put("course_code", request.getParameter("course_code"));
                course.put("course_name", request.getParameter("course_name"));
                course.put("credits", request.getParameter("credits"));
                course.put("semester", request.getParameter("semester"));
                course.put("description", request.getParameter("description"));
                break;
            }
        }
        application.setAttribute("facultyCourses", courses);
        
    } else if ("delete".equals(action)) {
        // Delete course
        String courseId = request.getParameter("course_id");
        courses.removeIf(course -> courseId.equals(course.get("id")));
        application.setAttribute("facultyCourses", courses);
    }
}

// Filter courses by current faculty's department
List<Map<String, String>> facultyCourses = new ArrayList<>();
for (Map<String, String> course : courses) {
    if (faculty_id.equals(course.get("faculty_id"))) {
        facultyCourses.add(course);
    }
}

String departmentFilter = request.getParameter("department");
if (departmentFilter != null && !departmentFilter.isEmpty()) {
    session.setAttribute("department", departmentFilter);
    faculty_dept = departmentFilter;
}
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Course Management - Faculty Portal</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; background: #f5f5f5; }
        .container { max-width: 1200px; margin: 0 auto; }
        .header { background: white; padding: 20px; border-radius: 8px; margin-bottom: 20px; text-align: center; position: relative; }
        .back-button { 
            position: absolute; left: 20px; top: 20px; 
            background: #007bff; color: white; padding: 8px 15px; 
            text-decoration: none; border-radius: 4px; 
        }
        .department-selector { 
            background: white; padding: 15px; border-radius: 8px; 
            margin-bottom: 20px; text-align: center;
        }
        .form-container, .table-container { 
            background: white; padding: 20px; border-radius: 8px; 
            margin-bottom: 20px; box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .form-group { margin: 15px 0; }
        label { display: block; margin-bottom: 5px; font-weight: bold; color: #333; }
        input, select, textarea { 
            width: 100%; padding: 8px; border: 1px solid #ddd; 
            border-radius: 4px; box-sizing: border-box;
        }
        textarea { height: 80px; resize: vertical; }
        .btn { 
            padding: 10px 20px; border: none; border-radius: 4px; 
            cursor: pointer; text-decoration: none; display: inline-block;
            margin: 5px;
        }
        .btn-primary { background: #007bff; color: white; }
        .btn-success { background: #28a745; color: white; }
        .btn-warning { background: #ffc107; color: black; }
        .btn-danger { background: #dc3545; color: white; }
        .btn-info { background: #17a2b8; color: white; }
        .action-buttons { display: flex; gap: 5px; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { border: 1px solid #ddd; padding: 12px; text-align: left; }
        th { background: #f8f9fa; font-weight: bold; }
        tr:nth-child(even) { background: #f8f9fa; }
        .tabs { display: flex; margin-bottom: 20px; background: white; border-radius: 8px; }
        .tab { padding: 15px 30px; background: #e9ecef; cursor: pointer; border-radius: 8px 8px 0 0; margin-right: 5px; }
        .tab.active { background: #007bff; color: white; }
        .course-card { 
            background: white; padding: 20px; border-radius: 8px; 
            margin: 10px 0; border-left: 4px solid #007bff;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .course-header { display: flex; justify-content: between; align-items: center; }
        .course-code { font-weight: bold; color: #007bff; font-size: 1.2em; }
        .course-credits { background: #28a745; color: white; padding: 2px 8px; border-radius: 12px; font-size: 0.8em; }
        .stats { display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 15px; margin: 20px 0; }
        .stat-card { background: white; padding: 20px; border-radius: 8px; text-align: center; box-shadow: 0 2px 4px rgba(0,0,0,0.1); }
        .stat-number { font-size: 2em; font-weight: bold; color: #007bff; }
        .stat-label { color: #666; margin-top: 5px; }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <a href="dashboard.jsp" class="back-button">← Back to Dashboard</a>
            <h2>Course Management</h2>
            <p>Manage courses for your department</p>
        </div>

        <!-- Department Selector -->
        <div class="department-selector">
            <form method="GET">
                <label><strong>Select Your Department:</strong></label>
                <select name="department" onchange="this.form.submit()" style="width: auto; display: inline-block; margin-left: 10px;">
                    <option value="Computer Science" <%= "Computer Science".equals(faculty_dept) ? "selected" : "" %>>Computer Science</option>
                    <option value="Electrical Engineering" <%= "Electrical Engineering".equals(faculty_dept) ? "selected" : "" %>>Electrical Engineering</option>
                    <option value="Mechanical Engineering" <%= "Mechanical Engineering".equals(faculty_dept) ? "selected" : "" %>>Mechanical Engineering</option>
                    <option value="Civil Engineering" <%= "Civil Engineering".equals(faculty_dept) ? "selected" : "" %>>Civil Engineering</option>
                    <option value="Electronics Engineering" <%= "Electronics Engineering".equals(faculty_dept) ? "selected" : "" %>>Electronics Engineering</option>
                </select>
            </form>
            <div style="margin-top: 10px; font-weight: bold; color: #007bff;">
                Current Department: <%= faculty_dept %>
            </div>
        </div>

        <!-- Statistics -->
        <div class="stats">
            <div class="stat-card">
                <div class="stat-number"><%= facultyCourses.size() %></div>
                <div class="stat-label">Total Courses</div>
            </div>
            <%
            int sem1Courses = 0, sem2Courses = 0, sem3Courses = 0, sem4Courses = 0;
            for (Map<String, String> course : facultyCourses) {
                String semester = course.get("semester");
                if ("1".equals(semester)) sem1Courses++;
                else if ("2".equals(semester)) sem2Courses++;
                else if ("3".equals(semester)) sem3Courses++;
                else if ("4".equals(semester)) sem4Courses++;
            }
            %>
            <div class="stat-card">
                <div class="stat-number"><%= sem1Courses %></div>
                <div class="stat-label">Semester 1 Courses</div>
            </div>
            <div class="stat-card">
                <div class="stat-number"><%= sem2Courses %></div>
                <div class="stat-label">Semester 2 Courses</div>
            </div>
            <div class="stat-card">
                <div class="stat-number"><%= facultyCourses.stream().mapToInt(c -> Integer.parseInt(c.get("credits"))).sum() %></div>
                <div class="stat-label">Total Credits</div>
            </div>
        </div>

        <div class="tabs">
            <div class="tab active" onclick="showTab('viewCourses')">View Courses</div>
            <div class="tab" onclick="showTab('addCourse')">Add New Course</div>
        </div>

        <!-- View Courses -->
        <div id="viewCourses" class="table-container">
            <h3>Your Courses in <%= faculty_dept %></h3>
            
            <% if (facultyCourses.isEmpty()) { %>
                <div style="text-align: center; padding: 40px; color: #666;">
                    <h4>No courses found for <%= faculty_dept %></h4>
                    <p>Click "Add New Course" to create your first course.</p>
                </div>
            <% } else { %>
                <div class="course-list">
                    <% for (Map<String, String> course : facultyCourses) { %>
                    <div class="course-card">
                        <div class="course-header">
                            <div>
                                <span class="course-code"><%= course.get("course_code") %></span>
                                <span class="course-credits"><%= course.get("credits") %> Credits</span>
                            </div>
                            <div class="action-buttons">
                                <button class="btn btn-warning btn-sm" onclick="editCourse('<%= course.get("id") %>')">Edit</button>
                                <form method="POST" style="display: inline;">
                                    <input type="hidden" name="action" value="delete">
                                    <input type="hidden" name="course_id" value="<%= course.get("id") %>">
                                    <button type="submit" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure you want to delete this course?')">Delete</button>
                                </form>
                            </div>
                        </div>
                        <h4 style="margin: 10px 0 5px 0;"><%= course.get("course_name") %></h4>
                        <div style="color: #666; margin: 5px 0;">
                            Semester: <%= course.get("semester") %> | 
                            Department: <%= course.get("department") %>
                        </div>
                        <% if (course.get("description") != null && !course.get("description").isEmpty()) { %>
                        <div style="margin-top: 10px; color: #555;">
                            <strong>Description:</strong> <%= course.get("description") %>
                        </div>
                        <% } %>
                    </div>
                    <% } %>
                </div>
            <% } %>
        </div>

        <!-- Add Course Form -->
        <div id="addCourse" class="form-container" style="display: none;">
            <h3>Add New Course to <%= faculty_dept %></h3>
            <form method="POST">
                <input type="hidden" name="action" value="add">
                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 20px;">
                    <div class="form-group">
                        <label>Course Code *</label>
                        <input type="text" name="course_code" required placeholder="e.g., CS101">
                    </div>
                    <div class="form-group">
                        <label>Course Name *</label>
                        <input type="text" name="course_name" required placeholder="e.g., Introduction to Programming">
                    </div>
                    <div class="form-group">
                        <label>Credits *</label>
                        <select name="credits" required>
                            <option value="1">1 Credit</option>
                            <option value="2">2 Credits</option>
                            <option value="3" selected>3 Credits</option>
                            <option value="4">4 Credits</option>
                            <option value="5">5 Credits</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Semester *</label>
                        <select name="semester" required>
                            <option value="1">Semester 1</option>
                            <option value="2">Semester 2</option>
                            <option value="3">Semester 3</option>
                            <option value="4">Semester 4</option>
                            <option value="5">Semester 5</option>
                            <option value="6">Semester 6</option>
                            <option value="7">Semester 7</option>
                            <option value="8">Semester 8</option>
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label>Course Description</label>
                    <textarea name="description" placeholder="Brief description of the course..."></textarea>
                </div>
                <button type="submit" class="btn btn-primary">Add Course</button>
                <button type="button" class="btn btn-info" onclick="showTab('viewCourses')">Cancel</button>
            </form>
        </div>
    </div>

    <script>
        function showTab(tabName) {
            // Hide all tabs
            document.getElementById('viewCourses').style.display = 'none';
            document.getElementById('addCourse').style.display = 'none';
            
            // Remove active class from all tabs
            document.querySelectorAll('.tab').forEach(tab => {
                tab.classList.remove('active');
            });
            
            // Show selected tab
            document.getElementById(tabName).style.display = 'block';
            
            // Add active class to clicked tab
            event.target.classList.add('active');
        }

        function editCourse(courseId) {
            alert('Edit functionality for course ID: ' + courseId + '\n\nIn a real application, this would open an edit form with pre-filled data.');
            // In a real application, you would:
            // 1. Fetch course details by ID
            // 2. Populate an edit form
            // 3. Handle the update via POST request
        }

        // Show success message if course was added
        <% if ("POST".equalsIgnoreCase(request.getMethod()) && "add".equals(request.getParameter("action"))) { %>
        setTimeout(() => {
            alert('Course added successfully!');
            showTab('viewCourses');
        }, 100);
        <% } %>
    </script>
</body>
</html>