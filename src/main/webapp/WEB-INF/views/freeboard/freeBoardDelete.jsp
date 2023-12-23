<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자유게시판 글삭제폼</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script src="./js/freeboard.js"></script>
<!-- css 양식 include -->
<%@include file="/WEB-INF/views/common/header.jsp"%> 

<!-- css 불러오기 -->
<link rel="stylesheet" href="css/freeBoardform.css">


<!-- 글삭제 성공 여부 판별 후 페이지 이동 -->
	<c:if test="${result > 0 }">
		<script type="text/javascript">
			alert("삭제 성공");
			location.href = "freeBoardList.do?page=${page}";
		</script>
	</c:if>
	<c:if test="${result <= 0 }">
		<script type="text/javascript">
			alert("삭제 실패");
			history.go(-1);
		</script>
	</c:if>
	
</head>
<body>
<!-- 전체 div시작 -->
<div class="div_insertform">
  <form action="freeBoardDeleteok.do" method="post" onSubmit="return board_del_check()">
  <input type="hidden" name="fId" value="${detail.fId}"/>
  <input type="hidden" name="page" value="${page}"/>
  <!-- 비회원 글삭제 방지를 위한 id값설정 -->
   <input type="hidden" id="mEmail" value="${sessionScope.member.mEmail}">
  
  <table class="table_insertform">
  <tr>
  <th>비밀번호</th>
  <td><input type="password" name="fPassword" id="fPassword"  size="30" class="table_td_text"></td>
  </tr>  
  </table>
  
<!-- button div 끝-->
<div class="div_boardform_button">
<input type="button"  class="boardform_button" value="취소"
		onClick="history.go(-1)">
<input type="submit" class="boardform_button" value="삭제"></button>
</div>
<!-- button div 끝-->
		
  </form>
</div><!-- 전체 div끝 -->
</body>

	<!-- css 양식 include -->
<%@include file="/WEB-INF/views/common/footer.jsp"%>
</html>