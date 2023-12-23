<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>결제 폼</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<link rel="stylesheet" href="css/ordersForm.css">

</head>
<!-- jQuery -->
<script type="text/javascript"
   src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<!-- iamport.payment.js -->
<script type="text/javascript"
   src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>

<body>
   <form method="post" action="ordersForm.do">
      <input
         type="hidden" name="mEmail" value="${member.mEmail}">
       <input type="hidden" name="pid" value="${bucket.pid }"> 
       <input type="hidden" name="totalPrice" value="${totalPrice }">
       <input type="hidden" name="amountCount" value="${amountCount }"> 
      <div class="container_main">
         <center>
            <h1 style="font-size: 50px">주문서 작성</h1>
         </center>
         <div class="container_left">

            <h2>수령자 정보</h2>
            <table class="table_orders1">
               <tr>
                  <td><input type="text" value="${member.mName } "
                     placeholder="이름을 입력하세요." maxlength="5" name="mName"
                     style="color: green; font-size: 30px"></td>
               </tr>
               <tr>
                  <td><input type="text" value="${member.mPhone }"
                     nmae="mPhone" placeholder="휴대폰번호를 입력하세요." maxlength="11"></td>
               </tr>
               <tr>
                  <td><input type="text" value="${member.mPost }" name="mPost"
                     placeholder="우편번호를 입력하세요." maxlength="5"></td>
               </tr>
               <tr>
                  <td><input type="text" value="${member.mAddress }"
                     name="mAddress" placeholder="주소를 입력하세요." maxlength="40"></td>
               </tr>
               <tr>
                  <td><input type="text" 
                     name="omessage" placeholder="배송메시지를 입력하세요." maxlength="70" style="color: red;"></td>
               </tr>
            </table>
            <h2>주문자</h2>
            <table class="table_orders2">
               <tr>
                  <td><input type="text" value="${member.mName }" readonly
                     placeholder="이름을 입력하세요." maxlength="5"
                     style="color: green; font-size: 30px"></td>
               </tr>
               <tr>
                  <td><input type="text" value="${member.mPhone }"
                     name="mPhone" placeholder="휴대폰번호를 입력하세요." maxlength="11" readonly></td>
               </tr>
            </table>



            <h2>주문상품</h2>
            
            <c:if test="${result == 1}">
            <c:forEach items="${bucketList}" var="bucket">
            <input type="hidden" name="bidAll" value="${bucket.bid }">
            <table class="table_product">
               <tr>
               	<c:if test="${bucket.bimage != null }">
                  <td class="product_img" rowspan="5"><img src="images/${bucket.bimage }" width="95%" height="100%"></td>
                </c:if>
                <c:if test="${product.pimage != null }">
                  <td class="product_img" rowspan="5"><img src="images/${product.pimage }" width="95%" height="100%"></td>
                </c:if>   
               <tr>
                  <td><input type="text" value="${bucket.bname}" name="bname"
                     readonly style="color: green; font-size: 30px; "></td>
               </tr>

               <tr>
                  <td>${bucket.bsize}</td>
               </tr>
               <tr>
                  <td>${bucket.bcolor}</td>
               </tr>
               <tr>
                  <td>&#8361;${bucket.bprice}&nbsp;&nbsp;[${bucket.bcount}개]</td>
               </tr>

            </table>
            </c:forEach>
             </c:if>
             <c:if test="${result == 0 }">
             <input type="hidden" name="bid" value="${bucket.bid}"> 
             	<table class="table_product">
               <tr>
                  <td class="product_img" rowspan="5"><img
                     src="./images/${bucket.bimage}" width="150" height="100"></td>
               <tr>
                  <td><input type="text" value="${bucket.bname}" name="bname"
                     readonly style="color: green; font-size: 30px"></td>
               </tr>

               <tr>
                  <td>${bucket.bsize}</td>
               </tr>
               <tr>
                  <td>${bucket.bcolor}</td>
               </tr>
               <tr>
                  <td>&#8361;${bucket.bprice}&nbsp;&nbsp;[${bucket.bcount}개]</td>
               </tr>

            </table>
             </c:if>
             
             <c:if test="${result == 2 }">
             	<table class="table_product">
               <tr>
                  <td class="product_img" rowspan="5"><img
                     src="./imeges/${product.pimage}"></td>
               <tr>
                  <td><input type="text" value="${product.pname}" name="bname"
                     readonly style="color: palegreen; font-size: 30px"></td>
               </tr>

               <tr>
                  <td>${product.psize}</td>
               </tr>
               <tr>
                  <td>${product.pcolor}</td>
               </tr>
               <tr>
                  <td>&#8361;${product.pprice}&nbsp;&nbsp;[${amountCount}개]</td>
               </tr>

            </table>
             </c:if>

         </div>
         <div class="container_right">
            <table class="table_point">
               <tr>
                  <h2>결제정보</h2>
               </tr>
               <tr>
                  <td><input type="text" value="${member.mName }" name="mName"
                     placeholder="이름을 입력하세요." maxlength="5"
                     style="color: green; font-size: 30px"></td>
               </tr>
               <tr>
                  <td>총금액 : ${totalPrice }</td>
               </tr>
               <tr>
                  <td>배송비 : 무료</td>
               </tr>

            </table>
            <button type="submit" style="margin-top: 20px;">결제하기</button>
            <button type="button" onclick="location.href='cartFormMove.do'" style="margin-top: 20px;">취소하기</button>
            <div class="img_logo">
               <a href="main.do"><img src="./images/logo.png"
                  style="margin-left: 20px; width: 350px"></a>
            </div>
         </div>
   </form>









</body>