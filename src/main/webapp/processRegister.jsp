<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.Date" %>
<%@ include file="dbconn.jsp" %>


<%
    request.setCharacterEncoding("utf-8");

    String id = request.getParameter("userID");
    String passwd = request.getParameter("userPW");
    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String address = request.getParameter("address");

    try {
        if (id != null && !id.isEmpty()) {
            // 현재 날짜와 시간 가져오기
            Date currentDate = new Date();

            // SQL 쿼리 작성
            String sql = "insert into user(userId, userPw, userName, userEmail, userAddress, userRegister, userAuth) values (?, ?, ?, ?, ?, ?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, id);
            pstmt.setString(2, passwd);
            pstmt.setString(3, name);
            pstmt.setString(4, email);
            pstmt.setString(5, address);

            // 현재 날짜와 시간을 java.sql.Timestamp 형식으로 변환하여 설정
            pstmt.setTimestamp(6, new java.sql.Timestamp(currentDate.getTime()));


            pstmt.setString(7, "고객");


            int rowsAffected = pstmt.executeUpdate();

            // 업데이트가 성공했는지 확인
            if (rowsAffected > 0) {
                %>
                <script>
                alert("저장완료");
               location.href="./Home.jsp";
                
                </script>
                <% 
            } else {
                out.println("오류가 있습니다!");
            }
        } else {
            out.println("사용자 ID가 유효하지 않습니다.");
        }
    } catch (SQLException ex) {
        out.println("SQLException: " + ex.getMessage());
        ex.printStackTrace();
    } finally {

        if (pstmt != null) {
            try {
                pstmt.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
%>
