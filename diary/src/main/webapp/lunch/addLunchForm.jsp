<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="loginConfirm.jsp" %>
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="/diary/diaryButton.css" rel="stylesheet">
	<meta charset="UTF-8">
	<title>먹은 메뉴 추가</title>
	
</head>
<body class="container bg">
	
	<div class="opacity-75" >	
	<div class="row">
			<div class="col"></div>	
		<div class="col-8 mt-5 p-5 mb-5 border shadow bg-body-tertiary rounded align-p">
		<h2 class="head">메뉴추가</h2><br>
		<a href="/diary/logout.jsp" class="logoutButton">로그아웃</a>	
		<%@ include file="lunchNavBar.jsp"%>
		
	<hr>
		<form method="post" action="/diary/lunch/addLunchAction.jsp">				
			<div class="mb-3 mt-3">
			<label class="form-label"> <b>날짜</b></label>
			<input type="date" class="form-control" name="lunch_date">			
			</div>
			<div class="mb-3 mt-3">
				<label class="form-label"><b>메뉴</b></label> 
				<select class="form-control" name="menu">
					<option >메뉴선택</option>
					<option value="구내식당">구내식당</option>
					<option value="편의점">편의점</option>
					<option value="국밥">국밥</option>
					<option value="분식">분식</option>
					<option value="양식">양식</option>
					<option value="한식">한식</option>
					<option value="기타">기타</option>
				</select>	
				
			</div>							
			
			<div><button type="submit">입력</button></div>
					
		</form>
		</div>	
			<div class="col"></div>	
		</div>
		
	</div>
</body>
</html>