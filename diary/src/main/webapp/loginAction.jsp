<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.net.*" %>
<%
	//0. 로그인(인증) 분기
	String loginMember = (String)(session.getAttribute("loginMember"));
	System.out.println(loginMember + " <-loginMember2");
	// loginForm페이지는 로그아웃상태에서만 출력되는 페이지
	if(loginMember != null) {
		response.sendRedirect("/diary/diary.jsp");
		return; // 코드 진행을 끝내는 문법 ex) 메서드 끝낼때 return사용
	}
	
	// loginMember가 null 이다 -> session공간에 loginMember변수를 생성..
	
%>
<%
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null; 
	conn= DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary","root","0901");

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
// 		String member_id = null;
// 		//diarye테이블의 my_session -> 'ON'변경  (Update문) 
// 		String update_mySession_Sql = "update login set my_session= 'ON',on_date=now() where my_session= 'OFF'";		
// 		PreparedStatement stmtUpdate = null; 
// 		ResultSet rsUpdate = null;
// 		stmtUpdate=conn.prepareStatement(update_mySession_Sql);
// 		int row = 0;	
// 		row = stmtUpdate.executeUpdate();
// 		// 3. 결과분기
// 			if(row==1){
// 				response.sendRedirect("/diary/diary.jsp");
// 			}else { 	}	
	
		// 로그인 성공시 DB값 설정 -> session변수 설정
				session.setAttribute("loginMember", rs2.getString("memberId"));	
				response.sendRedirect("/diary/diary.jsp");
				
	}else {		// 로그인실패
		System.out.println("로그인실패");
		String errMsg =  URLEncoder.encode("아이디와 비밀번호가 잘못되었습니다","utf-8");		
		response.sendRedirect("/diary/loginForm.jsp?errMsg="+errMsg); // 자동으로 로그인페이지로 넘어감
	}
	
	//자원반납
	rs2.close();
	stmt2.close();	
	
%>
