<%@ page import="java.sql.*" %>
<%@ page contentType="application/json;charset=UTF-8" language="java" %>
<%
    //This entire code gets the user information for the profile page of the searched user
    String url = "jdbc:mysql://localhost:3306/userDB";
    String dbUser = "root";
    String dbPassword = "jungho223";
    String nickname = request.getParameter("nickname");

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, dbUser, dbPassword);
        // SQL query to fetch nickname and phone from the 'users' table where the nickname matches
        String sql = "SELECT nickname, phone FROM users WHERE nickname=?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, nickname);
        rs = pstmt.executeQuery();
        // Check if the user is found and respond with their information
        if (rs.next()) {
            String foundNickname = rs.getString("nickname");
            String phone = rs.getString("phone");

            response.getWriter().print("{\"nickname\": \"" + foundNickname + "\", \"phone\": \"" + phone + "\"}");
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException ex) {}
        if (pstmt != null) try { pstmt.close(); } catch (SQLException ex) {}
        if (conn != null) try { conn.close(); } catch (SQLException ex) {}
    }
%>
