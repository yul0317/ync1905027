<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="user.UserDAO" %>
<%@ page import="user.User" %>
<%@ page import="ipy_info.Ipy_info" %>
<%@ page import="ipy_info.Ipy_infoDAO" %>
<%@ page import="pay_info.Pay_info" %>
<%@ page import="pay_info.Pay_infoDAO" %>
<%@ page import="card_info.Card_info" %>
<%@ page import="card_info.Card_infoDAO" %>
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
  <script src="offcanvas.js"></script>

 <title>이색 카드 저금통 :: IPY</title>

<link href="css/main.css" rel="stylesheet">
<style>
/*============================================= 메인 =============================================*/
/*===============================================================================================*/

.main_content > .row > .container > .nav-tabs > .active > a{background-color:#333333; color:white;}
.main_content > .row > .container > .nav-tabs > .active > a:hover{background-color:#333333; color:white;}
.main_content > .row > .container > .nav-tabs > .active > a:focus{background-color:#333333; color:white;}
.main_content > .row > .container > .nav-tabs > li > a{color:black;}
table{text-align:center;}
.table tr{height:50px;}
.table > tbody > tr > td {vertical-align: middle;}
.nav-tabs{width:90%; }
.pagebutton{text-align:center;}

/*건들지 말것 쓸줄 모름............. 만지지 말자~*/
@media screen and (max-width: 767px) {
  .row-offcanvas {position: relative;
    -webkit-transition: all .25s ease-out;
         -o-transition: all .25s ease-out;
            transition: all .25s ease-out;
  }
  .row-offcanvas-right {right: 0;}
  .row-offcanvas-left {left: 0;}
  .row-offcanvas-right .sidebar-offcanvas {right: -50%; /* 6 columns */}
  .row-offcanvas-left .sidebar-offcanvas {left: -50%; /* 6 columns */}
  .row-offcanvas-right.active {right: 50%; /* 6 columns */}
  .row-offcanvas-left.active {left: 50%; /* 6 columns */}
  .sidebar-offcanvas {position: absolute; top: 0; width: 50%; /* 6 columns */}
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
		String ipy_account = "";
  		int Startpage = -1;
  		int Startlist = -1;
		if (request.getParameter("ipy_account") != null || request.getParameter("Startlist") != null || request.getParameter("Startpage") != null){
			ipy_account = request.getParameter("ipy_account");
	  		Startpage = Integer.parseInt(request.getParameter("Startpage")); //시작페이지 1로 시작
	  		Startlist = Integer.parseInt(request.getParameter("Startlist")); //시작번호 0으로 시작
		}
		if(ipy_account=="" || Startpage < 0 || Startlist < 0){
			PrintWriter script = response.getWriter(); 
			script.println("<script>"); 
			script.println("alert('유효하지 않은 저금통입니다.')");
			script.println("location.href = 'main.jsp'"); 
			script.println("</script>");
		}
		//계좌번호 거래내역 조회
		Pay_infoDAO pay_info = new Pay_infoDAO();
		ArrayList<Pay_info> pay_list = pay_info.getList(ipy_account);
		//아이디에 맞는 저금통 리스트 불러오기
		Ipy_infoDAO ipy_info1 = new Ipy_infoDAO();
		ArrayList<Ipy_info> ipy_list = ipy_info1.getList(ID);
		
		
		
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
<div class="container main_content">
  <div class="row row-offcanvas row-offcanvas-left">

    <div class="container">
      <ul class="nav nav-tabs nav-justified" role="tablist">
        <li role="presentation" class="active"><a href="#">최근내역</a></li>
        <li role="presentation"><a href="graph.jsp?pay_account=<%= ipy_account %>">나의 저금 그래프</a></li>
        <li role="presentation"><a href="ranking.jsp">랭킹</a></li>
      </ul>
    </div>

    <div style="margin-top:10px;">
      <p class="pull-left visible-xs">
        <button type="button" class="btn btn-danger btn-xs" data-toggle="offcanvas">저금통</button>
      </p>


<!-- =============================링크 만드는곳===================================== -->
      <div class="col-xs-6 col-sm-3 sidebar-offcanvas" id="sidebar">
        <div class="list-group">
        <%//ipy_list 를 이용하여 링크 달아주기. 저금통 개수만큼 !
        	for(int i=0; i<ipy_list.size(); i++){
        		if(ipy_list.get(i).getIpy_account().equals(ipy_account)){
        %>
        <a href="#" class="list-group-item list-group-item-danger"><%= ipy_list.get(i).getIpy_name() %></a> 
        											<!-- 지금 들어가있는 저금통 색깔변경 info / warning / success  -->
        <%
        		}else{
        %>
        <a href="recent.jsp?ipy_account=<%= ipy_list.get(i).getIpy_account()%>&Startpage=<%= 1%>&Startlist=<%= 0%>" class="list-group-item"><%= ipy_list.get(i).getIpy_name() %></a>	
        <%
        		}
        	}
        %>
        </div>
      </div>

<!-- =============================테이블 만드는곳===================================== -->
<%
int totalCount = new Pay_infoDAO().getTotalpage(ipy_account); // 전체 글 개수
	if(totalCount != 0){
%>
      <div class="table-responsive col-xs-12 col-sm-9">
        <table class="table table-hover">
          <thead>
            <tr>
              <th class="text-center">입금일자</th>
              <th class="text-center">입금인</th>
              <th class="text-center">거래금액</th>
              <th class="text-center">총 금액</th>
            </tr>
          </thead>
          <tbody>
          <%//pay_info->pay_date(1번) , pay_card(2번) , price(3번) //ipy_info(ipy_total)[총금액] (4번)
	  		
	  		//페이징 처리하기위해서....... 복잡하다 복합해 ㅅㅂ 이거말고 좋은방법 많을텐데 ㅅㅂ
	  		
	  		int countList = 10; //토탈페이지 구하기
	  		int totalPage = totalCount / countList; // 총페이지 개수. 1,2,3,4,5,6,7.
	  		if (totalCount % countList > 0) { //  totalCount 가 25이면 5가 남으니
	  		    totalPage++;  // totalPage 는 3이됨.
	  		};
	  		int Endlist = Startpage * 10; //끝번호
	  		if (Startpage == totalPage && totalPage != 1){
	  			Endlist = (Startpage*10) - (totalCount % countList);
	  		}else if (Startpage == totalPage || totalPage ==1){
	  			Endlist = totalCount % countList;
	  		}
	  		
	  		int Totalpay = 0;
	  		for (int i = Startlist; i< totalCount; i++){
	  			Totalpay = Totalpay + pay_list.get(i).getPrice();
	  		}
	  		
	  		String Name ="";
			int Sum = 0, Result = 0; 
          	for(int i=Startlist; i<Endlist; i++){
          		//카드번호에 맞는 카드번호 불러오기
        		Card_info card_info = new Card_infoDAO().getCard_info(pay_list.get(i).getPay_card());
        		if(card_info.getCard_owner()==null){
        			Name = "등록되지 않은 사용자";
        			}else{
        				Name = card_info.getCard_owner();
        				}
          		Result = Totalpay - Sum;
          %>
            <tr>
              <td><%= pay_list.get(i).getPay_date().substring(0,11)+pay_list.get(i).getPay_date().substring(11,13)+"시"+pay_list.get(i).getPay_date().substring(14,16)+"분" %></td>
              <td><%= Name %></td>
              <td><%= pay_list.get(i).getPrice() %></td>
              <td><%= Result%></td>
            </tr>
          <%
          		Sum = Sum + pay_list.get(i).getPrice();
          	}
          %>
          </tbody>
        </table>
        <!-- =============================페이지 버튼 만드는곳===================================== -->
	      <div class="pagebutton">
	        <nav>
	          <ul class="pagination">
	         	 <%
	         		String disabled1 = "0";
	         	 	if (Startpage == 1 ){
	         	 		disabled1 = "disabled";
	         	 	}
	         	 %>
	            <li class="<%= disabled1%>">
	              <a href="recent.jsp?ipy_account=<%= ipy_account%>&Startpage=<%= Startpage - 1%>&Startlist=<%= Endlist - 20%>" aria-label="Previous">
	                <span aria-hidden="true">&laquo;</span>
	              </a>
	            </li>
	            <%
	            	for (int i = 0; i<totalPage; i++){
	            		if(Startpage==i+1){
	            %>
	            <li class="active"><a href="recent.jsp?ipy_account=<%= ipy_account%>&Startpage=<%= i+1%>&Startlist=<%= i*10%>"><%=i+1 %></a></li>
	            <%
	            		}else{
	            			
	            		
	            %>
	            <li><a href="recent.jsp?ipy_account=<%= ipy_account%>&Startpage=<%= i+1%>&Startlist=<%= i*10%>"><%=i+1 %></a></li>
	            <%
	            		}
	            	}
	            %>
	            
	            <%
	         		String disabled2 = "0";
	         	 	if (Startpage == totalPage){
	         	 		disabled2 = "disabled";
	         	 	}
	         	%>
	            <li class="<%= disabled2%>">
	              <a href="recent.jsp?ipy_account=<%= ipy_account%>&Startpage=<%= Startpage + 1%>&Startlist=<%= Endlist%>" aria-label="Next">
	                <span aria-hidden="true">&raquo;</span>
	              </a>
	            </li>
	          </ul>
	        </nav>
	      </div><!-- 버튼 끝 -->
      </div><!-- 테이블 끝 -->
      
<%
	}else{
%>
<div class="table-responsive col-xs-12 col-sm-9">
	<table class="table table-hover">
		<thead>
			<tr>
				<th class="text-center">입금일자</th>
				<th class="text-center">입금인</th>
				<th class="text-center">거래금액</th>
				<th class="text-center">총 금액</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td colspan="4">조회된 데이터가 없습니다.</td>
			</tr>
		</tbody>
	</table>
</div>
<%
	}
%>

      





    </div> <!--내용 부분 끝-->
  </div> <!--row부분 끝-->
</div> <!--main-content 끝-->
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