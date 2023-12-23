<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
function add(){
	//submit을 통해 # 요청. 데이터를 insert. 그 후 부모창의 함수를 호출. 해당 함수에선
	//qna 목록을 재요청하도록 설정되어 있음. 그 후 window.self.close()를 사용하면 팝업창이 꺼지지 않을까? 
	//이때 onsubmit을 통해 return false를 해주면 실제 서브밋은 일어나지 않음
	//실제 서브밋이 일어나야 값이 전달되는데....
	window.opener.
	
}


</script>

<script src="http://code.jquery.com/jquery-latest.js"></script>

 <script type="text/javascript"> 
 $(function() { 
	    $('#insert').click(function(){
	        if ($('#qnatitle').val() == "") {
	            alert("제목을 입력해주세요");
	            $("#qnatitle").val("").focus();
	            return false;
	        }
	        
	        if ($('#qnacontent').val() == "") {
	            alert("내용을 입력해주세요");
	            $("#qnacontent").val("").focus();
	            return false;
	        }
	    }); 
	});
</script>   


</head>
<body class="is-preload">
	<c:if test="${result == 1 }">
		<script>
			window.self.close();
			alert("${msg}");
			location.href="mypageQnA.do";
		</script>
	</c:if>
	<c:if test="${result == -1 }">
		<script>
			alert("${msg}");
			history.go(-1);
		</script>
	</c:if>
	<!-- 게시글번호=시퀀스,회원이메일(아이디),qna제목,내용,첨부파일,qna 쓴 날짜(sysdate),삭제여부(초기값N),답변여부(초기값N) -->
	<div class="container" align="center">
		<h2>문의 작성</h2>
		<div class="inner">
			<form action="myPageQnaBoardInsert.do" method="post"
				enctype="multipart/form-data"
				onSubmit="return ">
				<!-- 이 페이지는 팝업창.  -->
				<!-- 경로를 부모창의 함수로 지정. 부모창에서 myPageQnaBoardInsert.do로. 그 후 팝업창은 꺼지고, 부모창은 새로고침 
		onSubmit="return 함수"로 반환되는 값이 참이라면 submit 수행. 아니라면 멈춤. 유효성 검사?-->
				<!-- submit을 통해 myPageQnaBoardInsert.do 요청. 데이터를 insert. 그 후 부모창의 함수를 호출. 해당 함수에선
		qna 목록을 재요청하도록 설정되어 있음. 그 후 window.self.close()를 사용하면 팝업창이 꺼지지 않을까? 
		onsubmit 값에 false를 반환하게 되면 실제 submit은 이뤄지지 않음-->
				<input type="hidden" name="memail" value="${board.memail}">
				<table class="table table-hover">
					<tr>
						<td>제목</td>
						<td><input type="text" size="52" maxlength="50"
							name="qnatitle" id="qnatitle"></td>
					</tr>
					<tr>
						<td>첨부파일</td>
						<td><input type="file" name="qnaorifile1"></td>
					</tr>
					<tr>
						<td>내용</td>
						<td><textarea cols="50" rows="10" name="qnacontent" id="qnacontent"></textarea></td>
					</tr>
					<tr>
						<td colspan="2"><input type="submit"
							style="margin-left: 325px" value="확인" id="insert"> <input
							type="reset" style="margin-left: 5px" value="취소"></td>
					</tr>
				</table>
			</form>
		</div>
	</div>
</body>
</html>