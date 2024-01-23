<%@ page import="java.sql.*" %>
<%@ page contentType="application/json;charset=UTF-8" language="java" %>
<%
    //This entire code gets movie list which was added by the user
    String userID = session.getAttribute("userId").toString();

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    String url = "jdbc:mysql://localhost:3306/userDB";
    String dbUser = "root";
    String dbPassword = "jungho223";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, dbUser, dbPassword);
       // SQL query to fetch movie title, rating, and review from the 'movie_reviews' table for the current user
        String sql = "SELECT movieTitle, rating, review FROM movie_reviews WHERE userId = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, userID);
        rs = pstmt.executeQuery();
        // Build a JSON string to represent the list of movies
        StringBuilder jsonBuilder = new StringBuilder("[");
        boolean first = true;
        while (rs.next()) {
            if (!first) {
                jsonBuilder.append(",");
            } else {
                first = false;
            }
            jsonBuilder.append("{");
            jsonBuilder.append("\"movieTitle\":\"").append(rs.getString("movieTitle").replace("\"", "\\\"")).append("\",");
            jsonBuilder.append("\"rating\":\"").append(rs.getString("rating").replace("\"", "\\\"")).append("\",");
            jsonBuilder.append("\"review\":\"").append(rs.getString("review").replace("\"", "\\\"")).append("\"");
            jsonBuilder.append("}");
        }
        jsonBuilder.append("]");
        response.getWriter().print(jsonBuilder.toString());
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException ex) {}
        if (pstmt != null) try { pstmt.close(); } catch (SQLException ex) {}
        if (conn != null) try { conn.close(); } catch (SQLException ex) {}
    }
%>
