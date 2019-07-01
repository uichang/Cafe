<%@ page contentType="text/html;charset=utf-8" import="cafe.MemberDTO"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>회원 가입</title>
<link href="../css/common.css" rel="stylesheet">
<link href="../css/join.css" rel="stylesheet">
<link rel="shortcut icon" href="../bit_logo.png" />
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
					<li class="menu"><a href="../room.do">Room Info</a> <a
						href="../reservation.do">Reservation</a> <a href='../board.do'>Board</a>
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

			<div id="join" class="join">
				<p class="tit">회원가입</p>
				<form name="join_form" class="join_form"
					action="../member.do?m=join" method="post">
					<div>
						<p>
							<Strong>Strore Code</Strong><br> 
							<input type="radio" id="c_code4" name="c_code2" value="c01" 
							required><span>신촌</span>
							<input type="radio" id="c_code5" name="c_code2" value="c02"
								required><span> 강남</span>
						</p>
						<label for="id"><Strong>User ID</Strong></label> <input
							type="text" placeholder="Enter User ID" name="m_id" id="id"
							required> <input type="button" value="CheckID" id="check"
							onclick="idCheck()"> <input type="hidden" name="id"
							maxlength="50" onkeydown="inputIdChk()"> <input
							type="hidden" name="idDuplication" value="idUncheck"> <span
							id="result"
							style="font-size: 16px; padding-left: 10px; font-weight: bold;"></span>
						<br> <label for="pw"><Strong>Password</Strong></label> <input
							type="password" placeholder="Enter Password" name="m_pw" id="pw"
							required> <label for="pwCheck"><Strong>PasswordCheck</Strong></label>
						<input type="password" placeholder="Enter PasswordCheck"
							name="pwCheck" id="pwCheck" required> <label for="name"><Strong>User
								Name</Strong></label> <input type="text" placeholder="Enter User Name"
							name="m_name" id="name" required> <label for="phone"><Strong>Phone
								Number</Strong></label> <input type="text" placeholder="Enter Phone Number"
							name="m_phone" id="phone" required>
						<p>
							<Strong class="lo">Location</Strong><br> <select
								name="m_addr" required>
								<option value="서울">서울</option>
								<option value="경기">경기</option>
								<option value="인천">인천</option>
								<option value="강원">강원</option>
								<option value="충남">충남</option>
								<option value="대전">대전</option>
								<option value="충북">충북</option>
								<option value="세종">세종</option>
								<option value="부산">부산</option>
								<option value="울산">울산</option>
								<option value="대구">대구</option>
								<option value="경북">경북</option>
								<option value="경남">경남</option>
								<option value="전남">전남</option>
								<option value="광주">광주</option>
								<option value="전북">전북</option>
								<option value="제주">제주</option>
							</select>
						</p>
						<p>
							<Strong>Sex</Strong><br> <input type="radio" name="m_sex"
								value="남" required><span>남자</span> <input type="radio"
								name="m_sex" value="여" required><span> 여자</span>
						</p>

						<div class="btnDiv">
							<button type="button" onclick="sendIt()">Join</button>
							<button type="button" onclick="location.href='../index.do'"
								class="cancelbtn">Cancel</button>
						</div>
					</div>
				</form>
			</div>

			<footer>
				<p>copyright&copy;2019.bit study cafe all rights reserved.</p>
			</footer>

		</div>
		<!-- content -->
	</div>
	<!-- wrap -->
</body>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
	integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
	crossorigin="anonymous"></script>
<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
<script language="javascript">
         $('input').attr('autocomplete','off');        
         function sendIt() {   
              var regex = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;
              var msg, ss, cc, count=0, count2=0;
              //아이디 유효성 검사 (영문소문자, 숫자만 허용)
              for (i = 0; i < document.join_form.m_id.value.length; i++) {
                  ch = document.join_form.m_id.value.charAt(i)
                  if (!(ch >= '0' && ch <= '9') && !(ch >= 'a' && ch <= 'z')&&!(ch >= 'A' && ch <= 'Z')) {
                      document.join_form.m_id.focus();
                      document.join_form.m_id.select();
                      count++;
                  }
              }
              for (i = 0; i <  document.join_form.m_phone.value.length; i++) {
                  ph = document.join_form.m_phone.value.charAt(i)
                  if (!(ph >= '0' && ph <= '9')) {
                      document.join_form.m_phone.focus();
                      document.join_form.m_phone.select();
                      count2++;
                  }
              }
              
              if (document.join_form.c_code2.value.length == "") {
                	alert("가맹점을 선택해주세요");
              }
              else if(count>0)
            	  alert("아이디는 한글, 대소문자, 숫자만 입력가능합니다.");
              //아이디에 공백 사용하지 않기
              else if(count2>0)
             	alert("전화번호는 숫자만 입력가능합니다.");
              else if (document.join_form.m_id.value.indexOf(" ") >= 0) {
                  alert("아이디에 공백을 사용할 수 없습니다.");
                  document.join_form.m_id.focus();
                  document.join_form.m_id.select();
              }
              //아이디 길이 체크 (4~12자)
              else if ((document.join_form.m_id.value.length<4 || document.join_form.m_id.value.length>12)) {
                  alert("아이디를 4~12자까지 입력해주세요.");
                  document.join_form.m_id.focus();
                  document.join_form.m_id.select();
              }else if(document.join_form.idDuplication.value !="idCheck"){
            	  alert("아이디 중복체크를 해주세요.");
            	  document.join_form.m_pw.focus();
                  document.join_form.m_pw.select();
              }else if ((document.join_form.m_id.value < "A" || document.join_form.m_id.value > "Z") && 
            		  (document.join_form.m_id.value < "a" || document.join_form.m_id.value > "z")){
            	  alert("한글 및 특수문자는 아이디로 사용하실 수 없습니다.");
            	  document.join_form.m_pw.focus();
                  document.join_form.m_pw.select();
              }else if (document.join_form.m_pw.value == document.join_form.m_id.value) {
                  alert("아이디와 비밀번호가 같습니다.");
                  document.join_form.m_pw.focus();
              }
              //비밀번호 길이 체크(4~8자 까지 허용)
              else if (document.join_form.m_pw.value.length<4 || document.join_form.m_pw.value.length>12) {
                  alert("비밀번호를 4~12자까지 입력해주세요.");
                  document.join_form.m_pw.focus();
                  document.join_form.m_pw.select();
              }
              //비밀번호와 비밀번호 확인 일치여부 체크
              else if (document.join_form.m_pw.value != document.join_form.pwCheck.value) {
                  alert("비밀번호가 일치하지 않습니다");
                  document.join_form.pwCheck.value = "";
                  document.join_form.pwCheck.focus();
              }
       
              else if(document.join_form.m_name.value.length<2){
                  alert("이름을 2자 이상 입력해주십시오.");
                  document.join_form.m_name.focus();
              }
              else if (document.join_form.m_phone.value.length<9 || document.join_form.m_phone.value.length>11) {
                  alert("전화번호의 길이가 맞지 않습니다.");
                  document.join_form.m_phone.focus();
                  document.join_form.m_phone.select();
              }
              else if (document.join_form.m_sex.value.length == "") {
              	alert("성별을 선택해주세요");
              }
              else{
            	  join_form.submit();
              }
         }
           </script>

<script type="text/javascript">
		           var c_code2="";
		           $("#c_code4").change(function(){
		        	   c_code2 = $("input[type=radio][name=c_code2]:checked").val();
		        	   document.join_form.idDuplication.value ="idUncheck";
		         	});
		           $("#c_code5").change(function(){
		        	   c_code2 = $("input[type=radio][name=c_code2]:checked").val();
		        	   document.join_form.idDuplication.value ="idUncheck";
		         	});
                   function inputIdChk(){
                      document.join_form.idDuplication.value ="idUncheck";
                   }       
           
                  function idCheck(){
                      //jQuery에서 선택자역할
                      if (document.join_form.c_code2.value.length == "") {
                         alert("가맹점을 선택해주세요");
                         return;
                      }
                      var idStr = $("#id").val();
                      if(idStr.trim()==""){
                         alert("아이디를 입력해주세요");
                         return;
                      }
                      $.ajax({
                    	  url : "../member.do?m=check&id="+idStr+"&c_code="+c_code2,
                          success : function(data){
                               if(data == "success"){
                            	   document.join_form.idDuplication.value ="idCheck";
                            	    $("#result").css("color","#12e8e3");
                                    $("#result").text("사용가능한 아이디입니다.");
                               }else if(data == "fail"){
                            	    $("#result").css("color","red");
                                    $("#result").text("중복된 아이디입니다.");
                               }
                          }
                      });
                 }
                  function LoginCheck(){
                 	 var idStr = $("#id_lo").val();
                 	 var pwStr = $("#pw_lo").val();
                      if(idStr.trim()==""){
                         alert("아이디를 입력해주세요"+c_code2);
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
</script>
</html>
