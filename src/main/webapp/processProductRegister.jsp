<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*, java.sql.*, java.util.*, javax.servlet.*, javax.servlet.http.*, com.oreilly.servlet.MultipartRequest, com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ include file="dbconn.jsp" %>

<%
// 세션에서 사용자 ID 가져오기
request.setCharacterEncoding("UTF-8");
session = request.getSession();
String userId = (String) session.getAttribute("userID");

// 세션에서 userId가 있는지 확인
if (userId == null) {
    out.println("<h2>로그인되어 있지 않습니다 </h2>");
} else {
    // 업로드 디렉토리 경로
	String uploadPath = request.getServletContext().getRealPath("/uploads/images");

// 업로드 디렉토리가 존재하지 않으면 생성
File uploadDir = new File(uploadPath);
if (!uploadDir.exists()) {
    uploadDir.mkdirs();
}

// 이미지 업로드를 위한 설정
MultipartRequest multi = new MultipartRequest(request, uploadPath, 5*1024*1024, "utf-8", new DefaultFileRenamePolicy());

    // 다른 폼 데이터 가져오기
    String productName = multi.getParameter("productName");
    String productPrice = multi.getParameter("price");
    String productInfo = multi.getParameter("description");
    String productCategory = multi.getParameter("category");
    String productCondition = multi.getParameter("condition");
    String productTrade = multi.getParameter("productTrade");
    String productLocation = multi.getParameter("productLocation");

    // 업로드한 이미지 파일명 가져오기
    String uploadedFileName = multi.getFilesystemName("uploadedFile");


    // 이미지 파일의 실제 경로
    String imagePath = uploadPath + File.separator + uploadedFileName;

    // 상품 정보 데이터베이스에 저장
    String insertProductSql = "INSERT INTO product (userId, productName, productPrice, productCategory, productInfo, productCondition, productTrade, productLocation, productRegister, productTradeStatus) VALUES (?, ?, ?, ?, ?, ?, ?, ?, NOW(), ?)";

    try (PreparedStatement insertProductStatement = conn.prepareStatement(insertProductSql, Statement.RETURN_GENERATED_KEYS)) {
        insertProductStatement.setString(1, userId);
        insertProductStatement.setString(2, productName);
        insertProductStatement.setString(3, productPrice);
        insertProductStatement.setString(4, productCategory);
        insertProductStatement.setString(5, productInfo);
        insertProductStatement.setString(6, productCondition);
        insertProductStatement.setString(7, productTrade);
        insertProductStatement.setString(8, productLocation);
        insertProductStatement.setString(9, "판매중");

        // 업데이트 실행
        int rowsAffectedProduct = insertProductStatement.executeUpdate();

        if (rowsAffectedProduct > 0) {
            // 상품 등록 성공

            // 등록된 상품의 productNum 가져오기
            ResultSet generatedKeysProduct = insertProductStatement.getGeneratedKeys();
            int productNum = 0;
            if (generatedKeysProduct.next()) {
                productNum = generatedKeysProduct.getInt(1);

                // 상품 이미지 정보 데이터베이스에 저장

                String insertImageSql = "INSERT INTO productImage (productNum, imagePath) VALUES (?, ?)";
                try (PreparedStatement insertImageStatement = conn.prepareStatement(insertImageSql)) {
                    insertImageStatement.setInt(1, productNum);

                    // 상대 경로로 변경하여 저장
                    String relativeImagePath = imagePath.replace(uploadPath, "");
                    insertImageStatement.setString(2, relativeImagePath);

                    // 이미지 정보 업데이트 실행
                    int rowsAffectedImage = insertImageStatement.executeUpdate();

                    if (rowsAffectedImage > 0) {
                        // 성공적으로 등록된 경우의 처리
                %>
                <script>
                    alert("상품 및 이미지 정보 등록이 완료되었습니다!");
                    location.href="./productShow.jsp";
                </script>
                <%
                    } else {
                        out.println("<h2>이미지 정보 저장 불가</h2>");
                    }
                

                }
            } else {
                out.println("<h2>상품번호를 생성하지 못했습니다 다시시도하세요!</h2>");
            }
        } else {
            out.println("<h2>상품을 등록하지 못했습니다</h2>");
        }
    }
}
%>

<%@ include file="footer.jsp" %>
