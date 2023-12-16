<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <a class="navbar-brand" href="./Home.jsp">Trade Market</a>
    <div class="collapse navbar-collapse justify-content-end" id="navbarTogglerDemo01">
        <ul class="navbar-nav">
            <li class="nav-item <%= request.getRequestURI().endsWith("Home.jsp") ? "active" : "" %>">
                <a class="nav-link" href="./Home.jsp">홈</a>
            </li>
            <li class="nav-item <%= request.getRequestURI().endsWith("productShow.jsp") ? "active" : "" %>">
                <a class="nav-link" href="./productShow.jsp">상품</a>
            </li>
            <li class="nav-item <%= request.getRequestURI().endsWith("productRegister.jsp") ? "active" : "" %>">
                <a class="nav-link" href="./productRegister.jsp">상품 등록</a>
            </li>
            <li class="nav-item <%= request.getRequestURI().endsWith("selledScreen.jsp") ? "active" : "" %>">
                <a class="nav-link" href="./selledScreen.jsp">판매내역</a>
            </li>
            <li class="nav-item <%= request.getRequestURI().endsWith("productPurchase.jsp") ? "active" : "" %>">
                <a class="nav-link" href="./productPurchase.jsp">구매내역</a>
            </li>
            <li class="nav-item <%= request.getRequestURI().endsWith("likeList.jsp") ? "active" : "" %>">
                <a class="nav-link" href="./likeList.jsp">찜 목록</a>
            </li>
            
            <li class="nav-item <%= request.getRequestURI().endsWith("processLogout.jsp") ? "active" : "" %>">
                <a class="nav-link" href="./processLogout.jsp">로그아웃</a>
            </li>
        </ul>
    </div>
</nav>
