<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.net.*" %>
<%@ page import="java.util.*"%>
<%
	// 0. 로그인(인증) 분기
	String loginMember = (String)(session.getAttribute("loginMember"));
	if(loginMember == null) {
		String errMsg = URLEncoder.encode("잘못된 접근 입니다. 로그인 먼저 해주세요", "utf-8");
		response.sendRedirect("/diary/loginForm.jsp?errMsg="+errMsg);
		return;
	}
%>
<% 	
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null; 
	conn= DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary","root","0901");

	int currentPage = 1 ;
	if(request.getParameter("currentPage")!=null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}	
	int rowPerPage = 10;
	
	String perPage = request.getParameter("perPage");
	
	System.out.println(perPage+ "<-perPage");
	if(perPage == null || perPage.equals("null")) {
	    rowPerPage = 10;
	    System.out.println(rowPerPage + "널일때");
	} else {
	    rowPerPage = Integer.parseInt(perPage);
	    System.out.println(rowPerPage + "<-rowPerPage");
	}	
		
	int startRow = (currentPage-1)*rowPerPage;
	
	String searchWord = "";
	if(request.getParameter("searchWord")!=null){
		searchWord = request.getParameter("searchWord");
	}	
	String sql = "select diary_date diaryDate,title,content from diary where title like ? order by diary_date asc limit ?,?";
	PreparedStatement stmt = null;
	ResultSet rs = null;
	stmt = conn. prepareStatement(sql);
	stmt.setString(1,"%"+searchWord+"%");
	stmt.setInt(2,startRow);
	stmt.setInt(3,rowPerPage);
	rs = stmt.executeQuery();
	
	//출력리스트모듈
	String sql2="select count(*) cnt from diary where title like ?";
	PreparedStatement stmt2 = null;
	ResultSet rs2 = null;
	stmt2 = conn.prepareStatement(sql2);
	stmt2.setString(1,"%"+ searchWord +"%");
	rs2 = stmt2.executeQuery();
	int totalRow = 0;
	if(rs2.next()){
		totalRow = rs2.getInt("cnt");
	}
	int lastPage = totalRow / rowPerPage;
	if(totalRow % rowPerPage != 0) {
		lastPage = lastPage + 1;
	}	
	System.out.println(rs2.getInt("cnt")+"<-cnt");
	System.out.println(lastPage+"<-lastPage");
	System.out.println("-------------------------------------------------------------------------------");
%>
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Song Myung&display=swap" rel="stylesheet">
<link href="/diary/diaryButton.css" rel="stylesheet">
	<style>		
	.index  {
			
		font-weight: bold;	
	}
	
	td {
		text-align: center;
	}
	.box:link, .box:visited{
	  color: black;
	  padding: 12px 25px;
	  text-align: center;
	  text-decoration: none;
	  display: inline-block;
	}
</style>

	<title>홈 화면</title>
</head>
<body class="container bg" >
	<div class="opacity-75" >	
		<div class="row">
			<div class="col"></div>
			<div class="col-8 mt-5  p-5 mb-5  border shadow bg-body-tertiary rounded align-p">		
				<h1 class="head" style="text-align:center;" >Diary</h1>
				<%@ include file="NavBar.jsp"%>						
						<a href="/diary/logout.jsp" class="logoutButton">로그아웃</a>						
						<br>										
				<table class="table table-hover table-striped" border="1">
					<tr>
						<td class="index"  style="width:20%">날짜</td>
						<td class="index"  style="width:30%">제목</td>
						<td class="index">내용</td>
					</tr>
					<%
						while(rs.next()){
					%>
					<tr>
						<td><a class="box" href="/diary/diaryOne.jsp?diaryDate=<%=rs.getString("diaryDate")%>">
						<%=rs.getString("diaryDate")%></a></td>
						<td><a class="box" href="/diary/diaryOne.jsp?diaryDate=<%=rs.getString("diaryDate")%>">
						<%=rs.getString("title")%></a></td>	
						<td><%=rs.getString("content")%></td>					
					</tr>					
					<%
					}
					%>				
				</table>
				<nav aria-label="Page navigation example">
					<ul class="pagination justify-content-center">

				<%
					if(currentPage > 1) {
				%>
						<li class="page-item">
							<a class ="page-link" href="/diary/diary.jsp?currentPage=1&perPage=<%=perPage%>">처음페이지</a>
						</li>
						<li class="page-item">
							<a class ="page-link" href="/diary/diary.jsp?currentPage=<%=currentPage-1%>&perPage=<%=perPage%>">이전페이지</a>
						</li>																
				<%		
					} else {
				%>
						<li class="page-item disabled">
							<a class ="page-link" href="/diary/diary.jsp?currentPage=1">처음페이지</a>
						</li>
					
						<li class="page-item disabled">
							<a class ="page-link" href="/diary/diary.jsp?currentPage=<%=currentPage-1%>&perPage=<%=perPage%>">이전페이지</a>
						</li>
				<%		
					}				
					if(currentPage < lastPage || lastPage == 0  ) {
				%>
						<li class="page-item">
							<a class ="page-link" href="/diary/diary.jsp?currentPage=<%=currentPage+1%>&perPage=<%=perPage%>">다음페이지</a>
						</li>
						<li class="page-item">
							<a class ="page-link" href="/diary/diary.jsp?currentPage=<%=lastPage%>">마지막페이지</a>
						</li>
				<%		
					}
				%>
			</ul>
				</nav>						
				
			</div>	
			
			<div class="col"></div>
		</div>
	</div>		
</body>
</html>





