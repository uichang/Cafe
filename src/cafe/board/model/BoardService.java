package cafe.board.model;

import java.util.ArrayList;

import cafe.DTO;

public class BoardService {
	private static BoardService instance = new BoardService();
	private BoardDAO dao;

	private BoardService() {
		dao = new BoardDAO();
	}

	public static BoardService getInstance() {
		return instance;
	}

	public ArrayList<DTO> selectS() {
		return dao.select();
	}

	public ArrayList<DTO> selectR(int b_seq) {
		return dao.selectR(b_seq);
	}
	
	public void time() {
		dao.time1();
	}
	public void time2() {
		dao.time2();
	}
	public DTO selectS(int b_seq) {
		return dao.select(b_seq);
	}

	public void insertS(DTO dto) {
		dao.insert(dto);
	}

	public void insertR(DTO dto) {
		dao.insertR(dto);
	}

	public void insertR2(DTO dto) {
		dao.insertR2(dto);
	}

	public void deleteS(int b_seq) {
		dao.delete(b_seq);
	}

	public void deleteSR(int rp_seq) {
		dao.deleteR(rp_seq);
	}

	public void updateS(DTO dto) {
		dao.update(dto);
	}

	public void updateD(int cgroup, int step) {
		dao.updateD(cgroup, step);
	}

	public void updateH(int b_seq) {
		dao.updateH(b_seq);
	}

	public int findR(int rp_group) {
		return dao.findR(rp_group);
	}

	public ArrayList<DTO> searchS(String select, String search) {
		return dao.search(select, search);
	}
}