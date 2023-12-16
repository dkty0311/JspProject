<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <a class="navbar-brand" href="./Home.jsp">Trade Market</a>
    <div class="collapse navbar-collapse justify-content-end" id="navbarTogglerDemo01">
        <ul class="navbar-nav">
            <li class="nav-item <%= request.getRequestURI().endsWith("Home.jsp") ? "active" : "" %>">
                <a class="nav-link" href="./Home.jsp">홈</a>
            </li>
            <li class="nav-item <%= request.getRequestURI().endsWith("register.jsp") ? "active" : "" %>">
                <a class="nav-link" href="./register.jsp">회원가입</a>
            </li>
            <li class="nav-item <%= request.getRequestURI().endsWith("login.jsp") ? "active" : "" %>">
                <a class="nav-link" href="./login.jsp">로그인</a>
            </li>
        </ul>
    </div>
</nav>
