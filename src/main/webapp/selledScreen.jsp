<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>판매내역</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
          integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
</head>
<body>
<jsp:include page="loginMenu.jsp"/>

<div class="container mt-4">
    <h2 class="mb-4">판매내역</h2>

    <!-- 내가 등록한 상품 섹션 -->
    <h4 class="mb-2">내가 등록한 상품</h4>
    <div class="row">
        <%@ include file="dbconn.jsp" %>
        <%
            // 세션에서 사용자 아이디 가져오기
            String userId = (String) session.getAttribute("userID");
            
            // 사용자 아이디를 사용하여 해당 사용자가 등록한 상품 조회
            String myProductSql = "SELECT * FROM product p JOIN productImage pi ON p.productNum = pi.productNum WHERE p.userId=?";
            pstmt = conn.prepareStatement(myProductSql);
            pstmt.setString(1, userId);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                int productNum = rs.getInt("productNum");
                String imagePath = rs.getString("imagePath");
        %>
        <!-- 상품 카드 표시 -->
        <div class="col-md-4 mb-4">
            <div class="card">
                <ul class="list-group list-group-flush">
                    <li class="list-group-item">카테고리 : <%= rs.getString("productCategory") %></li>
                    <li class="list-group-item">등록자 : <%= rs.getString("userId")  %></li>
                </ul>
                <!-- 이미지 표시 -->
                <img src="<%=request.getContextPath()%>/uploads/images<%=imagePath%>" class="card-img-top" width="300" height="300" alt="Product Image">
                <div class="card-body">
                    <h5 class="card-title"><%= rs.getString("productName") %></h5>
                    <p class="card-text"><%= rs.getString("productInfo") %></p>
                </div>
                <form action="deleteProduct.jsp" method="post">
                    <input type="hidden" name="productNum" value="<%= productNum %>">
                    <button type="submit" class="btn btn-danger btn-block">상품 삭제</button>
                </form>
            </div>
        </div>
        <% } %>
    </div>

    <!-- 구매요청이 온 상품 섹션 -->
    <h4 class="mt-4 mb-2">구매요청이 온 상품</h4>
    <div class="row">
        <%
            // 사용자에게 온 구매요청이 있는 상품 조회
            String requestProductSql = "SELECT * FROM product p JOIN request r ON p.productNum = r.productNum JOIN productImage pi ON p.productNum = pi.productNum WHERE p.userId=?";
            pstmt = conn.prepareStatement(requestProductSql);
            pstmt.setString(1, userId);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                int productNum = rs.getInt("productNum");
                String imagePath = rs.getString("imagePath");
        %>
        <!-- 상품 카드 표시 -->
        <div class="col-md-4 mb-4">
            <div class="card">
                <ul class="list-group list-group-flush">
                    <li class="list-group-item">요청시간: <%= rs.getString("requestTime") %></li>
                <li class="list-group-item">요청자 : <%= rs.getString("r.userId") %></li>
                </ul>
                <!-- 이미지 표시 -->
                <img src="<%=request.getContextPath()%>/uploads/images<%=imagePath%>" class="card-img-top" width="300" height="300" alt="Product Image">
                <div class="card-body">
                    <h5 class="card-title"><%= rs.getString("productName") %></h5>
                    <p class="card-text"><%= rs.getString("productInfo") %></p>
                </div>
                <ul class="list-group list-group-flush">
                    <li class="list-group-item">등록일 : <%= rs.getString("productRegister") %></li>
                    <!-- 여기에 구매요청 처리 버튼 또는 링크 추가 -->
                </ul>
                <form action="processRequestAccept.jsp" method="post">
			        <input type="hidden" name="productNum" value="<%= rs.getString("productNum") %>">
			        <button type="submit" class="btn btn-primary btn-block">구매요청 수락하기</button>
    			</form>
    			<form action="processRequestRefusing.jsp" method="post">
			        <input type="hidden" name="productNum" value="<%= rs.getString("productNum") %>">
			        <button type="submit" class="btn btn-danger btn-block">구매요청 거절하기</button>
    			</form>
            </div>
        </div>
        <% } %>
    </div>
</div>

</body>
</html>
