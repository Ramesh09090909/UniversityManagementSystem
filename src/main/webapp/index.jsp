<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<html>
<head>
    <title>University Login Portal</title>
    <!-- styles omitted for brevity -->
</head>
<body>
    <h1>University Management System</h1>
    <div class="container">
        <!-- Admin Login -->
        <div class="login-box">
            <h2>Admin Login</h2>
            <form action="LoginServlet" method="post">
                <label>Name:</label>
                <input type="text" name="name" required />
                <label>Email:</label>
                <input type="text" name="email" required />
                <label>Password:</label>
                <input type="password" name="password" required />
                <input type="submit" value="Login as Admin" />
            </form>
        </div>

        <!-- Student Login -->
        <div class="login-box">
            <h2>Student Login</h2>
            <form action="StudentloginServlet" method="post">
                <label>Email ID:</label>
                <input type="email" name="email" required />
                <label>Password:</label>
                <input type="password" name="password" required />
                <input type="submit" value="Login as Student" />
            </form>
        </div>
    </div>

    <% if (request.getParameter("error") != null) { %>
        <p class="error">Invalid login. Please try again.</p>
    <% } %>
    <p>New student? <a href="studentRegister.jsp">Register here</a></p>
</body>
</html>