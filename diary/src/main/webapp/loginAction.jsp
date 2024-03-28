<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.net.*" %>
<%
	// 0. 로그인(인증) 분기
	// diary데이터베이스	login테이블my_session컬럼 => ON -> redirect("diary.jsp")

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
	if(rs1.next()){  // diary데이터베이스 출력
		mySession = rs1.getString("mySession"); // string 안을 "1"로 대체 가능(첫번째컬럼을 가져옴)		
	}
	if(mySession.equals("ON")){   // 로그인 상태가 ON이라면
		response.sendRedirect("/diary/loginForm.jsp"); // 자동으로 로그인페이지로 넘어감
		//자원반납
		rs1.close();
		stmt1.close();
		conn.close();
		return;  // redirect와 달리 아예 코드 진행을 끝냄
	}
	
	//1. 요청값분석
	String memberId = request.getParameter("memberId");	 
	String memberPw = request.getParameter("memberPw");	
	
	String sql2 = "select member_id memberId from member where member_id = ? and member_pw= ? ";
	PreparedStatement stmt2 = null; 	
	ResultSet rs2 = null;
	stmt2=conn.prepareStatement(sql2);
	stmt2.setString(1,memberId);
	stmt2.setString(2,memberPw);
	rs2 = stmt2.executeQuery();
	
	if(rs2.next()){  // 로그인성공 (sql이 출력될때)
		System.out.println("로그인성공");
		
		String member_id = null;
		//diarye테이블의 my_session -> 'ON'변경  (Update문) 
		String update_mySession_Sql = "update login set my_session= 'ON',on_date=now() where my_session= 'OFF'";		
		PreparedStatement stmtUpdate = null; 
		ResultSet rsUpdate = null;
		stmtUpdate=conn.prepareStatement(update_mySession_Sql);
		int row = 0;	
		row = stmtUpdate.executeUpdate();
		// 3. 결과분기
			if(row==1){
				response.sendRedirect("/diary/diary.jsp");
			}else {
			
			}		
		
	}else {		// 로그인실패
		System.out.println("로그인실패");
		String errMsg =  URLEncoder.encode("아이디와 비밀번호가 잘못되었습니다","utf-8");		
		response.sendRedirect("/diary/loginForm.jsp?errMsg="+errMsg); // 자동으로 로그인페이지로 넘어감
	}
	
	
	
	
	
	//자원반납
	rs2.close();
	stmt2.close();
	
	rs1.close();
	stmt1.close();
	
	conn.close();
	
	
	
%>
