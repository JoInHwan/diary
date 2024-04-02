<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%
	// 1. 요청분석
	String diary_date = request.getParameter("diaryDate");
	String title = request.getParameter("title");
	String weather = request.getParameter("weather");
	String feel = request.getParameter("feel");
	String content = request.getParameter("content");	
	
	System.out.println(diary_date + "<--불러온 diary_date 값");
	System.out.println(title + "<--불러온 title 값");
	System.out.println(weather + "<--불러온 weather 값");
	System.out.println(feel + "<--불러온 feel 값");
	System.out.println(content + "<--불러온 content 값");
	// 2.DB데이터 수정
	String sql = "INSERT INTO diary(diary_date,title,weather,feeling,content,update_date,create_date) VALUES(?,?,?,?,?,NOW(),NOW())";
	Connection conn = null;
	PreparedStatement stmt = null;	

	int row = 0;	
	
	Class.forName("org.mariadb.jdbc.Driver");
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary","root","java1234");
	
	stmt = conn.prepareStatement(sql);
	stmt.setString(1,diary_date );
	stmt.setString(2,title );
	stmt.setString(3,weather );
	stmt.setString(4,feel );
	stmt.setString(5,content );
	System.out.println(stmt + "<-stmt");
	
	row = stmt.executeUpdate();
	// 3. 결과분기
	if(row==1){
		response.sendRedirect("/diary/diary.jsp");
	}else {
		
	}
	
	//성공 :
	//실패 : 
	
%>