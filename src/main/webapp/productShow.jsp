<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>상품</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
          integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
</head>
<body>
<jsp:include page="loginMenu.jsp"/>

<div class="container mt-4">
    <h2 class="mb-4">상품</h2>

    <div class="row">
        <%@ include file="dbconn.jsp" %>
        <% 
           String sql = "SELECT * FROM product p JOIN productImage pi ON p.productNum = pi.productNum";
           pstmt = conn.prepareStatement(sql);
           rs= pstmt.executeQuery();
           
           while (rs.next()) {
               String imagePath = rs.getString("imagePath"); // 이미지 경로 가져오기
               
        %>
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
              <form action="processRequest.jsp" method="post">
			        <input type="hidden" name="productNum" value="<%= rs.getString("productNum") %>">
			        <button type="submit" class="btn btn-primary btn-block">구매요청 하기</button>
    			</form>
    		
    			<form action="processAddLike.jsp" method="post">
			        <input type="hidden" name="productNum" value="<%= rs.getString("productNum") %>">
			        <button type="submit" class="btn btn-info btn-block">찜 목록 추가하기</button>
    			</form>
            </div>
        </div>
        <% } %>

    </div>

</div>

</body>
</html>
