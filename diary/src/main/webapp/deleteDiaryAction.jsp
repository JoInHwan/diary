<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="loginConfirm.jsp" %>	
<%	
	String lunch_Date = request.getParameter("lunch_Date");
	System.out.println(lunch_Date + "<-lunch_Date");	

	// 해당 일기 삭제
		String sql = "delete from lunch where lunch_Date = ?";
		PreparedStatement stmt = null;	
		stmt = conn.prepareStatement(sql);
		stmt.setString(1,lunch_Date);
		
		int row= stmt.executeUpdate();
		System.out.println(row + "<-row");			
		
		response.sendRedirect("/diary/lunch/lunchList.jsp");	
%>