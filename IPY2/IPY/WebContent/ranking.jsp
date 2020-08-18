<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="user.UserDAO" %>
<%@ page import="user.User" %>
<%@ page import="ipy_info.Ipy_info" %>
<%@ page import="ipy_info.Ipy_infoDAO" %>
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


/*메인콘텐츠@@@@@@@@@@@@@@@@@!@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@*/

.main_content > .nav-tabs > .active > a{background-color:#333333; color:white;}
.main_content > .nav-tabs > .active > a:hover{background-color:#333333; color:white;}
.main_content > .nav-tabs > .active > a:focus{background-color:#333333; color:white;}
.main_content > .nav-tabs > li > a{color:black;}
table{text-align:center;}
.table-responsive{margin-top:10px;}
.table tr{height:50px;}
.table > tbody > tr > td {vertical-align: middle;}



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
			Ipy_infoDAO ipy_info = new Ipy_infoDAO();
			ArrayList<Ipy_info> ranking_list = ipy_info.getRanking(); //랭킹 만들기
			ArrayList<Ipy_info> ipy_list = ipy_info.getList(ID); //다른페이지 이동을 위한 ipy_account 얻기
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


	<div class="container main_content">
		<ul class="nav nav-tabs nav-justified" role="tablist">
  		<li role="presentation"><a href="recent.jsp?ipy_account=<%= ipy_list.get(0).getIpy_account() %>&Startpage=<%= 1%>&Startlist=<%= 0%>">최근내역</a></li>
  		<li role="presentation"><a href="graph.jsp?pay_account=<%= ipy_list.get(0).getIpy_account() %>">나의 저금 그래프</a></li>
  		<li role="presentation" class="active"><a href="#">랭킹</a></li>
    </ul>
		<div class="table-responsive">
      <table class="table table-striped">
        <thead>
          <tr>
            <th class="text-center" style="width:20%">순위</th>
            <th class="text-center">저금통 이름</th>
            <th class="text-center">기부금액</th>
          </tr>
        </thead>
        <tbody>
        <!-- ==============================랭킹 만들기 테이블============================  -->
        <%
        	for (int i=0; i<ranking_list.size(); i++){
        %>
          <tr>
            <td><%= i+1 %></td>
            <td><%= ranking_list.get(i).getIpy_name() %></td>
            <td><%= ranking_list.get(i).getIpy_total() %></td>
          </tr>
        <%
        	}
        %>

          
        <!-- ==============================랭킹 만들기 테이블 끝============================  -->
        </tbody>
      </table>
		</div><!--테이블 끝 -->
	</div><!--메인 콘텐츠 끝 -->
      






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