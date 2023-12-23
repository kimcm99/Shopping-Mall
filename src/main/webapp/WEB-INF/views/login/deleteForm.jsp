<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<link rel="stylesheet" href="./css/join.css">
<link rel="stylesheet" href="./css/default.css">
<title>회원탈퇴</title>
 
<script>
		function deleteconfirm(mEmail, mPwd) {
			var deleteConfirm = confirm("진짜 탈퇴 하시겠습니까?");
			if (deleteConfirm) {
				$.ajax({
					type : "POST",
					url : "deleteMember.do",
					data : {
						mEmail : mEmail,
						mPwd : mPwd
					},
					success : function(response) {
						if (response === "Y") {
							alert("회원 탈퇴가 되었습니다.");
							location.href = "Logout.do";
						} else {
							alert("회원 탈퇴에 실패했습니다.");
							location.href = "deleteForm.do";
						}
					},
					error : function() {
						alert("서버 오류가 발생했습니다.");
					}
				});
			}
		}
</script>


</head>
<body>
	<%@ include file="/WEB-INF/views/common/header.jsp"%>

	<div id="container" class="container">
		<div class="content">
			<div class="delete_wrap">
				<form id="join_frm" action="deleteMember.do" method="post">

					<div class="join_title">회원탈퇴</div>

					<div class="join_box" action="deleteMember.do">
						${member.mName } 님 감사합니다. <br>

						<input type="password" placeholder="비밀번호" name="mPwd" id="mPwd">

						<button type="button" id="join" class="join_btn"
							onclick="deleteconfirm('${member.mEmail}','${member.mPwd}')">탈퇴
							하기</button>
				</form>
			</div>
		</div>
	</div>

	<%@ include file="/WEB-INF/views/common/footer.jsp"%>

</body>
</html>