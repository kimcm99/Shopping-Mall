<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>커뮤니티</title>

<!--header css 양식 include -->
<%@include file="/WEB-INF/views/common/header.jsp"%>

<!-- css 불러오기 -->
<link rel="stylesheet" href="css/freeBoard.css">
<!-- <script src="https://apis.google.com/js/api.js"></script> -->
<!-- <script src="./js/freeboardyoutube.js"></script> -->


<!-- 유투브 API 시작 -->
<script async>
	async function fetchData() {
// 		var startOfWeek = moment().startOf('week').toDate();
// 		var endOfWeek   = moment().endOf('week').toDate();
// 		var w_start_date = startOfWeek
// 		var w_end_date = endOfWeek
		var queries = [
			"q=남성패션",
			"order=viewCount",
			"maxResults=9",
// 			`publishedAfter=${w_start_date}`,
// 			`publishedBefore=${w_end_date}`
		];
		var query = "";
		queries.forEach((item,index) => {
			if(index == 0)
				query += item
			else
				query += "&" + item 
		});
		var API_KEY = "AIzaSyAarAezWQSHuQQRYZ7hm_SIk5uOoKYX77w"
		var youtube_url = "https://youtube.googleapis.com"
		var search_endpoint = "/youtube/v3/search" 
		var req = youtube_url + search_endpoint + "?" + query + "&key=" + API_KEY
		console.log(req)
		var video_url = []
		var response = fetch(req, {
		  headers: {
		    'Authorization': 'Bearer',
		    'Accept': 'application/json'
		  }
		}).then(res => {return res.json()})
	      .then((result) => {
		          result.items.forEach(function(item, index) {
		        	  var youtube_embed_url = "https://www.youtube.com/embed/";
		        	  if('videoId' in item.id)
		        		  video_url.push(youtube_embed_url+item.id.videoId);
		          });
		          const iframes = document.querySelectorAll('.div_iframe iframe');
		          iframes.forEach((iframe, index) => {
		        	if(index < video_url.length)
	        	    	iframe.src = video_url[index];
	        	  });
		        })
		      .catch((error) => { window.alert("error", error);
		        console.log("authentication failed");
		      });
		
		return video_url
	}
	
	(async () => {
		var video_url = await fetchData();
	})();
	
	
</script>
<div class="div_iframe">
	<caption>
		<h2><img src="images/youtube.png">'남성 패션' 조회수 TOP 9</h2>
	</caption>
	<br>
	<iframe width="400" height="300"></iframe>
	<iframe width="400" height="300"></iframe>
	<iframe width="400" height="300"></iframe>
	<br>
	<iframe width="400" height="300"></iframe>
	<iframe width="400" height="300"></iframe>
	<iframe width="400" height="300"></iframe>
	<br>
	<iframe width="400" height="300"></iframe>
	<iframe width="400" height="300"></iframe>
	<iframe width="400" height="300"></iframe>
</div>
<!-- 유투브 API 끝 -->
</head>
<body>
	<!-- 전체 div시작 -->
	<div class="community">
		<table class="table_community">
			<caption>
				<a1>BOSS 커뮤니티에서 자유롭게 이야기 나눠보세요!</a1>
			</caption>
			<tr>
				<th width="5%">번호</th>
				<th width="38%">제목</th>
				<th width="13%">첨부파일</th>
				<th width="12%">작성자</th>
				<th width="10%">작성일</th>
				<th width="7%">조회수</th>
				<th width="8%">좋아요</th>
				<th width="7%">신고</th>
			</tr>

			<c:if test="${empty list}">
				<tr>
					<td colspan="6">데이터가 없습니다</td>
				</tr>
			</c:if>


			<c:if test="${not empty list}">
				<!-- 글번호 변수 정의 -->
				<c:set var="num" value="${no}" />

				<!-- 글목록 list출력 시작 -->
				<c:forEach var="board" items="${list}">
					<tr>
						<c:if test="${board.fDrop =='N' }">
							<!-- 글번호 출력부분 -->
							<td><c:out value="${num}" /> <c:set var="num"
									value="${num-1}" /></td>

							<!-- 삭제글인지 아닌지 판별 -->
							<%-- <c:if test="${board.fDrop =='Y' }">
							<td colspan="6">삭제된 데이터 입니다</td>
						</c:if> --%>
							<%-- 	<c:if test="${board.fDrop !='Y' }">
						</c:if> --%>

							<!-- 제목 출력 부분 -->
							<td><a
								href="freeBoardDetail.do?page=${pp.currentPage}&fId=${board.fId}&state=detail">
									${board.fTitle} <!-- 조회수 30 초과 인기글 표시 --> <c:if
										test="${board.fReadCount > 30 }">
										<img alt="" src="images/hot.gif">
									</c:if>
							</a></td>
							<td><c:if test="${empty board.fImage}">
                  &nbsp;
                </c:if> <c:if test="${!empty board.fImage}">
									<img src="<%=request.getContextPath()%>/images/${board.fImage}"
										height="100" width="100" />
								</c:if></td>
							<td>${board.mEmail}</td>
							<td><fmt:formatDate value="${board.fReg}"
									pattern="yyyy-MM-dd HH:mm:ss" /></td>
							<td>${board.fReadCount}</td>
							<td>${board.fLike}</td>
						</c:if>
						<!-- 신고하기 -->
<%-- 						<c:if test="${sessionScope.member.mEmail ne null }"> --%>
<!-- 							<td><img src="images/report.png" -->
<%-- 								onclick="location.href='reportWriteForm.do?reporttype=review&reportnum=${review.rid}&reportname=${review.memail}' " --%>
<!-- 								style="width: 25px; height: 25px;"></td> -->
<%-- 						</c:if> --%>
<%-- 						<c:if test="${sessionScope.member.mEmail eq null }"> --%>
<!-- 							<td>&nbsp;</td> -->
<%-- 						</c:if> --%>
<!-- 신고하기 -->
                  <c:if test="${sessionScope.member.mEmail ne null }">
                     <td><img src="images/report.png"
                        onclick="location.href='reportWriteForm.do?reporttype=freeBoard&reportnum=${board.fId}&reportname=${board.mEmail}' "
                        style="width: 25px; height: 25px;"></td>
                  </c:if>
                  <c:if test="${sessionScope.member.mEmail eq null }">
                     <td>&nbsp;</td>
                  </c:if>

					</tr>
				</c:forEach>
			</c:if>
			<!-- 글목록 list출력 끝-->
		</table>

		<!-- 검색칸 -->
		<form action="freeBoardList.do"
			style="text-align: center; margin-top: 20px;">
			<input type="hidden" name="page" value="1"> <select
				name="search">
				<option value="fTitle"
					<c:if test="${search=='fTitle'}">selected="selected" </c:if>>제목</option>
				<option value="fContent"
					<c:if test="${search=='fContent'}">selected="selected" </c:if>>내용</option>
				<option value="mEmail"
					<c:if test="${search=='mEmail'}">selected="selected" </c:if>>작성자</option>
				<option value="subcon"
					<c:if test="${search=='subcon'}">selected="selected" </c:if>>제목+내용</option>
			</select> <input type="text" name="keyword"> <input type="submit"
				value="확인">
		</form>

		<!-- page처리 div 시작-->
		<ul class="div_feeboard_paging">
			<!-- 검색 했을 경우의 페이징 처리 -->
			<c:if test="${not empty keyword}">
				<c:if test="${pp.startPage > pp.pagePerBlk }">
					<li><a
						href="freeBoardList.do?page=${pp.startPage - 1}&search=${search}&keyword=${keyword}">이전</a></li>
				</c:if>
				<c:forEach var="i" begin="${pp.startPage}" end="${pp.endPage}">
					<li
						<c:if test="$freeBoardList.do?page=${i}&search=${search}&keyword=${keyword}{pp.currentPage==i}">class="active"</c:if>><a
						href="">${i}</a></li>
				</c:forEach>
				<c:if test="${pp.endPage < pp.totalPage}">
					<li><a
						href="freeBoardList.do?page=${pp.endPage + 1}&search=${search}&keyword=${keyword}">다음</a></li>
				</c:if>
			</c:if>


			<!-- 전체 목록의 페이징 처리 -->
			<c:if test="${empty keyword}">
				<c:if test="${pp.startPage > pp.pagePerBlk }">
					<li><a href="freeBoardList.do?page=${pp.startPage - 1}">이전</a></li>
				</c:if>
				<c:forEach var="i" begin="${pp.startPage}" end="${pp.endPage}">
					<li <c:if test="${pp.currentPage==i}">class="active"</c:if>><a
						href="freeBoardList.do?page=${i}">${i}</a></li>
				</c:forEach>
				<c:if test="${pp.endPage < pp.totalPage}">
					<li><a href="freeBoardList.do?page=${pp.endPage + 1}">다음</a></li>
				</c:if>
			</c:if>
		</ul>

		<!-- button div 끝-->
		<div class="div_boardlist_button"
			style="text-align: center; margin-top: 20px;">
			<button type="button" class="boardlist_button"
				onClick="location.href='main.do'">메인</button>
			<button type="button" class="boardlist_button"
				onClick="location.href='freeBoardInsertform.do'">글쓰기</button>
		</div>
		<!-- button div 끝-->

		<!-- 전체 div끝 -->

		<!-- css 양식 include -->
		<%@include file="/WEB-INF/views/common/footer.jsp"%>
</body>
</html>