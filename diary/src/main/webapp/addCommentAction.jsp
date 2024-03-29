<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="loginConfirm.jsp" %>
<%
	// 0. post 인코딩 설정
	//request.setCharacterEncoding("utf-8");

	// 1. 입력값 받는다
	
	String diaryDate = request.getParameter("diaryDate");
	String memo = request.getParameter("memo");
	System.out.println(diaryDate + " <-- diaryDate");
	System.out.println(memo + " <-- memo");
	// 2. DB접속해서 입력값 입력한다.
	
	if (memo.equals("")){		
		response.sendRedirect("/diary/diaryOne.jsp?diaryDate="+diaryDate);
		System.out.println("memo값이 없습니다");
		} else{
			String sql = "insert into comment (diary_date,memo,create_date) VALUES (?,?,NOW())";				
			PreparedStatement stmt = conn.prepareStatement(sql);
			
			stmt.setString(1, diaryDate);
			stmt.setString(2, memo);			
			
			System.out.println(stmt);
			
				int row = stmt.executeUpdate();
				if(row == 1) {
					System.out.println("입력성공");
				} else {
					System.out.println("입력실패");
				}
		response.sendRedirect("/diary/diaryOne.jsp?diaryDate="+diaryDate);

	}
%>

