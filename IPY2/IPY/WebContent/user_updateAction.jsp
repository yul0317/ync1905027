<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>



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
		if(ID==null){
			PrintWriter script = response.getWriter();
			script.println("<script>"); 
			script.println("alert('로그인을 하세요.')");
			script.println("location.href = 'login.jsp'"); 
			script.println("</script>");
		}
		if(request.getParameter("PW")==null||request.getParameter("NAME")==null||request.getParameter("PW").equals("")||request.getParameter("NAME").equals("")){
			PrintWriter script = response.getWriter(); //하나의 스크립트문장을 넣어줄수 있게끔 하고.
			script.println("<script>");
			script.println("alert('입력이 안 된 사항이 있습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}else{
			UserDAO update = new UserDAO(); //하나의 인스턴스를 만들고
			int result = update.updateUser(request.getParameter("PW"), request.getParameter("NAME"), ID);
			if (result == -1){//데이터베이스 오류. 는 한개밖에 없음. id가 pk이기때문에!!!! 중복이 안됨!
				PrintWriter script = response.getWriter();
				script.println("<script>"); 
				script.println("alert('개인정보 수정에 실패했습니다.')");
				script.println("history.back()");  
				script.println("</script>");
				}
			else {
				PrintWriter script = response.getWriter(); 
				script.println("<script>"); 
				script.println("location.href = 'user_info.jsp'"); 
				script.println("</script>");
				}
		}
	%>  

  </body>
</html>