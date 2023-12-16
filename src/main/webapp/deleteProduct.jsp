<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="dbconn.jsp" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*, java.util.*" %>

<%
    // 한글 깨짐 방지를 위해 설정
    request.setCharacterEncoding("UTF-8");

    // 삭제할 상품의 productNum을 받아옴
    int productNum = Integer.parseInt(request.getParameter("productNum"));

    // 삭제 확인 여부를 받아옴
    String confirmDelete = request.getParameter("confirmDelete");

    if (confirmDelete != null && confirmDelete.equals("true")) {
        // 상품 삭제를 위해 이미지 경로를 가져옴
        String imagePath = "";
        String getImagePathSql = "SELECT imagePath FROM productImage WHERE productNum=?";
        try {
            PreparedStatement getImagePathStmt = conn.prepareStatement(getImagePathSql);
            getImagePathStmt.setInt(1, productNum);
            ResultSet imagePathResult = getImagePathStmt.executeQuery();
            if (imagePathResult.next()) {
                imagePath = imagePathResult.getString("imagePath");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        // 상품 삭제 SQL
        String deleteSql = "DELETE FROM product WHERE productNum=?";
        String deleteImageSql = "DELETE FROM productImage WHERE productNum=?";

        try {
            // SQL 실행을 위한 PreparedStatement 객체 생성
            PreparedStatement deleteStmt = conn.prepareStatement(deleteSql);
            PreparedStatement deleteImageStmt = conn.prepareStatement(deleteImageSql);

            // SQL 쿼리의 파라미터 값 설정
            deleteStmt.setInt(1, productNum);
            deleteImageStmt.setInt(1, productNum);

            // SQL 실행
            int rowsAffectedProduct = deleteStmt.executeUpdate();
            int rowsAffectedImage = deleteImageStmt.executeUpdate();

            if (rowsAffectedProduct > 0 && rowsAffectedImage > 0) {
                // 상품 및 이미지 삭제 성공 시
%>
                <script>
                    alert("삭제 성공");
                    location.href="./selledScreen.jsp";
                </script>
<%
            } else {
                // 상품 및 이미지 삭제 실패 시
%>
                <script>
                    location.href="./selledScreen.jsp";
                </script>
<%
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // 예외 발생 시 실패 페이지로 이동
            %>
            
           		 <script>
                    alert("구매요청내역이 있어 삭제할 수 없습니다");
                    location.href="./selledScreen.jsp";
                </script>
            
            <%
        } finally {
            // 연결과 관련된 자원을 해제
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }

            // 이미지 파일 삭제
            if (!imagePath.isEmpty()) {
                File imageFile = new File(imagePath);
                if (imageFile.exists()) {
                    imageFile.delete();
                }
            }
        }
    } else {
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>삭제 확인</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
          integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
</head>
<body>
<jsp:include page="loginMenu.jsp"/>
<div class="container mt-4">
    <h2 class="mb-4">삭제 확인</h2>
    <p>정말로 상품을 삭제하시겠습니까?</p>
    <form method="post" action="deleteProduct.jsp">
        <input type="hidden" name="productNum" value="<%= productNum %>">
        <input type="hidden" name="confirmDelete" value="true">
        <button type="submit" class="btn btn-danger">삭제</button>
        <a href="./selledScreen.jsp" class="btn btn-secondary">취소</a>
    </form>
</div>
</body>
</html>
<%
    }
%>
