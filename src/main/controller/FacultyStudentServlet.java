// FacultyStudentServlet.java
package university.controller;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import university.dao.StudentDAO;
import university.model.Student;

@WebServlet("/faculty/students")
public class FacultyStudentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private StudentDAO studentDAO;
    
    public void init() {
        studentDAO = new StudentDAO();
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        String facultyUsername = (String) session.getAttribute("username");
        String role = (String) session.getAttribute("role");
        
        System.out.println("=== FacultyStudentServlet - Faculty: " + facultyUsername + " ===");
        
        // Check if user is faculty and logged in
        if (facultyUsername == null || !"faculty".equals(role)) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        
        // Get all students from database
        List<Student> students = studentDAO.getAllStudents();
        System.out.println("=== Students found: " + students.size() + " ===");
        
        // Set attributes for JSP
        request.setAttribute("students", students);
        request.setAttribute("facultyUsername", facultyUsername);
        request.setAttribute("totalStudents", students.size());
        
        // Forward to faculty students page
        request.getRequestDispatcher("/faculty/students.jsp").forward(request, response);
    }
}