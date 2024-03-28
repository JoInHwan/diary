<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
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
		
		
		response.sendRedirect("/diary/diary.jsp"); // 자동으로 로그인페이지로 넘어감
		//자원반납
		rs1.close();
		stmt1.close();
		conn.close();
		return;  // redirect와 달리 아예 코드 진행을 끝냄
	}
	rs1.close();
	stmt1.close();
	conn.close();
	
	//1. 요청값분석
	String errMsg = request.getParameter("errMsg");	 //에러메시지 값을 이후 페이지로 부터 받아옴	
	
%>

<!DOCTYPE html>
<html>
<head>
<link href="https://fonts.googleapis.com/css2?family=Song Myung&display=swap" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" >
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" ></script>
	<meta charset="UTF-8">
	<title>로그인 화면</title>
<style>
	.head {
		font-family: Song Myung;
		font-size: 40px;
	}
	
	.bg {
		background-size: 100%;
		background-image: url(/diary/sk.jpg);
		background-attachment: fixed;
	}
	
	.temp {
		margin-top: 250px;
		height: 400px;
	}
	
	button {
		text-align: center;
		border: none;
		text-decoration: none;
		margin: 20px 2px;
		border-radius: 8px;
		color: white;
		background-color: #2a6afd;
		padding: 16px 16px;
		width: 50%;
	}
	
	button:hover {
		background-color: #e7e7e7;
		color: black;
	}
	
	input[type=text] {
		width: 50%;
		padding: 12px 20px;
		margin: 8px 0;
		box-sizing: border-box;
	}
	
	a {
		color: black;
		text-decoration: none;
	}
	
	.error {
		background-color: rgba(255, 30, 20, 0.8);
		border-radius: 4px;
		position: absolute;
		left: 50%;
		right: 50%;
		transform: translate(-50%, -50%);
		top: 385px;
		width: 15%;
	}
	
	.info {
		font-size: 20px;
		color: #2a6afd;
	}
</style>		
</head>
<body class="bg">
	<div class="container text-center">
		<div class="row">
			<div class="col"></div>
		
				<div class="temp col-7 border shadow p-3 bg-body-tertiary rounded">		
					
					<div class="head mb-3">My Diary</div> 	
					<div class="info">로그인 후 이용하실 수 있습니다</div>		
					<div class="error">
					<%		if(errMsg!=null){	// 에러메시지변수가 있다면 (로그인이 OFF상태라면) 출력	
						
					%>
					<a href="/diary/loginForm.jsp"><%=errMsg %>	</a>		
					<%
							}
					%>		
				</div><br>
		 					
		<form action="/diary/loginAction.jsp"> 	
		<div class="opacity-100"></div>	
		<div > <input type="text" name="memberId" placeholder="아이디">
		<div></div>	 
		<div><input type="text" name="memberPw" placeholder="비밀번호"></div>				
				
		<div><button type="submit">로그인</button></div>	 											
					
		</div>		
							
				</form>				
				</div>				
			
			<div class="col"></div>
		</div>
	</div>
</body>
</html>













