<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>SMS 전송</title>
<link rel="stylesheet" href="css/sms.css">
</head>
<body>
	<div class="container">
		<form method="post" action="sendSms.do" id="smsForm">
			<input type="hidden" name="type" value="${type }"> <input
				type="hidden" name="oid" value="${orders.oid }"> <input
				type="hidden" name="from" value="01039283425">
			<div>
				<h1 align="center" style="color: deeppink">SMS 전송 (문자보내기)</h1>
				<label for="from">보낼 사람:</label> <input type="text" id="from"
					value="관리자" readonly="readonly"> <label for="to">받는사람:
				</label> <input type="text" id="to" name="to" value="${orders.ophone}"
					maxlength="11" placeholder="수신번호를 입력하세요."> <label
					for="message">내용:</label>
				<textarea id="message" name="text" placeholder="보낼 내용 입력"
					maxlength="70">${msg }</textarea>
				<button type="submit">전송하기</button>
				<button type="button" onclick="location.href='masterOrdersList.do'">취소</button>
				<h4 style="color: gray" align="left">최대 글자수 : 한글 70자 영문/숫자 160자</h4>
			</div>
		</form>
	</div>
</body>
</html>
