package university.filter;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebFilter("/*")
public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);
        
        String contextPath = httpRequest.getContextPath();
        String requestURI = httpRequest.getRequestURI();
        
        // Get the path after context path
        String path = requestURI.substring(contextPath.length());
        
        System.out.println("AuthFilter: Checking access for path: " + path); // Debug
        
        // Check if user is logged in
        boolean loggedIn = session != null && session.getAttribute("user") != null;
        String userRole = loggedIn ? (String) session.getAttribute("role") : null;
        
        // Public resources that don't require authentication
        boolean isLoginPage = path.equals("/login") || path.equals("/login.jsp");
        boolean isRegisterPage = path.equals("/register") || path.equals("/register.jsp");
        boolean isLogout = path.equals("/logout");
        boolean isPublicResource = path.endsWith(".css") || path.endsWith(".js") || 
                                  path.endsWith(".png") || path.endsWith(".jpg") ||
                                  path.endsWith(".gif") || path.equals("/") ||
                                  path.equals("/index.jsp");
        
        // Allow public resources, login, register, and logout
        if (isLoginPage || isRegisterPage || isLogout || isPublicResource) {
            System.out.println("AuthFilter: Allowing public resource: " + path);
            chain.doFilter(request, response);
            return;
        }
        
        // If user is not logged in, redirect to login
        if (!loggedIn) {
            System.out.println("AuthFilter: User not logged in, redirecting to login");
            httpResponse.sendRedirect(contextPath + "/login.jsp");
            return;
        }
        
        // Role-based access control for protected areas
        if (path.startsWith("/admin/")) {
            if (!"admin".equals(userRole)) {
                System.out.println("AuthFilter: Non-admin trying to access admin area");
                httpResponse.sendRedirect(contextPath + "/access-denied.jsp");
                return;
            }
        }
        else if (path.startsWith("/faculty/")) {
            if (!"faculty".equals(userRole)) {
                System.out.println("AuthFilter: Non-faculty trying to access faculty area");
                httpResponse.sendRedirect(contextPath + "/access-denied.jsp");
                return;
            }
        }
        else if (path.startsWith("/student/")) {
            if (!"student".equals(userRole)) {
                System.out.println("AuthFilter: Non-student trying to access student area");
                httpResponse.sendRedirect(contextPath + "/access-denied.jsp");
                return;
            }
        }
        
        System.out.println("AuthFilter: Access granted for: " + path);
        chain.doFilter(request, response);
    }

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        System.out.println("AuthFilter initialized successfully");
    }

    @Override
    public void destroy() {
        System.out.println("AuthFilter destroyed");
    }
}