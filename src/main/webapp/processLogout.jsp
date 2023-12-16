<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
    // 현재 세션을 가져오기
    HttpSession login = request.getSession(false);
    
    if (login != null) {
        
    	session.invalidate();
      
        %>
        <script>
        alert("로그아웃 완료");
        location.href="./Home.jsp";
       
   		 </script>
   		 <% 
    }
%>
