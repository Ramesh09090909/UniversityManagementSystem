<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Holidays List - Student Dashboard</title>
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
            background: #f5f7fa;
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
            background-color: #e74c3c;
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
        }
        
        /* Holidays List Styles */
        .holidays-container {
            max-width: 1000px;
            margin: 0 auto;
            background: white;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.1);
            overflow: hidden;
        }
        
        .holidays-header {
            background: linear-gradient(135deg, #e74c3c, #c0392b);
            color: white;
            padding: 30px;
            text-align: center;
        }
        
        .holidays-header h1 {
            font-size: 2.2rem;
            margin-bottom: 10px;
            font-weight: 600;
        }
        
        .holidays-header p {
            font-size: 1.1rem;
            opacity: 0.9;
            margin-bottom: 5px;
        }
        
        .academic-year {
            background: rgba(255,255,255,0.2);
            padding: 8px 20px;
            border-radius: 20px;
            font-size: 0.9rem;
            font-weight: 500;
            display: inline-block;
            margin-top: 10px;
        }
        
        .holidays-content {
            padding: 30px;
        }
        
        .holiday-category {
            margin-bottom: 30px;
        }
        
        .category-title {
            background: #34495e;
            color: white;
            padding: 15px 20px;
            border-radius: 8px;
            margin-bottom: 20px;
            font-size: 1.3rem;
            font-weight: 600;
        }
        
        .holiday-list {
            display: grid;
            gap: 15px;
        }
        
        .holiday-item {
            background: #f8f9fa;
            border-radius: 8px;
            padding: 20px;
            border-left: 4px solid #e74c3c;
            transition: all 0.3s ease;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .holiday-item:hover {
            transform: translateX(5px);
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }
        
        .holiday-info {
            flex: 1;
        }
        
        .holiday-name {
            font-size: 1.1rem;
            font-weight: 600;
            color: #2c3e50;
            margin-bottom: 5px;
        }
        
        .holiday-description {
            color: #7f8c8d;
            font-size: 0.9rem;
            margin-bottom: 5px;
        }
        
        .holiday-date {
            background: #e74c3c;
            color: white;
            padding: 8px 15px;
            border-radius: 20px;
            font-size: 0.9rem;
            font-weight: 500;
            min-width: 120px;
            text-align: center;
        }
        
        .holiday-duration {
            color: #e74c3c;
            font-size: 0.85rem;
            font-weight: 500;
        }
        
        .upcoming-holiday {
            background: #fff3cd;
            border-left: 4px solid #ffc107;
        }
        
        .upcoming-holiday .holiday-date {
            background: #ffc107;
            color: #856404;
        }
        
        .current-holiday {
            background: #d4edda;
            border-left: 4px solid #28a745;
        }
        
        .current-holiday .holiday-date {
            background: #28a745;
        }
        
        .holiday-stats {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }
        
        .stat-card {
            background: white;
            padding: 20px;
            border-radius: 8px;
            text-align: center;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        
        .stat-number {
            font-size: 2rem;
            font-weight: bold;
            color: #e74c3c;
            margin-bottom: 5px;
        }
        
        .stat-label {
            color: #7f8c8d;
            font-size: 0.9rem;
        }
        
        .section-divider {
            height: 1px;
            background: linear-gradient(90deg, transparent, #bdc3c7, transparent);
            margin: 30px 0;
        }
        
        .quick-info {
            background: #e8f4fd;
            border-radius: 8px;
            padding: 20px;
            margin-top: 30px;
        }
        
        .quick-info h3 {
            color: #2c3e50;
            margin-bottom: 15px;
            font-size: 1.2rem;
        }
        
        .info-item {
            display: flex;
            align-items: center;
            margin-bottom: 10px;
            color: #2c3e50;
        }
        
        .info-item i {
            margin-right: 10px;
            color: #3498db;
        }
        
        @media (max-width: 768px) {
            .dashboard-container {
                flex-direction: column;
            }
            
            .sidebar {
                width: 100%;
            }
            
            .holiday-item {
                flex-direction: column;
                align-items: flex-start;
                gap: 10px;
            }
            
            .holiday-date {
                align-self: flex-start;
            }
            
            .holiday-stats {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <div class="dashboard-container">
        <!-- Sidebar -->
        <div class="sidebar">
            <div class="sidebar-header">
                <h2>Student Portal</h2>
            </div>
            <ul class="sidebar-menu">
                <li><a href="dashboard.jsp"><i>🏠</i> Dashboard</a></li>
                <li><a href="student-profile.jsp"><i>👤</i> My Profile</a></li>
                <li><a href="courses.jsp"><i>📚</i> My Courses</a></li>
                <li><a href="grades.jsp"><i>📊</i> Grades & Results</a></li>
                <li><a href="holidays.jsp" class="active"><i>🎉</i> Holidays List</a></li>
            </ul>
        </div>
        
        <!-- Main Content -->
        <div class="main-content">
            <div class="header">
                <h1>Holidays List</h1>
                <div class="user-info">
                    <div class="user-avatar">R</div>
                    <span>Welcome, Rakesh!</span>
                </div>
            </div>
            
            <!-- Holidays Container -->
            <div class="holidays-container">
                <!-- Header -->
                <div class="holidays-header">
                    <h1>University Holidays Calendar</h1>
                    <p>Academic Year 2025-26</p>
                    <div class="academic-year">School of Engineering and Technology</div>
                </div>
                
                <!-- Holidays Content -->
                <div class="holidays-content">
                    <!-- Statistics -->
                    <div class="holiday-stats">
                        <div class="stat-card">
                            <div class="stat-number">24</div>
                            <div class="stat-label">Total Holidays</div>
                        </div>
                        <div class="stat-card">
                            <div class="stat-number">3</div>
                            <div class="stat-label">Upcoming Holidays</div>
                        </div>
                        <div class="stat-card">
                            <div class="stat-number">15</div>
                            <div class="stat-label">Days Off This Year</div>
                        </div>
                        <div class="stat-card">
                            <div class="stat-number">8</div>
                            <div class="stat-label">Long Weekends</div>
                        </div>
                    </div>
                    
                    <!-- Current/Upcoming Holidays -->
                    <div class="holiday-category">
                        <div class="category-title">Current & Upcoming Holidays</div>
                        <div class="holiday-list">
                            <div class="holiday-item current-holiday">
                                <div class="holiday-info">
                                    <div class="holiday-name">Diwali Break</div>
                                    <div class="holiday-description">Festival of Lights - University Closed</div>
                                    <div class="holiday-duration">5 Days Holiday</div>
                                </div>
                                <div class="holiday-date">Oct 28 - Nov 1</div>
                            </div>
                            
                            <div class="holiday-item upcoming-holiday">
                                <div class="holiday-info">
                                    <div class="holiday-name">Christmas Holiday</div>
                                    <div class="holiday-description">Christmas Celebration</div>
                                    <div class="holiday-duration">3 Days Holiday</div>
                                </div>
                                <div class="holiday-date">Dec 24 - 26</div>
                            </div>
                            
                            <div class="holiday-item upcoming-holiday">
                                <div class="holiday-info">
                                    <div class="holiday-name">New Year Break</div>
                                    <div class="holiday-description">New Year Celebration</div>
                                    <div class="holiday-duration">2 Days Holiday</div>
                                </div>
                                <div class="holiday-date">Dec 31 - Jan 1</div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="section-divider"></div>
                    
                    <!-- National Holidays -->
                    <div class="holiday-category">
                        <div class="category-title">National Holidays</div>
                        <div class="holiday-list">
                            <div class="holiday-item">
                                <div class="holiday-info">
                                    <div class="holiday-name">Republic Day</div>
                                    <div class="holiday-description">National Holiday</div>
                                </div>
                                <div class="holiday-date">Jan 26, 2025</div>
                            </div>
                            
                            <div class="holiday-item">
                                <div class="holiday-info">
                                    <div class="holiday-name">Independence Day</div>
                                    <div class="holiday-description">National Holiday</div>
                                </div>
                                <div class="holiday-date">Aug 15, 2025</div>
                            </div>
                            
                            <div class="holiday-item">
                                <div class="holiday-info">
                                    <div class="holiday-name">Gandhi Jayanti</div>
                                    <div class="holiday-description">National Holiday</div>
                                </div>
                                <div class="holiday-date">Oct 2, 2025</div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Festival Holidays -->
                    <div class="holiday-category">
                        <div class="category-title">Festival Holidays</div>
                        <div class="holiday-list">
                            <div class="holiday-item">
                                <div class="holiday-info">
                                    <div class="holiday-name">Holi</div>
                                    <div class="holiday-description">Festival of Colors</div>
                                </div>
                                <div class="holiday-date">Mar 14, 2025</div>
                            </div>
                            
                            <div class="holiday-item">
                                <div class="holiday-info">
                                    <div class="holiday-name">Eid al-Fitr</div>
                                    <div class="holiday-description">Islamic Festival</div>
                                </div>
                                <div class="holiday-date">Apr 10, 2025</div>
                            </div>
                            
                            <div class="holiday-item">
                                <div class="holiday-info">
                                    <div class="holiday-name">Raksha Bandhan</div>
                                    <div class="holiday-description">Brother-Sister Festival</div>
                                </div>
                                <div class="holiday-date">Aug 19, 2025</div>
                            </div>
                            
                            <div class="holiday-item">
                                <div class="holiday-info">
                                    <div class="holiday-name">Janmashtami</div>
                                    <div class="holiday-description">Hindu Festival</div>
                                </div>
                                <div class="holiday-date">Aug 26, 2025</div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Semester Breaks -->
                    <div class="holiday-category">
                        <div class="category-title">Semester Breaks</div>
                        <div class="holiday-list">
                            <div class="holiday-item">
                                <div class="holiday-info">
                                    <div class="holiday-name">Summer Vacation</div>
                                    <div class="holiday-description">End of Even Semester Break</div>
                                    <div class="holiday-duration">45 Days Break</div>
                                </div>
                                <div class="holiday-date">May 15 - Jun 28</div>
                            </div>
                            
                            <div class="holiday-item">
                                <div class="holiday-info">
                                    <div class="holiday-name">Winter Break</div>
                                    <div class="holiday-description">End of Odd Semester Break</div>
                                    <div class="holiday-duration">21 Days Break</div>
                                </div>
                                <div class="holiday-date">Dec 20 - Jan 9</div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Quick Information -->
                    <div class="quick-info">
                        <h3>📋 Important Notes</h3>
                        <div class="info-item">
                            <i>📅</i> All holidays are subject to change as per university guidelines
                        </div>
                        <div class="info-item">
                            <i>⏰</i> Examination schedules will be announced separately
                        </div>
                        <div class="info-item">
                            <i>📚</i> Library will remain open during most breaks with limited hours
                        </div>
                        <div class="info-item">
                            <i>🏢</i> Administrative offices will be closed on all national holidays
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>