package cafe;
import java.sql.*;

public class MemberDTO {
	private String c_code;
	private String m_id;
	private String m_pw;
	private String m_name;
	private String m_addr;
	private String m_phone;
	private String m_sex;
	private Date m_joindate;
	private int m_point;
	private String m_grade;
	
	
	public MemberDTO() {}
	public MemberDTO(String c_code, String m_id, String m_pw, String m_name, String m_addr, String m_phone,
			String m_sex, Date m_joindate, int m_point, String m_grade) {
		this.c_code = c_code;
		this.m_id = m_id;
		this.m_pw = m_pw;
		this.m_name = m_name;
		this.m_addr = m_addr;
		this.m_phone = m_phone;
		this.m_sex = m_sex;
		this.m_joindate = m_joindate;
		this.m_point = m_point;
		this.m_grade = m_grade;
	}
	public String getC_code() {
		return c_code;
	}
	public void setC_code(String c_code) {
		this.c_code = c_code;
	}
	public String getM_id() {
		return m_id;
	}
	public void setM_id(String m_id) {
		this.m_id = m_id;
	}
	public String getM_pw() {
		return m_pw;
	}
	public void setM_pw(String m_pw) {
		this.m_pw = m_pw;
	}
	public String getM_name() {
		return m_name;
	}
	public void setM_name(String m_name) {
		this.m_name = m_name;
	}
	public String getM_addr() {
		return m_addr;
	}
	public void setM_addr(String m_addr) {
		this.m_addr = m_addr;
	}
	public String getM_phone() {
		return m_phone;
	}
	public void setM_phone(String m_phone) {
		this.m_phone = m_phone;
	}
	public String getM_sex() {
		return m_sex;
	}
	public void setM_sex(String m_sex) {
		this.m_sex = m_sex;
	}
	public Date getM_joindate() {
		return m_joindate;
	}
	public void setM_joindate(Date m_joindate) {
		this.m_joindate = m_joindate;
	}
	public int getM_point() {
		return m_point;
	}
	public void setM_point(int m_point) {
		this.m_point = m_point;
	}
	public String getM_grade() {
		return m_grade;
	}
	public void setM_grade(String m_grade) {
		this.m_grade = m_grade;
	}
}
