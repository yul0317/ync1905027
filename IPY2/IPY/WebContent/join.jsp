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
.form-signin input{margin: 10px 0px;}
</style>


</head>
  <body>

    <div class="site-wrapper">
      <div class="site-wrapper-inner">
        <div class="cover-container">
          <div class="inner cover">
           <form class="form-signin" method="post" action="joinAction.jsp">
             <h2 class="form-signin-heading">IPY</h2>

             <label for="inputID" class="sr-only">ID</label>
             <input type="text" id="inputID" class="form-control" placeholder="ID (5~20)" name="ID" required pattern="[A-Za-z0-9]{5,20}" title="5~20자리를 입력하세요." autocomplete=off>

             <label for="inputPW" class="sr-only">Password</label>
             <input type="password" id="inputPW" class="form-control" placeholder="Password (5~20)" name="PW" required pattern="[A-Za-z0-9]{5,20}" title="5~20자리를 입력하세요.">

             <label for="inputNAME" class="sr-only">Name</label>
             <input type="text" id="inputNAME" class="form-control" placeholder="Name (0~8)" name="NAME" required pattern="[A-Za-z0-9]{0,8}" title="0~8자리를 입력하세요." autocomplete=off>

             <label for="inputemail" class="sr-only">Email</label>
             <input type="email" id="inputemail" class="form-control" placeholder="Email" name="email" autocomplete=off>
             
             <button class="btn btn-lg btn-info btn-block" type="submit">회원가입</button>
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