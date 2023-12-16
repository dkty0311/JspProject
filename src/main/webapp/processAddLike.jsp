<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ include file="dbconn.jsp" %>

<%

    try {
        request.setCharacterEncoding("UTF-8");
        session = request.getSession();
        String userId = (String) session.getAttribute("userID");
        // 클라이언트로부터 받아온 productNum 값
        String productNum = request.getParameter("productNum");

        // 좋아요가 이미 있는지 체크
        String checkSql = "SELECT * FROM likeList WHERE userId = ? AND productNum = ?";
        pstmt = conn.prepareStatement(checkSql);
        pstmt.setString(1, userId);
        pstmt.setString(2, productNum);
        ResultSet resultSet = pstmt.executeQuery();

        if (resultSet.next()) {
            // 이미 좋아요가 있다면 사용자에게 알림을 띄우고 페이지를 이동하지 않음
        %>
            <script>
                alert("이미 좋아요 목록에 추가된 상품입니다.");
                location.href="./productShow.jsp";
            </script>
        <%
        } else {
            // 좋아요 정보를 likeList 테이블에 추가하는 SQL 쿼리
            String insertSql = "INSERT INTO likeList (likeDate, userId, productNum) VALUES (?, ?, ?)";
            pstmt = conn.prepareStatement(insertSql);
            pstmt.setTimestamp(1, new Timestamp(System.currentTimeMillis()));
            pstmt.setString(2, userId);
            pstmt.setString(3, productNum);

            // SQL 쿼리 실행
            pstmt.executeUpdate();
        %>
            <script>
                alert("좋아요 목록에 추가되었습니다!");
                location.href="./productShow.jsp";
            </script>
        <%
        }

    } catch (Exception e) {
        // 오류 발생 시 예외 처리
        e.printStackTrace();
        out.println("좋아요 추가 중 오류가 발생했습니다.");
    } finally {
        // 리소스 해제
        if (pstmt != null) {
            pstmt.close();
        }
        if (conn != null) {
            conn.close();
        }
    }
%>
