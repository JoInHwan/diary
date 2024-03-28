<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.net.*" %>
<%@ page import = "java.sql.*" %>
<%@ include file="loginConfirm.jsp" %>
<%
	String diaryDate = request.getParameter("diaryDate");
	System.out.println(diaryDate + "<-diaryDate");	
	
	String sql = "select diary_date,title,weather,feeling, content from diary where diary_date = ?";
	PreparedStatement stmt = null;	
	ResultSet rs = null;
	
	
	
	stmt = conn.prepareStatement(sql);
	stmt.setString(1,diaryDate);
	System.out.println(stmt + "<-stmt");
			
	
	rs = stmt.executeQuery();
	if(rs.next()){
%>
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="/diary/diaryButton.css" rel="stylesheet">
	<meta charset="UTF-8">
	<title>일기 쓰기</title>
	<style>
				
	</style>
</head>
<body class="container bg">
	<div class="opacity-75" >	
		<div class="row">
			<div class="col"></div>
			<div class="col-8 mt-5  p-5 mb-5  border shadow bg-body-tertiary rounded align-p">		
				<h2 class="head" >일기 수정</h2><br>
				<%@ include file="NavBar.jsp"%>	<br>
	<form method="post" action="/diary/updateDiaryAction.jsp">
		<div class="mb-3 mt-3">
			<label class="form-label"> <b>날짜</b></label>
			<input type="text" class="form-control" name="diary_date"
					value='<%=rs.getString("diary_date")%>'readonly="readonly">
		</div>		
		
		<div class="mb-3 mt-3">
			<label class="form-label"><b>제목</b></label>
			<input type="text" class="form-control" name="title"
					value='<%=rs.getString("title")%>'>
		</div>
		
		<div class="mb-3 mt-3">
			<label class="form-label"><b>날씨</b></label>
			<select name="weather" class="form-control">
					<option value='<%=rs.getString("weather")%>'><%=rs.getString("weather")%></option>
					<option value="맑음">맑음</option>
					<option value="흐림">흐림</option>
					<option value="비">비</option>
					<option value="눈">눈</option>
				</select>			
		</div>		
		
		<div class="mb-3 mt-3">
		<label class="form-label"><b>기분</b> 
				<input type="radio" class="feel" name="feeling" value="&#128516;">&#128516;
				<input type="radio" class="feel" name="feeling" value="&#128528;">&#128528;
				<input type="radio" class="feel" name="feeling" value="&#128544;">&#128544;
				<input type="radio" class="feel" name="feeling" value="&#128558;">&#128558;
				<input type="radio" class="feel" name="feeling" value="&#128577;">&#128577;					
		</label></div>
		
		<div class="mb-3 mt-3">
			<label class="form-label"><b>내용</b></label>
			<input type="text" class="form-control" name="content" height="60px;"
				placeholder="반드시 한글자 이상 입력하세요" value='<%=rs.getString("content")%>'>

		</div>
		<br><br>
		<button type="submit" class="btn btn-primary">수정하기</button>
	</form>
			</div>			
			<div class="col"></div>
		</div>
	</div>
	
</body>
</html>
<% 
	}
%>  