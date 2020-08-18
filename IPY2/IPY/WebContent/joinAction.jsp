<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="user.User" scope="page"/>
<jsp:setProperty name="user" property="ID"/>
<jsp:setProperty name="user" property="PW"/>
<jsp:setProperty name="user" property="NAME"/>
<jsp:setProperty name="user" property="email"/>

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
		if(user.getID()==null||user.getPW()==null||user.getNAME()==null||user.getEmail()==null){
			PrintWriter script = response.getWriter(); //하나의 스크립트문장을 넣어줄수 있게끔 하고.
			script.println("<script>");
			script.println("alert('입력이 안 된 사항이 있습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		else{
			UserDAO userDAO = new UserDAO(); //하나의 인스턴스를 만들고
			int result = userDAO.join(user);//각각 정보를 받아 만들어진 user라는 인스턴스가 join함수를 실행하게끔.
			if (result == -1){//데이터베이스 오류. 는 한개밖에 없음. id가 pk이기때문에!!!! 중복이 안됨!
				PrintWriter script = response.getWriter(); 
				script.println("<script>"); 
				script.println("alert('이미 존재하는 아이디입니다.')"); 
				script.println("history.back()");  
				script.println("</script>");
				}
			else if (result == 1){
				session.setAttribute("ID",user.getID());
				PrintWriter script = response.getWriter(); 
				script.println("<script>"); 
				script.println("location.href = 'login.jsp'"); 
				script.println("</script>");
				}
		}
	%>  

  </body>
</html>