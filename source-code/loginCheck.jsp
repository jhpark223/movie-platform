<%@ page import="java.sql.*" %>
<%@ page contentType="application/json" %>
<%
//This entire code check if the id and password is valid
String userID = request.getParameter("id");
String userPassword = request.getParameter("password");

Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;
String url = "jdbc:mysql://localhost:3306/userDB";
String dbUser = "root";
String dbPassword = "jungho223";

boolean isAuthenticated = false;

try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    conn = DriverManager.getConnection(url, dbUser, dbPassword);
    // SQL query to check if a user with the given ID and password exists
    String sql = "SELECT * FROM users WHERE id=? AND password=?";
    pstmt = conn.prepareStatement(sql);
    pstmt.setString(1, userID);
    pstmt.setString(2, userPassword);

    rs = pstmt.executeQuery();
    isAuthenticated = rs.next();

    String jsonResult = "{\"isAuthenticated\": " + isAuthenticated + "}";
    out.print(jsonResult);

} catch (Exception e) {
    out.print("{\"error\": \"" + e.getMessage() + "\"}");
} finally {
    if (rs != null) try { rs.close(); } catch (SQLException ex) {}
    if (pstmt != null) try { pstmt.close(); } catch (SQLException ex) {}
    if (conn != null) try { conn.close(); } catch (SQLException ex) {}
}
%>
