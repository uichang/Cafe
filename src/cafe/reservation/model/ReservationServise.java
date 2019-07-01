package cafe.reservation.model;

import java.sql.Date;
import java.sql.Timestamp;
import java.util.ArrayList;

import cafe.DTO;
import cafe.MemberDTO;

public class ReservationServise {
	private static ReservationServise instance = new ReservationServise();
	private ReservationDAO dao;

	private ReservationServise() {
		dao = new ReservationDAO();
	}

	public static ReservationServise getInstance() {
		return instance;
	}

	public void insertS(DTO dto) {
		dao.insert(dto);
	}

	public int cash(long useTime, int s_number) {
		return dao.cash(useTime, s_number);
	}

	public ArrayList<String> start(Date cal, int s_number, String c_code) {
		return dao.start(cal, s_number, c_code);
	}

	public ArrayList<String> end(Date cal, int s_number, String c_code) {
		return dao.end(cal, s_number, c_code);
	}

	public ArrayList<Integer> oneday(Date cal, String c_code) {
		return dao.oneday(cal, c_code);
	}

	public ArrayList<DTO> into(String c_code, Date cal, int s_number) {
		return dao.into(c_code, cal, s_number);
	}

	public ArrayList<DTO> intoU(String c_code, String m_id) {
		return dao.intoU(c_code, m_id);
	}

	public void deleteOne(DTO dto) {
		dao.deleteOne(dto);
	}

	public void insertOne(DTO dto) {
		dao.insertOne(dto);
	}

	public void delete(String c_code) {
		dao.delete(c_code);
	}
}
