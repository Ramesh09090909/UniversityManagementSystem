<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>University Management System - Login</title>
    <style>
        body { font-family: Arial, sans-serif; background: #f4f4f4; margin: 0; padding: 0; display: flex; justify-content: center; align-items: center; height: 100vh; }
        .login-container { background: white; padding: 30px; border-radius: 8px; box-shadow: 0 0 10px rgba(0,0,0,0.1); width: 350px; }
        .form-group { margin-bottom: 15px; }
        label { display: block; margin-bottom: 5px; font-weight: bold; }
        input[type="text"], input[type="password"] { width: 100%; padding: 8px; border: 1px solid #ddd; border-radius: 4px; box-sizing: border-box; }
        input[type="submit"] { background: #007bff; color: white; padding: 10px 15px; border: none; border-radius: 4px; cursor: pointer; width: 100%; }
        input[type="submit"]:hover { background: #0056b3; }
        .error { color: red; margin-bottom: 15px; text-align: center; }
        .user-type { display: flex; gap: 10px; margin-bottom: 15px; }
        .user-type label { display: flex; align-items: center; gap: 5px; }
        .register-link { text-align: center; margin-top: 20px; padding-top: 15px; border-top: 1px solid #ddd; }
        .register-link a { color: #007bff; text-decoration: none; }
        .register-link a:hover { text-decoration: underline; }
    </style>
</head>
<body>
    <div class="login-container">
        <h2 style="text-align: center; color: #333;">University Login</h2>
        
        <%-- Error message display --%>
        <c:if test="${not empty errorMessage}">
            <div class="error">${errorMessage}</div>
        </c:if>
        
        <form action="login" method="post">
            <div class="form-group">
                <label for="username">Username:</label>
                <input type="text" id="username" name="username" required>
            </div>
            
            <div class="form-group">
                <label for="password">Password:</label>
                <input type="password" id="password" name="password" required>
            </div>
            
            <div class="form-group">
                <label>Login As:</label>
                <div class="user-type">
                    <label><input type="radio" name="role" value="student" checked> Student</label>
                    <label><input type="radio" name="role" value="faculty"> Faculty</label>
                    <label><input type="radio" name="role" value="admin"> Admin</label>
                </div>
            </div>
            
            <div class="form-group">
                <input type="submit" value="Login">
            </div>
        </form>

        <!-- ADD THIS REGISTRATION LINK -->
        <div class="register-link">
            <p>Don't have an account? <a href="register.jsp">Register here</a></p>
        </div>
    </div>
</body>
</html>