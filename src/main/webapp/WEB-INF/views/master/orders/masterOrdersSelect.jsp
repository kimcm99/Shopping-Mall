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

<script>
	// 해당 스크립트를 js로 이동시 작동 X 
	// 초기 배경색 설정 반드시필요)
	var  odid = '${orders.odid}';
	
$(document).ready(function() {
  function startcolor() {
    $(".select-Dtype").each(function() {
      var background = $(this).find("option:selected").css("background-color");
      $(this).css("background-color", background);
    });
  }

  // 페이지 로드시 초기 배경색 설정
  startcolor();

  // 변경 이벤트에 따른 배경색 설정
  $(".select-Dtype").change(function() {
    var background = $(this).find("option:selected").css("background-color");
    var color = $(this).find("option:selected").css("color");
    $(this).css("background-color", background);
    $(this).css("color", color);
  });
});
 
 // 배송상태 변경 / 변경에따른 문자 전송 여부
function ajax_change(status, odid, oid) {
    var odstatus = status.value;

    $.ajax({ // 배송상태 변경 에이작스
        type: "POST",
        url: "masterOrdersStatus.do",
        data: {
            odstatus: odstatus,
            odid: odid,
            oid: oid
        },
        success: function(response) { 
            if (response === "Y") {
            	if(confirm("배송 메시지를 보내시겠습니까?")){ 
            		location.href="masterOrdersSmsMove.do?type=delivery&odstatus="+odstatus+"&odid="+odid+"&oid="+oid;
            		//location.href="masterOrdersSmsMove.do?type=delivery&odid="+odid+"&oid="+oid;
            	}
                
            } else {
                alert("상태 변경 실패");
                location.href = "masterOrdersList.do";
            }
        },
        error: function(xhr, error) {
            // AJAX 오류 시 실행할 코드
            console.error("오류 발생:", error);
        }
    });
}

</script>


<title>주문 상세정보</title>
</head>
<body>



	<%@ include file="../common/masterNav.jsp"%>
	<form method="post" action="masteroDelete.do">
		<h1 class="h1_caption">주문 상세정보</h1>
		<div class="container">

			<table>
				<tr>
					<th>고유번호</th>
					<th>ID</th>
					<th>수령인</th>
					<th>휴대폰</th>
					<th>우편번호</th>
					<th>주소</th>
					<th>총금액</th>
					<th>배송비</th>
					<th>메시지</th>
					<th>주문일</th>
				</tr>

				<tr>
					<td>${orders.OID}</td>
					<td>${orders.MEMAIL}</td>
					<td>${orders.ONAME}</td>
					<td>${orders.OPHONE}</td>
					<td>${orders.OPOST}</td>
					<td>${orders.OADDRESS}</td>
					<td>${orders.OTOTALPRICE}</td>
					<td>${orders.ODELIVERY}</td>
					<td><input type="text" maxlength="10" readonly="readonly"
						value="${orders.OMESSAGE}"></td>
					<td><fmt:formatDate pattern="yyyy/MM/dd"
							value="${orders.OREG}" /></td>
				</tr>
			</table>

			<table class="fancy_table">
				<tr>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
				</tr>
				<tr>
					<th>수령인</th>
					<td>${orders.ONAME}</td>
					<th>휴대폰</th>
					<td colspan="2">${orders.OPHONE}</td>
					<th>배송일</th>
					<td colspan="2"><fmt:formatDate pattern="yyyy/MM/dd HH시 mm분"
							value="${orders.OREG}" /></td>
				</tr>

			</table>
			<table class="fancy_table">
				<tr>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
				</tr>
				<tr align="center">
					<td colspan="9"
						style="padding: 20px; color: deeppink; font-size: 40px; font-weight: bold;">주문
						목록</td>

				</tr>
				<tr>
					<th>상세번호</th>
					<th>상품코드</th>
					<th>상품이름</th>
					<th>이미지</th>
					<th>색상</th>
					<th>사이즈</th>
					<th>수량</th>
					<th>개당가격</th>
					<th>합계</th>
					<th>배송상태</th>
				</tr>

				<script>
					var total = 0;
				</script>
				<c:forEach var="o" items="${ordersList}">
					<tr>

						<td onclick="location.href='masterProductDetail.do?id=${o.PID }' ">${o.ODID }</td>
						<td onclick="location.href='masterProductDetail.do?id=${o.PID }' ">${o.PID }</td>
						<td onclick="location.href='masterProductDetail.do?id=${o.PID }' ">${o.PNAME }</td>
						<!-- HTML -->
						<td style="position: relative;"><img
							src="./images/${o.PIMAGE}" width="50" height="50"
							class="toggle-image"> <span class="text-on-image">${o.PTEXT}</span>
						</td>

						<td onclick="location.href='masterProductDetail.do?id=${o.PID }' ">${o.PCOLOR }</td>
						<td onclick="location.href='masterProductDetail.do?id=${o.PID }' ">${o.PSIZE }</td>
						<td onclick="location.href='masterProductDetail.do?id=${o.PID }' ">${o.ODCOUNT}</td>
						<td onclick="location.href='masterProductDetail.do?id=${o.PID }' ">${o.PPRICE }</td>
						<td><script>
						        var result = ${o.PPRICE} * ${o.ODCOUNT};
						    	document.write(result);
						      total = total+result; 
						      </script></td>
						<td>
							<button type="button" class="putsub2"
								onclick="location.href='masterProductUpdateForm.do?id=${o.PID}'">상품수정</button>
							<select class="select-Dtype"
							onchange="ajax_change(this,${o.ODID},${o.OID })"
							style="color: black; background-color: gray; font-size: 15px">
								<option value="0" style="color: black; background-color: gray;"
									<c:if test="${empty o.ODSTATUS or o.ODSTATUS eq ''}"> selected 
									</c:if>>배송상태
								</option>
								<option value="0"
									style="color: black; background-color: papayawhip;"
									<c:if test="${o.ODSTATUS == 0}"> selected </c:if>>배송대기</option>
								<option value="1"
									style="color: black; background-color: MediumSpringGreen;"
									<c:if test="${o.ODSTATUS == 1}"> selected </c:if>>배송완료</option>
								<option value="2"
									style="color: black; background-color: deeppink;"
									<c:if test="${o.ODSTATUS == 2}"> selected </c:if>>취소대기</option>
								<option value="3"
									style="color: black; background-color: darkorange;"
									<c:if test="${o.ODSTATUS == 3}"> selected </c:if>>취소완료</option>
						</select>



						</td>
					</tr>
				</c:forEach>

				<tr>
					<th>배송메시지</th>
					<td colspan="8"><textarea readonly="readonly">${orders.OMESSAGE}</textarea></td>

				</tr>
				<tr>
					<th>우편번호</th>
					<td>${orders.OPOST}</td>
					<th>주소</th>
					<td colspan="2">${orders.OADDRESS}</td>
					<th>배송비</th>
					<td>${orders.ODELIVERY}</td>
					<th>결제금액</th>
					<td colspan="2"><script>
					  document.write(total);
					</script></td>
				</tr>
			</table>
			<h4 class=info-message>상품수정 클릭시 해당상품 수정창으로 이동합니다. (재고추가)</h4>
			<h4 class=info-message>배송상태 클릭시 배송상태를 변경합니다.</h4>
			<h4 class=info-message>배송상태 변경시 상태에 따른 문자를 전송 합니다.</h4>
	</form>
	</div>

</body>
</html>