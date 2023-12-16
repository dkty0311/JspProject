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

        // 좋아요 정보를 likeList 테이블에서 삭제하는 SQL 쿼리
        String deleteSql = "DELETE FROM likeList WHERE userId = ? AND productNum = ?";
        pstmt = conn.prepareStatement(deleteSql);
        pstmt.setString(1, userId);
        pstmt.setString(2, productNum);

        // SQL 쿼리 실행
        int rowCount = pstmt.executeUpdate();

        if (rowCount > 0) {
            // 성공적으로 삭제되었음을 클라이언트에게 알림
        %>
            <script>
                alert("좋아요가 성공적으로 삭제되었습니다.");
                location.href = "./likeList.jsp"; // 좋아요한 상품 목록 페이지로 이동
            </script>
        <%
        } else {
            // 삭제할 좋아요가 없는 경우
        %>
            <script>
                alert("해당 상품에 대한 좋아요를 찾을 수 없습니다.");
                location.href = "./likedProducts.jsp"; // 좋아요한 상품 목록 페이지로 이동
            </script>
        <%
        }

    } catch (Exception e) {
        // 오류 발생 시 예외 처리
        e.printStackTrace();
        out.println("좋아요 삭제 중 오류가 발생했습니다.");
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
