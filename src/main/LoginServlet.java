package university.servlet;

import university.dao.DBConnection;
import java.io.IOException;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;


public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try (Connection conn = DBConnection.getConnection()) {
            PreparedStatement ps = conn.prepareStatement("SELECT * FROM admin WHERE name=? AND email=? AND password=?");
            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, password);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                HttpSession session = request.getSession();
                session.setAttribute("adminName", name);
                response.sendRedirect("adminDashboard.jsp");
            } else {
                response.sendRedirect("index.jsp?error=invalid");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}