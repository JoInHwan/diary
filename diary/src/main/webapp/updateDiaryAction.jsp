<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%	
	String diary_date = request.getParameter("diary_date");
	String title = request.getParameter("title"); 
	String weather = request.getParameter("weather"); 
	String feeling = request.getParameter("feeling");
	String content = request.getParameter("content");
	

	
	System.out.println(diary_date + " <--불러온 diary_date 값");
	System.out.println(title + " <--불러온 title 값");
	System.out.println(weather + " <--불러온 weather 값");	
	System.out.println(feeling + " <--불러온 feeling 값");	
	System.out.println(content + " <--불러온 content 값");

	// DB데이터 수정
		String sql = "update diary SET title=?,weather=?,feeling=?,content=? WHERE diary_date=?";
		Connection conn = null;
		PreparedStatement stmt = null;	
		//ResultSet rs = null;
		int row = 0;	
		
		Class.forName("org.mariadb.jdbc.Driver");
		conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary","root","java1234");
		
		stmt = conn.prepareStatement(sql);
		stmt.setString(1,title );
		stmt.setString(2,weather );
		stmt.setString(3,feeling );
		stmt.setString(4,content );
		stmt.setString(5,diary_date );
		
		System.out.println(stmt + "<-stmt");
		
		row = stmt.executeUpdate();
		// 3. 결과분기
		if(row==1){
			//response.sendRedirect("/diary/diary.jsp");
			response.sendRedirect("/diary/diaryOne.jsp?diaryDate="+diary_date);
		}else {
			
		}	
	
%>