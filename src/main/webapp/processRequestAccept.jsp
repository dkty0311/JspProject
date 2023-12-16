<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="dbconn.jsp" %>
<%@ page import="java.sql.*" %>

<%

        // 요청으로부터 productNum 가져오기
        int productNum = Integer.parseInt(request.getParameter("productNum"));

        // productTradeStatus를 '거래완료'로 업데이트
        String updateProductSql = "UPDATE product SET productTradeStatus = '판매완료' WHERE productNum = ?";
        PreparedStatement updateProductStmt = conn.prepareStatement(updateProductSql);
        updateProductStmt.setInt(1, productNum);
        updateProductStmt.executeUpdate();


        response.sendRedirect("productPurchase.jsp"); // 성공 시 리다이렉트할 페이지

%>
