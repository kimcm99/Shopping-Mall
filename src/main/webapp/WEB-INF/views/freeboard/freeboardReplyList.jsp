<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- css 불러오기 -->
<link rel="stylesheet" href="css/freeBoardDetail.css">
<!-- css 불러오기 -->
<link rel="stylesheet" href="css/freeBoard.css">

<script src="http://code.jquery.com/jquery-latest.js"></script>	
<script type="text/javascript">
//'edit1'인 요소를 클릭하면 해당 테이블 셀의 텍스트 내용이 텍스트 영역으로 바뀌고 
//사용자가 편집을 확인하거나 취소할 수 있는 두 개의 버튼('확인' 및 '취소')이 표시
$(function() {
	$('.edit1').click(function() {
		var id  = $(this).attr('id');  // this:사용자가 선택한 id의 버튼의 id속성값을 id에 저장
		var txt = $('#td_'+id).text(); // text():text내용을 가져오고 id속성값의 txt와 확인 취소 버튼을 가져옴
		$('#td_'+id).html("<textarea rows='3' cols='30' id='tt_"+id+"'>"+txt
			+"</textarea>");
		$('#btn_'+id).html(
		   "<input type='button' value='확인' onclick='up("+id+")'> "
		  +"<input type='button' value='취소' onclick='lst()'>");
	});  //onclick='up("+id+")' :밑의 up() 함수 호출 
});

//id속성값에 맞는 값을 변수에 저장해서 controller로 보내서 수정 및 삭제 후 replylist로 보냄 
function up(id) { //댓글 내용 수정 
	var frContent = $('#tt_'+id).val();
	var formData = "frId="+id+'&frContent='+frContent+"&fId=${detail.fId}";
	
// 	$.post('freereplyUpdate.do',formData, function(data) {
// 		$('#replylist').html(data);
// 	});
 			$.ajax({
				url : 'freereplyUpdate.do',
				type : 'post',
				data : formData,
				success : function(data){
					$('#replylist').html(data);
				}				
			}); // $.ajax() end	
}
function lst() { //취소 버튼 
	$('#replylist').load('FreeReplyList.do?fId=${detail.fId}');
}
function del(frId,fId) { //삭제 버튼 (클릭시 바로 삭제)
	var formData="frId="+frId+"&fId="+fId;
// 	$.post('freereplyDelete.do',formData, function(data) {
// 		$('#replylist').html(data);
// 	});
			$.ajax({
				url : 'freereplyDelete.do',
				type : 'post',
				data : formData,
				success : function(data){
					$('#replylist').html(data);
				}				
			}); // $.ajax() end	
}

</script>

</head>
<body>

	<!---------------------댓글 목록 div시작------------------------------>
	<div class="community">
		<table class=table_community>
		<br>
			<caption>댓글 ${replycount}개 보기</caption>
			<tr>
				<td width="6%">작성자</td>
				<td width="25%">내용</td>
				<td width="8%">작성일</td>
				<td width="10%"></td>
			</tr>

			<c:if test="${empty freplylist}">
				<tr>
					<td colspan="6">아직 댓글이 없습니다. 댓글을 남겨보세요.</td>
				</tr>
			</c:if>


			<c:if test="${not empty freplylist}">
				<!-- 글목록 list출력 시작 -->
				<c:forEach var="frboard" items="${freplylist}">
					<tr>
						<!-- 삭제글인지 아닌지 판별 -->
<%-- 						<c:if test="${frboard.frDrop =='Y' }"> --%>
<!-- 							<td colspan="6">삭제된 데이터 입니다</td> -->
<%-- 						</c:if> --%>

						<c:if test="${frboard.frDrop !='Y' }">
							<td>${frboard.mEmail}</td>
							<td id="td_${frboard.frId}">${frboard.frContent}</td>
							<td><fmt:formatDate value="${frboard.frReg}"
									pattern="yyyy-MM-dd" /></td>
							<td id="btn_${frboard.frId}">
							<!-- 댓글 작성자 이메일과 로그인된 이메일 값이 같으면  -->
								<c:if test="${frboard.mEmail == sessionScope.member.mEmail}">
									<input type="button" value="수정" class="edit1" id="${frboard.frId}">
									<input type="button" value="삭제" class="edit1" 
											onclick="del(${frboard.frId},${frboard.fId})">
								</c:if>
							</td>
						</c:if>
					</tr>
				</c:forEach>
			</c:if>
			<!-- 글목록 list출력 끝-->
		</table>
	</div>
	<!---------------------댓글 목록 div시작------------------------------>
</body>
</html>