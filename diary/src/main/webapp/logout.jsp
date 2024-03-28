<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.net.*" %>
<%
	// 로그아웃된상태에서 강제로 logout페이지로 접근할경우 에러메시지와 함께 로그인페이지로 이동 
	String sql1 = null;
	sql1="select my_session as mySession from login";
	
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null; 
	PreparedStatement stmt1 = null; 
	ResultSet rs1 = null;	
	
	conn= DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary","root","0901");
	stmt1=conn.prepareStatement(sql1);
	rs1 = stmt1.executeQuery();
	
	String mySession = null; //변수 생성
	if(rs1.next()){	 // diary데이터베이스 출력
		mySession = rs1.getString("mySession"); // "1"로 대체 가능(첫번째컬럼을 가져옴)		
	}
	if(mySession.equals("OFF")){   // 로그인 상태가 OFF라면
		String errMsg =  URLEncoder.encode("잘못된 접근입니다. 로그인을 해주세요","utf-8");		
		response.sendRedirect("/diary/loginForm.jsp?errMsg="+errMsg); // 자동으로 로그인페이지로 넘어감
		//자원반납
		rs1.close();
		stmt1.close();
		conn.close();
		return;  // redirect와 달리 아예 코드 진행을 끝냄
	}
	
%>

<% 	// 로그아웃 loginDB수정
	String logout = request.getParameter("logout");
	System.out.println(logout+"logoutaction.로그아웃");
	
	Class.forName("org.mariadb.jdbc.Driver");
	conn= DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary","root","0901");

	String member_id = null;
	//diarye테이블의 my_session -> 'ON'변경  (Update문) 
	String update_mySession_Sql = "update login set my_session= 'OFF',off_date=now() where my_session= 'ON'";		
	PreparedStatement stmtUpdate = null; 
	ResultSet rsUpdate = null;
	stmtUpdate=conn.prepareStatement(update_mySession_Sql);
	int row = stmtUpdate.executeUpdate();
	System.out.println(row + " <-- row");
	
	response.sendRedirect("/diary/loginForm.jsp");
%>
	