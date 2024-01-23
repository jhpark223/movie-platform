<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page contentType="application/json" %>
<%
//This entire code checks if the id or nickname is duplicated during signup process
String userID = request.getParameter("id");
String userNickname = request.getParameter("nickname");
String userPhone = request.getParameter("phone");

Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;
String url = "jdbc:mysql://localhost:3306/userDB";
String dbUser = "root";
String dbPassword = "jungho223";

boolean idDuplicate = false;
boolean nicknameDuplicate = false;
boolean phoneDuplicate = false;

try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    conn = DriverManager.getConnection(url, dbUser, dbPassword);
    // Query to check if the provided ID already exists in the database
    String checkIdQuery = "SELECT * FROM users WHERE id = ?";
    pstmt = conn.prepareStatement(checkIdQuery);
    pstmt.setString(1, userID);
    rs = pstmt.executeQuery();
    idDuplicate = rs.next();
    // Query to check for duplicate nickname if ID is not duplicate
    if (!idDuplicate) {
        String checkNicknameQuery = "SELECT * FROM users WHERE nickname = ?";
        pstmt = conn.prepareStatement(checkNicknameQuery);
        pstmt.setString(1, userNickname);
        rs = pstmt.executeQuery();
        nicknameDuplicate = rs.next();
    }
   // Query to check for duplicate phone if ID and nickname are not duplicates
    if (!idDuplicate && !nicknameDuplicate) {
        String checkPhoneQuery = "SELECT * FROM users WHERE phone = ?";
        pstmt = conn.prepareStatement(checkPhoneQuery);
        pstmt.setString(1, userPhone);
        rs = pstmt.executeQuery();
        phoneDuplicate = rs.next();
    }

    String jsonResult = String.format("{\"idDuplicate\": %b, \"nicknameDuplicate\": %b, \"phoneDuplicate\": %b}", idDuplicate, nicknameDuplicate, phoneDuplicate);
    out.print(jsonResult);

} catch (Exception e) {
    out.print("{\"error\": \"" + e.getMessage() + "\"}");
} finally {
    if(rs != null) try { rs.close(); } catch(SQLException ex) {}
    if(pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
    if(conn != null) try { conn.close(); } catch(SQLException ex) {}
}
%>
