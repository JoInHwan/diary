<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ include file="loginConfirm.jsp" %>

<%	
	String diaryDate = request.getParameter("diaryDate");
	System.out.println(diaryDate + "<-diaryDate");	

	// 해당 일기 삭제
		String sql = "delete from diary where diary_date = ?";
		PreparedStatement stmt = null;	
		stmt = conn.prepareStatement(sql);
		stmt.setString(1,diaryDate);
		
		int row= stmt.executeUpdate();
		System.out.println(row + "<-row");			
		
		response.sendRedirect("/diary/calendarDiary.jsp");	
%>