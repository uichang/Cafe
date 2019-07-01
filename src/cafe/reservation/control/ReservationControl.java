package cafe.reservation.control;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Random;

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
import cafe.member.model.MemberService;
import cafe.reservation.model.ReservationServise;

@WebServlet("/reservation.do")
public class ReservationControl extends HttpServlet {
	private static final long serialVersionUID = 1L;
	HttpSession session;

	public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String m = request.getParameter("m");
		if (m != null) {
			if (m.equals("time")) {
				insert(request, response);
			} else if (m.equals("oneday")) {
				oneday(request, response);
			} else if (m.equals("into")) {
				into(request, response);
			} else if (m.equals("user_into")) {
				user_into(request, response);
			} else if (m.equals("del")) {
				del(request, response);
			}
		} else {
			reservation_form(request, response);
		}
	}

	private void insert(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int totalamount = 0, count = 0;
		int compare1 = 0, compare2 = 0, compare3 = 0, compare4 = 0, compare5 = 0, compare6 = 0;
		Date reStrat = null, reEnd = null;
		int s_number = getInt(request, "s_number");
		String calender = request.getParameter("cal");
		String starttime = request.getParameter("start");
		String endtime = request.getParameter("end");
		session = request.getSession();
		MemberDTO login = (MemberDTO) session.getAttribute("session");
		PrintWriter out = response.getWriter();
		if (login != null && !(starttime.equals(endtime))) {
			ReservationServise service = ReservationServise.getInstance();
			String c_code = login.getC_code();
			String re_starttime = calender + " " + starttime;
			String re_endtime = calender + " " + endtime;

			SimpleDateFormat format = new SimpleDateFormat("kk:mm");
			SimpleDateFormat format2 = new SimpleDateFormat("yyyy-MM-dd kk:mm");
			try { // 세미나실 가격 가져오는 코드
				Date firstTime = format.parse(starttime);
				Date secondDate = format.parse(endtime);
				Date firstTime2 = format2.parse(re_starttime);
				Date secondDate2 = format2.parse(re_endtime);
				Date present = new Date();
				compare5 = firstTime2.compareTo(present);
				compare6 = secondDate2.compareTo(present);
				if (compare5 < 0 || compare6 < 0) {
					out.print("late");
				} else {

					long useTime = firstTime.getTime() - secondDate.getTime();
					useTime = useTime / (30 * 60 * 1000);
					useTime = Math.abs(useTime);
					int amount = service.cash(useTime, s_number);
					totalamount = (int) (amount * useTime);

					java.sql.Date ts = java.sql.Date.valueOf(calender);
					ArrayList<String> re_start = service.start(ts, s_number, c_code);
					ArrayList<String> re_end = service.end(ts, s_number, c_code);
					for (int i = 0; i < re_start.size(); i++) {
						reStrat = format.parse(re_start.get(i));
						reEnd = format.parse(re_end.get(i));
						compare1 = firstTime.compareTo(reStrat);
						compare2 = firstTime.compareTo(reEnd);
						compare3 = secondDate.compareTo(reStrat);
						compare4 = secondDate.compareTo(reEnd);
						if (compare1 < 0) {
							if (compare3 > 0 || compare4 > 0) {
								count++;
							}
						} else if (compare1 > 0) {
							if (compare2 < 0) {
								count++;
							}
						} else
							count++;
					}
					if (count > 0) {
						out.print("fail");
					} else if (count == 0) {
						String m_id = login.getM_id();
						Random rnd = new Random();
						String a1 = String.valueOf((char) ((int) (rnd.nextInt(26)) + 97));
						String a2 = String.valueOf(rnd.nextInt(10));
						String a3 = String.valueOf((char) ((int) (rnd.nextInt(26)) + 65));
						String a4 = String.valueOf((char) ((int) (rnd.nextInt(26)) + 97));
						String a5 = String.valueOf((char) ((int) (rnd.nextInt(26)) + 65));
						String a6 = String.valueOf(rnd.nextInt(10));
						String a7 = String.valueOf((char) ((int) (rnd.nextInt(26)) + 65));
						String a8 = String.valueOf(rnd.nextInt(10));
						String re_code = a1 + a2 + a3 + a4 + a5 + a6 + a7 + a8;

						DTO dto = new DTO(s_number, re_starttime, re_endtime, m_id, c_code, re_code, totalamount);
						service.insertS(dto);
						MemberService service2 = MemberService.getInstance();
						int point = (int) (0.5 * useTime);
						point = (int) Math.floor(point);
						service2.updateP(login, point);
						MemberDTO dto2 = new MemberDTO(c_code, m_id, null, login.getM_name(), login.getM_addr(),
								login.getM_phone(), login.getM_sex(), login.getM_joindate(), login.getM_point() + point,
								login.getM_grade());
						session.setAttribute("session", dto2);
						out.print("success");
					}
				}
			} catch (Exception e) {
				System.out.println("나가나");
			}
		} else if (login == null) {
			out.print("login");
		} else {
			out.print("same");
		}
	}

	private void reservation_form(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		RequestDispatcher rd = request.getRequestDispatcher("reservation/reservation_form.jsp");
		rd.forward(request, response);
	}

	private void oneday(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int a_onedayamount = 0;
		ReservationServise service = ReservationServise.getInstance();
		session = request.getSession();
		String date = request.getParameter("date");
		String c_code = request.getParameter("c_code");
		java.sql.Date cal = java.sql.Date.valueOf(date);
		ArrayList<Integer> amount = service.oneday(cal, c_code);
		for (int i : amount) {
			a_onedayamount += i;
		}
		int a_reservationcount = amount.size();
		DTO dto = new DTO(cal, c_code, a_onedayamount, a_reservationcount);
		service.deleteOne(dto);
		service.insertOne(dto);
		request.setAttribute("amount", dto);
		RequestDispatcher rd = request.getRequestDispatcher("mypage/mypage.jsp");
		rd.forward(request, response);
	}

	private void into(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ReservationServise service = ReservationServise.getInstance();
		SimpleDateFormat format = new SimpleDateFormat("yyyy-mm-dd");
		session = request.getSession();
		String c_code = request.getParameter("c_code");
		String date = request.getParameter("date");
		int s_number = getInt(request, "s_number");
		java.sql.Date cal = java.sql.Date.valueOf(date);
		ArrayList<DTO> list = service.into(c_code, cal, s_number);
		request.setAttribute("list", list);
		RequestDispatcher rd = request.getRequestDispatcher("reservation/reservation_form.jsp");
		rd.forward(request, response);
	}

	private void user_into(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		ReservationServise service = ReservationServise.getInstance();
		session = request.getSession();
		MemberDTO login = (MemberDTO) session.getAttribute("session");
		String c_code = login.getC_code();
		String m_id = login.getM_id();
		ArrayList<DTO> list = service.intoU(c_code, m_id);
		request.setAttribute("into_list", list);
		int pageN = getInt(request, "pagen");
		if (pageN == -1)
			pageN = 0;
		int pageb = pageN / 5;
		if (pageb == -1)
			pageb = 0;
		PageInfo page = new PageInfo(pageb, 5, pageN);
		request.setAttribute("page", page);
		request.setAttribute("number", "1");
		RequestDispatcher rd = request.getRequestDispatcher("mypage/mypage.jsp");
		rd.forward(request, response);
	}

	private void del(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ReservationServise service = ReservationServise.getInstance();
		session = request.getSession();
		MemberDTO login = (MemberDTO) session.getAttribute("session");
		service.delete(login.getC_code());
		RequestDispatcher rd = request.getRequestDispatcher("mypage/mypage.jsp");
		rd.forward(request, response);
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
