<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="ipy_info.Ipy_infoDAO" %>
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
		String ipy_account = "";
		if (request.getParameter("ipy_account") != null){ 
			ipy_account = request.getParameter("ipy_account"); //bbsid를 넣어줌
		}
		if(ipy_account==""){
			PrintWriter script = response.getWriter(); 
			script.println("<script>"); 
			script.println("alert('무언가 잘못되었습니다.')");
			script.println("location.href = 'user_info.jsp'"); 
			script.println("</script>");
		}
		String admin = new Ipy_infoDAO().getIpy_admin(ipy_account); // 저금통의 아이디를 확인하구~
		if(!ID.equals(admin)) {
			PrintWriter script = response.getWriter(); //하나의 스크립트문장을 넣어줄수 있게끔 하고.
			script.println("<script>"); 
			script.println("alert('권한이 없습니다.')");
			script.println("location.href = 'user_info.jsp'"); 
			script.println("</script>");
		}else{
			Ipy_infoDAO delete = new Ipy_infoDAO(); //하나의 인스턴스를 만들고
			int result = delete.deleteIpy(ipy_account);
			if (result == -1){
				PrintWriter script = response.getWriter();
				script.println("<script>"); 
				script.println("alert('저금통 삭제에 실패하였습니다.')");
				script.println("history.back()"); 
				script.println("</script>");
				}
			else {
				PrintWriter script = response.getWriter(); 
				script.println("<script>"); 
				script.println("alert('저금통을 삭제했습니다.')");
				script.println("location.href = 'user_info.jsp'"); 
				script.println("</script>");
				}
		}
	%>  

  </body>
</html>