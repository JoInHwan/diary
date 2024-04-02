<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%
	// 1. 요청분석
	String lunch_date = request.getParameter("lunch_date");
	String menu = request.getParameter("menu");
	
	System.out.println(lunch_date + "<--불러온 lunch_date 값");
	System.out.println(menu + "<--불러온 menu 값");
	
	// 2.DB데이터 수정
	String sql = "INSERT INTO lunch(lunch_date,menu,update_date,create_date) VALUES(?,?,NOW(),NOW())";
	Connection conn = null;
	PreparedStatement stmt = null;	

	int row = 0;	
	
	Class.forName("org.mariadb.jdbc.Driver");
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary","root","java1234");
	
	stmt = conn.prepareStatement(sql);
	stmt.setString(1,lunch_date );
	stmt.setString(2,menu );
	
	System.out.println(stmt + "<-stmt");
	
	row = stmt.executeUpdate();
	// 3. 결과분기
	if(row==1){
		response.sendRedirect("/diary/lunch/lunchList.jsp");
	}else {
		
	}
	
%>