<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<meta charset="UTF-8">
<script src="http://code.jquery.com/jquery-latest.js"></script>
<title>장바구니 폼</title>



<!-- 체크박스 전체선택/해제  -->
<script>
	$(document).ready(
			function() {
				$('.check-all-checkbox')
						.click(
								function() {
									var checkboxes = $(this).closest('table')
											.find('input[type="checkbox"]');
									checkboxes.prop('checked', $(this).prop(
											'checked'));
								});
			});
</script>
<script>
	$(document).ready(function() {
		$("#payClick").click(function() {
			$("form").attr("action", "moveOrdersForm.do");
			$("form")[0].submit(); // form 요소의 submit() 함수를 호출하여 이벤트를 발생시킴
		});

		$("#deleteAll").click(function() {
			$("form").attr("action", "cartListDelete.do");
			$("form")[0].submit(); // form 요소의 submit() 함수를 호출하여 이벤트를 발생시킴
		});
	});
</script>
<body>
	<div>
		<a href="main.do" class="logo"> <span class=" "><img
				src="images/logo.png" alt="" style="width: 200px; height: 100px;"></span>
		</a>
	</div>
	<link rel="stylesheet" href="css/bucket.css">

	<section class="cart">
		<div class="cart__information">
			<ul>
				<li>장바구니 상품은 최대 30일간 저장됩니다.</li>
				<li>가격, 옵션 등 정보가 변경된 경우 주문이 불가할 수 있습니다.</li>
				<li>오늘출발 상품은 판매자 설정 시점에 따라 오늘출발 여부가 변경될 수 있으니 주문 시 꼭 다시 확인해 주시기
					바랍니다.</li>
			</ul>
		</div>
		<table class="cart__list">
			<form method="post" action="cartListDelete.do">
				<thead>
					<tr>
						<td><input type="checkbox" class="check-all-checkbox"></td>
						<td colspan="2">상품명</td>
						<td>상품정보</td>
						<td>상품금액</td>
						<td>배송비</td>
					</tr>
				</thead>
				<tbody>

					<c:set var="i" value="1"></c:set>
					<c:forEach var="bucket" items="${list }" varStatus="loop">
						<c:if test="${bucket.bdrop eq 'N'}">
							<input type="hidden" name="pidAll" value="${bucket.pid }">
								<tr class="cart__list__detail">
								<td><input type="checkbox" name="bidAll"
									value="${bucket.bid }"></td>
								<td><img src="images/${bucket.bimage }" width="50px"
									height="50px" alt="magic keyboard"></td>
								<td><a href="main.do">Bo$$Mall</a><span
									class="cart__list__smartstore"> HB & CM</span>
									<p>${bucket.bname }</p> <sapn class="price">${bucket.bprice }원</sapn><span
										style="text-decoration: line-through; color:
										lightgray;">${bucket.bprice}</span></td>
								<td class="cart__list__option">
									<p>상품명 : ${bucket.bname } / 수량 : (${bucket.bcount }개)</p>
									<!-- <button class="cart__list__optionbtn" >주문조건 추가/변경</button> -->
									<p>색상 : ${bucket.bcolor } / 사이즈 : ${bucket.bsize }</p>
								</td>
								<td><span class="price">${bucket.bprice * bucket.bcount}원</span><br>
									<button type="button" class="cart__list__orderbtn"
										onclick="location.href='moveOrdersForm.do?bid=${bucket.bid }&pid=${bucket.pid }'">주문하기</button>
									<button type="button" class="cart__list__orderbtn"
										onclick="location.href='cartListDelete.do?bid=${bucket.bid}'">삭제하기</button>
								</td>
								<td>무료</td>
							</tr>
						</c:if>
					</c:forEach>
				</tbody>
				<tfoot>
					<tr>
						<td colspan="3"><input type="checkbox">
							<button type="button" class="cart__list__optionbtn"
								id="deleteAll">선택상품 삭제</button>
							<button type="button" class="cart__list__optionbtn">선택상품
								찜</button></td>
						<td>총 결제 금액 : ${totalPrice}원</td>

						<td></td>
						<td></td>
					</tr>
				</tfoot>
		</table>
		<div class="cart__mainbtns">

			<button type="button" class="cart__bigorderbtn right" id="payClick">주문하기</button>
		</form>	
			<button class="cart__bigorderbtn left"
				onclick="location.href='main.do'">쇼핑 계속하기</button>
		</div>
		
	</section>
</body>
<%@include file="/WEB-INF/views/common/footer.jsp"%>

</html>