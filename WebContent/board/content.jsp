<%@ page language="java" contentType="text/html; charset=UTF-8"
	import="java.util.*, cafe.DTO, cafe.MemberDTO,cafe.PageInfo"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>공지 게시판</title>
<link href="css/common.css" rel="stylesheet">
<link href="css/board_content.css" rel="stylesheet">
<link rel="shortcut icon" href="bit_logo.png" />
<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
<script src="js/login.js"></script>
</head>

<body>
	<div class="wrap">
		<%
   MemberDTO login = (MemberDTO)session.getAttribute("session");
   DTO dto = (DTO)request.getAttribute("list");
   String content = dto.getB_content().replace("\r\n", "<br>");
   content = content.replace(" ","&nbsp");
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
						href="reservation.do">Reservation</a> <a href='board.do'
						style="border-top: 2px solid #333; background: #dee9fc;">Board</a>
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

			<div class="cont">
				<h1>BIT STUDY CAFE</h1>
				<p class="t_tit">
					<span> <%if(login != null){
            	   if(login.getC_code().equals("c01")){%> 신촌 <%}else{%> 강남 <%} 
			    }%>
					</span> <span><%=dto.getB_subject()%></span>
				</p>
				<table class="con">
					<thead>
						<tr>
							<input type="hidden" name="c_code" value="<%=dto.getC_code()%>">
							<th><strong>운영자</strong><span><%=dto.getB_date()%></span> <span><%=dto.getB_hseq()%></span>
								<%if(login != null){
            	   			if(login.getM_grade().equals("A")){%> <a
								href="board.do?m=up_form&b_seq=<%=dto.getB_seq()%>">수정</a> <b>/</b>
								<a href="board.do?m=del&b_seq=<%=dto.getB_seq()%>">삭제</a> <%}
                     	}%></th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td><%=content%></td>
						</tr>
					</tbody>
				</table>


				<div class="reply_in clearfix">
					<form action="board.do?m=reply&b_seq=<%=dto.getB_seq()%>"
						name="reply_form" method="post">
						<%
					if(login == null){
			   %>
						<input type="text" name="reply_text"
							value="로그인을 하셔야 댓글을 작성할 수 있습니다" disabled>
						<%
					}else{
			   %>
						<input type="text" id=reply_text name="reply_text"
							autocomplete="off">
						<%
					}
			   %>
						<a href="#" onclick="ReplyCheck()">댓글달기</a>
					</form>
				</div>
				<%
			ArrayList<DTO> reply = (ArrayList<DTO>)request.getAttribute("reply");
			PageInfo pa = (PageInfo)request.getAttribute("page");
			int pageS = pa.getPageb() * pa.getPagebn();
			int pageG = 3;
			int pageL = 0;
			int size=0;
			if(reply != null) size = reply.size();
			if(size %pageG == 0) pageL = (size / pageG);
			else pageL = (size / pageG)+1 ;
			for(int i=pa.getPagen()*pageG; i<(pa.getPagen()*pageG)+pageG; i++){
			DTO dto2 =null;
			if(i>size-1) break;
			else dto2 = reply.get(i);
			String reply_content = dto2.getRp_content().replace(" ","&nbsp");
		%>
				<table class="rep">
					<colgroup>
						<col width="4%">
						<col width="96%">
					</colgroup>
					<tbody>
						<tr>
							<td rowspan="2"><img src="img/reply.PNG" style="vertical-align:middle"></td>
							<td><strong><%=dto2.getM_id() %></strong><span><%=dto2.getRp_date() %></span>
								<a
								href="board.do?m=redel&rp_seq=<%=dto2.getRp_seq()%>&b_seq=<%=dto2.getB_seq()%>">삭제</a></td>
						</tr>
						<tr>
							<td><%=reply_content%></td>
						</tr>
					</tbody>
				</table>
				<%
				}
            %>
				</table>
				<ul class="pageNum">
					<li>
						<%
						if(pageL>5 && pa.getPagen() >2){
					%> <a href="board.do?m=con&pagen=0&b_seq=<%=dto.getB_seq()%>">1</a>...
						<% 
						}
						if (pa.getPagen()<3 || pageL<5){
							for(int i=0; i<5; i++){
								if(pageL > i){
									if(pa.getPagen()==i){
					%> <a href="board.do?m=con&pagen=<%=i%>&b_seq=<%=dto.getB_seq()%>"
						style="background: #9e9374; color: #fff;"> <%=i+1 %></a> <%
								}else{%> <a
						href="board.do?m=con&pagen=<%=i%>&b_seq=<%=dto.getB_seq()%>">
							<%=i+1 %></a> <%}
									}
								}
						}else if(pa.getPagen()>pageL-4){
							for(int i=pageL-5; i<pageL+1; i++){
								if(pageL > i){
									if(pa.getPagen()==i){
					%> <a href="board.do?m=con&pagen=<%=i%>&b_seq=<%=dto.getB_seq()%>"
						style="background: #9e9374; color: #fff;"> <%=i+1 %></a> <%
								}else{%> <a
						href="board.do?m=con&pagen=<%=i%>&b_seq=<%=dto.getB_seq()%>">
							<%=i+1 %></a> <%}
									}
								}
						}else{
							for(int i=pa.getPagen()-2; i<pa.getPagen()+3; i++){
								if(pageL > i){
									if(pa.getPagen()==i){
					%> <a href="board.do?m=con&pagen=<%=i%>&b_seq=<%=dto.getB_seq()%>"
						style="background: #9e9374; color: #fff;"> <%=i+1 %></a> <%
							}else{%> <a
						href="board.do?m=con&pagen=<%=i%>&b_seq=<%=dto.getB_seq()%>">
							<%=i+1 %></a> <%}
								}
							}
						}
						if(pageL>5 && pa.getPagen()+2 < pageL-1){
					%> ... <a
						href="board.do?m=con&pagen=<%=pageL-1%>&b_seq=<%=dto.getB_seq()%>"><%=pageL%></a>
						<% }%>
					</li>
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
   function ReplyCheck(){
   	 var reply_text = $("#reply_text").val();
        if(reply_text.trim()==""){
           alert("내용 입력해주세요");
           $('#reply_text').val('');
           return;
        }else{
        	reply_form.submit();
        }
        	
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