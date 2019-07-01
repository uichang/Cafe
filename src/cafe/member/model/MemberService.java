package cafe.member.model;

import java.util.ArrayList;

import cafe.DTO;
import cafe.MemberDTO;

public class MemberService {
	private static MemberService instance = new MemberService();
	private MemberDAO dao;

	private MemberService() {
		dao = new MemberDAO();
	}

	public static MemberService getInstance() {
		return instance;
	}

	public void insertS(MemberDTO dto) {
		dao.insert(dto);
	}

	public ArrayList<MemberDTO> selectAll(String c_code) {
		return dao.selectAll(c_code);
	}

	public MemberDTO selectSS(String c_code, String m_id) {
		return dao.selectS(c_code, m_id);
	}

	public MemberDTO compareS(String c_code, String id, String pw) {
		return dao.compare(c_code, id, pw);
	}

	public String searchPW(String c_code, String m_id) {
		return dao.searchPW(c_code, m_id);
	}

	public void leaveS(String c_code, String m_id) {
		dao.leave(c_code, m_id);
	}

	public void deleteS(String c_code, String m_id) {
		dao.delete(c_code, m_id);
	}

	public void updateS(MemberDTO dto) {
		dao.update(dto);
	}

	public void updateP(MemberDTO login, int point) {
		dao.updateP(login, point);
	}

	public void updateC(MemberDTO dto) {
		dao.updateC(dto);
	}
}
