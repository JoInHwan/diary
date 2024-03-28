<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ include file="loginConfirm.jsp" %>
<%		
	
	String diaryDate = request.getParameter("diaryDate");
	System.out.println(diaryDate+"<-diaryDate");
	String sql="select * from diary WHERE diary_date = ?";
	
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setString(1,diaryDate);
	System.out.println(stmt);
	ResultSet rs= stmt.executeQuery(); 
	
%>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>일기장</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Song Myung&display=swap" rel="stylesheet">
<link href="/diary/diaryButton.css" rel="stylesheet"/>
<style>
		.align-p {
			position: relative;
		}
		
		.index  {
		width:150px;	
		 height:80px;
		font-weight: bold;	
		
	}
	.box{
	  color: black;	 
	  text-align: center;	 
	  
	}
		
	</style>
</head>
<body class="container bg">
	<div class="opacity-75" >	
	<div class="row">
		<div class="col"></div>	
		<div class="col-8 mt-5 p-5 mb-5 border shadow bg-body-tertiary rounded align-p">
		
		<h1 class="head"><%=diaryDate%> 일기 </h1><br>	
		<%@ include file="NavBar.jsp"%>	
		<a href="/diary/logout.jsp" class="logoutButton">로그아웃</a>		
		<br>
		<% 
			if(rs.next()){
		%>
			<table class="table table-hover table-striped" border="1">
				<tr><td class="index">날짜</td> <td class="box"><%=rs.getString("diary_date")%></td></tr>
				<tr><td class="index">제목</td><td class="box"><%=rs.getString("title")%></td></tr>
				<tr><td class="index">날씨</td><td class="box"><%=rs.getString("weather")%></td></tr>
				<tr><td class="index">기분</td><td class="box" style="font-size:30px;"><%=rs.getString("feeling")%></td></tr>
			 	<tr><td class="index">내용</td><td class="box"><%=rs.getString("content")%></td></tr>			 	
			 	<tr><td class="index">수정날짜</td><td class="box"><%=rs.getString("update_date")%></td></tr>
			 	<tr><td class="index">처음작성날짜</td><td class="box"><%=rs.getString("create_date")%></td></tr>						
			</table>
									
			<a href="/diary/updateDiaryForm.jsp?diaryDate=<%=rs.getString("diary_date")%>" class="btn btn-outline-warning">일기수정</a>
			<a href="/diary/deleteDiaryAction.jsp?diaryDate=<%=rs.getString("diary_date")%>" class="btn btn-outline-warning">일기삭제</a>
		<%
		} else{
		%>
			<div> 해당 날짜의 일기는 없습니다.</div>
		<%	}
		
		%>
	</div>	
			<div class="col"></div>	
		</div>
		
	</div>

</body>
</html>