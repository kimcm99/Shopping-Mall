<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>결제 폼</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>

</head>
<!-- jQuery -->
<script type="text/javascript"
   src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<!-- iamport.payment.js -->
<script type="text/javascript"
   src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>

<script>
   var IMP = window.IMP;
   IMP.init("imp36778371");

   var today = new Date();
   var hours = today.getHours(); // 시
   var minutes = today.getMinutes(); // 분
   var seconds = today.getSeconds(); // 초
   var milliseconds = today.getMilliseconds();
   var makeMerchantUid = hours + minutes + seconds + milliseconds;
   
   var pid = '${pid}';
   var bid = '${bid}';
   var amountCount = '${amountCount}';
   var bidList = JSON.stringify('${bidList}');
   var name = '${name}';
   var amount = '${totalPrice}';
   var buyer_email = '${member.mEmail}';
   var buyer_name = '${member.mName}';
   var buyer_tel = '${member.mPhone}';
   var buyer_addr = '${member.mAddress}';
   var buyer_postcode = '${member.mPost}';
   var omessage = '${omessage}';

   function requestPay() {
      IMP.request_pay({
         pg : 'kcp',
         pay_method : 'card',
         merchant_uid : "IMP" + makeMerchantUid,
         name : name,
         amount : amount,
         buyer_email : buyer_email,
         buyer_name : buyer_name,
         buyer_tel : buyer_tel,
         buyer_addr : buyer_addr,
         buyer_postcode : buyer_postcode
      }, function(rsp) { // callback

         //           // 결제검증
         //            $.ajax({
         //                type : "POST",
         //                url : "/verifyIamport/" + res.imp_uid

         // 검증완료시
         if (rsp.success) {
			alert('결제완료');
            console.log(rsp);
            
             var toSend = {
			   mEmail: buyer_email,
 			   pid: pid,
 			   bid: bid,
 			   bidList: bidList,
			   //bcount: amount,
			   oname: buyer_name,
			   ophone: buyer_tel,
			   opost: buyer_postcode,
			   oaddress: buyer_addr,
			   ototalprice: amount,
			   omessage: omessage,
			   amountCount: amountCount
			   
		     };
			        
			 $.ajax({
				url: 'orderResult.do',
				method: 'POST',
				//contentType: 'application/json',
				data: toSend,
				success: function(map){
					
					alert('구매 완료');
					location.href='cartFormMove.do';
					
					},
							 
				 });
             
		} else {
            alert('결제실패');
            location.href='cartFormMove.do';
         }
      });
   }
</script>

<script>
	const result = confirm('결제를 진행하시겠습니까?');
	
	if(result){
		alert('결제 창으로 이동 합니다.');
		requestPay();
	} else{
		alert('결제가 취소 됩니다.');
		location.href='cartFormMove.do';
	}
</script>

</html>