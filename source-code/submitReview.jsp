<%@ page import="java.sql.*" %>
<%
//This entire code store the movie review which is submitted by the user
String userID = session.getAttribute("userId").toString();
String movieId = request.getParameter("movieId");
String movieTitle = request.getParameter("movieTitle"); 
String rating = request.getParameter("rating");
String review = request.getParameter("review");

Connection conn = null;
PreparedStatement pstmt = null;
String url = "jdbc:mysql://localhost:3306/userDB";
String dbUser = "root"; 
String dbPassword = "jungho223"; 
String posterUrl = request.getParameter("posterUrl"); 

try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    conn = DriverManager.getConnection(url, dbUser, dbPassword);
    // SQL query to insert movie review data into the movie_reviews table
    String sql = "INSERT INTO movie_reviews (userId, movieId, movieTitle, rating, review) VALUES (?, ?, ?, ?, ?)";
    pstmt = conn.prepareStatement(sql);
    pstmt.setString(1, userID);
    pstmt.setString(2, movieId);
    pstmt.setString(3, movieTitle);
    pstmt.setString(4, rating);
    pstmt.setString(5, review);
    
    int result = pstmt.executeUpdate();
    if(result > 0){ 
        out.println("리뷰 등록 성공");
        response.sendRedirect("loggedin.html");
    } else {
        out.println("리뷰 등록 실패");
    }
} catch (Exception e) {
    out.println("DB 연결 실패: ");
    e.printStackTrace();
} finally {
    if(pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
    if(conn != null) try { conn.close(); } catch(SQLException ex) {}
}
%>
