<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.net.*" %>
<%@ page import="java.util.*"%>
<%
	// 로그아웃된상태에서 강제로 접근할경우 에러메시지와 함께 로그인페이지로 이동 
	// 0. 로그인(인증) 분기
	String loginMember = (String)(session.getAttribute("loginMember"));
	if(loginMember == null) {
		String errMsg = URLEncoder.encode("잘못된 접근 입니다. 로그인 먼저 해주세요", "utf-8");
		response.sendRedirect("/diary/loginForm.jsp?errMsg="+errMsg);
		return;
	}
	
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null; 
	conn= DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary","root","java1234");
	
%>