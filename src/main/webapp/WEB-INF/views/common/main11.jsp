<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인페이지</title>
</head>
<body>
   <%@ include file="header.jsp"%>

   <div id="wrap">
      <div id="content-wrap">

         <div>
         
        	<c:if test="${sessionId eq null}">
			<a href="NaverLogin.do">로그인</a>
			</c:if>
			<c:if test="${sessionId ne null && sessionId eq 'boss'}">
				${sessionId }님 환영합니다.
				<a href="Logout.do" onclick="alert('로그아웃')"><br>로그아웃</a>
				<a href="productInsertForm.do" onclick="alert('상품등록')"><br>상품등록</a>
				<input type="button" value="관리자페이지"
                        onclick="location.href='master_main.do'"><br>
			</c:if>
			<c:if test="${sessionId ne null && sessionId ne 'boss'}">
				${sessionId }님 환영합니다.
				<a href="Logout.do" onclick="alert('로그아웃')"><br>로그아웃</a>
			</c:if>
			
            <div align="center" width="100px" height="100px">
               <input type="text" maxlength="50" placeholder="검색어를 입력하세요."><br><br><br>
               
            </div>
            <table border="1" width="50%" height="100%" align="center">
               <tr align="center">
                  <td><a href="main.do" style = "text-decoration: none" >HOME</a></td>
                  <td><a href="#" style = "text-decoration: none" >CATEGORY</a></td>
                  <td><a href="#" style = "text-decoration: none" >EVENT</a></td>
               </tr>
               <tr align="center">
                  <td><p>
                        <a href="productDetail.do?img=gun2.jpg"><img src="./resources/images/gun2.jpg"
                           border="0" width="100" height="100" /></a>
                     </p></td>
                  <td><p>
                        <a href="#"><img src="./resources/images/ch3.jpg"
                           border="0" width="100" height="100" /></a>
                     </p></td>
                  <td><p>
                        <a href="#"><img src="./resources/images/ch2.jpg"
                           border="0" width="100" height="100" /></a>
                     </p></td>
               </tr>
               <tr align="center">
                  <td><p>
                        <a href="#"><img src="./resources/images/gun3.jpg"
                           border="0" width="100" height="100" /></a>
                     </p></td>
                  <td><p>
                        <a href="#"><img src="./resources/images/gun4.jpg"
                           border="0" width="100" height="100" /></a>
                     </p></td>
                  <td><p>
                        <a href="#"><img src="./resources/images/6.png"
                           border="0" width="100" height="100" /></a>
                     </p></td>
               </tr>
               <tr align="center">
                  <td><p>
                        <a href="#"><img src="./resources/images/7.png"
                           border="0" width="100" height="100" /></a>
                     </p></td>
                  <td><p>
                        <a href="#"><img src="./resources/images/8.png"
                           border="0" width="100" height="100" /></a>
                     </p></td>
                  <td><p>
                        <a href="#"><img src="./resources/images/9.png"
                           border="0" width="100" height="100" /></a>
                     </p></td>
               </tr>
               <tr align="center">
                  <td><p>
                        <img src="./main.png">
                     </p></td>
                  <td><p>
                        <img src="./main.png">
                     </p></td>
                  <td><p>
                        <img src="./main.png">
                     </p></td>
               </tr>
               <tr align="center">
                  <td><p>
                        <img src="./main.png">
                     </p></td>
                  <td><p>
                        <img src="./main.png">
                     </p></td>
                  <td><p>
                        <img src="./main.png">
                     </p></td>
               </tr>
            </table>
         </div>
      </div>
   </div>


   <%@ include file="footer.jsp"%>


</body>
</html>