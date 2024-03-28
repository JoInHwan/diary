<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="loginConfirm.jsp" %>
<% 		
	int currentPage = 1 ;
	if(request.getParameter("currentPage")!=null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}	
	int rowPerPage = 10;
	
	String perPage = request.getParameter("perPage");
	
	System.out.println(perPage+ "<-perPage");
	if(perPage == null || perPage.equals("null")) {
	    rowPerPage = 10;
	    System.out.println(rowPerPage + "rowPerPage가 null일때");
	} else {
	    rowPerPage = Integer.parseInt(perPage);
	    System.out.println(rowPerPage + "<-rowPerPage");
	}	
		
	int startRow = (currentPage-1)*rowPerPage;	
	
	String searchWord = "";
	if(request.getParameter("searchWord")!=null){
		searchWord = request.getParameter("searchWord");
	}	
	String sql = "select lunch_date,menu from lunch where menu like ? limit ?,?";
	PreparedStatement stmt = null;
	ResultSet rs = null;
	stmt = conn. prepareStatement(sql);
	stmt.setString(1,"%"+searchWord+"%");
	stmt.setInt(2,startRow);
	stmt.setInt(3,rowPerPage);
	rs = stmt.executeQuery();
	
	//출력리스트모듈
	String sql2="select count(*) cnt from lunch where menu like ?";
	PreparedStatement stmt2 = null;
	ResultSet rs2 = null;
	stmt2 = conn.prepareStatement(sql2);
	stmt2.setString(1,"%"+ searchWord +"%");
	rs2 = stmt2.executeQuery();
	int totalRow = 0;
	if(rs2.next()){
		totalRow = rs2.getInt("cnt");
	}
	int lastPage = totalRow / rowPerPage;
	if(totalRow % rowPerPage != 0) {
		lastPage = lastPage + 1;
	}	
	System.out.println(rs2.getInt("cnt")+"<-cnt");
	System.out.println(lastPage+"<-lastPage");
	
	
	String sql3 = "select menu, count(*) cnt from lunch group by menu order by COUNT(*) DESC ";
	PreparedStatement stmt3 = null;
	ResultSet rs3 = null;
	stmt3 = conn.prepareStatement(sql3);
	rs3 = stmt3.executeQuery();	
%>
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Song Myung&display=swap" rel="stylesheet">
<link href="/diary/diaryButton.css" rel="stylesheet">
	<style>		
	.index  {
			
		font-weight: bold;	
	}
	
	td {
		text-align: center;
	}
	.box:link .box:visited{
	  color: black;
	  padding: 12px 25px;
	  text-align: center;
	  text-decoration: none;
	  display: inline-block;
	  height:"50px"
	}
</style>

	<title>홈 화면</title>
</head>
<body class="container bg" >
<div class="opacity-75" >	
	<div class="row">
		<div class="col"></div>
		<div class="col-8 mt-5  p-5 mb-5  border shadow bg-body-tertiary rounded align-p">		
			<h1 class="head" style="text-align:center;" >Lunch</h1>
			<%@ include file="lunchNavBar.jsp"%>						
			<a href="/diary/logout.jsp" class="logoutButton">로그아웃</a><br>										
			<table class="table table-hover table-striped" border="1">
				<tr>
					<td class="index"  style="width:20%">날짜</td>						
					<td class="index">내용</td>
				</tr>
				<%
					while(rs.next()){
				%>
				<tr>
					<td class="box"> 
						<%=rs.getString("lunch_date")%>
					</td>
					<td class="box">							
						<%=rs.getString("menu")%>
					</td>					
				</tr>					
				<%
					}
				%>				
			</table>										
				<nav aria-label="Page navigation example">
					<ul class="pagination justify-content-center">

				<%
					if(currentPage > 1) {
				%>
						<li class="page-item">
							<a class ="page-link" href="/diary/lunch/lunchList.jsp?currentPage=1&perPage=<%=perPage%>">처음페이지</a>
						</li>
						<li class="page-item">
							<a class ="page-link" href="/diary/lunch/lunchList.jsp?currentPage=<%=currentPage-1%>&perPage=<%=perPage%>">이전페이지</a>
						</li>																
				<%		
					} else {
				%>
						<li class="page-item disabled">
							<a class ="page-link" href="/diary/lunch/lunchList.jsp?currentPage=1">처음페이지</a>
						</li>
					
						<li class="page-item disabled">
							<a class ="page-link" href="/diary/lunch/lunchList.jsp?currentPage=<%=currentPage-1%>&perPage=<%=perPage%>">이전페이지</a>
						</li>
				<%		
					}				
					if(currentPage < lastPage || lastPage == 0  ) {
				%>
						<li class="page-item">
							<a class ="page-link" href="/diary/lunch/lunchList.jsp?currentPage=<%=currentPage+1%>&perPage=<%=perPage%>">다음페이지</a>
						</li>
						<li class="page-item">
							<a class ="page-link" href="/diary/lunch/lunchList.jsp?currentPage=<%=lastPage%>">마지막페이지</a>
						</li>
				<%		
					}
				%>
			</ul>
				</nav>					
<!-- 	statsLunch 시작	 -->			
				<%
				double maxHeight = 1000;
				double totalCnt = 0; //
				while(rs3.next()) {
					totalCnt = totalCnt + rs3.getInt("cnt");
				}							
				rs3.beforeFirst();
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
							while(rs3.next()) {
								int h = (int)(maxHeight * (rs3.getInt("cnt")/totalCnt));
						%>
								<td style="vertical-align: bottom;width: 10%;">
									<div style="height: <%=h%>px; background-color:<%=c[i]%>;
												text-align: center">
										<%=rs3.getInt("cnt")%>
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
							rs3.beforeFirst();
										
							while(rs3.next()) {
						%>
								<td style="text-align: center"><%=rs3.getString("menu")%></td>
						<%		
							}
						%>
							</tr>
						</table>
						
					</div>
					<div class="col"></div>
				</div><br>	      
<!-- 	statsLunch 끝	 -->
			<div style="text-align:right;">
				<a style="color:red;"href="/diary/lunch/deleteLunch.jsp">항목삭제</a>
			</div>
		</div>
						
		<div class="col"></div>
	</div>
</div>		
</body>
</html>





