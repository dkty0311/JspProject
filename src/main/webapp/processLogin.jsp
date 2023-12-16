<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.Date" %>
<%@ include file="dbconn.jsp" %>

<html>

<head>
    <title>Login Processing</title>
</head>

<body>

<%
    request.setCharacterEncoding("utf-8");

    String id = request.getParameter("userID");
    String passwd = request.getParameter("userPW");

    try {
        // SQL 쿼리 작성 - 사용자 인증을 위한 쿼리
        String sql = "SELECT * FROM user WHERE userId=? AND userPw=?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, id);
        pstmt.setString(2, passwd);

        // 쿼리 실행
       rs = pstmt.executeQuery();

        // 결과가 있는 경우
        if (rs.next()) {
            
            String userAuth = rs.getString("userAuth");
            String userName = rs.getString("userName");
            
            if ("고객".equals(userAuth)) {
                // 세션에 사용자 정보 저장
                session.setAttribute("userID", id);
                session.setAttribute("userName", userName);
                
                %>
                <script>
                    alert("로그인 성공. 홈페이지로 이동합니다.");
                    location.href="./Home.jsp";
                </script>
                <%


            }
        } else {
            // 사용자 인증 실패
            %>
            <script>
                alert("로그인 실패. 아이디 또는 비밀번호를 확인하세요.");
                location.href="./login.jsp";
            </script>
            <%
        }

    } catch (SQLException ex) {
        // SQL 예외 처리
        %>
        <script>
            alert("로그인 중 오류가 발생했습니다. 다시 시도하세요.");
            location.href="./login.jsp";
        </script>
        <%
        ex.printStackTrace();
    } finally {
        // 자원 해제
        if (pstmt != null) {
            try {
                pstmt.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
%>

</body>
</html>
