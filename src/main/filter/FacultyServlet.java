package university.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import university.dao.FacultyDAO;
import university.model.Faculty;

@WebServlet("/FacultyServlet")
public class FacultyServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private FacultyDAO facultyDAO;

    @Override
    public void init() throws ServletException {
        facultyDAO = new FacultyDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if (action == null) {
            action = "list";
        }

        try {
            switch (action) {
                case "new":
                    showNewForm(request, response);
                    break;
                case "edit":
                    showEditForm(request, response);
                    break;
                case "delete":
                    deleteFaculty(request, response);
                    break;
                case "view":
                    viewFaculty(request, response);
                    break;
                default:
                    listFaculty(request, response);
                    break;
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if (action == null) {
            action = "list";
        }

        try {
            switch (action) {
                case "add":
                    addFaculty(request, response);
                    break;
                case "update":
                    updateFaculty(request, response);
                    break;
                default:
                    listFaculty(request, response);
                    break;
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    private void listFaculty(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String search = request.getParameter("search");
        String department = request.getParameter("department");
        String designation = request.getParameter("designation");
        
        List<Faculty> facultyList;
        
        if ((search != null && !search.trim().isEmpty()) || 
            (department != null && !department.trim().isEmpty()) || 
            (designation != null && !designation.trim().isEmpty())) {
            facultyList = facultyDAO.searchFaculty(search, department, designation);
        } else {
            facultyList = facultyDAO.getAllFaculty();
        }
        
        request.setAttribute("facultyList", facultyList);
        request.setAttribute("search", search);
        request.setAttribute("department", department);
        request.setAttribute("designation", designation);
        
        request.getRequestDispatcher("/admin/faculty.jsp").forward(request, response);
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/admin/add-faculty.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Faculty existingFaculty = facultyDAO.getFacultyById(id);
        request.setAttribute("faculty", existingFaculty);
        request.getRequestDispatcher("/admin/faculty-form.jsp").forward(request, response);
    }

    private void viewFaculty(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String employeeId = request.getParameter("employeeId");
        Faculty faculty = facultyDAO.getFacultyByEmployeeId(employeeId);
        request.setAttribute("faculty", faculty);
        request.getRequestDispatcher("/admin/view-faculty.jsp").forward(request, response);
    }

    private void addFaculty(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Get all parameters
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String employeeId = request.getParameter("employeeId");
        String department = request.getParameter("department");
        String designation = request.getParameter("designation");
        String qualification = request.getParameter("qualification");
        String phone = request.getParameter("phone");
        String joinDate = request.getParameter("joinDate");
        
        // Debug output
        System.out.println("=== FacultyServlet Debug ===");
        System.out.println("First Name: " + firstName);
        System.out.println("Last Name: " + lastName);
        System.out.println("Email: " + email);
        System.out.println("Username: " + username);
        System.out.println("Password: " + password);
        System.out.println("Employee ID: " + employeeId);
        System.out.println("Department: " + department);
        System.out.println("Designation: " + designation);
        System.out.println("Qualification: " + qualification);
        System.out.println("Phone: " + phone);
        System.out.println("Join Date: " + joinDate);
        
        // Check if username, email, or employee ID already exists
        if (facultyDAO.usernameExists(username)) {
            System.out.println("ERROR: Username already exists - " + username);
            request.setAttribute("errorMessage", "Username already exists. Please choose a different username.");
            request.getRequestDispatcher("/admin/add-faculty.jsp").forward(request, response);
            return;
        }
        
        if (facultyDAO.emailExists(email)) {
            System.out.println("ERROR: Email already exists - " + email);
            request.setAttribute("errorMessage", "Email already exists. Please use a different email.");
            request.getRequestDispatcher("/admin/add-faculty.jsp").forward(request, response);
            return;
        }
        
        if (facultyDAO.employeeIdExists(employeeId)) {
            System.out.println("ERROR: Employee ID already exists - " + employeeId);
            request.setAttribute("errorMessage", "Employee ID already exists. Please use a different employee ID.");
            request.getRequestDispatcher("/admin/add-faculty.jsp").forward(request, response);
            return;
        }
        
        Faculty newFaculty = new Faculty();
        newFaculty.setFirstName(firstName);
        newFaculty.setLastName(lastName);
        newFaculty.setEmail(email);
        newFaculty.setUsername(username);
        newFaculty.setPassword(password);
        newFaculty.setEmployeeId(employeeId);
        newFaculty.setDepartment(department);
        newFaculty.setDesignation(designation);
        newFaculty.setQualification(qualification);
        newFaculty.setPhone(phone);
        newFaculty.setJoinDate(joinDate);
        newFaculty.setStatus("active");
        
        boolean success = facultyDAO.addFaculty(newFaculty);
        
        System.out.println("Add faculty result: " + success);
        
        if (success) {
            request.setAttribute("successMessage", "Faculty added successfully! Employee ID: " + employeeId);
        } else {
            request.setAttribute("errorMessage", "Failed to add faculty. Please try again.");
        }
        
        request.getRequestDispatcher("/admin/add-faculty.jsp").forward(request, response);
    }
    private void updateFaculty(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        int id = Integer.parseInt(request.getParameter("facultyId"));
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");
        String username = request.getParameter("username");
        String employeeId = request.getParameter("employeeId");
        String department = request.getParameter("department");
        String designation = request.getParameter("designation");
        String qualification = request.getParameter("qualification");
        String phone = request.getParameter("phone");
        String joinDate = request.getParameter("joinDate");
        String status = request.getParameter("status");
        
        Faculty faculty = new Faculty();
        faculty.setId(id);
        faculty.setFirstName(firstName);
        faculty.setLastName(lastName);
        faculty.setEmail(email);
        faculty.setUsername(username);
        faculty.setEmployeeId(employeeId);
        faculty.setDepartment(department);
        faculty.setDesignation(designation);
        faculty.setQualification(qualification);
        faculty.setPhone(phone);
        faculty.setJoinDate(joinDate);
        faculty.setStatus(status);
        
        boolean success = facultyDAO.updateFaculty(faculty);
        
        if (success) {
            request.setAttribute("successMessage", "Faculty updated successfully!");
        } else {
            request.setAttribute("errorMessage", "Failed to update faculty. Please try again.");
        }
        
        listFaculty(request, response);
    }

    private void deleteFaculty(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        int id = Integer.parseInt(request.getParameter("id"));
        boolean success = facultyDAO.deleteFaculty(id);
        
        if (success) {
            request.setAttribute("successMessage", "Faculty deleted successfully!");
        } else {
            request.setAttribute("errorMessage", "Failed to delete faculty. Please try again.");
        }
        
        listFaculty(request, response);
    }
}