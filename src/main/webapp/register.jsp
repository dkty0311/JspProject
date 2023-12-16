<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>회원가입</title>

  <!-- Bootstrap CSS -->
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">

  <style>

    .input-form {
      max-width: 680px;

      margin-top: 80px;
      padding: 32px;

      background: #fff;
      -webkit-border-radius: 10px;
      -moz-border-radius: 10px;
      border-radius: 10px;
      -webkit-box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15);
      -moz-box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15);
      box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15)
    }
  </style>
</head>

<body>

	<%@ include file="menu.jsp" %>



  <div class="container">
    <div class="input-form-backgroud row">
      <div class="input-form col-md-12 mx-auto">
        <h4 class="mb-3">회원가입</h4>
        <form class="validation-form" method="post" action="processRegister.jsp" novalidate>
    <div class="row">
        <div class="col-md-6 mb-3">
            <label for="userID">아이디</label>
            <input type="text" class="form-control" id="userID" name="userID" placeholder="" value="" required>
            <div class="invalid-feedback">
                아이디를 입력 해주세요.
            </div>
        </div>
        <div class="col-md-6 mb-3">
            <label for="userPW">비밀번호</label>
            <input type="password" class="form-control" id="userPW" name="userPW" placeholder="" value="" required>
            <div class="invalid-feedback">
                비밀번호를 입력해주세요.
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-md-6 mb-3">
            <label for="email">이메일</label>
            <input type="text" class="form-control" id="email" name="email" placeholder="" value="" required>
            <div class="invalid-feedback">
                이메일을 입력해주세요.
            </div>
        </div>
        <div class="col-md-6 mb-3">
            <label for="name">이름</label>
            <input type="text" class="form-control" id="name" name="name" placeholder="" value="" required>
            <div class="invalid-feedback">
                이름을 입력해주세요.
            </div>
        </div>
    </div>

    <div class="mb-3">
        <label for="address">주소</label>
        <input type="text" class="form-control" id="address" name="address" placeholder="서울특별시 강남구" required>
        <div class="invalid-feedback">
            주소를 입력해주세요.
        </div>
    </div>

    <hr class="mb-4">
    <div class="mb-4"></div>
    <button class="btn btn-primary btn-lg btn-block" type="submit">가입 완료</button>
</form>
      </div>
    </div>
  </div>
  
  	<%@ include file="footer.jsp" %>
  <script>
    window.addEventListener('load', () => {
      const forms = document.getElementsByClassName('validation-form');

      Array.prototype.filter.call(forms, (form) => {
        form.addEventListener('submit', function (event) {
          if (form.checkValidity() === false) {
            event.preventDefault();
            event.stopPropagation();
          }

          form.classList.add('was-validated');
        }, false);
      });
    }, false);
  </script>
</body>

</html>