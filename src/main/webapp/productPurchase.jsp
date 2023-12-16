<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>구매내역</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
          integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
</head>
<body>
<jsp:include page="loginMenu.jsp"/>

<div class="container mt-4">
    <h2 class="mb-4">구매내역</h2>
        <%@ include file="dbconn.jsp" %>
        <%
            // 세션에서 사용자 아이디 가져오기
            String userId = (String) session.getAttribute("userID");
            
            // 사용자 아이디를 사용하여 해당 사용자가 등록한 상품 조회
            String myProductSql = "SELECT * FROM product p JOIN productImage pi ON p.productNum = pi.productNum WHERE p.userId=?";
            pstmt = conn.prepareStatement(myProductSql);
            pstmt.setString(1, userId);
            rs = pstmt.executeQuery();
        %>

    <!-- 내가 보낸 구매요청이 있는 상품 섹션 -->
    <h4 class="mt-4 mb-2">내가 보낸 구매요청이 있는 상품</h4>
    <div class="row">
        <%
            // 사용자가 보낸 구매요청이 있는 상품 조회
            String myRequestSql = "SELECT * FROM product p JOIN request r ON p.productNum = r.productNum JOIN productImage pi ON p.productNum = pi.productNum WHERE r.userId=?";
            pstmt = conn.prepareStatement(myRequestSql);
            pstmt.setString(1, userId);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                int productNum = rs.getInt("productNum");
                String imagePath = rs.getString("imagePath");
        %>
        <!-- 상품 카드 표시 -->
        <div class="col-md-4 mb-4">
            <div class="card">
             <span class="badge badge-dark"><h3><%=rs.getString("productCategory")%></h3></span>
			    <li class="list-group-item">등록자 : <%= rs.getString("userId")  %></li>
			
               <img src="<%=request.getContextPath()%>/uploads/images<%=imagePath%>" class="card-img-top" width="300" height="300" alt="Product Image">

                <div class="card-body">
                
                <span class="badge badge-danger"><%=rs.getString("productCondition")%></span>
                <span class="badge badge-warning"><%=rs.getString("productTradeStatus")%></span>
                    <h5 class="card-title"><%=rs.getString("productName") %></h5>
                    
                    <p class="card-text"><%= rs.getString("productInfo") %></p>
                    
                </div>
            </div>
        </div>
        <% } %>
    </div>
</div>

</body>
</html>
