<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="cafe.MemberDTO"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>세미나</title>
<link href="../css/common.css" rel="stylesheet">
<link href="../css/room.css" rel="stylesheet">
<link rel="stylesheet" type="text/css"
	href="../timepicker/jquery.datetimepicker.css"/ >
<link rel="shortcut icon" href="../bit_logo.png" />
<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
<script src="../js/jquery.easing.1.3.min.js"></script>
</head>

<body>
	<div class="wrap">
		<%
   MemberDTO login = (MemberDTO)session.getAttribute("session");
%>
		<header class="clearfix">
			<div class="inner clearfix">
				<a href="../index.do"><img src="../bit_logo.png" alt="logo"
					style="width: 80px;"></a>
				<ul class="navi">
					<li class="log">
						<%if(login == null){ %>
						<button
							onclick="document.getElementById('log').style.display='block'">Login</button>
						<button onclick="location.href='../member.do?m=join_form'">Join</button>
						<%}else{
                    	 if(login.getC_code().equals("c01")){%> <span>신촌</span>
						<%}else{%> <span>강남</span> <%} %>
						<button onclick="location.href='../member.do?m=logout'">Logout</button>
						<button onclick="location.href='../member.do?m=mypage'">마이페이지</button>
						<%}%>
					</li>
					<li class="menu"><a href="../room.do"
						style="border-top: 2px solid #333; background: #dee9fc;">Room
							Info</a> <a href="../reservation.do">Reservation</a> <a
						href='../board.do'>Board</a></li>
				</ul>
			</div>
		</header>

		<div class="content">
			<!-- login 입력창 start -->
			<div id="log" class="login">
				<form class="login_form ani" name="login_form" action="#"
					method="post">
					<div class="btnCon">
						<p style="margin-bottom: 14px;">
							<Strong style="padding-right: 20px;">가맹점</Strong> <input
								type="radio" id="c_code2" name="c_code" value="c01" checked
								required><span
								style="display: inline-block; padding: 0 10px 0 4px;">신촌</span>
							<input type="radio" id="c_code3" name="c_code" value="c02"
								required><span> 강남</span>
						</p>
						<label for="id"><Strong>User ID</Strong></label> <input
							type="text" placeholder="Enter User ID" id="id_lo" name="id"
							required autocomplete="off"
							onkeypress="if(window.event.keyCode == 13) LoginCheck()"
							autofocus> <label for="pw"><Strong>Password</Strong></label>
						<input type="password" placeholder="Enter Password" id="pw_lo"
							name="pw" required autocomplete="off"
							onkeypress="if(window.event.keyCode == 13) LoginCheck()">

						<div class="btnDiv">
							<button type="button" onclick="LoginCheck()">Login</button>
							<button type="button" onclick="LoginCancle()" class="cancelbtn">Cancel</button>
						</div>
					</div>
				</form>
			</div>
			<!-- log -->
			<!-- login 입력창 end -->

			<div class="room_con">
				<ul class="clearfix">
					<li><img src="../img/r1.jpg" alt="room1">
						<div>
							Seminar 1<br>4인실<br>모니터 X
						</div></li>
					<li><img src="../img/r2.png" alt="room2">
						<div>
							Seminar 2<br>4인실<br>모니터 O
						</div></li>
				</ul>
				<ul class="clearfix">
					<li><img src="../img/r3.jpg" alt="room3">
						<div>
							Seminar 3<br>6인실<br>모니터 X
						</div></li>
					<li><img src="../img/r4.png" alt="room4">
						<div>
							Seminar 4<br>6인실<br>모니터 O
						</div></li>
				</ul>
				<ul class="clearfix">
					<li><img src="../img/r5.jpg" alt="room5">
						<div>
							Seminar 5<br>8인실<br>모니터 X
						</div></li>
					<li><img src="../img/r6.png" alt="room6">
						<div>
							Seminar 6<br>8인실<br>모니터 O
						</div></li>
				</ul>
			</div>
			<footer>
				<p>copyright&copy;2019.bit study cafe all rights reserved.</p>
			</footer>

		</div>
		<!-- content -->
	</div>
	<!-- wrap -->
</body>
<script>
               $(function () {
                  $('.room_con li').mouseover(function() {
                     $(this).children('div').css("opacity", "0.7");
                  });
                  $('.room_con li').mouseleave(function() {
                     $(this).children('div').css("opacity", "0");
                  });
               });
               function LoginCheck(){
               	 var idStr = $("#id_lo").val();
               	 var pwStr = $("#pw_lo").val();
                    if(idStr.trim()==""){
                       alert("아이디를 입력해주세요");
                       $('#id_lo').val('');
                       return;
                    }else if(pwStr.trim()==""){
                        alert("비밀번호를 입력해주세요");
                        $('#pw_lo').val('');
                        return;
                     }
                    $.ajax({
                  	  url : "../member.do?m=login&id="+idStr+"&pw="+pwStr+"&c_code="+c_code,
                        success : function(data){
                       	  if(data == "success"){
                                document.getElementById('log').style.display='none'
                                location.href = "../index.do";
                             }
                       	  else if(data == "fail"){
                                  alert("로그인 실패");
                                  $('#id_lo').val('');
                                  $('#pw_lo').val('');
                             }
                        }
                    });
                }
                var c_code="c01";
                $("#c_code2").change(function(){
             	   c_code = $("input[type=radio][name=c_code]:checked").val();
              	});
                $("#c_code3").change(function(){
             	   c_code = $("input[type=radio][name=c_code]:checked").val();
              	});
                function LoginCancle(){
            		document.login_form.pw.value = "";
            	    document.login_form.id.value = "";
            		document.getElementById('log').style.display='none'
            	}
  </script>
</html>