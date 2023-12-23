<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<link rel="stylesheet" href="css/LoginForm.css">
<script src="./js/member.js"></script>

<!-- 로그인 ajax로 처리함 -->
<script>
$(document).ready(function () {
	$("#btn").on("click", function () {
		event.preventDefault();
		var f = $('#insert_frm');
	    var formData = f.serialize();
	
	    $.ajax({
	        type: "POST",
	        url: f.attr('action'),
	        data: formData,
	        dataType: "json",
	        success: function (data) {
	            // 서버 응답에 따른 처리
	            if (data.result == "Y") {
	                alert("로그인 성공");
	                location.href = "main.do";
                } else if (data.result == "N") {
	                alert("로그인 실패");
                    location.href = "NaverLogin.do";
	            }
	        },
    	    error: function (data) {
 	           alert("에러 발생!");
            	console.log(data);
        	}
    	});
	});
});
</script>

</head>
   <%@ include file="/WEB-INF/views/common/header.jsp"%>
<body>
   <div class="LoginForm">
      <form method="post" action="login.do" id = "insert_frm">
         <input type="text" placeholder="이메일" class="in" id="mEmail" name="mEmail"> 
         <input type="password" placeholder="비밀번호" class="in" id="mPwd" name="mPwd"> 
         <input type="submit" id="btn" name = "btn" value="로그인"><br> 
         <input type="button" value="회원가입" onClick="location.href='insertForm.do' " name = "btn" id = "btn">
             <br>
      </form>
         <a href="https://kauth.kakao.com/oauth/authorize?response_type=code&client_id=45b48fcc29ad5a368b013958e9976afe&redirect_uri=http://ec2-3-25-94-162.ap-southeast-2.compute.amazonaws.com/kakaologin.do&response_type=code">
            <img src="./resources/login_image/kakao_login.png">
         </a> 
         <br>
         <br> 
         
         <a href="${url }"> 
            <img src="./resources/login_image/naver_login.png" width="183" height="45" alt="Naver로그인">
         </a>
   </div>      
   <br>
   <br>
   <br>
   <br>
   <br>
   <%@ include file="/WEB-INF/views/common/footer.jsp"%>
      
</body>
</html>