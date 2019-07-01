package cafe;
import java.sql.*;

public class DTO {

	private int s_number;
	private int s_headcount;
	private int s_possibility;
	private int s_monitor;

	private int s_amount;

	private String c_code;
	private String c_name;
	private String c_boss;
	private String c_phone;
	private String c_addr;
	private String c_opendate;
	private String c_businesstime;

	private int b_seq;
	private String b_subject;
	private String b_content;
	private Date b_date;
	private String b_time;
	private int b_hseq;
	
	private String m_id;
	private String m_name;

	private int rp_seq;
	private String rp_content;
	private Date rp_date;
	private int rp_group;
	private int rp_step;
	private int rp_indent;	

	private String re_starttime;
	private String re_endtime;
	private String re_code;
	private int totalamount;

	private Date a_businessdate;
	private int a_onedayamount;
	private int a_reservationcount;

	public DTO(int s_number, int s_headcount, int s_possibility, int s_monitor) {
		this.s_number = s_number;
		this.s_headcount = s_headcount;
		this.s_possibility = s_possibility;
		this.s_monitor = s_monitor;
	} //세미나

	public DTO(int s_number, int s_amount) {
		this.s_number = s_number;
		this.s_amount = s_amount;
	}//세미나 가격

	public DTO(String c_code, String c_name, String c_boss, String c_phone, String c_addr, String c_opendate,
			String c_businesstime) {
		this.c_code = c_code;
		this.c_name = c_name;
		this.c_boss = c_boss;
		this.c_phone = c_phone;
		this.c_addr = c_addr;
		this.c_opendate = c_opendate;
		this.c_businesstime = c_businesstime;
	}//가맹점

	public DTO(int b_seq, String b_subject, String b_content, Date b_date, String b_time, int b_hseq, String c_code) {
		this.b_seq = b_seq;
		this.b_subject = b_subject;
		this.b_content = b_content;
		this.b_date = b_date;
		this.b_time = b_time;
		this.b_hseq = b_hseq;
		this.c_code = c_code;
	}//게시판
	
	public String getB_time() {
		return b_time;
	}

	public void setB_time(String b_time) {
		this.b_time = b_time;
	}

	public DTO(int rp_seq, String c_code, String m_id, int b_seq, String rp_content, Date rp_date, int rp_group, int rp_step,
			int rp_indent) {
		this.rp_seq = rp_seq;
		this.c_code = c_code;
		this.m_id = m_id;
		this.b_seq = b_seq;
		this.rp_content = rp_content;
		this.rp_date = rp_date;
		this.rp_group = rp_group;
		this.rp_step = rp_step;
		this.rp_indent = rp_indent;
	}// 공지게시판 리플

	public DTO(int s_number, String re_starttime, String re_endtime, String m_id, String c_code,
			String re_code, int totalamount) {
		this.s_number = s_number;
		this.re_starttime = re_starttime;
		this.re_endtime = re_endtime;
		this.m_id = m_id;
		this.c_code = c_code;
		this.re_code = re_code;
		this.totalamount = totalamount;
	}//예약

	public DTO(int s_number, String re_starttime, String re_endtime) {
		super();
		this.s_number = s_number;
		this.re_starttime = re_starttime;
		this.re_endtime = re_endtime;
	}// 스케쥴

	public DTO(Date a_businessdate, String c_code, int a_onedayamount, int a_reservationcount) {
		super();
		this.a_businessdate = a_businessdate;
		this.c_code = c_code;
		this.a_onedayamount = a_onedayamount;
		this.a_reservationcount = a_reservationcount;
	}//매출액

	public int getS_number() {
		return s_number;
	}
	public void setS_number(int s_number) {
		this.s_number = s_number;
	}
	public int getS_headcount() {
		return s_headcount;
	}
	public void setS_headcount(int s_headcount) {
		this.s_headcount = s_headcount;
	}
	public int getS_possibility() {
		return s_possibility;
	}
	public void setS_possibility(int s_possibility) {
		this.s_possibility = s_possibility;
	}
	public int getS_monitor() {
		return s_monitor;
	}
	public void setS_monitor(int s_monitor) {
		this.s_monitor = s_monitor;
	}
	public int getS_amount() {
		return s_amount;
	}
	public void setS_amount(int s_amount) {
		this.s_amount = s_amount;
	}
	public String getC_code() {
		return c_code;
	}
	public void setC_code(String c_code) {
		this.c_code = c_code;
	}
	public String getC_name() {
		return c_name;
	}
	public void setC_name(String c_name) {
		this.c_name = c_name;
	}
	public String getC_boss() {
		return c_boss;
	}
	public void setC_boss(String c_boss) {
		this.c_boss = c_boss;
	}
	public String getC_phone() {
		return c_phone;
	}
	public void setC_phone(String c_phone) {
		this.c_phone = c_phone;
	}
	public String getC_addr() {
		return c_addr;
	}
	public void setC_addr(String c_addr) {
		this.c_addr = c_addr;
	}
	public String getC_opendate() {
		return c_opendate;
	}
	public void setC_opendate(String c_opendate) {
		this.c_opendate = c_opendate;
	}
	public String getC_businesstime() {
		return c_businesstime;
	}
	public void setC_businesstime(String c_businesstime) {
		this.c_businesstime = c_businesstime;
	}
	public int getB_seq() {
		return b_seq;
	}
	public void setB_seq(int b_seq) {
		this.b_seq = b_seq;
	}
	public String getB_subject() {
		return b_subject;
	}
	public void setB_subject(String b_subject) {
		this.b_subject = b_subject;
	}
	public String getB_content() {
		return b_content;
	}
	public void setB_content(String content) {
		this.b_content = b_content;
	}
	public Date getB_date() {
		return b_date;
	}
	public void setB_date(Date b_date) {
		this.b_date = b_date;
	}
	public int getB_hseq() {
		return b_hseq;
	}
	public void setB_hseq(int b_hseq) {
		this.b_hseq = b_hseq;
	}
	public String getM_id() {
		return m_id;
	}
	public void setM_id(String m_id) {
		this.m_id = m_id;
	}
	public String getM_name() {
		return m_name;
	}

	public void setM_name(String m_name) {
		this.m_name = m_name;
	}
	public int getRp_seq() {
		return rp_seq;
	}

	public void setRp_seq(int rp_seq) {
		this.rp_seq = rp_seq;
	}

	public String getRp_content() {
		return rp_content;
	}

	public void setRp_content(String rp_content) {
		this.rp_content = rp_content;
	}

	public Date getRp_date() {
		return rp_date;
	}

	public void setRp_date(Date rp_date) {
		this.rp_date = rp_date;
	}

	public int getRp_group() {
		return rp_group;
	}

	public void setRp_group(int rp_group) {
		this.rp_group = rp_group;
	}

	public int getRp_step() {
		return rp_step;
	}

	public void setRp_step(int rp_step) {
		this.rp_step = rp_step;
	}

	public int getRp_indent() {
		return rp_indent;
	}

	public void setRp_indent(int rp_indent) {
		this.rp_indent = rp_indent;
	}
	public String getRe_starttime() {
		return re_starttime;
	}
	public void setRe_starttime(String re_starttime) {
		this.re_starttime = re_starttime;
	}
	public String getRe_endtime() {
		return re_endtime;
	}
	public void setRe_endtime(String re_endtime) {
		this.re_endtime = re_endtime;
	}
	public int getTotalamount() {
		return totalamount;
	}
	public void setTotalamount(int totalamount) {
		this.totalamount = totalamount;
	}
	public String getRe_code() {
		return re_code;
	}
	public void setRe_code(String re_code) {
		this.re_code = re_code;
	}
	public Date getA_businessdate() {
		return a_businessdate;
	}
	public void setA_businessdate(Date a_businessdate) {
		this.a_businessdate = a_businessdate;
	}
	public int getA_onedayamount() {
		return a_onedayamount;
	}
	public void setA_onedayamount(int a_onedayamount) {
		this.a_onedayamount = a_onedayamount;
	}
	public int getA_reservationcount() {
		return a_reservationcount;
	}
	public void setA_reservationcount(int a_reservationcount) {
		this.a_reservationcount = a_reservationcount;
	}
}


