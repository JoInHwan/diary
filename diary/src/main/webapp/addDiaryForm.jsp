<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.net.*" %>
<%@ page import = "java.sql.*" %>
<%@ include file="loginConfirm.jsp" %>

<%
	String checkDate = request.getParameter("checkDate");
	if(checkDate == null){
		checkDate="";
	}
	String ck = request.getParameter("ck");
	if(ck == null) {
		ck = "";
	}
	
	String msg = "";
	if(ck.equals("N")){
		msg = "날짜를 입력하세요";
	} else if(ck.equals("T")) {
		msg = "입력이 가능한 날짜입니다";
	} else if(ck.equals("F")){
		msg = "해당 날짜의 일기가 이미 있습니다!";
	}
	
	System.out.println(checkDate+"checkDate"); 
	System.out.println(ck+"<-ck"); 
	
%>

<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="/diary/diaryButton.css" rel="stylesheet">
	<meta charset="UTF-8">
	<title>일기 쓰기</title>
	<style>
	input[type=radio] {
    border: 0px;
   width: 15px;
    height: 2em;
    vertical-align: bottom;
	}
	.emotion {font-size:20px;
	}
	</style>
</head>
<body class="container bg">
	
	<div class="opacity-75" >	
	<div class="row">
			<div class="col"></div>	
		<div class="col-8 mt-5 p-5 mb-5 border shadow bg-body-tertiary rounded align-p">
		<h2 class="head">일기 쓰기</h2><br>
		<a href="/diary/logout.jsp" class="logoutButton">로그아웃</a>	
		<%@ include file="NavBar.jsp"%>
		<form method="post" action="/diary/checkDateAction.jsp">
		<br>
			<div>
				날짜확인 : <input type="date" name="checkDate" value="<%=checkDate%>">
			<span><button type="submit">날짜기능확인</button>&nbsp;<%=msg%></span>
			</div>
						
		</form>
	<hr>
		<form method="post" action="/diary/addDiaryAction.jsp">				
			<div class="mb-3 mt-3">
			<label class="form-label"> <b>날짜</b></label>
			<%
				if(ck.equals("T")) {
			%>
					<input value="<%=checkDate%>" type="text" class="form-control" name="diaryDate" readonly="readonly">
			<%		
				} else {
			%>
					<input value="" type="text" class="form-control" name="diaryDate" readonly="readonly">				
			<%		
				}
			%>			
			</div>
			<div class="mb-3 mt-3">
				<label class="form-label"><b>제목</b></label> 
				<input type="text" class="form-control" name="title">
			</div>			
			<div class="mb-3 mt-3">
				<label class="form-label"><b>날씨</b></label> 
				<select name="weather" class="form-control">
					<option value="맑음">맑음</option>
					<option value="흐림">흐림</option>
					<option value="비">비</option>
					<option value="눈">눈</option>
				</select>							
			</div>
			<div class="mb-3 mt-3">
				<label class="form-label"><b>기분</b></label> &nbsp;
				<input type="radio" name="feeling" value="&#128516;"><span class="emotion"> &#128516; </span>
				<input type="radio" name="feeling" value="&#128528;"><span class="emotion"> &#128528; </span>
				<input type="radio" name="feeling" value="&#128544;"><span class="emotion"> &#128544; </span>
				<input type="radio" name="feeling" value="&#128558;"><span class="emotion"> &#128558; </span>
				<input type="radio" name="feeling" value="&#128577;"><span class="emotion"> &#128577; </span>				
			</div>				
			
			<div class="mb-3 mt-3">
				<label class="form-label"><b>내용</b></label></div>
			<div class="mb-3 mt-3"><textarea class="form-control" rows="7" cols="50" name="content"></textarea></div>			
			
			
			<div><button type="submit">입력</button></div>
					
		</form>
		</div>	
			<div class="col"></div>	
		</div>
		
	</div>
</body>
</html>