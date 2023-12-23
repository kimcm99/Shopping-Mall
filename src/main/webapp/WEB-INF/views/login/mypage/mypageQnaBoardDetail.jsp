<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@page import="java.lang.Math"%>
<%@page import="java.lang.Integer"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항</title>
<!-- css 양식 include -->
<%@include file="/WEB-INF/views/common/header.jsp"%>
<!-- css 불러오기 -->
<link rel="stylesheet" href="css/productDetailReview.css">
<!-- css 불러오기 -->
<link rel="stylesheet" href="css/productDetail.css">
<link rel="stylesheet" href="css/freeBoardDetail.css">
<style type="text/css">
.qna_btn {
	background-color: black;
    color: white;
    padding: 10px;
    display: block;
    margin-left:auto;
    width: 150px; /* 버튼을 100%로 설정하여 테이블 셀과 일치시킵니다. */
    white-space: nowrap; /* 텍스트 줄 바꿈 방지 */
}

.qna_btn:hover{
	background-color: #ffffff;
	color: #000000;
}
</style>
</head>
<body>

	<div class="div_freeBoardDetail" align="center">
		<table class="table_freeBoardDetail">



		<tr>
			<th>작성일</th>
			<td colspan="3" style="color: black;"><fmt:formatDate
												pattern="yyyy-MM-dd hh:mm" value="${board.qnareg}" /></td>
		</tr>
		<tr>
			<th>제목</th>
			<td colspan="3" style="color: black;">
				${board.qnatitle } 
			</td>
		</tr>


		<tr>
			<td colspan="4" style="color: black;">${board.qnacontent }</td>
		</tr>

		<c:if test="${board.qnaorifile != null }">
               <td colspan="4">
               	<img src="images/${board.qnaorifile}">
               </td>
            </c:if>

	</table>
	
	<c:if test="${board.qnayn == 'Y' }">
	<a href="mypageQnaBoardReplyDetail.do?qrid=${board.qrid}&qid=${board.qid}">답변 보기</a><br>
	</c:if>
	<button type="button" class="qna_btn" 
	onclick="location.href='mypageQnA.do?nowPage=${Integer.toString(Math.floor((board.rnum-1)/pp.cntPerPage)+1)}'">목록으로</button>
	</div>
</body>
</html>