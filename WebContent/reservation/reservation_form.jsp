<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="cafe.MemberDTO, cafe.DTO,java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>예약</title>
<link href="css/common.css" rel="stylesheet">
<link href="css/reservation_page.css" rel="stylesheet">
<link rel="stylesheet" type="text/css"
	href="timepicker/jquery.datetimepicker.css"/ >
<link rel="shortcut icon" href="bit_logo.png" />
<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
<script src="timepicker/jquery.js"></script>
<script src="timepicker/jquery.datetimepicker.full.min.js"></script>
<script src="js/login.js"></script>
</head>

<body>
	<div class="wrap">
		<%
   MemberDTO login = (MemberDTO)session.getAttribute("session");
   ArrayList<DTO> list = (ArrayList<DTO>)request.getAttribute("list");
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
						href="reservation.do"
						style="border-top: 2px solid #333; background: #dee9fc;">Reservation</a>
						<a href='board.do'>Board</a></li>
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

			<div class="r_list">
				<h1>
					BIT STUDY CAFE<br>
					<span>예약현황</span>
				</h1>
				<div class="choose">
					<form action="reservation.do?m=into" name="check_into"
						method="post">
						<ul class="clearfix">
							<li><span>가맹점 : </span> <select name="c_code"
								id="store_code">
									<option value="c01">신촌</option>
									<option value="c02">강남</option>
							</select></li>
							<li><span>날짜 : </span> <input style="" type="text" id="date"
								name="date" autocomplete="off"></li>
							<li><span>세미나 : </span> <select name="s_number"
								id="s_number">
									<option value="1">세미나1</option>
									<option value="2">세미나2</option>
									<option value="3">세미나3</option>
									<option value="4">세미나4</option>
									<option value="5">세미나5</option>
									<option value="6">세미나6</option>
							</select></li>
							<li><button type="button" onclick="CheckInto()">조회</button></li>
						</ul>
					</form>
				</div>
				<table>
					<colgroup>
						<col width="20%">
						<col width="20%">
						<col width="30%">
						<col width="30%">
					</colgroup>
					<thead>
						<tr>
							<th>가맹점</th>
							<th>시작시간</th>
							<th>종료시간</th>
							<th>예약자</th>
						</tr>
					</thead>
					<tbody>
						<%if(list!=null){
               for(DTO dto : list){ %>
						<tr>
							<%if(dto.getC_code().equals("c01")){%>
							<td>신촌</td>
							<%}else{%>
							<td>강남</td>
							<%} %>
							<td><%=dto.getRe_starttime() %></td>
							<td><%=dto.getRe_endtime() %></td>
							<td><%=dto.getM_id() %></td>
						</tr>
						<%}
               }%>
					</tbody>
				</table>
				<button
					onclick="document.getElementById('reserv').style.display='block'"
					class="r_btn">예약하기</button>
			</div>

			<!-- reservation 입력창 start -->
			<div id="reserv" class="reservation">
				<form name="reservation_form" class="reservation_form ani"
					action="reservation.do?m=time" method="post">
					<p>
						<strong>세미나실</strong><span> : </span> <select id="s_number2"
							name="s_number">
							<option value=1>1번방 (4인/모니터x)</option>
							<option value="2">2번방 (4인/모니터o)</option>
							<option value="3">3번방 (6인/모니터x)</option>
							<option value="4">4번방 (6인/모니터o)</option>
							<option value="5">5번방 (8인/모니터x)</option>
							<option value="6">6번방 (8인/모니터o)</option>
						</select>
					</p>
					<div class="calenCon">
						<label for="calender"><Strong>시작 날짜</Strong></label> <input
							type="text" id="datetimepicker" name="calender"
							autocomplete="off"><br> <label for="start"><Strong>시작
								시간</Strong></label> <input type="text" id="date_timepicker_start" name="start"
							autocomplete="off" disabled><br> <label for="end"><Strong>종료
								시간</Strong></label> <input type="text" id="date_timepicker_end" name="end"
							autocomplete="off" disabled>
					</div>
					<div class="btnDiv">
						<button type="button" onclick="Reservation()">예약하기</button>
						<button type="button" onclick="reservationCancle()"
							class="cancelbtn">Cancel</button>
					</div>
				</form>
			</div>
			<!-- reservation 입력창 end -->
			<footer>
				<p>copyright&copy;2019.bit study cafe all rights reserved.</p>
			</footer>

		</div>
		<!-- content -->
	</div>
	<!-- wrap -->
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
      var today = new Date();
      var dd = today.getDate();
      var mm = today.getMonth()+4; //January is 0!
      var mm2 = today.getMonth()+1;
      var yyyy = today.getFullYear();

      if(dd<10) {
         dd='0'+dd
      } 

      if(mm<10) {
         mm='0'+mm
      } 

      today = yyyy+'/'+mm+'/'+dd;
      today2 = yyyy+'-0'+mm2+'-'+dd;
      $('#date').datetimepicker({
          format:'Y-m-d',   
          minDate:'',//yesterday is minimum date(for today use 0 or -1970/01/01)
          maxDate:today,//tomorrow is maximum date calendar
          defaultDate:'',
          timepicker:false
       });
      $('#datetimepicker').datetimepicker({
         format:'Y-m-d',   
         minDate:'',//yesterday is minimum date(for today use 0 or -1970/01/01)
         maxDate:today,//tomorrow is maximum date calendar
         defaultDate:'',
         timepicker:false
      });
      $(function(){
         $('#date_timepicker_start').datetimepicker({
            format:'H:i',
            defaultTime:'09:00',
            allowTimes:[
            '09:00','09:30','10:00','10:30','11:00','11:30','12:00','12:30','13:00','13:30','14:00','14:30','15:00','15:30',
            '16:00','16:30','17:00','17:30','18:00','18:30','19:00','19:30','20:00','20:30'
            ],
            onShow:function( ct ){
            	if( time===today2 ){
            	    this.setOptions({
            	      minTime:'',
            	      maxTime:$('#date_timepicker_end').val()?$('#date_timepicker_end').val():false
            	    });
            	  }
            	else
            	    this.setOptions({
            	    	minTime:'09:00',
            	    	maxTime:$('#date_timepicker_end').val()?$('#date_timepicker_end').val():false
            	    });
            },
            datepicker:false
         });
         $('#date_timepicker_end').datetimepicker({
            format:'H:i',
            defaultTime:'09:30',
            allowTimes:[
               '09:00','09:30','10:00','10:30','11:00','11:30','12:00','12:30','13:00','13:30','14:00','14:30','15:00','15:30',
               '16:00','16:30','17:00','17:30','18:00','18:30','19:00','19:30','20:00','20:30','21:00'
               ],
            onShow:function( ct ){
            this.setOptions({
            minTime:$('#date_timepicker_start').val()?$('#date_timepicker_start').val():false
            })
         },
         datepicker:false
         });
      });
      $.datetimepicker.setLocale('ko');
      
      function Reservation() {   
          
          if(document.reservation_form.calender.value.trim() == ""){
             alert("시작날짜를 입력해주세요");
             document.reservation_form.calender.focus();
              document.reservation_form.calender.select();
            
          }else if(document.reservation_form.start.value.trim() == ""){
             alert("시작시간를 입력해주세요");
             document.reservation_form.start.focus();
              document.reservation_form.start.select();
           
          }else if(document.reservation_form.end.value.trim() == ""){
             alert("종료시간를 입력해주세요");
             document.reservation_form.end.focus();
              document.reservation_form.end.select();
             
          }
          else{
        	  var s_number = $("#s_number2").val();
        	  var cal = $("#datetimepicker").val();
        	  var start = $("#date_timepicker_start").val();
        	  var end = $("#date_timepicker_end").val();
              $.ajax({
            	  url : "reservation.do?m=time&cal="+cal+"&start="+start+"&end="+end+"&s_number="+s_number,
                  success : function(data){
                       if(data == "success"){
                            alert("예약 완료 되었습니다.");
                            $('#datetimepicker').val('');
                            $('#date_timepicker_start').val('');
                            $('#date_timepicker_end').val('');
                            $('#date_timepicker_start').attr('disabled', true);
                      	    $('#date_timepicker_end').attr('disabled', true);
                            document.getElementById('reserv').style.display='none'
                       }else if(data == "login"){
                    	   alert("로그인 하셔야 이용 가능합니다.");
                    	   $('#datetimepicker').val('');
                           $('#date_timepicker_start').val('');
                           $('#date_timepicker_end').val('');
                           $('#date_timepicker_start').attr('disabled', true);
                     	   $('#date_timepicker_end').attr('disabled', true);
                           document.getElementById('reserv').style.display='none'
                       }else if(data == "same"){
                    	   alert("시작시간과 종료시간이 동일합니다.");
                    	   $('#datetimepicker').val('');
                           $('#date_timepicker_start').val('');
                           $('#date_timepicker_end').val('');
                    	   $('#date_timepicker_start').attr('disabled', true);
                     	   $('#date_timepicker_end').attr('disabled', true);
                       }else if(data == "fail"){
                    	   alert("이미 예약이 된 시간입니다.");
                    	   $('#datetimepicker').val('');
                           $('#date_timepicker_start').val('');
                           $('#date_timepicker_end').val('');
                    	   $('#date_timepicker_start').attr('disabled', true);
                     	   $('#date_timepicker_end').attr('disabled', true);
                       }else if(data == "late"){
                    	   alert("이미 지난 시간입니다.");
                    	   $('#datetimepicker').val('');
                           $('#date_timepicker_start').val('');
                           $('#date_timepicker_end').val('');
                    	   $('#date_timepicker_start').attr('disabled', true);
                     	   $('#date_timepicker_end').attr('disabled', true);
                       }
                  }
              });
          }
      }
          function CheckInto(){
              if(document.check_into.date.value.trim() == ""){
                 alert("날짜를 입력하고 조회해주세요");
                 document.check_into.date.focus();
                 document.check_into.date.select();
              }else
              check_into.submit();
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
          function reservationCancle(){
        	    document.reservation_form.s_number.value = 1;
        		document.reservation_form.calender.value = "";
        	    document.reservation_form.start.value = "";
        	    document.reservation_form.end.value = "";
        	    $('#date_timepicker_start').attr('disabled', true);
          	    $('#date_timepicker_end').attr('disabled', true);
        	    document.getElementById('reserv').style.display='none'
        	}
   </script>
</html>