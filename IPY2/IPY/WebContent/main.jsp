<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="user.UserDAO" %>
<%@ page import="user.User" %>
<%@ page import="ipy_info.Ipy_info" %>
<%@ page import="ipy_info.Ipy_infoDAO" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <meta name="description" content="">
  <meta name="author" content="">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
  <link href="css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
  <link href="css/bootstrap-theme.min.css" rel="stylesheet">
  <script src="js/bootstrap.min.js"></script>
  <script src="ie-emulation-modes-warning.js"></script>
  <script src="docs.min.js"></script>
  <script src="ie10-viewport-bug-workaround.js"></script>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>

 <title>이색 카드 저금통 :: IPY</title>

<link href="css/main.css" rel="stylesheet">
<style>
body {color: #5a5a5a;}
.logo{background-color:#5D5D5D;}
/*============================================ 본문 ============================================*/
/*===============================================================================================*/
.carousel {height: 860px;}
/* Declare heights because of positioning of img element */
.carousel .item {height: 860px; background-color:#5D5D5D; padding-top:50px;}
.carousel-inner > .item > img {
margin: 0 auto;
width: 800px;
height: 80%;
border:1px solid #E7E7E7;
border-radius:10px;
padding:30px;
margin-bottom:0;
}
/*========================================= 본문 버튼 =========================================*/
/*===============================================================================================*/
.carousel-caption {z-index: 10; height:120px;}
.carousel-caption .btn {margin-bottom:15px;}
/*========================================= 본문 화살표 =========================================*/
/*===============================================================================================*/
.carousel-control{position:absolute; top:-130px;}
@media (min-width: 768px) {/*============================== 768~ 사이즈============================*/
/*=========================================== 본문 =============================================*/
/*===============================================================================================*/
.carousel {margin-top:0px;}
.carousel .item {padding-top:100px;}
}
@media (max-width:767px){/*============================== ~767 사이즈 ============================*/
/*============================================ 본문 ============================================*/
/*===============================================================================================*/
.carousel{height: 500px; }
.carousel .item {height: 500px;}
.carousel-inner > .item > img{width:500px; height:auto; margin-top:10px;}
.carousel-control{position:absolute; top:0;}
.carousel-caption .btn {margin-bottom:-150px;}
.carousel-indicators{display:none;}
/*============================================ 푸터 =============================================*/
/*===============================================================================================*/
.footer{top:500px;}
}
</style>

</head>
<body>
	<%
		String ID = null;
		String NAME=null;
		if (session.getAttribute("ID") != null){
			ID = (String) session.getAttribute("ID");
		}
	%>
	
	<%
		if(ID==null){
	%>
	<script>
		location.href='login.jsp';
	</script>
	<%
		}else{
			UserDAO userDAO = new UserDAO();
			String name = userDAO.getName(ID);
	%>
<!-- /*============================================ 기본 =============================================*/ -->
<!-- /*===============================================================================================*/   -->
      <div class="container logo">
        <a href="main.jsp"><img src="img/ipy_logo.png" alt=""></a>
      </div>
    <div class="navbar-wrapper">
      <div class="container">
        <nav class="navbar navbar-inverse navbar-static-top">
          <div class="container">
            <div class="navbar-header">
              <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
              </button>
              <a class="navbar-brand" href="main.jsp">이색 카드 저금통 :: IPY</a>
            </div>
            <div id="navbar" class="navbar-collapse collapse">
              <ul class="nav navbar-nav">
                <li class="active"><a href="main.jsp">나의 저금통</a></li>
                <li><a href="user_info.jsp">개인정보 설정</a></li>
              </ul>
              <form class="navbar-form navbar-right" role="out">
               <a href="#"><%= name%>님 환영합니다.</a>
               <a type="button" class="btn btn-primary btn-xl btn-right" href="logoutAction.jsp">로그아웃</a>
              </form>
            </div>
          </div>
        </nav>
      </div>
    </div>


<!-- /*============================================ 내용 =============================================*/ -->
<!-- /*===============================================================================================*/   -->

<div id="myCarousel" class="carousel slide" data-ride="carousel">
    <%
	Ipy_infoDAO ipy_info = new Ipy_infoDAO();
	ArrayList<Ipy_info> ipy_list = ipy_info.getList(ID);
	if(ipy_list == null || ipy_list.size() == 0){
	%>
	<ol class="carousel-indicators">
		<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
	</ol>
	<div class="carousel-inner" role="listbox">
		<div class="item active">
			<img src="img/carousel/piggybank.png" alt="1 slide">
			<div class="container">
				<div class="carousel-caption">
					<a class="btn btn-lg btn-primary" href="user_info.jsp" role="button">저금통 등록</a>
				</div>
			</div>
		</div>
	</div>
	<%
		}else{
		%>
		<ol class="carousel-indicators">
		<%
		for(int i=0; i<ipy_list.size(); i++){
			if(i==0){
	    %>
	    <li data-target="#myCarousel" data-slide-to="<%= i%>" class="active"></li>
	    <%
	        } else{
	    %>
	    <li data-target="#myCarousel" data-slide-to="<%= i%>"></li>
	    <%
	        }
	      }// for(int i=0; i<ipy_list.size(); i++) 끝
	    %>
	  </ol>
	  <div class="carousel-inner" role="listbox">
	    <%
	      for(int i=0; i<ipy_list.size(); i++){
	        if(i==0){
	    %>
	    <div class="item active">
	      <img src="img/carousel/<%= ipy_list.get(i).getIpy_name() %>.png" alt="<%= (i+1)%> slide">
	      <div class="container">
	        <div class="carousel-caption">
	          <a class="btn btn-lg btn-primary" href="recent.jsp?ipy_account=<%= ipy_list.get(i).getIpy_account()%>&Startpage=<%= 1%>&Startlist=<%= 0%>" role="button">Continue</a>
	        </div>
	      </div>
	    </div>
	    <%
	    	} else{
	    %>
	    <div class="item">
	      <img src="img/carousel/<%= ipy_list.get(i).getIpy_name() %>.png" alt="<%= (i+1)%> slide">
	      <div class="container">
	        <div class="carousel-caption">
	          <p><a class="btn btn-lg btn-primary" href="recent.jsp?ipy_account=<%= ipy_list.get(i).getIpy_account()%>&Startpage=<%= 1%>&Startlist=<%= 0%>" role="button">Continue</a></p>
	        </div>
	      </div>
	    </div>
	    
	    <%
	        }
	      } //for(int i=0; i<ipy_list.size(); i++) 문 끝
		} // if(ipy_list == null || ipy_list.size() == 0) 문 끝
    	%>
    	</div> <!-- carousel-inner 끝 -->
	  <a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev">
	    <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
	    <span class="sr-only">Previous</span>
	  </a>
	  <a class="right carousel-control" href="#myCarousel" role="button" data-slide="next">
	    <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
	    <span class="sr-only">Next</span>
	  </a>
</div> <!-- myCarousel 끝 -->


<!-- /*============================================ 푸터 =============================================*/ -->
<!-- /*===============================================================================================*/   -->
    <footer class="footer">
      <div class="footercontainer">
        <p class="text-muted">&copy; 2020 by 영남이공대학교 IT's</p>
      </div>
    </footer>
    <%
		}
	%>
</body>
</html>