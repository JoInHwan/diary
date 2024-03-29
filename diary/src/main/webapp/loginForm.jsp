<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%=session.getId()%>
<%
	//0-1) 로그인(인증) 분기 session사용으로 변경
	// 로그인 성공시 세션에 loginMember라는 변수를 만들고 값으로 로그인 아이디를 저장
	// 사용되는 Ssssion API
	
	String loginMember = (String)session.getAttribute("loginMember"); // session.getAttibute(String) : 변수이름으로 변수값을 반환하는 메서드	
			
	// session.getAttibute() 찾는 변수가 없으면 null 값을 반환한다 	
	System.out.println(loginMember + "<-loginMember1");	// null이면 로그아웃상태이고, null이아니면 로그인 상태
	// loginForm페이지는 로그아웃상태에서만 출력되는 페이지
	
	
	
	if(loginMember != null) {  // 세션값이 '있다면' 즉 로그인이 되어있다면
		response.sendRedirect("/diary/diary.jsp");
		return; // 코드 진행을 끝내는 문법 ex) 메서드 끝낼때 return사용
	}		
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
	
	.loginPage {
		margin-top: 250px;
		height: 400px;
	}
	
	.loginButton {
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
	
	.loginButton:hover {
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
/* 		height:20px; */
/* 		position: absolute; */
/* 		left: 50%; */
/* 		right: 50%; */
/* 		transform: translate(-50%, -50%); */
/* 		top: 385px; */
/*  	width: 10%;  */
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
		
				<div class="loginPage col-7 border shadow p-3 bg-body-tertiary rounded">		
					
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
				
		<div><button class="loginButton" type="submit">로그인</button></div>	 											
					
		</div>		
							
				</form>				
				</div>				
			
			<div class="col"></div>
		</div>
	</div>
</body>
</html>













