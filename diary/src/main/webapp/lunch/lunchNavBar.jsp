<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Song Myung&display=swap" rel="stylesheet">
<link href="/diary/diaryButton.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" ></script>
	<style>
		
	</style>

	<title>홈 화면</title>
</head>
<body class="container " >
	<nav class="navbar navbar-expand-lg" style="background-color: #98FB98;" >
  <div class="container-fluid">  
   <a class="navbar-brand" href="/diary/diary.jsp">Home</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
 
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
        <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="/diary/calendarDiary.jsp">달력보기</a>
        </li>
        <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="/diary/lunch/lunchList.jsp">점심메뉴</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="/diary/lunch/addLunchForm.jsp">메뉴추가</a>
        </li>       
        
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            항목개수
          </a>
          <ul class="dropdown-menu">  
            <li><a class="dropdown-item" href="/diary/lunch/lunchList.jsp?perPage=1">1개씩</a></li>     
            <li><a class="dropdown-item" href="/diary/lunch/lunchList.jsp?perPage=5">5개씩</a></li>
            <li><a class="dropdown-item" href="/diary/lunch/lunchList.jsp?perPage=7">7개씩</a></li>
            <li><a class="dropdown-item" href="/diary/lunch/lunchList.jsp?perPage=10">10개씩</a></li>
            <li><a class="dropdown-item" href="/diary/lunch/lunchList.jsp?perPage=15">15개씩</a></li>
            <li><hr class="dropdown-divider"></li>
            <li><a class="dropdown-item" href="#">Something else here</a></li>
          </ul>
        </li>
<!--         <li class="nav-item"> -->
<!--           <a class="nav-link disabled" aria-disabled="true">Disabled</a> -->
<!--         </li> -->
      </ul>
      <form class="d-flex" role="search" method="get" action="/diary/lunch/lunchList.jsp" >
        <input class="form-control me-2" name="searchWord" type="search" placeholder="메뉴검색" aria-label="Search">
        <button class="btn btn-outline-success" type="submit">Search</button>
      </form>
    </div>
  </div>
  
</nav>	
</body>
</html>
