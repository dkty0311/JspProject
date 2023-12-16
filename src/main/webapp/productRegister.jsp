	<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>상품등록</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
          integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

     
          
          
          
          
     <style>
			body
			{
			  background-color:#f5f5f5;
			}
			.imagePreview {
			    width: 100%;
			    height: 180px;
			    background-position: center center;
			  background-color:#fff;
			    background-size: cover;
			  background-repeat:no-repeat;
			    display: inline-block;
			  box-shadow:0px -3px 6px 2px rgba(0,0,0,0.2);
			}
			.btn-info
			{
			  display:block;
			  border-radius:0px;
			  box-shadow:0px 4px 6px 2px rgba(0,0,0,0.2);
			  margin-top:-5px;
			}
			.imgUp
			{
			  margin-bottom:15px;
			}
			.del
			{
			  position:absolute;
			  top:0px;
			  right:15px;
			  width:30px;
			  height:30px;
			  text-align:center;
			  line-height:30px;
			  background-color:rgba(255,255,255,0.6);
			  cursor:pointer;
			}
			.imgAdd
			{
			  width:30px;
			  height:30px;
			  border-radius:50%;
			  background-color:#4bd7ef;
			  color:#fff;
			  box-shadow:0px 0px 2px 1px rgba(0,0,0,0.2);
			  text-align:center;
			  line-height:30px;
			  margin-top:0px;
			  cursor:pointer;
			  font-size:15px;
			}
     
     
     </style>
</head>
<body>
<jsp:include page="loginMenu.jsp"/>

<div class="container mt-4">
    <h2 class="mb-4">상품 등록</h2>
        <br>
        <div class="container">
    

</div>


<div class= "container">
    <form name="newProduct" method="post" action="processProductRegister.jsp" class = "form-horizontal" enctype="multipart/form-data">

        <div class="form-group">
        <div class="row">
        <div class="col-sm-2 imgUp">
            <div class="imagePreview"></div>
            <label class="btn btn-info">
                이미지 등록
                <input type="file" name="uploadedFile" class="uploadFile img" value="Upload Photo"
                       style="width: 0px; height: 0px; overflow: hidden;">
            </label>
        </div>
        <i class="fas fa-plus imgAdd"></i>
    </div>
            <label for="productName">상품이름</label>
            <input type="text" class="form-control"  name="productName" required>

            <label for="price">상품 가격</label>
            <input type="number" class="form-control" id="price" name="price" required>
            
             <label for="productName">거래지역</label>
            <input type="text" class="form-control"  name="productLocation" required>

            <label for="description">상품 설명</label>
            <textarea class="form-control" id="description" name="description" rows="3" required></textarea>
				<br>
             <label class="my-1 mr-2" for="inlineFormCustomSelectPref"><h5>카테고리</h5></label>
				  <select class="custom-select my-1 mr-sm-2" name="category" id="inlineFormCustomSelectPref">

				    <option selected value="기타">카테고리를 선택하세요</option>
			        <option value="도서">도서</option>
			        <option value="의류">의류</option>
			        <option value="가구">가구</option>
			        <option value="가전제품">전자/가전제품</option>
			        <option value="컴퓨터/노트북">컴퓨터/노트북</option>
			        <option value="스포츠용품">스포츠용품</option>
			        <option value="음악/악기">음악/악기</option>
			        <option value="자동차용품">자동차용품</option>
			        <option value="화장품/미용">화장품/미용</option>
			        <option value="식품">식품</option>
			        <option value="완구/취미">완구/취미</option>
			        <option value="반려동물용품">반려동물용품</option>
			        <option value="가전제품">가전제품</option>
			        <option value="헬스/피트니스">헬스/피트니스</option>
			        <option value="가든/애완">가든/애완</option>
			        <option value="취미/수집">취미/수집</option>
			        <option value="기타">기타</option>
				  </select>
        </div>
        
        <div class="form-group">
            <h5>상품 상태</h5>
            <div class="form-check">
                <input class="form-check-input" type="radio" name="condition" id="new" value="새 상품" checked>
                <label class="form-check-label" for="new">
                    새 상품
                </label>
            </div>
            <div class="form-check">
                <input class="form-check-input" type="radio" name="condition" id="usedGood" value="사용감 있음">
                <label class="form-check-label" for="usedGood">
                    사용감 있음
                </label>
            </div>
            <div class="form-check">
                <input class="form-check-input" type="radio" name="condition" id="usedPoor" value="사용감 많음">
                <label class="form-check-label" for="usedPoor">
                    사용감 많음
                </label>
            </div>
        </div>
        
        
        <div class="form-group">
          <h5>교환가능 여부</h5>
            <div class="form-check">
                <input class="form-check-input" type="radio" name="productTrade" value="교환 가능" checked>
                <label class="form-check-label" for="new">
                 	교환 가능
                </label>
            </div>
            <div class="form-check">
                <input class="form-check-input" type="radio" name="productTrade" value="교환 불가">
                <label class="form-check-label" for="usedGood">
                  교환 불가
                </label>
                </div>
        </div>
        
        
        
        <button type="submit" class="btn btn-primary">상품 등록하기</button>
    </form>
    </div>
    <br>

</div>
<%@ include file="footer.jsp" %>
		
		<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
		        integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
		        crossorigin="anonymous"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"
		        integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1"
		        crossorigin="anonymous"></script>
		<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
		        integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
		        crossorigin="anonymous"></script>
		        <script>
		        
		        
		        
    $(".imgAdd").click(function () {
        var imageCount = $(this).closest(".row").find('.imgUp').length;
        if (imageCount < 5) {
            $(this).closest(".row").find('.imgAdd').before('<div class="col-sm-2 imgUp"><div class="imagePreview"></div><label class="btn btn-info">이미지 등록<input type="file" class="uploadFile img" value="Upload Photo" style="width:0px;height:0px;overflow:hidden;"></label><i class="fa fa-times del"></i></div>');
        } else {
            alert("이미지는 최대 5개까지 등록 가능합니다.");
        }
    });

    $(document).on("click", "i.del", function () {
        $(this).parent().remove();
    });

    $(function () {
        $(document).on("change", ".uploadFile", function () {
            var uploadFile = $(this);
            var files = !!this.files ? this.files : [];
            if (!files.length || !window.FileReader) return;

            if (/^image/.test(files[0].type)) {
                var reader = new FileReader();
                reader.readAsDataURL(files[0]);

                reader.onloadend = function () {
                    uploadFile.closest(".imgUp").find('.imagePreview').css("background-image", "url(" + this.result + ")");
                }
            }
        });
    });
</script>


    
</body>
</html>
