<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<!--
	Phantom by HTML5 UP
	html5up.net | @ajlkn
	Free for personal and commercial use under the CCA 3.0 license (html5up.net/license)
-->
<html>
<head>
<title>Phantom by HTML5 UP</title>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, user-scalable=no" />
<link rel="stylesheet" href="assets/css/main.css" />
<noscript>
	<link rel="stylesheet" href="assets/css/noscript.css" />
</noscript>

<script src="http://code.jquery.com/jquery-latest.js"></script>

 <script type="text/javascript"> 
 $(function() { 
	    $('#search').click(function(){
	    	if ($('#searchtype').val() == "") {
	            alert("검색 유형을 선택해주세요");
	            return false;
	        }
	    
	        if ($.trim($('#keyword').val()) == "") {
	            alert("검색어를 입력해주세요");
	            $("#keyword").val("").focus();
	            return false;
	        }
	        
	    }); 
	});
</script> 

<script>
	function popup(a, b) {
		location.href = "masterNoticeSearchInsertForm.do?searchtype=" + a
				+ "&keyword=" + b
				+ "&nowPage=${pp.nowPage }&cntPerPage=${pp.cntPerPage }"
	}

	function deleteCheck(a, b, c) {
		if (window.confirm("삭제하시겠습니까?")) {
			location.href = "masterNoticeSearchDelete.do?mnId=" + a
					+ "&searchtype=" + b + "&keyword=" + c
					+ "&nowPage=${pp.nowPage }&cntPerPage=${pp.cntPerPage }"
			alert("삭제되었습니다!")
		}
		event.stopPropagation()
	}

	function update(a, b, c, d) {
		location.href = "masterNoticeSearchUpdateForm.do?rnum=" + a + "&mnId="
				+ b + "&searchtype=" + c + "&keyword=" + d
				+ "&cntPerPage=${pp.cntPerPage}";
		event.stopPropagation()
	}
</script>

<style type="text/css">
body {
	margin: 0;
	padding: 0;
}

.content {
	padding: 16px;
	overflow-y: auto;
	box-sizing: border-box;
	margin-left: 20%; /* 사이드바 너비만큼 여백을 주기 위해 조절 */
}

.ordertable {
	border-collapse: collapse;
	width: 800px;
	margin-bottom: 10px;
}

.ordertable th, .ordertable td {
	border: 1px solid #ddd;
	padding: 8px;
	text-align: center;
	white-space: nowrap; /* 텍스트 줄바꿈 방지 */
	overflow: hidden; /* 텍스트를 셀 내에서 숨김 */
	text-overflow: ellipsis; /* 텍스트 오버플로우 시 ...으로 표시 */
}

.ordertable th {
	background-color: #333;
	color: white;
	text-align: center;
}

.ordertable tr:nth-child(even) {
	background-color: #f2f2f2;
}

.ordertable tr:hover {
	background-color: #ddd;
}

.ordertable td.lastcolumn, .ordertable th.lastcolumn {
	background-color: #FFFFFF; /* 브라우저 바탕의 흰색 */
	padding: 0; /* 패딩 제거 */
	border: 2px solid white;
}

button {
	margin-right: 10px; /* 오른쪽 여백을 조절하여 간격을 벌립니다. */
}

/* 마지막 버튼의 오른쪽 여백을 제거합니다. */
button:last-child {
	margin-right: 0;
}

.putsub {
	background-color: black;
	padding: 8px;
	box-sizing: border-box;
	transition: background-color 2s;
	margin-top: 0;
	margin-bottom: 0;
	border: 1px solid white;
	/* 다른 원하는 스타일 추가 */
}

.text-input {
	background-color: white;
	padding: 8px;
	box-sizing: border-box;
	transition: background-color 2s;
	margin-top: 0;
	margin-bottom: 0;
	border: 1px solid white;
}

.putsub {
	background-color: white;
	color: black;
	padding: 8px;
	box-sizing: border-box;
	transition: background-color 2s;
	margin-top: 0;
	margin-bottom: 0;
	border: 1px solid white;
	/* 다른 원하는 스타일 추가 */
}

input[type="text"] {
	width: 100%; /* 부모 요소(여기서는 td)의 너비에 맞게 설정 */
	max-width: 200px; /* 최대 너비 설정 */
	box-sizing: border-box; /* 패딩과 테두리 포함하여 전체 너비 설정 */
	background-color: white;
	padding: 8px;
	box-sizing: border-box;
	transition: background-color 2s;
	margin-top: 0;
	margin-bottom: 0;
	border: 1px solid white;
}

body #searchtype select {
	box-sizing: border-box;
	width: 30% !important;
	padding: 10px;
	margin-bottom: 10px;
	font-size: 14px;
	border: 1px solid #ccc;
	border-radius: 4px;
	font-family: "Source Sans Pro", Helvetica, sans-serif;
	font-size: 16pt;
	font-weight: 50;
	line-height: 1.75;
}

#myForm {
	float: right;
}

#keyword {
	float: left;
}
</style>
</head>

<%@include file="/WEB-INF/views/common/chatbot.jsp"%>
<body class="is-preload">

	<!-- Wrapper -->
	<div id="wrapper">

		<!-- Header -->
		<header id="header">
			<div class="inner">

				<!-- 쇼핑몰 로고 & 상단 아이콘 불러오기 -->
				<%@include file="../../common/header.jsp"%>

				<!--1. 회원 or 비회원 페이지 -->
				<div class="category-link" align="center">
					<a href="category.do?newCid=코트"
						style="font-size: 20px; font-weight: bold; margin-right: 10px; text-decoration: none;">OUTER</a>
					<a href="category.do?newCid=코트"
						style="font-size: 20px; font-weight: bold; margin-right: 10px; text-decoration: none">KNIT</a>
					<a href="category.do?newCid=상의"
						style="font-size: 20px; font-weight: bold; margin-right: 10px; text-decoration: none">TOP</a>
					<a href="category.do?newCid=하의"
						style="font-size: 20px; font-weight: bold; margin-right: 10px; text-decoration: none">BOTTOM</a>
					<a href="category.do?newCid=코트"
						style="font-size: 20px; font-weight: bold; margin-right: 10px; text-decoration: none">SHIRT</a>
					<a href="category.do?newCid=코트"
						style="font-size: 20px; font-weight: bold; margin-right: 10px; text-decoration: none">SHOES</a>
					<a href="category.do?newCid=코트"
						style="font-size: 20px; font-weight: bold; margin-right: 10px; text-decoration: none">ACC</a>
				</div>
				<br>

				<!---------------------- Nav --------------------->
					<nav>
						<ul>
							<li><a href="#menu">Menu</a></li>
						</ul>
					</nav>
			</div>
		</header>
		<!-- Menu -->
		<nav id="menu">
			<h2>Menu</h2>
			<ul>
				<li><a href="category.do"
					style="text-decoration: none">카테고리</a></li>
				<br>
				<li><a href="freeBoardList.do" style="text-decoration: none">커뮤니티</a></li>
				<br>
				<li><a href="masterNotice.do" style="text-decoration: none">공지사항</a></li>
				<br>
			</ul>
		</nav>
		<!---------------------- Nav ------------------->

		<!-- Main -->
		<div id="main">
			<div class="inner">
				<header align="left">

					<h1>공지사항</h1>
				</header>

				<section class="tiles">



					<!-- 공지사항 테이블 출력 -->
					<div class="content">
						<div class="container_orders">
						<!-- 길이를 800으로 -->
							<c:if test="${empty list }">
							<div style="width: 800px;" align="center">
								<br>
								<br>
								<h1>등록된 글이 없습니다</h1>
							</div>
							</c:if>
							<c:if test="${not empty list }">
								<table border="1" class="ordertable">
									<tr>
										<th>글번호</th>
										<th>제목</th>
										<th>작성일</th>
										<th>조회수</th>
										<c:if test="${member ne null && member.mEmail eq 'master'}">
											<th>관리</th>
										</c:if>
									</tr>
									<c:set var="i"
										value="${pp.total - (pp.nowPage-1)* pp.cntPerPage }"></c:set>
									<c:forEach var="masterNotice" items="${list}" varStatus="loop">
										<tr
											onclick="location.href='masterNoticeSearchDetail.do?mnId=${masterNotice.mnId}&nowPage=${pp.nowPage }&cntPerPage=${pp.cntPerPage }&keyword=${pp.keyword }&searchtype=${pp.searchtype }' ">
											<td id="${i }">${i }</td>
											<td>${masterNotice.mnTitle}</td>
											<td><fmt:formatDate pattern="yyyy-MM-dd hh:mm"
													value="${masterNotice.mnReg}" /></td>
											<td>${masterNotice.mnReadCount}</td>
											<c:if test="${member ne null && member.mEmail eq 'master'}">
												<td>
													<button type="button"
														onclick="javascript:update('${masterNotice.rnum}','${masterNotice.mnId}','${param.searchtype }','${param.keyword }')">
														수정</button>
													<button type="button"
														onclick="javascript:deleteCheck('${masterNotice.mnId}','${param.searchtype }','${param.keyword }')">삭제</button>
													<!-- mnId는 items="{list}" 안에 포함된 정보.  -->
												</td>
											</c:if>
										</tr>
										<c:set var="i" value="${i - 1}"></c:set>
									</c:forEach>
								</table>
							</c:if>
						</div>
						<c:if test="${member ne null && member.mEmail eq 'master'}">
							<button type="button"
								onclick="javascript:popup('${param.searchtype}','${param.keyword }')">공지사항
								등록</button>
						</c:if>
						<!-- 다른 페이지로 넘어가기 위한 숫자들 자리 -->
						<div align="center">
							<c:if test="${pp.startPage != 1 }">
								<a style="text-decoration: none; color: deeppink"
									href="./masterNoticeSearch.do?keyword=${pp.keyword }&nowPage=${pp.startPage - 1 }&cntPerPage=${pp.cntPerPage}&searchtype=${pp.searchtype}">
									<- </a>
							</c:if>
							<c:forEach begin="${pp.startPage }" end="${pp.endPage }" var="p">
								<c:choose>
									<c:when test="${p == pp.nowPage }">
										<b>${p }</b>
									</c:when>
									<c:when test="${p != pp.nowPage }">
										<a style="text-decoration: none; color: deeppink"
											href="./masterNoticeSearch.do?keyword=${pp.keyword }&nowPage=${p }&cntPerPage=${pp.cntPerPage}&searchtype=${pp.searchtype}">${p }</a>
									</c:when>
								</c:choose>
							</c:forEach>
							<c:if test="${pp.endPage != pp.lastPage}">
								<a style="text-decoration: none; color: deeppink"
									href="./masterNoticeSearch.do?keyword=${pp.keyword }&nowPage=${pp.endPage+1 }&cntPerPage=${pp.cntPerPage}&searchtype=${pp.searchtype}">
									-> </a>
							</c:if>
						</div>



						<form action="masterNoticeSearch.do" id="myForm">
							<select class="putsub" name="searchtype" id="searchtype"
								style="width: 280px">
								<option value="">검색 유형 선택</option>
								<option value="mnTitle"
									${param.searchtype =='mnTitle' ? 'selected="selected"' : '' }>제목</option>
								<option value="mnContent"
									${param.searchtype == 'mnContent' ? 'selected="selected"' : '' }>내용</option>
								<!-- 삼항연산자를 통해 처리 -->
							</select> <input type="text" id="keyword" name="keyword"
								value="${pp.keyword }" maxlength="10"> <input
								type="submit" value="검색" class="putsub" id="search">
						</form>
					</div>
				</section>




			</div>





		</div>




		<!-- Footer -->
		<footer id="footer">
			<div class="inner">
				<section>
					<h2>Get in touch</h2>
					<form method="post" action="#">
						<div class="fields">
							<div class="field half">
								<input type="text" name="name" id="name" placeholder="Name" />
							</div>
							<div class="field half">
								<input type="email" name="email" id="email" placeholder="Email" />
							</div>
							<div class="field">
								<textarea name="message" id="message" placeholder="Message"></textarea>
							</div>
						</div>
						<ul class="actions">
							<li><input type="submit" value="Send" class="primary" /></li>
						</ul>
					</form>
				</section>
				<section>
					<h2>Follow</h2>
					<ul class="icons">
						<li><a href="#" class="icon brands style2 fa-twitter"><span
								class="label">Twitter</span></a></li>
						<li><a href="#" class="icon brands style2 fa-facebook-f"><span
								class="label">Facebook</span></a></li>
						<li><a href="#" class="icon brands style2 fa-instagram"><span
								class="label">Instagram</span></a></li>
						<li><a href="#" class="icon brands style2 fa-dribbble"><span
								class="label">Dribbble</span></a></li>
						<li><a href="#" class="icon brands style2 fa-github"><span
								class="label">GitHub</span></a></li>
						<li><a href="#" class="icon brands style2 fa-500px"><span
								class="label">500px</span></a></li>
						<li><a href="#" class="icon solid style2 fa-phone"><span
								class="label">Phone</span></a></li>
						<li><a href="#" class="icon solid style2 fa-envelope"><span
								class="label">Email</span></a></li>
					</ul>
				</section>
				<ul class="copyright">
					<li>&copy; Untitled. All rights reserved</li>
					<li>Design: <a href="http://html5up.net">HTML5 UP</a></li>
				</ul>
			</div>
		</footer>

	</div>
	<%@ include file="../../common/footer.jsp"%>
	<!-- Scripts -->
	<script src="assets/js/jquery.min.js"></script>
	<script src="assets/js/browser.min.js"></script>
	<script src="assets/js/breakpoints.min.js"></script>
	<script src="assets/js/util.js"></script>
	<script src="assets/js/main.js"></script>

</body>
</html>