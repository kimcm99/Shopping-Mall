<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자유게시판 글작성폼</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>

<script src="./js/freeboard.js"></script>

<!-- css 양식 include -->
 <%@include file="/WEB-INF/views/common/header.jsp"%> 

<!-- css 불러오기 -->
<link rel="stylesheet" href="css/freeBoardform.css">

<!-- 글작성 성공 여부 판별 후 페이지 이동 -->
	<c:if test="${result == 1 }">
		<script type="text/javascript">
			alert("글작성 성공");
			location.href = "freeBoardList.do";
		</script>
	</c:if>
	<c:if test="${result <= 0 }">
		<script type="text/javascript">
			alert("입력 실패");
			history.go(-1);
		</script>
	</c:if>
	<c:if test="${result == 2 }">
	<script>
		alert("파일은 1000KB까지 업로드 가능합니다.");
		history.go(-1);
	</script>
</c:if>

<c:if test="${result == 3 }">
	<script>
		alert("첨부파일은 jpg, gif, png파일만 업로드 가능합니다.");
		history.go(-1);
	</script>
</c:if>


</head>
<body>
<!-- 전체 div시작 -->
<div class="div_insertform">

  <form action="freeBoardInsertok.do" method="post" onSubmit="return board_check()" enctype="multipart/form-data">
  	<input type="hidden" name="mEmail"  id="mEmail" value="${sessionScope.member.mEmail}">
  	<input type="hidden" id="fPassword" value="${sessionScope.member.mPwd}">
  <table class="table_insertform">
  <tr>
  <th>제목</th>
  <td><input type="text" name="fTitle" id="fTitle" placeholder="제목을 입력해 주세요" size="90"></td>
  </tr>
  <tr>
  <th>내용</th>
  <td><textarea name="fContent" id="fContent" cols="90" rows="30" placeholder="내용을 입력해 주세요"></textarea></td>
  </tr>
      <tr>
     <th>첨부파일</th>
     <td>
      <input type="file" name="freeImage" />
     </td><!-- name: 프로퍼티명과 다르게해야 오류가 안뜸 -->
    </tr>
  <%-- <tr>
  	<th>작성자</th>
  	<td><input type="text" name="mEmail" id="mEmail" value="${member.mEmail}" size="30" class="table_td_text"></td>
  </tr>
  <tr>
  <th>비밀번호</th>
  <td><input type="password" name="fPassword" id="fPassword"  size="30" class="table_td_text"></td>
  </tr> --%>
  </table>
  
  
<!-- button div 끝-->
<div class="div_boardform_button">
<button type="button"  class="boardform_button"
		onClick="location.href='freeBoardList.do'">취소</button>
<input type="submit" class="boardform_button" value="등록">
</div>
<!-- button div 끝-->
		
		
  </form>
</div><!-- 전체 div끝 -->
</body>

	<!-- css 양식 include -->
<%@include file="/WEB-INF/views/common/footer.jsp"%>
</html>