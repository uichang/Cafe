package cafe.board.control;

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
import cafe.MemberDTO;
import cafe.PageInfo;
import cafe.board.model.BoardService;

@WebServlet("/board.do")
public class BoardControl extends HttpServlet {
	private static final long serialVersionUID = 1L;
	HttpSession session;

	public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String m = request.getParameter("m");
		if (m != null) {
			if (m.equals("in_form")) {
				in_form(response);
			} else if (m.equals("in")) {
				insert(request, response);
			} else if (m.equals("con")) {
				content(request, response);
			} else if (m.equals("del")) {
				delete(request, response);
			} else if (m.equals("up_form")) {
				up_form(request, response);
			} else if (m.equals("up")) {
				up(request, response);
			} else if (m.equals("search")) {
				search(request, response);
			} else if (m.equals("reply")) {
				reply(request, response);
			} else if (m.equals("reply2")) {
				reply2(request, response);
			} else if (m.equals("redel")) {
				redelete(request, response);
			}

		} else {
			list(request, response);
		}
	}

	private void list(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ArrayList<DTO> list = null;
		String select = request.getParameter("select2");
		String search = request.getParameter("search2");
		BoardService service = BoardService.getInstance();
		if (select != null && !(select.equals("null"))) {
			request.setAttribute("select", select);
			request.setAttribute("search", search);
			list = service.searchS(select, search);
		} else {
			list = service.selectS();
		}
		int pageN = getInt(request, "pagen");
		if (pageN == -1)
			pageN = 0;
		int pageb = pageN / 5;
		if (pageb == -1)
			pageb = 0;
		PageInfo page = new PageInfo(pageb, 5, pageN);
		session = request.getSession();
		session.setAttribute("page", page);
		request.setAttribute("list", list);
		RequestDispatcher rd = request.getRequestDispatcher("board/list.jsp");
		rd.forward(request, response);
	}

	private void in_form(HttpServletResponse response) throws IOException {
		response.sendRedirect("board/input.jsp");
	}

	private void insert(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		session = request.getSession();
		MemberDTO dto2 = (MemberDTO) session.getAttribute("session");
		String c_code = dto2.getC_code();
		String m_id = dto2.getM_id();
		String b_subject = request.getParameter("subject");
		String b_content = request.getParameter("content");
		DTO dto = new DTO(-1, b_subject, b_content, null, null,-1, c_code);
		BoardService service = BoardService.getInstance();
		service.insertS(dto);
		service.time();
		service.time2();
		response.sendRedirect("board.do");
	}

	private void reply(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		session = request.getSession();
		MemberDTO dto2 = (MemberDTO) session.getAttribute("session");
		String c_code = dto2.getC_code();
		String m_id = dto2.getM_id();
		int b_seq = getInt(request, "b_seq");
		String rp_content = request.getParameter("reply_text");
		DTO dto = new DTO(-1, c_code, m_id, b_seq, rp_content, null, -1, -1, -1);
		BoardService service = BoardService.getInstance();
		service.insertR(dto);
		response.sendRedirect("board.do?m=con&b_seq=" + b_seq);
	}

	private void reply2(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		session = request.getSession();
		MemberDTO dto2 = (MemberDTO) session.getAttribute("session");
		String c_code = dto2.getC_code();
		String m_id = dto2.getM_id();
		int b_seq = getInt(request, "b_seq");
		String rp_content = request.getParameter("reply_text");
		int rp_group = getInt(request, "rp_group");
		int rp_step = getInt(request, "rp_step");
		BoardService service = BoardService.getInstance();
		int rstep = service.findR(rp_group) + 1;
		DTO dto = new DTO(-1, c_code, m_id, b_seq, rp_content, null, rp_group, rstep, -1);
		service.insertR2(dto);
		response.sendRedirect("board.do?m=con&b_seq=" + b_seq);
	}

	private void content(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int b_seq = getInt(request, "b_seq");
		if (b_seq == -1) {
			response.sendRedirect("board.do");
		} else {
			BoardService service = BoardService.getInstance();
			service.updateH(b_seq);
			DTO list = service.selectS(b_seq);
			request.setAttribute("list", list);
			ArrayList<DTO> list2 = service.selectR(b_seq);
			request.setAttribute("reply", list2);
			int pageN = getInt(request, "pagen");
			if (pageN == -1)
				pageN = 0;
			int pageb = pageN / 5;
			if (pageb == -1)
				pageb = 0;
			PageInfo page = new PageInfo(pageb, 5, pageN);
			request.setAttribute("page", page);
			RequestDispatcher rd = request.getRequestDispatcher("board/content.jsp");
			rd.forward(request, response);
		}
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

	private void delete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int b_seq = getInt(request, "b_seq");
		BoardService service = BoardService.getInstance();
		service.deleteS(b_seq);
		response.sendRedirect("board.do");
	}

	private void redelete(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int b_seq = getInt(request, "b_seq");
		int rp_seq = getInt(request, "rp_seq");
		BoardService service = BoardService.getInstance();
		service.deleteSR(rp_seq);
		response.sendRedirect("board.do?m=con&b_seq=" + b_seq);
	}

	private void up_form(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String c_code = request.getParameter("c_code");
		int b_seq = getInt(request, "b_seq");
		BoardService service = BoardService.getInstance();
		DTO list = service.selectS(b_seq);
		request.setAttribute("list", list);
		RequestDispatcher rd = request.getRequestDispatcher("board/update_form.jsp");
		rd.forward(request, response);
	}

	private void up(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int b_seq = getInt(request, "b_seq");
		String b_subject = request.getParameter("b_subject");
		String b_content = request.getParameter("b_content");
		BoardService service = BoardService.getInstance();
		DTO dto = new DTO(b_seq, b_subject, b_content, null, null, -1, null);
		service.updateS(dto);
		response.sendRedirect("board.do?m=con&b_seq=" + b_seq);
	}

	private void search(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String select = request.getParameter("select");
		String search = request.getParameter("search");
		BoardService service = BoardService.getInstance();
		ArrayList<DTO> list = service.searchS(select, search);
		request.setAttribute("select", select);
		request.setAttribute("search", search);
		request.setAttribute("list", list);
		PageInfo page = new PageInfo(0, 5, 0);
		session = request.getSession();
		session.setAttribute("page", page);
		RequestDispatcher rd = request.getRequestDispatcher("board/list.jsp");
		rd.forward(request, response);
	}

}
