<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    //This entire code handles the login process for the user
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

        String sql = "SELECT * FROM users WHERE id=? AND password=?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, userID);
        pstmt.setString(2, userPassword);

        rs = pstmt.executeQuery();
        isAuthenticated = rs.next(); 

        if (isAuthenticated) {
            session.setAttribute("userId", userID);

            response.sendRedirect("loggedin.html");
        } else {
            out.println("<script type='text/javascript'>");
            out.println("alert('Invalid ID or Password');");
            out.println("history.back();"); 
            out.println("</script>");
        }        
    } catch (Exception e) {
        out.println("Login failed. Error: " + e.getMessage());
        e.printStackTrace();
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException ex) {}
        if (pstmt != null) try { pstmt.close(); } catch (SQLException ex) {}
        if (conn != null) try { conn.close(); } catch (SQLException ex) {}
    }
%>