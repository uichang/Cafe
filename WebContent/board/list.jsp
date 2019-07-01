<%@ page language="java" contentType="text/html; charset=UTF-8"
	import="java.util.*,cafe.MemberDTO,cafe.DTO, cafe.PageInfo
	,java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>공지 게시판</title>
<link href="https://fonts.googleapis.com/css?family=Cinzel&display=swap"
	rel="stylesheet">
<link href="css/common.css" rel="stylesheet">
<link href="css/board.css" rel="stylesheet">
<link rel="shortcut icon" href="bit_logo.png" />
<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
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

			<div class="bt">
				<h1>
					BIT STUDY CAFE<br>
					<span>공지사항</span>
				</h1>
				<ul class="clearfix">
					<%
            	if(login != null){	
            		if(login.getM_grade().equals("A")){
            %>
					<a href="board.do?m=in_form">글쓰기</a>
					<%		
            		}
            	}
            %>
					<li>
						<form action="board.do?m=search" name="search_form"
							id="search_form" method="post">
							<select name="select"
								style="height: 25px; border-radius: 2px; border: 1px solid #777;">
								<option value="subject">제목</option>
								<option value="content">내용</option>
								<option value="mix">제목+내용</option>
							</select> <input type="search" placeholder="Search" name="search"
								maxlength="15" autocomplete="off"> <a href="#"
								onclick="Writesub()">검색</a>
						</form>
					</li>
				</ul>
				<table>
					<colgroup>
						<col width="10%">
						<col width="40%">
						<col width="25%">
						<col width="15%">
						<col width="10%">
					</colgroup>
					<thead>
						<tr>
							<th>글번호</th>
							<th>제목</th>
							<th>날짜</th>
							<th>가맹점</th>
							<th>조회수</th>
						</tr>
					</thead>
					<%
						PageInfo pa = (PageInfo)session.getAttribute("page");
						ArrayList<DTO> list = (ArrayList<DTO>)request.getAttribute("list");
						String select = (String)request.getAttribute("select");
						String search = (String)request.getAttribute("search");	
						int pageS = pa.getPageb() * pa.getPagebn();
						int pageG = 10;
						int pageL = 0;
						if(list !=null){
							if(list.size() %pageG == 0) pageL = (list.size() / pageG);
							else pageL = (list.size() / pageG)+1 ;
							for(int i=pa.getPagen()*pageG; i<(pa.getPagen()*pageG)+pageG; i++){
								DTO dto =null;
								if(i>list.size()-1) break;
								else dto = list.get(i);
								String subject = dto.getB_subject().replace(" ","&nbsp");
					%>
					<tr>
						<td><%=dto.getB_seq()%></td>
						<td class="enter"><a
							href="board.do?m=con&b_seq=<%=dto.getB_seq()%>"><%=subject%></a></td>
						<%if(dto.getB_time() == null){ %>
							<td><%=dto.getB_date() %></td>
						<%}else{ %>
							<td><%=dto.getB_time() %></td>
						<%}%>
						<%if(dto.getC_code().equals("c01")){%>
						<td>신촌</td>
						<%}else{%>
						<td>강남</td>
						<%} %>
						<td><%=dto.getB_hseq() %></td>
					</tr>
					<%
							}
						}
					%>
				</table>
				<ul class="pageNum">
					<li>
						<%
						if(pageL>5 && pa.getPagen() >2){
					%> <a href="board.do?pagen=0">1</a>... <% 
						}
					if (pa.getPagen()<3 || pageL<5){
							for(int i=0; i<5; i++){
								if(pageL > i){
									if(pa.getPagen()==i){
					%> <a
						href="board.do?&pagen=<%=i%>&select2=<%=select%>&search2=<%=search%>"
						style="background: #9e9374; color: #fff;"> <%=i+1 %></a> <%
									}else{%> <a
						href="board.do?&pagen=<%=i%>&select2=<%=select%>&search2=<%=search%>">
							<%=i+1 %></a> <%}
								}
							}
						}else if(pa.getPagen()>pageL-4){
							for(int i=pageL-5; i<pageL+1; i++){
								if(pageL > i){
									if(pa.getPagen()==i){
					%> <a
						href="board.do?&pagen=<%=i%>&select2=<%=select%>&search2=<%=search%>"
						style="background: #9e9374; color: #fff;"> <%=i+1 %></a> <%
								}else{%> <a
						href="board.do?&pagen=<%=i%>&select2=<%=select%>&search2=<%=search%>">
							<%=i+1 %></a> <%}
									}
								}
						}else{
							for(int i=pa.getPagen()-2; i<pa.getPagen()+3; i++){
								if(pageL > i){
									if(pa.getPagen()==i){
					%> <a
						href="board.do?&pagen=<%=i%>&select2=<%=select%>&search2=<%=search%>"
						style="background: #9e9374; color: #fff;"> <%=i+1 %></a> <%
						}else{%> <a
						href="board.do?&pagen=<%=i%>&select2=<%=select%>&search2=<%=search%>">
							<%=i+1 %></a> <%}
								}
							}
						}
						if(pageL>5 && pa.getPagen()+2 < pageL-1){
					%> ... <a
						href="board.do?&pagen=<%=pageL-1%>&select2=<%=select%>&search2=<%=search%>"><%=pageL%></a>
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
<script type="text/javascript">
               	function Writesub(){
                  if(document.search_form.search.value.trim() == ""){
                         alert("검색할 내용을 입력해주세요");
                         document.search_form.search.focus();
                          document.search_form.search.select();
                      }
                  search_form.submit();
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