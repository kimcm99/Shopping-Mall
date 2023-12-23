<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="http://code.jquery.com/jquery-latest.js"></script>
<link rel="stylesheet" href="css/masterCss.css">
<script src="js/master.js"></script>
<script src="js/masterQnaBoard.js" ></script> 
<title>Qna 상세정보</title>

</head>
<body>
	<%@ include file="../common/masterNav.jsp"%>
	<form method="post" action="masterQnaReplyInsert.do">
		<input type="hidden" name="memail" value="${qnaBoard.memail  }">
		<input type="hidden" name="qid" value="${qnaBoard.qid }">

		<div class="container">
			<h1 class="h1_caption">Qna 상세정보</h1>

			<table>
				<tr>
					<th>게시글 번호</th>
					<th>ID</th>
					<th>제목</th>
					<th>내용</th>
					<th>첨부파일</th>
					<th>작성일</th>
					<th>삭제여부[Y/N]</th>
					<th>관리</th>
				</tr>
				<tr>
					<td>${qnaBoard.qid}</td>
					<td>${qnaBoard.memail}</td>
					<td>${qnaBoard.qnatitle}</td>
					<td>${qnaBoard.qnacontent}</td>
					<td><img src="images/${qnaBoard.qnaorifile}" width="50"
						height="50">
					<td><fmt:formatDate value="${qnaBoard.qnareg}" pattern="yyyy-MM-dd HH:mm" /></td>

					<td>${qnaBoard.qnadrop}</td>
					<td>
						<%-- <button type="button"
							onclick="location.href='masterReviewUpdateForm.do?rid=${review.rid}'">수정</button> --%>
						<button type="button"
							onclick="location.href='masterQnaBoardDelete.do?id=${qnaBoard.qid}' ">삭제</button>
					</td>
				</tr>
			</table>

			<table class="fancy_table">
				<tr>
					<th>제목</th>
					<td>${qnaBoard.qnatitle}</td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
				</tr>
				<tr>
					<th>작성자</th>
					<td>${qnaBoard.memail}</td>
					<th>작성일</th>
					<td><fmt:formatDate pattern="yyyy-MM-dd"
							value="${qnaBoard.qnareg}" /></td>
					<th>삭제여부[Y/N]</th>
					<td>${qnaBoard.qnadrop}</td>
				</tr>
				<tr>
					<th>내용</th>
					<td colspan="5"><textarea readonly="readonly">${qnaBoard.qnacontent }</textarea></td>
				</tr>
			</table>
			<table class="fancy_table" width="50%" align="lift">
				<tr>
					<th colspan="5">답변</th>
				</tr>
				<c:if test="${qnaReply.qrcontent == null}">
					<tr>
						<td colspan="5" autofocus="autofocus"><textarea
								id="qrcontent" name="qrcontent">${qnaReply.qrcontent }</textarea></td>

					</tr>
			</table>
			<%-- <c:if test="${qnaReply.qrcontent == null}"> --%>
			<button type="submit">답변</button>
			</c:if>

		</div>
	</form>

	<c:if test="${qnaReply.qrcontent != null}">
		<form method="post" action="masterQnaBoardUpdate.do">
			<input type="hidden" name="qid" value="${qnaReply.qid}">
			<tr>
				<td colspan="5" autofocus="autofocus"><textarea
						name="qrcontent">${qnaReply.qrcontent }</textarea></td>

			</tr>
			</table>
			<button type="submit">답변수정</button>
		</form>
		<%-- <button type="submit" onclick="location.href='masterQnaBoardUpdate.do?qrid=${qnaReply.qrid}'">답변수정</button> --%>
	</c:if>



</body>
</html>