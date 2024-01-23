<%@ page import="java.sql.*" %>
<%@ page contentType="application/json;charset=UTF-8" language="java" %>
<%
    //This entire code search the user by nickname and get information
    String url = "jdbc:mysql://localhost:3306/userDB";
    String dbUser = "root";
    String dbPassword = "jungho223";
    String searchNickname = request.getParameter("nickname"); 

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, dbUser, dbPassword);
         // SQL query to find a user by nickname and retrieve their nickname and phone number
        String sql = "SELECT nickname, phone FROM users WHERE nickname=?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, searchNickname);
        rs = pstmt.executeQuery();
        // Check if a user with the specified nickname exists and respond with their information
        if (rs.next()) {
            String nickname = rs.getString("nickname");
            String phone = rs.getString("phone");

            response.getWriter().print("{\"nickname\": \"" + nickname + "\", \"phone\": \"" + phone + "\"}");
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException ex) {}
        if (pstmt != null) try { pstmt.close(); } catch (SQLException ex) {}
        if (conn != null) try { conn.close(); } catch (SQLException ex) {}
    }
%>
