<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 문의 상세폼</title>

<!-- css 양식 include -->
<%@include file="/WEB-INF/views/common/header.jsp"%>
<!-- css불러오기 -->
<link rel="stylesheet" href="css/AskBoard.css">
<script src="http://code.jquery.com/jquery-latest.js"></script>

<script>
function deleteAsk(askid,pid) {
	   var confirmDelete = confirm("진짜 삭제하시겠습니까?");
	   console.log(askid);
	   if(confirmDelete){
		$.ajax({
	        type:"POST",
	        url: "productAskBoardDeleteCheck.do",
	        data: {askid: askid},
	        success: function (response) {
	            if (response === "Y") {
	                alert("문의글이 삭제 되었습니다.");
	                location.href = "productDetail.do?pid="+pid;
	            } else {
	                alert("문의글 삭제에 실패했습니다.");
	                location.href = "productAskBoardSelectForm.do?askid=" +askid + "&pid=" + pid;
	            }
	        },
	       error: function(jqXHR, textStatus, errorThrown) {
	        	console.error("Error:", textStatus, errorThrown);
	            alert("서버 오류가 발생했습니다.");
	        }
	    });
	   }
	}
</script>

</head>
<body>
	<div class="Ask_insert">
		<h1 class="" align="center">문의 상세</h1>
		<form method="post"
			action="productAskBoardUpdateForm.do?askid=${askboard.askid }&pid=${askboard.pid}">

			<table class="askinsert_table">
				<tr>
					<th>상품번호</th>
					<td class=""><input type="text" class="input_box" name="pid"
						readonly="readonly" value="${askboard.pid}"></td>
				</tr>
				<tr>
					<th>작성자</th>
					<td class=""><input type="text" class="input_box"
						name="memail" readonly="readonly" value="${askboard.memail}"></td>
				</tr>
				<tr>
					<th>상품문의날짜</th>
					<fmt:formatDate value="${askboard.askreg }" var="formatDate"
						pattern="YYYY년 MM월 dd일" />
					<td class="">${formatDate }</td>
				</tr>


				<tr>
					<!-- 추가할수도 -->
				</tr>


				<tr>
					<th>상품문의내용</th>
					<td><textarea rows="10" cols="50" class="input_box"
							id="askcontent" name="askcontent" readonly="readonly">${askboard.askcontent }</textarea></td>
				</tr>
			</table>

			<div class="ask_insert_button">
				<c:if test="${member.mEmail eq askboard.memail }">
					<input type="submit" value="수정" class="review_insert_button" />
					<input type="button" value="삭제" class="review_insert_button"
						onclick="deleteAsk(${askboard.askid },${askboard.pid })" />
				</c:if>
				 <input type="reset" value="취소" class="review_insert_button"
					onclick="history.go(-1)" />
			</div>
		</form>
	</div>


	<!-- css 양식 include -->
	<%@include file="/WEB-INF/views/common/footer.jsp"%>
</body>
</html>