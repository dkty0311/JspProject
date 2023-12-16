<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ include file="dbconn.jsp" %>

<%
    try {
        // 클라이언트로부터 받아온 정보
        String productNum = request.getParameter("productNum");
        String userId = (String) session.getAttribute("userID"); // 세션에서 사용자 아이디 가져오기

        // 이미 해당 사용자가 해당 상품에 대한 요청을 보냈는지 확인
        String checkRequestSql = "SELECT * FROM request WHERE userId = ? AND productNum = ?";
        pstmt = conn.prepareStatement(checkRequestSql);
        pstmt.setString(1, userId);
        pstmt.setString(2, productNum);
        ResultSet resultSet = pstmt.executeQuery();

        if (resultSet.next()) {
            // 이미 요청을 보낸 경우
            %>
            <script>
                alert("이미 해당 상품에 대해 구매요청을 보냈습니다.");
                location.href = "./productShow.jsp"; // 좋아요한 상품 목록 페이지로 이동
            </script>
            <%
        } else {
            // 아직 요청을 보내지 않은 경우

            // 상품의 현재 상태 확인
            String checkProductStatusSql = "SELECT productTradeStatus FROM product WHERE productNum = ?";
            pstmt = conn.prepareStatement(checkProductStatusSql);
            pstmt.setString(1, productNum);
            ResultSet productStatusResultSet = pstmt.executeQuery();

            if (productStatusResultSet.next()) {
                String productTradeStatus = productStatusResultSet.getString("productTradeStatus");

                if ("판매완료".equals(productTradeStatus)) {
                    // 이미 판매완료된 경우
                    %>
                    <script>
                        alert("이미 판매완료된 상품입니다.");
                        location.href = "./productShow.jsp"; // 상품 목록 페이지로 이동
                    </script>
                    <%
                } else {
                    // 현재 날짜와 시간 가져오기
                    java.util.Date date = new java.util.Date();
                    Timestamp requestTime = new Timestamp(date.getTime());

                    // request 테이블에 구매요청 추가하는 SQL 쿼리
                    String insertRequestSql = "INSERT INTO request (requestTime, userId, productNum) VALUES (?, ?, ?)";
                    pstmt = conn.prepareStatement(insertRequestSql);
                    pstmt.setTimestamp(1, requestTime);
                    pstmt.setString(2, userId);
                    pstmt.setString(3, productNum);

                    // SQL 쿼리 실행
                    pstmt.executeUpdate();

                    // 상품의 productTradeStatus를 '예약중'으로 업데이트하는 SQL 쿼리
                    String updateProductSql = "UPDATE product SET productTradeStatus = '예약중' WHERE productNum = ?";
                    pstmt = conn.prepareStatement(updateProductSql);
                    pstmt.setString(1, productNum);

                    // SQL 쿼리 실행
                    pstmt.executeUpdate();

                    // 성공적으로 처리되었음을 클라이언트에게 알림
                    response.sendRedirect("./productShow.jsp"); // 구매요청 후 상품 목록 페이지로 이동
                }
            }
        }
    } catch (Exception e) {
        // 오류 발생 시 예외 처리
        e.printStackTrace();
        out.println("구매요청 처리 중 오류가 발생했습니다.");
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
