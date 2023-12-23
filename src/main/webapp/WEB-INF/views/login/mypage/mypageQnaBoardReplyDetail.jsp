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
<script>
	function back(){
		history.go(-1)
	}
</script>
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
												pattern="yyyy-MM-dd hh:mm" value="${reply.qrreg}" /></td>
		</tr>
		<tr>
			<td colspan="4" style="color: black;">${reply.qrcontent }</td>
		</tr>
	</table>
	<% 
		int id = Integer.parseInt(request.getParameter("qrid"));
		if(id == 0){
	%>
	<a href="javascript:back()">이전으로</a><br>
	<%
		}
	%>
	
	<% 
		if(id != 0){
	%>
	<button type="button" class="qna_btn" 
	onclick="location.href='mypageQnA.do?nowPage=${Integer.toString(Math.floor((reply.rnum-1)/pp.cntPerPage)+1)}'">목록으로</button>
	<%
		}
	%>
	</div>
	
	
</body>
</html>