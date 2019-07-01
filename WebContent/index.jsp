<%@ page language="java" contentType="text/html; charset=utf-8"
	import="cafe.MemberDTO"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Bit StudyCafe</title>
<link href="https://fonts.googleapis.com/css?family=Cinzel&display=swap"
	rel="stylesheet">
<link href="css/common.css" rel="stylesheet">
<link href="css/main.css" rel="stylesheet">
<link rel="shortcut icon" href="bit_logo.png" />
<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
<script src="js/jquery.easing.1.3.min.js"></script>
<script src="js/jquery.bxslider.min.js"></script>
<script src="js/main.js"></script>
<script src="js/login.js"></script>
</head>

<body>
	<div class="wrap">
		<%
   MemberDTO login = (MemberDTO)session.getAttribute("session");
%>
		<header class="clearfix">
			<div class="inner clearfix">
				<a href="index.do"><img src="bit_logo.png" alt="logo"
					style="width: 80px;"></a>
				<ul class="navi">
					<li class="log">
						<%if(login == null){ %>
						<button
							onclick="document.getElementById('log').style.display='block'">Login</button>
						<button onclick="location.href='member.do?m=join_form'">Join</button>
						<%}else{
                    	 if(login.getC_code().equals("c01")){%> <span>신촌</span>
						<%}else{%> <span>강남</span> <%} %>
						<button onclick="location.href='member.do?m=logout'">Logout</button>
						<button onclick="location.href='member.do?m=mypage'">마이페이지</button>
						<%}%>
					</li>
					<li class="menu"><a href="room.do">Room Info</a> <a
						href="reservation.do">Reservation</a> <a href='board.do'>Board</a>
					</li>
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
			<div class="slide">
				<ul class="main_slide clearfix">
					<li><div class="s_img01"></div></li>
					<li><div class="s_img02"></div></li>
					<li><div class="s_img03"></div></li>
				</ul>
				<div class="slide_prev"></div>
				<div class="slide_next"></div>
			</div>
			<!-- slide -->
		</div>

		<div class="con">
			<div class="main_con clearfix">
				<p>
					<strong>비트 스터디 카페...</strong> <br>
					<br>비트 스터디 카페는 독서실과 카페를 결합하여<br>꿈을 향해 도전하시거나 자기계발을 위해 힘쓰는
					분들에게<br>편안한 공간을 제공하고 공부할 때 가장 큰 영향을 미치는<br>책상과 의자를 학습에
					특화된 프리미엄 제품들로 구성하여<br>학습능률을 향상시키고 피로감을 최소화 할 수 있도록 구성하였습니다. <br>
					<br>또한 학습과 휴식에 필요한 기본시설과 편의시설의<br>소소한 부분까지도 놓치지 않고 준비
					하였습니다. <br>
					<br>이용하시는 분들의 원하시는 결과를 꼭 이루시길 진심으로 바라며<br>항상 최적의 환경이 유지될
					수 있도록 항상 노력 하겠습니다.
				</p>
				<table>
					<tbody>
						<tr>
							<td><img src="img/r1.jpg" alt="room1"></td>
							<td><img src="img/r2.png" alt="room2"></td>
							<td><img src="img/r3.jpg" alt="room3"></td>
						</tr>
						<tr style="height: 50px;">
							<td>세미나 1</td>
							<td>세미나 2</td>
							<td>세미나 3</td>
						</tr>
						<tr>
							<td><img src="img/r4.png" alt="room4"></td>
							<td><img src="img/r5.jpg" alt="room5"></td>
							<td><img src="img/r6.png" alt="room6"></td>
						</tr>
						<tr style="height: 50px;">
							<td>세미나 4</td>
							<td>세미나 5</td>
							<td>세미나 6</td>
						</tr>
					</tbody>
				</table>
			</div>
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