<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.net.*" %>
<%@ include file="loginConfirm.jsp" %>


<%  //1. 요청분석
	// 출력하고자하는달력의 년도와 월 값을 넘겨받음
	String targetYear = request.getParameter("targetYear");
	String targetMonth = request.getParameter("targetMonth");
	
	Calendar target = Calendar.getInstance();
	Calendar today = Calendar.getInstance();	
	 	
	if(targetYear !=null && targetMonth !=null ){
		target.set(Calendar.YEAR, Integer.parseInt(targetYear));
		target.set(Calendar.MONTH, Integer.parseInt(targetMonth));
	}
	// 오늘 날짜에 대한 값
	int todayDate = today.get(Calendar.DATE);	
	int todayYear = today.get(Calendar.YEAR);
	int todayMonth = today.get(Calendar.MONTH);	
	
	// 시작공백의 개수를 알기위해 1일의 요일이 필요 -> target날짜를 1일로 변경
	target.set(Calendar.DATE,1);
	
	// 달력 타이틀로 출력할 변수 
	int tYear = target.get(Calendar.YEAR);
	int tMonth = target.get(Calendar.MONTH);	
	
	int yo = target.get(Calendar.DAY_OF_WEEK);
	System.out.println(yo + "<-yo");   //금요일이므로 6이 출력
	// 시작공백의 개수 : 일요일x 월:1, 화:2
	int startBlank = yo-1;  // 6-1=5개의 시작공백
	int lastDate = target.getActualMaximum(Calendar.DATE); //마지막일
	System.out.println(lastDate + "<-lastDate");  
	int countDiv = startBlank + lastDate;
	
	String wholeMonth[]= 
		{"January","Fabruary","March","April","May","June","July","August","September","October","November","December"};
	String month="";

	for(int i=0;i<12;i++){		
		if(tMonth==i){
			month=wholeMonth[i];
		}
	}
	System.out.println(month+"<-month");	
	
	// DB에서 tYear과 tMonth에 해당하는 diary목록 추출
	String sql2 = "SELECT day(diary_date)as day,diary_date as diaryDate,left(title,5)as title,feeling from diary where year(diary_date)=? AND MONTH (diary_date)=?";
	PreparedStatement stmt2 = null;
	ResultSet rs2 = null;
	stmt2 = conn.prepareStatement(sql2);
	stmt2.setInt(1,tYear);
	stmt2.setInt(2,tMonth+1);
	System.out.println(stmt2+"<-stmt2");
	
	rs2 = stmt2.executeQuery();	
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>다이어리 달력</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="/diary/diaryButton.css" rel="stylesheet"/>
	<style>		
		.calendar {
			display: flex;
			width:100%;
			flex-wrap: wrap;
			box-sizing: border-box;
		}
		.calendar > div {
			width: calc(100%/7);
			height: 91px;
			lien-height: 128px;
			box-sizing: border-box;
			text-align: center;	
		}		
 		.calendar > div:nth-child(7n + 1) { 
 			color: red;} 
					
		.pass{ text-decoration: none;
			color: black;
			font-size: 50px;
		}		
		.month{ 
		font-family:"Times New Roman", serif;
		font-size: 35px;	
		font-weight: bold;
		text-align:center;
		 margin-top: 50px;
		}		
		
		.today{
		 border-color: #2a6afd;
		border-style: groove;
		 border-width: 2px;
		border-radius: 8px;
		}
		.yoil{
		 font-family: "Lucida Console";
		 font-weight: bold;
		 height:60px;
		}		
			
		.circle{text-decoration: none;
			color: black;			
			text-align:center;
			position:absolute;
			z-index: 10;
			width:122px;
			height:88px;
			
		}
		
		.cellHover:Hover{
		display:block;
		cursor: pointer; 
		background-color: #C0C0C0;		
		border-radius: 50%;
		}		
</style>
</head>
<body class="container bg" >
<div class="row">
	<div class="col"></div>
	<div class="col-8 mt-5 pt-5 pb-3 mb-5 border shadow bg-body-tertiary rounded opacity-75 align-p">
				
		<h3 class="yoil">&nbsp;&nbsp;<%=tYear%>년 <%=tMonth+1%>월 </h3>
		<%@ include file="NavBar.jsp"%>
		<a href="/diary/logout.jsp" class="logoutButton">로그아웃</a>
		<div>
		<br>
		<div class="row">
		
			<div class="col" style=text-align:center; > <a class="pass" href="/diary/calendarDiary.jsp?targetYear=<%=tYear%>&targetMonth=<%=tMonth-1%>" style="text-align:left" > &#11160; </a> </div>
			<div class="col-8" style=text-align:center;><span class="month"><%=month%></span></div>	
			<div class="col" style=text-align:center;> <a class="pass" href="/diary/calendarDiary.jsp?targetYear=<%=tYear%>&targetMonth=<%=tMonth+1%>" style="text-align:right">&#11162;</a> </div>	
				 
		</div>		 
		<br><br>				
		</div>
		
		<!-- DATE값이 들어갈 DIV -->
		<div class="calendar yoil">
			<div> Sun </div>
			<div > Mon </div>
			<div > Tue </div>
			<div > Wed </div>
			<div > Thu </div>
			<div> Fri </div>
			<div > Sat </div>
		</div>
		<div class="calendar">
		<%
			for(int i=1; i<=countDiv; i++){				
				if(((i-startBlank)==todayDate)&&(todayMonth==tMonth)&&(todayYear==tYear)) {
		%>			<div class="today cellHover"><%=todayDate%><br>
		<%				
				//현재날짜(i-startBlank)의 일기가 rs2목록에 있는지비교 [달력에 일기 제목 출력]
						while(rs2.next()){
							if(rs2.getInt("day")==(i-startBlank)){  //해당날짜에 일기가 존재하는지
		%>
							<a class="circle" href="/diary/diaryOne.jsp?diaryDate=<%=rs2.getString("diaryDate")%>">
								<%=rs2.getString("title")%><br><%=rs2.getString("feeling")%></a>
		<%					break;
							}
						}rs2.beforeFirst(); %></div><%  //처음일짜로 변경	
						
				}else if(i-startBlank>0){
		%>
					<div class="cellHover" ><%=i-startBlank %><br>	
					
		<%				//현재날짜(i-startBlank)의 일기가 rs2목록에 있는지비교 [달력에 일기 제목 출력]
						while(rs2.next()){
							if(rs2.getInt("day")==(i-startBlank)){  //해당날짜에 일기가 존재하는지
		%>
			
			
							<a class="circle" href="/diary/diaryOne.jsp?diaryDate=<%=rs2.getString("diaryDate")%>">
								<%=rs2.getString("title")%><br><%=rs2.getString("feeling")%></a>
		<%					break;
							}
						}rs2.beforeFirst(); //처음일짜로 변경	
		%>		</div>
		<%  		
						}else{
		%>
					<div >&nbsp;</div>
		<%
				}		
			}
		%>
		</div>
	</div>
	<div class="col"></div>	
</div>
	

	
</body>
</html>