<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="loginConfirm.jsp" %>

<%	
	int comment_num = Integer.parseInt(request.getParameter("comment_num"));
	String diary_date = request.getParameter("diary_date");
	
	System.out.println(comment_num + "<-comment_num in 댓글삭제 Action");	
	System.out.println(diary_date + "<-diary_date in 댓글삭제 Action");	
	
	String sql = "delete from comment where comment_num=?";
	
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setInt(1,comment_num);
	
	
	int row= stmt.executeUpdate();
	System.out.println(row + "<-row in 댓글삭제 Action");
	
	response.sendRedirect("/diary/diaryOne.jsp?diaryDate="+diary_date);
%>
