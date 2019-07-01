<%@ page language="java" contentType="text/html; charset=utf-8" import="cafe.MemberDTO,cafe.DTO,java.util.*,cafe.PageInfo"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title>마이 페이지</title>
		<link href="https://fonts.googleapis.com/css?family=Cinzel&display=swap" rel="stylesheet">
		<link href="css/common.css" rel="stylesheet">
		<link href="css/mypage.css" rel="stylesheet">
		<link rel="stylesheet" type="text/css" href="timepicker/jquery.datetimepicker.css"/ >
		<link rel="shortcut icon" href="bit_logo.png" />
		<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
		<script src="timepicker/jquery.js"></script>
		<script src="timepicker/jquery.datetimepicker.full.min.js"></script>		
		<style type="text/css">
<% 
	String number = (String)request.getAttribute("number");
	if(number!=null){
		if(number.equals("1")){%>
			.my_reservation{display:block;}
		<%	}else if(number.equals("2")){%>
			.data_change{display:block;}
		<%	}else if(number.equals("3")){%>
			.leave{display:block;}
		<%	}else if(number.equals("4")){%>
			.management{display:block;}
		<%	}else if(number.equals("5")){%>
			.m_data_change{display:block;}
		<%	}   	
	}
	MemberDTO login = (MemberDTO)session.getAttribute("session");
	DTO amount = (DTO)request.getAttribute("amount");
	if(login.getM_grade().equals("A")){
%>
	.my_menu {background:#dee9fc;}
	.my_menu_con {background:#eff4fc;}
	<%}else{%>
	.my_menu {background:#dbdbdb;}
	.my_menu_con {background:#f2f2f2;}
	<%}%>
		</style>
	</head>

	<body>
		<div class="wrap">
			<header class="clearfix">
				<div class="inner clearfix">
					<a href="index.do"><img src="bit_logo.png" alt="logo" style="width:80px;"></a>
					<ul class="navi">
						<li class="log">
<%
	if(login == null){ 
%>
							<button onclick="document.getElementById('log').style.display='block'">Login</button>
							<button onclick="location.href='member.do?m=join_form'">Join</button>
<%
	}else{
		if(login.getC_code().equals("c01")){
%>
							<span>신촌</span>
<%
		}else{
%>
							<span>강남</span>
<%
		} 
%>
							<button onclick="location.href='member.do?m=logout'">Logout</button>
							<button onclick="location.href='member.do?m=mypage'">마이페이지</button>
<%
	}
%>
						</li> <!-- log -->
						<li class="menu">
							<a href="room.do?">Room Info</a>
							<a href="reservation.do?">Reservation</a>
							<a href='board.do?'>Board</a>
						</li> <!-- menu -->
					</ul> <!-- navi -->
				</div> <!-- inner -->
			</header>

			<div class="content">
				<!-- login 입력창 start -->
				<div id="log" class="login">
					<form class="login_form ani" action="member.do?m=login" method="post">
						<div class="btnCon">
							<label for="id"><Strong>User ID</Strong></label>
							<input type="text" placeholder="Enter User ID" name="id" required autocomplete="off">
							<label for="pw"><Strong>Password</Strong></label>
							<input type="password" placeholder="Enter Password" name="pw" required autocomplete="off">
							<div class="btnDiv">
								<button type="submit">Login</button>
								<button type="button" onclick="document.getElementById('log').style.display='none'" class="cancelbtn">Cancel</button>
							</div>
						</div> <!-- btnCon -->
					</form>
				</div> <!-- login -->
				<!-- login 입력창 end -->
			</div> <!-- content -->

			<div class="my_con clearfix">
				<div class="my_menu">
					<p class="l_name"><%=login.getM_id() %></p>
					<div class="status">
<%
	if(login.getM_grade().equals("A")){
%>
						<form action="reservation.do?m=oneday&c_code=<%=login.getC_code() %>" name="reser_day" method="post" class="pl">
							<span>날짜 : </span>
							<input type="text" id="date" name= "date" autocomplete="off">
							<button type="button" onclick="CheckInto()">조회</button>
						</form>
						<table class="s_tab">
							<colgroup>
								<col width="50%">
								<col width="50%">
							</colgroup>
							<tbody>
<%
		if(amount!=null){ 
%>
								<tr>
									<td>일일 매출액</td>
									<td><%=amount.getA_onedayamount() %> 원</td>
								</tr>
								<tr>
									<td>일일 예약건수</td>
									<td><%=amount.getA_reservationcount() %> 건</td>
								</tr>
<%
		}else{ 
%>
								<tr>
									<td>일일 매출액</td>
									<td> 원</td>
								</tr>
								<tr>
									<td>일일 예약건수</td>
									<td> 건</td>
								</tr>
<%
		} 
%>
							</tbody>
						</table> <!-- s_tab -->
<%
	}else{ 
%>
						<table class="m_tab">
							<colgroup>
								<col width="50%">
								<col width="50%">
							</colgroup>
							<tbody>
								<tr>
									<td>Point</td>
									<td><%=login.getM_point() %></td>
								</tr>
							</tbody>
						</table> <!-- m_tab -->
<%
	} 
%>
					</div> <!-- status -->
					<ul>
<%
	if(login.getM_grade().equals("B")){
%>
						<li><a href="reservation.do?m=user_into" class="m_menu_1">예약현황</a></li>
						<li><a href="member.do?m=leave_form" class="m_menu_3">탈퇴하기</a></li>
<%
	}else{ 
%>
						<li><a href="member.do?m=member_list" class="m_menu_4">회원관리</a></li>
						<li><a href="reservation.do?m=del" class="m_menu_5">출입코드 정리</a></li>
<%
	} 
%>
						<li><a href="member.do?m=data_change" class="m_menu_2">정보수정</a></li>
					</ul>
				</div> <!-- my_menu -->

				<div class="my_menu_con">
					<div class="my_reservation">
<%
	ArrayList<DTO> into_list = (ArrayList<DTO>)request.getAttribute("into_list");
	if(into_list != null){
		PageInfo pa = (PageInfo)request.getAttribute("page");
		int pageS = pa.getPageb() * pa.getPagebn();
		int pageG = 6;
		int pageL = 0;
		int size=0;
		if(into_list != null) size = into_list.size();
		if(size %pageG == 0) pageL = (size / pageG);
		else pageL = (size / pageG)+1 ;
		for(int i=pa.getPagen()*pageG; i<(pa.getPagen()*pageG)+pageG; i++){
			DTO dto =null;
			if(i>size-1) break;
			else dto = into_list.get(i);
%>
						<table>
							<colgroup>
								<col width="16%">
								<col width="20%">
								<col width="22%">
								<col width="22%">
								<col width="20%">
							</colgroup>
							<thead>
								<tr>
									<th>세미나</th>
									<th>날짜</th>
									<th>시작시간</th>
									<th>종료시간</th>
									<th>출입코드</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td><%=dto.getS_number() %></td>
									<td><%=dto.getRe_starttime().substring(0,10)  %></td>
									<td><%=dto.getRe_starttime().substring(10) %></td>
									<td><%=dto.getRe_endtime() %></td>
									<td><%=dto.getRe_code() %></td>
								</tr>
							</tbody>
						</table>
<%
		} 
%>
<ul class="pageNum">
					<li>
					<%
						if(pageL>5 && pa.getPagen() >2){
					%>
						<a href="reservation.do?m=user_into&pagen=0">1</a>...
					<% 
						}
					if (pa.getPagen()<3 || pageL<5){
							for(int i=0; i<5; i++){
								if(pageL > i){
									if(pa.getPagen()==i){
					%>
					        <a href="reservation.do?m=user_into&pagen=<%=i%>" style="background:#9e9374;color:#fff;"> <%=i+1 %></a>
					  <%
									}else{%>
							<a href="reservation.do?m=user_into&pagen=<%=i%>"> <%=i+1 %></a>			
									<%}
								}
							}
						}else if(pa.getPagen()>pageL-4){
							for(int i=pageL-5; i<pageL+1; i++){
								if(pageL > i){
									if(pa.getPagen()==i){
					%>
				        	<a href="reservation.do?m=user_into&pagen=<%=i%>" style="background:#9e9374;color:#fff;"> <%=i+1 %></a>
				    <%
								}else{%>
							<a href="reservation.do?m=user_into&pagen=<%=i%>"> <%=i+1 %></a>
										<%}
									}
								}
						}else{
							for(int i=pa.getPagen()-2; i<pa.getPagen()+3; i++){
								if(pageL > i){
									if(pa.getPagen()==i){
					%>
							<a href="reservation.do?m=user_into&pagen=<%=i%>" style="background:#9e9374;color:#fff;"> <%=i+1 %></a>
					<%
						}else{%>
						<a href="reservation.do?m=user_into&pagen=<%=i%>"> <%=i+1 %></a>
									<%}
								}
							}
						}
						if(pageL>5 && pa.getPagen()+2 < pageL-1){
					%>
					... <a href="reservation.do?m=user_into&pagen=<%=pageL-1%>"><%=pageL%></a>
					<% }%>
					</li>
				      </ul>
<% 
	} 
%>
					</div> <!-- my_reservation -->
					<div class="data_change">
<%
	MemberDTO change_list = (MemberDTO)request.getAttribute("change_list");
	if(change_list != null){
%>
						<form class="dchange_form" name="dchange_form" action="member.do?m=change" method="post">
							<label for="id"><Strong>User ID</Strong></label>
							<input type="text" placeholder="Enter User ID" name="m_id" id="id" required autocomplete="off"; value="<%=change_list.getM_id()%>" disabled>
							<label for="pw"><Strong>Password</Strong></label>
							<input type="password" placeholder="Enter Password" name="m_pw" id="pw" required autocomplete="off";>
							<label for="name"><Strong>User Name</Strong></label>
							<input type="text" placeholder="Enter User Name" name="m_name" id="name" required autocomplete="off"; value="<%=change_list.getM_name()%>">
							<label for="phone"><Strong>Phone Number</Strong></label>
							<input type="text" placeholder="Enter Phone Number" name="m_phone" id="phone" required autocomplete="off"; value="<%=change_list.getM_phone()%>">
							<input type="hidden" name="add2" id="add2" value="<%=change_list.getM_addr()%>">
                     <p>
                        <Strong>Location</Strong><br>
                        <select name="m_addr" id="user_addr" required>
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
                     <script>
                     var addr2 = $("#add2").val().trim();
                  	$("#user_addr").val(addr2);
                   	$("#user_addr").attr("selected","selected");
                   	</script>
<%
		if(change_list.getM_sex().equals("남 ")){ 
%>
							<input type="radio" name="m_sex" value="남" checked required><span>남자</span>
							<input type="radio" name="m_sex" value="여" required><span> 여자</span>
<%
		}else{ 
%>
							<input type="radio" name="m_sex" value="남" required><span>남자</span>
							<input type="radio" name="m_sex" value="여" checked required><span> 여자</span>
<%
		} 
%>
							<div class="btnDiv">
								<button type="button" onclick="sendIt2()">수정하기</button>
							</div> <!-- btnDiv -->
						</form> <!-- dchange_form -->
<%
	} 
%>
					</div> <!-- data_change -->
					<div class="leave">
						<form class="leave_form" name="leave_form" action="member.do?m=leave" method="post">
							<label for="pw"><Strong>'Password'를 입력해주세요.</Strong></label>
							<input type="password" placeholder="Enter Password" name="m_pw" id="l_pw" required autocomplete="off">
							<button type="button" onclick="PasswordCheck()">탈퇴하기</button>
						</form> <!-- leave_form -->
					</div> <!-- leave -->
					<div class="management">
						<table>
							<colgroup>
								<col width="70%">
								<col width="30%">
							</colgroup>
							<thead>
								<tr>
									<th>Member ID</th>
									<th>Delete</th>
								</tr>
							</thead>
							<tbody>
<%
	ArrayList<MemberDTO> member_list = (ArrayList<MemberDTO>)request.getAttribute("member_list");
	if(member_list!=null){
		for(MemberDTO dto : member_list){
			if(!(dto.getM_grade().equals("A"))){
%>
								<tr>
									<td><a href="member.do?m=manager_form&m_id=<%=dto.getM_id()%>&select=<%=dto.getC_code()%>" class="member_info"><%=dto.getM_id()%></a></td>
									<td><a href="member.do?m=del&c_code=<%=dto.getC_code()%>&m_id=<%=dto.getM_id()%>">삭제</a></td>
								</tr>
<% 
			}
		}
	}
%>
							</tbody>
						</table>
					</div> <!-- management -->
					<div class="m_data_change">
<%
	MemberDTO manager_list = (MemberDTO)request.getAttribute("manager_list");
	if(manager_list != null){
%>
						<form class="dchange_form" name="update_form" action="member.do?m=manager&m_id=<%=manager_list.getM_id()%>" method="post">
							<p>
								<Strong>Strore Code</Strong><br>
<%
		if(manager_list.getC_code().equals("c01")){ 
%>
							<span
								style="font-weight: bold; padding-left: 10px; color: #ae88f7">신촌</span>
							<%
		}else if(manager_list.getC_code().equals("c02")){ 
%>
							<span
								style="font-weight: bold; padding-left: 10px; color: #ae88f7">강남</span>
							<%
		} 
%>						</p>
							<label for="id"><Strong>User ID</Strong></label>
							<input type="text" placeholder="Enter User ID" name="m_id" id="id" required autocomplete="off"; value="<%=manager_list.getM_id()%>" disabled>
							<label for="name"><Strong>User Name</Strong></label>
							<input type="text" placeholder="Enter User Name" name="m_name" id="name" required autocomplete="off"; value="<%=manager_list.getM_name()%>">
							<label for="phone"><Strong>Phone Number</Strong></label>
							<input type="text" placeholder="Enter Phone Number" name="m_phone" id="phone" required autocomplete="off"; value="<%=manager_list.getM_phone()%>">
							<input type="hidden" name="add" id="add" value="<%=manager_list.getM_addr()%>">
                     <p>
                        <Strong>Location</Strong><br>
                        <select id="change_addr" name="m_addr" required>
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
                     <script>
					      var addr = $("#add").val().trim();
					  	$("#change_addr").val(addr);
					   	$("#change_addr").attr("selected","selected");
					   </script>
                     <p>
								<Strong>Sex</Strong><br>
<%
		if(manager_list.getM_sex().equals("남 ")){ 
%>
								<input type="radio" name="m_sex" value="남" checked required><span>남자</span>
								<input type="radio" name="m_sex" value="여" required><span> 여자</span>
<%
		}else{ 
%>
								<input type="radio" name="m_sex" value="남" required><span>남자</span>
								<input type="radio" name="m_sex" value="여" checked required><span> 여자</span>
<%
		} 
%>
							</p>
							<label for="point"><Strong>Point</Strong></label>
							<input type="text" placeholder="Enter Point" name="m_point" id="point" required autocomplete="off"; value="<%=manager_list.getM_point()%>"></p>
							<div class="btnDiv">
								<button type="button" onclick="sendIt1()">수정하기</button>
							</div> <!-- btnDiv -->
						</form> <!-- dchange_form -->
					</div> <!-- m_data_change -->
<%
	} 
%>
				</div> <!-- my_menu_con -->
			</div> <!-- my_con -->
		</div> <!-- wrap -->

		<footer>
			<p>copyright&copy;2019.bit study cafe all rights reserved.</p>
		</footer>
	</body>
	<script language="javascript">
		var time=null;
		$('input').attr('autocomplete','off');
		$("#datetimepicker").change(function(){
			time = $('#datetimepicker').val(),
			$('#date_timepicker_start').attr('disabled', false);
		});
		$("#date_timepicker_start").change(function(){
			$('#date_timepicker_end').attr('disabled', false);
		});
		$('#date').datetimepicker({
			format:'Y-m-d',   
			defaultDate:'',
			timepicker:false
		});

		function CheckInto(){
			if(document.reser_day.date.value == ""){
				alert("날짜를 입력하고 조회해주세요");
				document.reser_day.date.focus();
				document.reser_day.date.select();
			}else reser_day.submit();
		}
		function PasswordCheck(){
			var pwStr = $("#l_pw").val();
			if(pwStr.trim()==""){
				alert("비밀번호를 입력해주세요");
				return;
			}
			$.ajax({
				url : "member.do?m=leave&pw="+pwStr,
				success : function(data){
					if(data == "success"){
						alert("탈퇴완료");
						location.href = "index.do";
					}else if(data == "fail"){
						alert("비밀번호가 틀렷습니다.");
						$('#l_pw').val('');
					}
				}
			});
		}  
        function sendIt1() {   
        	var msg, ss, cc, count=0, count2=0;
             for (i = 0; i <  document.update_form.m_phone.value.trim().length; i++) {
                 ph = document.update_form.m_phone.value.charAt(i)
                 if (!(ph >= '0' && ph <= '9')) {
                     document.update_form.m_phone.focus();
                     document.update_form.m_phone.select();
                     count2++;
                 }
             }
             if(count2>0)
               alert("전화번호는 숫자만 입력가능합니다.");
             else if(document.update_form.m_name.value.trim() == ""){
                alert("이름을 입력해주세요");
                  document.update_form.m_name.focus();
                 document.update_form.m_name.select();
             }else if(document.update_form.m_name.value.trim().length<2){
                 alert("이름을 2자 이상 입력해주십시오.");
                 document.update_form.m_name.focus();
                 document.update_form.m_name.select();
             }else if(document.update_form.m_phone.value.trim() == ""){
                alert("전화번호를 입력해주세요");
                document.update_form.m_phone.focus();
                 document.update_form.m_phone.select();
             }
             else if (document.update_form.m_phone.value.trim().length<9 || document.update_form.m_phone.value.trim().length>11) {
                 alert("전화번호의 길이가 맞지 않습니다.");
                 document.update_form.m_phone.focus();
                 document.update_form.m_phone.select();
             }else{
            	 update_form.submit();
             }
        }
        function sendIt2() {   
            var msg, ss, cc, count=0, count2=0;
            for (i = 0; i <  document.dchange_form.m_phone.value.trim().length; i++) {
                ph = document.dchange_form.m_phone.value.charAt(i)
                if (!(ph >= '0' && ph <= '9')) {
                    document.dchange_form.m_phone.focus();
                    document.dchange_form.m_phone.select();
                    count2++;
                }
            }
            if(count2>0)
              alert("전화번호는 숫자만 입력가능합니다.");
            else if (document.dchange_form.m_pw.value.trim().length<4 || document.dchange_form.m_pw.value.trim().length>12) {
                alert("비밀번호를 4~12자까지 입력해주세요.");
                document.dchange_form.m_pw.focus();
                document.dchange_form.m_pw.select();
            }else if(document.dchange_form.m_name.value.trim() == ""){
               alert("이름을 입력해주세요");
              document.dchange_form.m_name.focus();
             document.dchange_form.m_name.select();
            }else if(document.dchange_form.m_name.value.trim().length<2){
                alert("이름을 2자 이상 입력해주십시오.");
                document.dchange_form.m_name.focus();
            }else if(document.dchange_form.m_phone.value.trim() == ""){
               alert("전화번호를 입력해주세요");
            document.dchange_form.m_phone.focus();
             document.dchange_form.m_phone.select();
            }else if (document.dchange_form.m_phone.value.trim().length<9 || document.dchange_form.m_phone.value.trim().length>11) {
                alert("전화번호의 길이가 맞지 않습니다.");
                document.dchange_form.m_phone.focus();
                document.dchange_form.m_phone.select();
            }else{
            	dchange_form.submit();
            }
       }
	</script>
</html>