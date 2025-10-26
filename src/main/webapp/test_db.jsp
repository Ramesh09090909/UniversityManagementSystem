<%@ page import="com.university.util.DatabaseConnection" %>
<%@ page import="java.sql.Connection" %>
<%
try {
    Connection conn = DatabaseConnection.getConnection();
    out.println("<h3 style='color: green'>Database Connection Successful!</h3>");
    conn.close();
} catch (Exception e) {
    out.println("<h3 style='color: red'>Database Connection Failed: " + e.getMessage() + "</h3>");
}
%>