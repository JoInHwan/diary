<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.*" %>
<%
	// 0. 로그인(인증) 분기
	// diary.login.my_session => 'OFF' => redirect("loginForm.jsp")
	
	String sql1 = "select my_session mySession from login";
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	PreparedStatement stmt1 = null;
	ResultSet rs1 = null;
	conn = DriverManager.getConnection(
			"jdbc:mariadb://127.0.0.1:3306/diary", "root", "java1234");
	stmt1 = conn.prepareStatement(sql1);
	rs1 = stmt1.executeQuery();
	String mySession = null;
	if(rs1.next()) {
		mySession = rs1.getString("mySession");
	}
	// diary.login.my_session => 'OFF' => redirect("loginForm.jsp")
	if(mySession.equals("OFF")) {
		String errMsg = URLEncoder.encode("잘못된 접근 입니다. 로그인 먼저 해주세요", "utf-8");
		response.sendRedirect("/diary/loginForm.jsp?errMsg="+errMsg);
		return; // 코드 진행을 끝내는 문법 ex) 메서드 끝낼때 return사용
	}
%>	

<%
	/*
	SELECT menu,COUNT(*)FROM lunch GROUP BY menu ORDER BY COUNT(*) DESC;*/
	String sql = "select menu, count(*) cnt from lunch group by menu order by COUNT(*) DESC ";
	PreparedStatement stmt = null;
	ResultSet rs = null;
	stmt = conn.prepareStatement(sql);
	rs = stmt.executeQuery();
%>
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Song Myung&display=swap" rel="stylesheet">
<link href="/diary/diaryButton.css" rel="stylesheet">
	<meta charset="UTF-8">
	<title></title>
	
</head>
<body class="container bg">
<div class="opacity-75" >	
		<div class="row">
			<div class="col"></div>
			<div class="col-8 mt-5  p-5 mb-5  border shadow bg-body-tertiary rounded align-p">
				<h1 class="head" style="text-align:center;">점심 통계</h1>					
				
				<%@ include file="lunchNavBar.jsp"%><br>		
				<%
							double maxHeight = 1000;
							double totalCnt = 0; //
							while(rs.next()) {
								totalCnt = totalCnt + rs.getInt("cnt");
							}							
							rs.beforeFirst();
				%>
				<div class="row">
				<div class="col"></div>
					<div class="col-10">				
						<div>				
						<h4>전체 표본 수 : <%=(int)totalCnt%> </h4>
						</div>				
					<table border="1" style="width:100%">
						<tr>
							<%	
								String[] c = {"#FF0000", "#FF5E00", "#FFE400", "#1DDB16", "#0054FF","#8A2BE2","#EE82EE"};
								int i = 0;
								while(rs.next()) {
									int h = (int)(maxHeight * (rs.getInt("cnt")/totalCnt));
							%>
									<td style="vertical-align: bottom;width: 10%;">
										<div style="height: <%=h%>px; 
													background-color:<%=c[i]%>;
													text-align: center">
											<%=rs.getInt("cnt")%>
										</div>
									</td>
							<%		
									i = i+1;
								}
							%>
						</tr>
						<tr>
							<%
								// 커스의 위치를 다시 처음으로
								rs.beforeFirst();
											
								while(rs.next()) {
							%>
									<td style="text-align: center"><%=rs.getString("menu")%></td>
							<%		
								}
							%>
						</tr>
					</table>
					</div>
					<div class="col"></div>
					</div>
			</div>			
			<div class="col"></div>
		</div>
	</div>
	
	
</body>
</html>