<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%
//This entire code store information about users who have signed up 
String userID = request.getParameter("id");
String userPassword = request.getParameter("password");
String userNickname = request.getParameter("nickname");
String userPhone = request.getParameter("phone");

Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;
String url = "jdbc:mysql://localhost:3306/userDB";
String dbUser = "root";
String dbPassword = "jungho223";

boolean isDuplicate = false;

try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    conn = DriverManager.getConnection(url, dbUser, dbPassword);
    // SQL query to insert the new user data into the users table
        String sql = "INSERT INTO users (id, password, nickname, phone) VALUES (?, ?, ?, ?)";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, userID);
        pstmt.setString(2, userPassword);
        pstmt.setString(3, userNickname);
        pstmt.setString(4, userPhone);

        int result = pstmt.executeUpdate();
        if(result > 0){  
            out.println("signup success");
            response.sendRedirect("main.html");
        } else { 
            out.println("signup fail");
        }
    }
  catch (Exception e) {
    out.println("DB connect fail: ");
    e.printStackTrace();
} finally {
    if(rs != null) try { rs.close(); } catch(SQLException ex) {}
    if(pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
    if(conn != null) try { conn.close(); } catch(SQLException ex) {}
}
%>
