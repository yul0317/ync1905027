<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
  
<link href="css/login.css" rel="stylesheet">
<style>
.form-signin input[type="text"] {margin-bottom: -1px; border-bottom-right-radius: 0; border-bottom-left-radius: 0;}
.form-signin input[type="password"] {margin-bottom: 10px; border-top-left-radius: 0; border-top-right-radius: 0;}
</style>
 
</head>
<body>

    <div class="site-wrapper">
      <div class="site-wrapper-inner">
        <div class="cover-container">
          <div class="inner cover">
           <form class="form-signin" action="loginAction.jsp" method="post">
             <h2 class="form-signin-heading">IPY</h2>
             
             <label for="inputID" class="sr-only">ID</label>
             <input type="text" id="inputID" class="form-control" placeholder="ID" name="ID" required autocomplete=off>
             
             <label for="inputPW" class="sr-only">Password</label>
             <input type="password" id="inputPW" class="form-control" placeholder="Password" name="PW" required>
             
             <div class="checkbox">
               <a href="join.jsp">회원가입</a>
             </div>
             <input class="btn btn-lg btn-info btn-block" type="submit" value="Sign in"></input>
           </form>
          </div>
          <div class="mastfoot">
            <div class="inner">
              <p>Made by <a href="#">영남이공대학교 IT's</a>.</p>
            </div>
          </div>
        </div>
      </div>
    </div>



</body>
</html>