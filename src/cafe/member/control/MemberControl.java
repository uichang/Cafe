package cafe.member.control;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import cafe.DTO;
import cafe.board.model.BoardService;
import cafe.MemberDTO;
import cafe.member.model.MemberService;

@WebServlet("/member.do")
public class MemberControl extends HttpServlet {
	private static final long serialVersionUID = 1L;
	HttpSession session = null;

	public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String m = request.getParameter("m");
		if (m != null) {
			if (m.equals("join")) {
				join(request, response);
			} else if (m.equals("join_form")) {
				join_form(response);
			} else if (m.equals("login")) {
				login(request, response);
			} else if (m.equals("logout")) {
				logout(request, response);
			} else if (m.equals("leave_form")) {
				leave_form(request, response);
			} else if (m.equals("leave")) {
				leave(request, response);
			} else if (m.equals("member_list")) {
				member_list(request, response);
			} else if (m.equals("manager_form")) {
				manager_form(request, response);
			} else if (m.equals("manager")) {
				manager(request, response);
			} else if (m.equals("data_change")) {
				data_change(request, response);
			} else if (m.equals("change")) {
				change(request, response);
			} else if (m.equals("del")) {
				delete(request, response);
			} else if (m.equals("check")) {
				check(request, response);
			} else if (m.equals("mypage")) {
				mypage(request, response);
			}
		} else {
			index(request, response);
		}
	}

	private void index(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
		rd.forward(request, response);
	}

	private void leave_form(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setAttribute("number", "3");
		RequestDispatcher rd = request.getRequestDispatcher("mypage/mypage.jsp");
		rd.forward(request, response);
	}

	private void join_form(HttpServletResponse response) throws ServletException, IOException {
		response.sendRedirect("member/member_form.jsp");
	}

	private void data_change(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		session = request.getSession();
		MemberDTO login = (MemberDTO) session.getAttribute("session");
		MemberService service = MemberService.getInstance();
		MemberDTO dto2 = service.selectSS(login.getC_code(), login.getM_id());
		request.setAttribute("change_list", dto2);
		request.setAttribute("number", "2");
		RequestDispatcher rd = request.getRequestDispatcher("mypage/mypage.jsp");
		rd.forward(request, response);
	}

	private void mypage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher rd = request.getRequestDispatcher("mypage/mypage.jsp");
		rd.forward(request, response);
	}

	private void member_list(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		session = request.getSession();
		MemberDTO login = (MemberDTO) session.getAttribute("session");
		MemberService service = MemberService.getInstance();
		String c_code = request.getParameter("select");
		c_code = login.getC_code();
		ArrayList<MemberDTO> list = service.selectAll(c_code);
		request.setAttribute("member_list", list);
		request.setAttribute("number", "4");
		RequestDispatcher rd = request.getRequestDispatcher("mypage/mypage.jsp");
		rd.forward(request, response);
	}

	private void join(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String c_code = request.getParameter("c_code2");
		String m_id = request.getParameter("m_id");
		String m_pw = request.getParameter("m_pw");
		String m_name = request.getParameter("m_name");
		String m_addr = request.getParameter("m_addr");
		String m_phone = request.getParameter("m_phone");
		String m_sex = request.getParameter("m_sex");
		MemberDTO dto = new MemberDTO(c_code, m_id, m_pw, m_name, m_addr, m_phone, m_sex, null, 0, null);
		MemberService service = MemberService.getInstance();
		service.insertS(dto);
		response.sendRedirect("member.do");
	}

	private void login(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		session = request.getSession();
		String c_code = request.getParameter("c_code");
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		MemberService service = MemberService.getInstance();
		MemberDTO dto = service.compareS(c_code, id, pw);
		PrintWriter out = response.getWriter();
		if (dto != null) {
			session.setAttribute("session", dto);
			out.print("success");
		} else {
			out.print("fail");
		}
	}

	private void delete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String c_code = request.getParameter("c_code");
		String m_id = request.getParameter("m_id");
		MemberService service = MemberService.getInstance();
		service.deleteS(c_code, m_id);
		ArrayList<MemberDTO> list = service.selectAll(c_code);
		request.setAttribute("member_list", list);
		request.setAttribute("number", "4");
		RequestDispatcher rd = request.getRequestDispatcher("mypage/mypage.jsp");
		rd.forward(request, response);
	}

	private void logout(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		session = request.getSession();
		session.invalidate();
		RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
		rd.forward(request, response);
	}

	private void leave(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		session = request.getSession();
		MemberDTO dto = (MemberDTO) session.getAttribute("session");
		String pw = request.getParameter("pw");
		String c_code = dto.getC_code();
		String m_id = dto.getM_id();
		MemberService service = MemberService.getInstance();
		String pw2 = service.searchPW(c_code, m_id);
		PrintWriter out = response.getWriter();
		if (pw.equals(pw2)) {
			service.leaveS(c_code, m_id);
			session.invalidate();
			out.print("success");
		} else
			out.print("fail");
	}

	private void manager_form(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String c_code = request.getParameter("select");
		String m_id = request.getParameter("m_id");
		MemberService service = MemberService.getInstance();
		MemberDTO dto = service.selectSS(c_code, m_id);
		request.setAttribute("manager_list", dto);
		request.setAttribute("number", "5");
		RequestDispatcher rd = request.getRequestDispatcher("mypage/mypage.jsp");
		rd.forward(request, response);
	}

	private void manager(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String c_code = request.getParameter("c_code");
		String m_id = request.getParameter("m_id");
		String m_name = request.getParameter("m_name");
		String m_addr = request.getParameter("m_addr");
		String m_phone = request.getParameter("m_phone");
		String m_sex = request.getParameter("m_sex");
		int m_point = getInt(request, "m_point");
		MemberDTO dto = new MemberDTO(c_code, m_id, null, m_name, m_addr, m_phone, m_sex, null, m_point, null);
		MemberService service = MemberService.getInstance();
		service.updateS(dto);
		ArrayList<MemberDTO> list = service.selectAll(c_code);
		request.setAttribute("member_list", list);
		request.setAttribute("number", "4");
		RequestDispatcher rd = request.getRequestDispatcher("mypage/mypage.jsp");
		rd.forward(request, response);
	}

	private void change(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		session = request.getSession();
		MemberDTO login = (MemberDTO) session.getAttribute("session");
		String c_code = login.getC_code();
		String m_id = login.getM_id();
		String m_pw = request.getParameter("m_pw");
		String m_name = request.getParameter("m_name");
		String m_addr = request.getParameter("m_addr");
		String m_phone = request.getParameter("m_phone");
		String m_sex = request.getParameter("m_sex");
		MemberDTO dto = new MemberDTO(c_code, m_id, m_pw, m_name, m_addr, m_phone, m_sex, null, -1, null);
		MemberService service = MemberService.getInstance();
		service.updateC(dto);
		/*
		 * MemberDTO dto2 = service.selectSS(c_code, m_id);
		 * request.setAttribute("change_list", dto2); request.setAttribute("number",
		 * "2");
		 */
		RequestDispatcher rd = request.getRequestDispatcher("mypage/mypage.jsp");
		rd.forward(request, response);
	}

	private void check(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int count = 0;
		MemberService service = MemberService.getInstance();
		String id = request.getParameter("id");
		String c_code = request.getParameter("c_code");
		ArrayList<MemberDTO> list = service.selectAll(c_code);
		PrintWriter out = response.getWriter();
		for (int i = 0; i < list.size(); i++) {
			if (id.equals(list.get(i).getM_id())) {
				count++;
			} else {
			}
		}
		if (count > 0)
			out.print("fail");
		else
			out.print("success");
	}

	private int getInt(HttpServletRequest request, String parameter) {
		String Str = request.getParameter(parameter);
		if (Str != null) {
			Str = Str.trim();
			if (Str.length() != 0) {
				try {
					int para = Integer.parseInt(Str);
					return para;
				} catch (NumberFormatException ne) {
					return -1;
				}
			} else {
				return -1;
			}
		} else {
			return -1;
		}
	}
}
