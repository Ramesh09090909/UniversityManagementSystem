<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>University Management System</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .container {
            text-align: center;
            background: white;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
        }
        h1 {
            color: #333;
            margin-bottom: 20px;
        }
        p {
            color: #666;
            margin-bottom: 30px;
            font-size: 18px;
        }
        .btn {
            display: inline-block;
            padding: 12px 30px;
            background: #667eea;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            margin: 0 10px;
            font-size: 16px;
            transition: background 0.3s ease;
        }
        .btn:hover {
            background: #764ba2;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>🏫 University Management System</h1>
        <p>Welcome to the University Management System Portal</p>
        <div>
            <a href="login.jsp" class="btn">Login</a>
            <a href="register.jsp" class="btn">Register</a>
        </div>
    </div>
</body>
</html>
