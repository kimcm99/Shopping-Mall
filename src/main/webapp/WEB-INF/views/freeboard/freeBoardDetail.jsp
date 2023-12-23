<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자유게시판 상세페이지</title>

<!-- css 양식 include -->
<%@include file="/WEB-INF/views/common/header.jsp"%>

<!-- css 불러오기 -->
<link rel="stylesheet" href="css/freeBoardDetail.css">
<!-- css 불러오기 -->
<!-- <link rel="stylesheet" href="css/freeBoard.css"> -->
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script src="./js/freeboard.js"></script>

<script type="text/javascript">
	/* 	window.onload=function() {
	 } */
	$(function() {
		// 좋아요가 있는지 확인한 값을 likeval에 저장
		var likeval = '${like.likeDrop}'
		console.log(likeval);
		// likeval이 Y이면 좋아요가 이미 되있는것이므로 fill-heart.svg를 출력하는 코드
		if(likeval == "Y") {
            $("#heart").prop("src", "images/fill-heart.png");
         } else {
            $("#heart").prop("src", "images/bin-heart.png");
         }
		//기존 댓글 목록 요청 
		//load함수로 불러온 결과 페이지(freeboardReplyList.jsp)의 댓글 목록을 div태그사이에 출력
		//상세페이지 들어오자마자 자동으로 처리됨. 
		$('#replylist').load('FreeReplyList.do?fId=${detail.fId}')
		
		//로그인 했는지 확인 & 유효성 검사 
		$('#replyInsert').click(function() {
			console.log('${sessionScope.member}');
			if('${sessionScope.member}' == ''){
		 		alert("로그인 후에 글작성을 해주세요.");
		 		return false;
	 	    }
			if ($('#frContent').val() == '') {
				alert('댓글 입력후에 클릭하시오');
				$('#frContent').focus();
				return false;
			}
			var frmData = $('form').serialize();
			//form태그의 전달값들을 한꺼번에 구해옴 
			//#replylist 아이디 값에 data값을 출력하고, #frContent에 공백처리
			$.ajax({
				url : 'replyInsert.do',
				type : 'post',
				data : frmData,
				success : function(data) {
					$('#replylist').html(data);
					$('#frContent').val('');
				}
			}); // $.ajax() end			
		});

		// 좋아요 버튼을 클릭 시 실행되는 코드
        $("#div_fLike").on("click", function () {
         	if('${sessionScope.member}' == ''){
 		 		alert("로그인 후에 이용 해주세요.");
 		 		return false;
 	 	    }
		    $.ajax({
		    	url :'toggleLike.do',
		        type :'POST',
		        data : {'fId':${detail.fId}, 'mEmail':'${sessionScope.member.mEmail}'},
		    	success : function(data){
		    		
		    		console.log("data:"+ data);
		    		console.log("data.fboard.fLike:"+ data.fboard.fLike);
		    		console.log("data.like.likeDrop:"+ data.like.likeDrop);
		    		
		    		$("#heart_count").text(data.fboard.fLike);
		    		//$("#div_fLike").text('${data.fboard.fLike}');
		    		
		    		var likeval = data.like.likeDrop
					console.log(likeval);
					if(likeval == "Y") {
			            $("#heart").prop("src", "images/fill-heart.png");
			        } else {
			            $("#heart").prop("src", "images/bin-heart.png");
			        }
             	}
		    });
        });
    });
</script>
</head>
<body>
	<!-- 전체 div시작 -->
	<div class="div_freeBoardDetail">
		<table class="table_freeBoardDetail">
			<tr>
				<td>제목</td>
				<td><h1>${detail.fTitle}</h1></td>
			</tr>
			<tr>
				<td>작성자</td>
				<td>${detail.mEmail}</td>
			</tr>
			<tr>
				<td>작성일</td>
				<td><fmt:formatDate value="${detail.fReg}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
			</tr>
			<tr>
				<td>내용</td>
				<td><h2>
						<pre>${detail.fContent}</pre>
					</h2></td>
			</tr>
			<tr>
				<td>첨부파일</td>
				<td><c:if test="${empty detail.fImage}">
                  &nbsp;
                </c:if> <c:if test="${!empty detail.fImage}">
						<img src="images/${detail.fImage}" height="100" width="100" />
					</c:if></td>
			<tr>
				<td>조회수</td>
				<td>${detail.fReadCount}</td>
			</tr>
			<tr>
				<!--  heart : 좋아요O, fill-heart : 좋아요X -->
				<td>좋아요</td>
				<td>
					<div id="div_fLike">
						<div class="heart"
							style="text-decoration-line: none; cursor: pointer;">
							<img id="heart" src="images/bin-heart.png">
							<div id="heart_count">${detail.fLike}</div>
						</div>
					</div>
				</td>
			</tr>
		</table>

		<!-- button div 시작-->
		<!-- 로그인 되어있고 글작성자와 mEmail이 같을때 삭제/수정 버튼 보임 -->
		<div class="div_boardform_button" align="center">
			<c:if
				test="${!empty sessionScope.member && sessionScope.member.mEmail == detail.mEmail}">
				<input type="button" class="boardform_button" value="수정"
					onClick="location.href='freeBoardDetail.do?fId=${detail.fId}&page=${page}&state=update'">
				<input type="button" class="boardform_button" value="삭제"
					onClick="location.href='freeBoardDetail.do?fId=${detail.fId}&page=${page}&state=delete'">
			</c:if>
			<input type="button" class="boardform_button" value="목록"
				onClick="location.href='freeBoardList.do?page=${page}'">
		</div>
		<!-- button div 끝-->
		<!-- 전체 div끝 -->

		<p>
			<!--------- 댓글입력 div 시작------->
			<!--freereplycontroller로 부모글의fId전달  댓글단사람의  mEmail로해야함 추후 수정  -->
		<div class="div_reply form">
			<form name="frm" id="frm">
				<input type="hidden" name="mEmail"
					value="${sessionScope.member.mEmail}"> <input type="hidden"
					name="fId" value="${detail.fId}"> 댓글 :
				<textarea rows="2" cols="50" name="frContent" id="frContent"
					placeholder="댓글을 입력해 주세요."></textarea>
				<input type="button" value="확인" id="replyInsert"
					class="button_replyok">
			</form>
		</div>
		<div id="replylist"></div>
		<!-- <div id="list"></div> -->
	</div>
	<!-- 댓글입력 div 끝 -->

</body>

<!-- css 양식 include -->
<%@include file="/WEB-INF/views/common/footer.jsp"%>
</html>