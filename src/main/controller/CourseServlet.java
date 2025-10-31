package university.controller;

import university.dao.CourseDAO;
import university.dao.FacultyDAO;
import university.model.Course;
import university.model.Faculty; // ADDED: Import the Faculty Model

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession; // ADDED: Import HttpSession
import java.io.IOException;
import java.util.List;

@WebServlet("/CourseServlet")
public class CourseServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private CourseDAO courseDAO;
    private FacultyDAO facultyDAO;
    
    public void init() {
        System.out.println("=== CourseServlet INIT called ===");
        try {
            courseDAO = new CourseDAO();
            facultyDAO = new FacultyDAO();
            System.out.println("=== CourseServlet initialized successfully ===");
        } catch (Exception e) {
            System.err.println("=== Error initializing CourseServlet: " + e.getMessage() + " ===");
            e.printStackTrace();
        }
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        System.out.println("=== CourseServlet doGet called ===");
        System.out.println("Request URL: " + request.getRequestURL());
        System.out.println("Action parameter: " + request.getParameter("action"));
        
        String action = request.getParameter("action");
        
        if (action == null) {
            action = "list";
        }
        
        try {
            switch (action) {
                // ... Existing Admin Actions ...
                case "new":
                    System.out.println("=== Showing new course form ===");
                    showNewForm(request, response);
                    break;
                case "edit":
                    System.out.println("=== Showing edit course form ===");
                    showEditForm(request, response);
                    break;
                case "delete":
                    System.out.println("=== Deleting course ===");
                    deleteCourse(request, response);
                    break;
                case "view":
                    System.out.println("=== Viewing course ===");
                    viewCourse(request, response);
                    break;
                    
                // --- NEW FACULTY ACTION ---
                case "viewFacultyCourses":
                    System.out.println("=== Viewing faculty's assigned courses ===");
                    viewFacultyCourses(request, response); // CALL THE NEW METHOD
                    break;
                // --- END NEW FACULTY ACTION ---
                    
                default:
                    System.out.println("=== Listing all courses ===");
                    listCourses(request, response);
                    break;
            }
        } catch (Exception e) {
            System.err.println("=== Error in CourseServlet doGet: " + e.getMessage() + " ===");
            e.printStackTrace();
            request.setAttribute("errorMessage", "Server error: " + e.getMessage());
            try {
                // If the error happens during a non-list action, default back to list
                if (!action.equals("viewFacultyCourses")) { 
                    listCourses(request, response);
                } else {
                    // If error happens in faculty view, send back to dashboard
                    response.sendRedirect("faculty/dashboard.jsp"); 
                }
            } catch (Exception ex) {
                throw new ServletException(ex);
            }
        }
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // ... doPost logic remains unchanged ...
        System.out.println("=== CourseServlet doPost called ===");
        System.out.println("Action parameter: " + request.getParameter("action"));
        
        String action = request.getParameter("action");
        
        try {
            switch (action) {
                case "insert":
                    System.out.println("=== Inserting new course ===");
                    insertCourse(request, response);
                    break;
                case "update":
                    System.out.println("=== Updating course ===");
                    updateCourse(request, response);
                    break;
                default:
                    System.out.println("=== Default action: listing courses ===");
                    listCourses(request, response);
                    break;
            }
        } catch (Exception e) {
            System.err.println("=== Error in CourseServlet doPost: " + e.getMessage() + " ===");
            e.printStackTrace();
            request.setAttribute("errorMessage", "Server error: " + e.getMessage());
            try {
                listCourses(request, response);
            } catch (Exception ex) {
                throw new ServletException(ex);
            }
        }
    }
    
    // ----------------------------------------------------------------------
    // --- NEW METHOD FOR FACULTY DASHBOARD ---
    // ----------------------------------------------------------------------

    private void viewFacultyCourses(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        
        if (session == null || session.getAttribute("currentFaculty") == null) {
            System.out.println("ACCESS DENIED: Faculty not logged in.");
            // Redirect to login if session is invalid or faculty object is missing
            response.sendRedirect("login.jsp?error=SessionExpired");
            return;
        }

        // Retrieve the full Faculty object stored during login
        Faculty faculty = (Faculty) session.getAttribute("currentFaculty"); 
        String username = faculty.getUsername();
        
        System.out.println("Fetching courses for logged-in faculty: " + username);
        
        try {
            // Use the DAO method you created
            List<Course> facultyCourses = courseDAO.getCoursesByFacultyUsername(username);
            
            System.out.println("Found " + facultyCourses.size() + " courses for " + username);
            
            // Set the list of courses into the request scope
            request.setAttribute("courses", facultyCourses); 
            
            // Forward to the JSP view you created
            RequestDispatcher dispatcher = request.getRequestDispatcher("/faculty/my-courses.jsp");
            dispatcher.forward(request, response);
            
        } catch (Exception e) {
            System.err.println("Error fetching faculty courses for " + username + ": " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("errorMessage", "Could not load courses: " + e.getMessage());
            // Redirect back to the faculty dashboard on failure
            response.sendRedirect("faculty/dashboard.jsp"); 
        }
    }

    // ----------------------------------------------------------------------
    // --- EXISTING ADMIN METHODS (no change) ---
    // ----------------------------------------------------------------------

    private void listCourses(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // ... (implementation remains the same) ...
    }
    
    private void showNewForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // ... (implementation remains the same) ...
    }
    
    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // ... (implementation remains the same) ...
    }
    
    private void viewCourse(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // ... (implementation remains the same) ...
    }
    
    private void insertCourse(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // ... (implementation remains the same) ...
    }
    
    private void updateCourse(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // ... (implementation remains the same) ...
    }
    
    private void deleteCourse(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // ... (implementation remains the same) ...
    }
    
    
    @Override
    public void destroy() {
        System.out.println("=== CourseServlet DESTROY called ===");
        super.destroy();
    }
}