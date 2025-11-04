package university.controller;

import university.dao.CourseDAO;
import university.dao.FacultyDAO;
import university.dao.StudentDAO;
import university.model.ReportData;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/ReportServlet")
public class ReportServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private StudentDAO studentDAO;
    private FacultyDAO facultyDAO;
    private CourseDAO courseDAO;
    
    public void init() {
        studentDAO = new StudentDAO();
        facultyDAO = new FacultyDAO();
        courseDAO = new CourseDAO();
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if (action == null) {
            action = "dashboard";
        }
        
        try {
            switch (action) {
                case "students":
                    showStudentReport(request, response);
                    break;
                case "faculty":
                    showFacultyReport(request, response);
                    break;
                case "courses":
                    showCourseReport(request, response);
                    break;
                case "enrollment":
                    showEnrollmentReport(request, response);
                    break;
                default:
                    showDashboard(request, response);
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException(e);
        }
    }
    
    private void showDashboard(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            // Get overall statistics
            int totalStudents = studentDAO.getTotalStudents();
            int totalFaculty = facultyDAO.getTotalFaculty();
            int totalCourses = courseDAO.getTotalCourses();
            int activeCourses = courseDAO.getActiveCoursesCount();
            
            // Get department-wise counts
            Map<String, Integer> studentsByDept = studentDAO.getStudentsByDepartment();
            Map<String, Integer> facultyByDept = facultyDAO.getFacultyByDepartment();
            Map<String, Integer> coursesByDept = courseDAO.getCoursesByDepartment();
            
            // Recent activities (you can implement these methods later)
            List<?> recentStudents = studentDAO.getRecentStudents(5);
            List<?> recentFaculty = facultyDAO.getRecentFaculty(5);
            List<?> recentCourses = courseDAO.getRecentCourses(5);
            
            ReportData reportData = new ReportData();
            reportData.setTotalStudents(totalStudents);
            reportData.setTotalFaculty(totalFaculty);
            reportData.setTotalCourses(totalCourses);
            reportData.setActiveCourses(activeCourses);
            reportData.setStudentsByDepartment(studentsByDept);
            reportData.setFacultyByDepartment(facultyByDept);
            reportData.setCoursesByDepartment(coursesByDept);
            
            request.setAttribute("reportData", reportData);
            request.setAttribute("recentStudents", recentStudents);
            request.setAttribute("recentFaculty", recentFaculty);
            request.setAttribute("recentCourses", recentCourses);
            
            RequestDispatcher dispatcher = request.getRequestDispatcher("admin/reports.jsp");
            dispatcher.forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error generating dashboard: " + e.getMessage());
            RequestDispatcher dispatcher = request.getRequestDispatcher("admin/reports.jsp");
            dispatcher.forward(request, response);
        }
    }
    
    private void showStudentReport(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            int totalStudents = studentDAO.getTotalStudents();
            int activeStudents = studentDAO.getActiveStudentsCount();
            Map<String, Integer> studentsByDept = studentDAO.getStudentsByDepartment();
            Map<String, Integer> studentsByStatus = studentDAO.getStudentsByStatus();
            Map<String, Integer> studentsByYear = studentDAO.getStudentsByYear();
            
            ReportData reportData = new ReportData();
            reportData.setTotalStudents(totalStudents);
            reportData.setActiveStudents(activeStudents);
            reportData.setStudentsByDepartment(studentsByDept);
            reportData.setStudentsByStatus(studentsByStatus);
            reportData.setStudentsByYear(studentsByYear);
            
            request.setAttribute("reportData", reportData);
            request.setAttribute("reportType", "students");
            
            RequestDispatcher dispatcher = request.getRequestDispatcher("admin/reports.jsp");
            dispatcher.forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error generating student report: " + e.getMessage());
            RequestDispatcher dispatcher = request.getRequestDispatcher("admin/reports.jsp");
            dispatcher.forward(request, response);
        }
    }
    
    private void showFacultyReport(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            int totalFaculty = facultyDAO.getTotalFaculty();
            int activeFaculty = facultyDAO.getActiveFacultyCount();
            Map<String, Integer> facultyByDept = facultyDAO.getFacultyByDepartment();
            Map<String, Integer> facultyByStatus = facultyDAO.getFacultyByStatus();
            Map<String, Integer> facultyByDesignation = facultyDAO.getFacultyByDesignation();
            
            ReportData reportData = new ReportData();
            reportData.setTotalFaculty(totalFaculty);
            reportData.setActiveFaculty(activeFaculty);
            reportData.setFacultyByDepartment(facultyByDept);
            reportData.setFacultyByStatus(facultyByStatus);
            reportData.setFacultyByDesignation(facultyByDesignation);
            
            request.setAttribute("reportData", reportData);
            request.setAttribute("reportType", "faculty");
            
            RequestDispatcher dispatcher = request.getRequestDispatcher("admin/reports.jsp");
            dispatcher.forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error generating faculty report: " + e.getMessage());
            RequestDispatcher dispatcher = request.getRequestDispatcher("admin/reports.jsp");
            dispatcher.forward(request, response);
        }
    }
    
    private void showCourseReport(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            int totalCourses = courseDAO.getTotalCourses();
            int activeCourses = courseDAO.getActiveCoursesCount();
            Map<String, Integer> coursesByDept = courseDAO.getCoursesByDepartment();
            Map<String, Integer> coursesByStatus = courseDAO.getCoursesByStatus();
            Map<String, Integer> coursesWithoutFaculty = courseDAO.getCoursesWithoutFaculty();
            
            ReportData reportData = new ReportData();
            reportData.setTotalCourses(totalCourses);
            reportData.setActiveCourses(activeCourses);
            reportData.setCoursesByDepartment(coursesByDept);
            reportData.setCoursesByStatus(coursesByStatus);
            reportData.setCoursesWithoutFaculty(coursesWithoutFaculty);
            
            request.setAttribute("reportData", reportData);
            request.setAttribute("reportType", "courses");
            
            RequestDispatcher dispatcher = request.getRequestDispatcher("admin/reports.jsp");
            dispatcher.forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error generating course report: " + e.getMessage());
            RequestDispatcher dispatcher = request.getRequestDispatcher("admin/reports.jsp");
            dispatcher.forward(request, response);
        }
    }
    
    private void showEnrollmentReport(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            // This would require an EnrollmentDAO - for future implementation
            Map<String, Integer> enrollmentStats = new HashMap<>();
            enrollmentStats.put("Total Enrollments", 150);
            enrollmentStats.put("Average per Course", 25);
            enrollmentStats.put("Max Enrollment", 45);
            enrollmentStats.put("Min Enrollment", 10);
            
            ReportData reportData = new ReportData();
            reportData.setEnrollmentStats(enrollmentStats);
            
            request.setAttribute("reportData", reportData);
            request.setAttribute("reportType", "enrollment");
            
            RequestDispatcher dispatcher = request.getRequestDispatcher("admin/reports.jsp");
            dispatcher.forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error generating enrollment report: " + e.getMessage());
            RequestDispatcher dispatcher = request.getRequestDispatcher("admin/reports.jsp");
            dispatcher.forward(request, response);
        }
    }
}