<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="user.UserDAO" %>
<%@ page import="user.User" %>
<%@ page import="ipy_info.Ipy_infoDAO" %>
<%@ page import="ipy_info.Ipy_info" %>
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

.main_content{width:100%; text-align:center;}
.table-responsive{width:100%; margin:0 auto;}
.table input{width:50%; text-align:center; margin:0 auto;}
.table tr{height:50px;}
.table > tbody > tr > td {vertical-align: middle;}




@media (min-width: 768px) { 
  .main_content{width:700px;}
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
			String email = userDAO.getEmail(ID);
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
                <li><a href="#">개인정보 설정</a></li>
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
      <div class="table-responsive row">
          <table class="table">
            <thead>
              <tr>
                <th colspan="2" style="text-align:center;font-size:30px;">개인정보 수정</th>
              </tr>  
            </thead>
            <tbody>
           <form action="user_updateAction.jsp" method="post"> 	<!-- =============== 유저정보 수정 부분 =============== -->
              <tr>
                <td>아이디</td>
                <td><%= ID%></td>
              </tr>
              <tr>
                <td>비밀번호</td>
                <td><input type="password" class="form-control" placeholder="Password (5~20)" name="PW" required pattern="[A-Za-z0-9]{5,20}" title="5~20자리를 입력하세요." autocomplete=off></td>
              </tr>
              <tr>
                <td>이름</td>
                <td><input type="text" class="form-control" placeholder="Name (0~8)" name="NAME" required pattern="[가-힣A-Za-z0-9]{0,8}" title="0~8자리"></td>
              </tr>
              <tr>
                <td>이메일</td>
                <td><%= email %></td>
              </tr>
              <tr>
                <td colspan="2"><button class="btn btn-l btn-info btn-block" type="submit" style="width:200px;margin:0 auto;">수정</button></td>
              </tr>
             </form>	<!-- =============== 유저정보 수정 부분 끝 =============== -->
             
              <tr>
                <td colspan="2">
                  <form action="useripy_updateAction.jsp"><!-- =============== 저금통 등록 부분 =============== -->
                    <button type="button" class="btn btn-l btn-info btn-block" data-toggle="modal" data-target=".add" style="width:40%;float:left;margin-left:5%;margin-right:5%;">저금통 추가</button>
                    <div class="modal fade bs-example-modal-sm add" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
                      <div class="modal-dialog modal-lg">
                        <div class="modal-content">
                          <table class="table" style="height:250px;">
                            <thead>
                              <tr>
                                <th colspan="2" style="text-align:center;font-size:30px; height:100px">저금통 등록</th>
                              </tr>
                            </thead>
                            <tbody>
                              <tr>
                                <td>저금통 이름</td>
                                <td><input type="text"  name="NAME" class="form-control" placeholder="Name (0~20)" required pattern="[ㄱ-ㅎ가-힣A-Za-z0-9]{0,20}" title="0~20자리" autocomplete=off></td>
                              </tr>
                              <tr>
                                <td>계좌번호</td>
                                <td><input type="text"  name="ACCOUNT"class="form-control" placeholder="Account Number" required pattern="[0-9]{0,20}" autocomplete=off></td>
                              </tr>
                            </tbody>
                            <tr>
                              <td colspan="2"><button class="btn btn-l btn-info btn-block" type="submit" style="width:100px;margin:0 auto;">등록</button></td>
                            </tr>
                          </table>
                        </div>
                      </div>
                    </div>
                  </form><!-- =============== 저금통 등록 부분끝 =============== -->
<!-- /*===============================================================================================*/ -->
                  <!-- =============== 저금통 삭제 부분 =============== -->
                    <button type="button" class="btn btn-l btn-info btn-block" data-toggle="modal" data-target=".sub" style="width:40%;float:left;margin-left:5%;margin-right:5%;">저금통 삭제</button>
                    <div class="modal fade bs-example-modal-sm sub" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true">
                      <div class="modal-dialog modal-lg">
                        <div class="modal-content">
                          <table class="table">
                            <thead>
                              <tr>
                                <th class="text-center">저금통명</th>
                                <th class="text-center">저금통 내 총액</th>
                                <th class="text-center">연결된 계좌</th>
                                <th class="text-center">삭제</th>
                              </tr>
                            </thead>
                            <tbody>
        <%
    	Ipy_infoDAO ipy_info = new Ipy_infoDAO();
    	ArrayList<Ipy_info> ipy_list = ipy_info.getList(ID);
    	if(ipy_list != null || ipy_list.size() != 0){
    		for (int i=0; i<ipy_list.size(); i++){
    			
    		
        %>
                              <tr>
                                <td><%= ipy_list.get(i).getIpy_name() %></td>
                                <td><%= ipy_list.get(i).getIpy_total() %></td>
                                <td><%= ipy_list.get(i).getIpy_account() %></td>
                                <td><a onclick="return confirm('정말로 삭제하시겠습니까?')" href="useripy_deleteAction.jsp?ipy_account=<%=ipy_list.get(i).getIpy_account() %>" class="btn btn-l btn-info btn-block" type="button" style="width:100px;margin:0 auto;">삭제</a></td>
                              </tr>
        <%
    		}
    	}
        %>
                              
                            </tbody>
                          </table>
                        </div>
                      </div>
                    </div>
                 <!-- =============== 저금통 삭제 부분 끝 =============== -->
                </td>
              </tr>
            </tbody>
        </table>
      </div>
    </div>







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