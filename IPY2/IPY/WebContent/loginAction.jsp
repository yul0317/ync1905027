<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="user.User" scope="page"/>
<jsp:setProperty name="user" property="ID"/>
<jsp:setProperty name="user" property="PW"/>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
   <meta name="viewport" content="width=device-width, initial-scale=1">

  <title>로그인</title>
  
</head>
  <body>

	<%
		String ID=null;//세션을 확인해서 id에 세션이 존재하면 ?!!?!?!?
		if(session.getAttribute("ID") != null){
			ID=(String) session.getAttribute("ID");
		}
		if(ID!=null){
			PrintWriter script = response.getWriter(); 
			script.println("<script>"); 
			script.println("alert('이미 로그인이 되어있습니다.')");
			script.println("location.href = 'main.jsp'"); 
			script.println("</script>");
		}
		UserDAO userDAO = new UserDAO(); //하나의 인스턴스를 만들고
		int result = userDAO.login(user.getID(), user.getPW());// 로그인 페이지에서 입력한 값들을 여기에 넣어줌
		if (result == 1){
			session.setAttribute("ID",user.getID());
			PrintWriter script = response.getWriter(); //하나의 스크립트문장을 넣어줄수 있게끔 하고.
			script.println("<script>"); 
			script.println("location.href = 'main.jsp'"); // 이 페이지로 이동하게끔!
			script.println("</script>");
			}
			else if (result == 0){
			PrintWriter script = response.getWriter(); //하나의 스크립트문장을 넣어줄수 있게끔 하고.
			script.println("<script>"); 
			script.println("alert('비밀번호가 틀립니다.')");  //비밀번호가 틀리다고 출력
			script.println("history.back()");  //이전페이지로 돌려보냄
			script.println("</script>");
			}
			else if (result == -1){
			PrintWriter script = response.getWriter(); //하나의 스크립트문장을 넣어줄수 있게끔 하고.
			script.println("<script>"); 
			script.println("alert('존재하지 않는 아이디입니다.')");  
			script.println("history.back()");  //이전페이지로 돌려보냄
			script.println("</script>");
			}
			else if (result == -2){ ///result 결과값들은 위에서 만들때 설정한 숫자들임!!!!!!!!!!!!!!!!
			PrintWriter script = response.getWriter(); //하나의 스크립트문장을 넣어줄수 있게끔 하고.
			script.println("<script>"); 
			script.println("alert('데이터베이스가 존재하지 않습니다.')");  
			script.println("history.back()");  //이전페이지로 돌려보냄
			script.println("</script>");
			}
	%>  

  </body>
</html>