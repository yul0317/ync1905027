<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="user.UserDAO" %>
<%@ page import="user.User" %>
<%@ page import="pay_info.Pay_info" %>
<%@ page import="pay_info.Pay_infoDAO" %>
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

/*============================================ 본문 ============================================*/
/*===============================================================================================*/
.main_content > .nav-tabs > .active > a{background-color:#333333; color:white;}
.main_content > .nav-tabs > .active > a:hover{background-color:#333333; color:white;}
.main_content > .nav-tabs > .active > a:focus{background-color:#333333; color:white;}
.main_content > .nav-tabs > li > a{color:black;}
.sub_content{margin-top:25px; margin-left:0; width:100%;}
.progress{height:30px; }
.progress-bar{height:30px; line-height:30px; font-size:13px;}


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
			String pay_account = "";
			if (request.getParameter("pay_account") != null){
				pay_account = request.getParameter("pay_account");
			}
			if(pay_account==""){
				PrintWriter script = response.getWriter(); 
				script.println("<script>"); 
				script.println("alert('유효하지 않은 저금통입니다.')");
				script.println("location.href = 'main.jsp'"); 
				script.println("</script>");
			}
			//계좌번호 거래내역 조회
			Pay_infoDAO pay_info = new Pay_infoDAO();
			ArrayList<Pay_info> pay_list = pay_info.getList(pay_account);
			//그래프 월별 내용 만들기
			List<String> graph_list = new ArrayList<>(12); //1월~12월
			for(int i = 0; i<9; i++) graph_list.add("0"+(i+1)); //01~12 까지 넣어서
			graph_list.add("10");
			graph_list.add("11");
			graph_list.add("12");
			
			List<Integer> graph_result = new ArrayList<>(12); // 1~12월 월별 금액
			for(int i = 0;i<12;i++) graph_result.add(0);
			
			int totalCount = new Pay_infoDAO().getTotalpage(pay_account); // 전체 글 개수
			if(totalCount != 0){ // 총 조회내역이 0이 아니면!
				//월별 금액 계산해서 쳐넣기
				for(int i=0; i<12; i++){
					for(int j=0; j<pay_list.size(); j++){
						String y = pay_list.get(j).getPay_date().substring(5,7);
						if(graph_list.get(i).equals(y) ){
							int x = graph_result.get(i) + pay_list.get(j).getPrice();
							graph_result.set(i, x);
						}
					}
				}
			}
			




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
  		<li role="presentation"><a href="recent.jsp?ipy_account=<%= pay_account%>&Startpage=<%= 1%>&Startlist=<%= 0%>">최근내역</a></li>
  		<li role="presentation" class="active"><a href="#">나의 저금 그래프</a></li>
  		<li role="presentation"><a href="ranking.jsp">랭킹</a></li>
  	</ul>
		<div class="container sub_content">
		<%
		if(totalCount != 0){ // 조회 내역이 있으면!
			int graph_total = new Pay_infoDAO().getTotalpay(pay_account);
			List<String> color_list = new ArrayList<String>(5);
			color_list.add("progress-bar-success");
			color_list.add("progress-bar-info");
			color_list.add("progress-bar-warning");
			color_list.add("progress-bar-danger");
			color_list.add("");
			for (int i = 0; i<12; i++){
				float width_result = 0;
				if(graph_result.get(i)!=0){
				width_result = graph_result.get(i) / (graph_total/100);
				};
		%>
			<p><%= i+1%>월 입금금액 : <%= graph_result.get(i) %> 원 </p>
			<div class="progress">
  				<div class="progress-bar <%= color_list.get(i%5)%>" role="progressbar" aria-valuenow="<%= graph_result.get(i)%>" aria-valuemin="0" aria-valuemax="<%= graph_total%>" style="width: <%= width_result%>%;">
  					<%= i+1 %>월
				</div>
			</div>
		<%
			}
		}else{ // 조회 내역이 없으면!
		%>
			<div class="progress">
  				<div class="progress-bar progress-bar-danger" role="progressbar" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100" style="width: 100%;">
  					조회된 내역이 없습니다.
				</div>
			</div>	
		<%
		}
		%>


		</div> <!-- sub_content 끝 -->
  </div><!--  main-content 끝 -->







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