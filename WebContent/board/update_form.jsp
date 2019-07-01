<%@ page language="java" contentType="text/html; charset=utf-8"
	import="cafe.MemberDTO, cafe.DTO"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>공지 게시판</title>
<link href="https://fonts.googleapis.com/css?family=Cinzel&display=swap"
	rel="stylesheet">
<link href="css/common.css" rel="stylesheet">
<link href="css/write.css" rel="stylesheet">
<link rel="shortcut icon" href="bit_logo.png" />
</head>

<body>
	<div class="wrap">
		<%
   MemberDTO login = (MemberDTO)session.getAttribute("session");
   DTO dto = (DTO)request.getAttribute("list");
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

			<div class="wt">
				<h1>
					BIT STUDY CAFE<br>
					<span>수정</span>
				</h1>
				<ul class="clearfix">
					<li><a href="board.do">목록</a></li>
				</ul>
				<form action="board.do?m=up&b_seq=<%=dto.getB_seq() %>"
					name="write_form" method="post">
					<table>
						<colgroup>
							<col width="25%">
							<col width="25%">
							<col width="25%">
							<col width="25%">
						<tbody>
							<tr>
								<td colspan="2"><strong>작성자</strong> : 운영자</td>
								<td colspan="2"><strong>지점명</strong> <%if(dto.getC_code().equals("c01")){%>
									: 신촌</td>
								<%}else{%>
								: 강남
								</td>
								<%} %>
							</tr>
							<tr>
								<td><strong>제목</strong></td>
								<td colspan="3" style="text-align: left; text-align: left;"><input
									type="text" name="b_subject" value="<%=dto.getB_subject()%>"
									autocomplete="off"></td>
							</tr>
							<tr>
								<td colspan="4"><textarea name="b_content" rows="10"
										cols="90"><%=dto.getB_content()%></textarea></td>
							</tr>
							<tr>
								<td colspan="4"><button type="submit">수정하기</button></td>
							</tr>
						</tbody>
					</table>
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

</html>