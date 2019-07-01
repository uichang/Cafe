package cafe.board.model;

import java.sql.*;
import java.util.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import cafe.DTO;

class BoardDAO {
	DataSource ds;

	BoardDAO() {
		try {
			Context initContext = new InitialContext();
			Context envContext = (Context) initContext.lookup("java:/comp/env");
			ds = (DataSource) envContext.lookup("jdbc/myoracle");
		} catch (NamingException ne) {
		}
	}

	ArrayList<DTO> select() {
		ArrayList<DTO> list = new ArrayList<DTO>();
		ResultSet rs = null;
		Statement stmt = null;
		Connection con = null;
		ResultSet rs2 = null;
		PreparedStatement pstmt= null;
		Connection con2 = null;
		try {
			con = ds.getConnection();
			stmt = con.createStatement();
			rs = stmt.executeQuery(BoardSQL.SQL_SE1);
			while (rs.next()) {
				int b_seq = rs.getInt(1);
				String b_subject = rs.getString(2);
				String b_content = rs.getString(3);
				java.sql.Date b_date = rs.getDate(4);
				String b_time = rs.getString(5);
				int b_hseq = rs.getInt(6);
				String c_code = rs.getString(7);
				DTO dto = new DTO(b_seq, b_subject, b_content, b_date, b_time, b_hseq, c_code);
				list.add(dto);
			}
			return list;
		} catch (SQLException se) {
			return null;
		} finally {
			try {
				if (rs2 != null)
					rs2.close();
				if (pstmt != null)
					pstmt.close();
				if (con2 != null)
					con2.close();
				if (rs != null)
					rs.close();
				if (stmt != null)
					stmt.close();
				if (con != null)
					con.close();
			} catch (Exception e) {
			}
		}
	}

	ArrayList<DTO> selectR(int b_seq) {
		ArrayList<DTO> list = new ArrayList<DTO>();
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		Connection con = null;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(BoardSQL.SQL_SE_RE);
			pstmt.setInt(1, b_seq);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				int rp_seq = rs.getInt(1);
				String c_code = rs.getString(2);
				String m_id = rs.getString(3);
				String rp_content = rs.getString(5);
				java.sql.Date rp_date = rs.getDate(6);
				int rp_group = rs.getInt(7);
				int rp_step = rs.getInt(8);
				int rp_indent = rs.getInt(9);
				DTO dto = new DTO(rp_seq, c_code, m_id, b_seq, rp_content, rp_date, rp_group, rp_step, rp_indent);
				list.add(dto);
			}
			return list;
		} catch (SQLException se) {
			return null;
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
				if (rs != null)
					rs.close();
				if (con != null)
					con.close();
			} catch (Exception e) {
			}
		}
	}

	DTO select(int b_seq) {
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		Connection con = null;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(BoardSQL.SQL_SE2);
			pstmt.setInt(1, b_seq);
			rs = pstmt.executeQuery();
			rs.next();
			String b_subject = rs.getString(2);
			String b_content = rs.getString(3);
			java.sql.Date b_date = rs.getDate(4);
			String b_time = rs.getString(5);
			int b_hseq = rs.getInt(6);
			String c_code = rs.getString(7);
			DTO dto = new DTO(b_seq, b_subject, b_content, b_date, b_time, b_hseq, c_code);
			return dto;
		} catch (SQLException se) {
			return null;
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
				if (rs != null)
					rs.close();
				if (con != null)
					con.close();
			} catch (Exception e) {
			}
		}
	}

	void insert(DTO dto) {
		PreparedStatement pstmt = null;
		Connection con = null;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(BoardSQL.SQL_IN1);
			pstmt.setString(1, dto.getB_subject());
			pstmt.setString(2, dto.getB_content());
			pstmt.setString(3, dto.getC_code());
			pstmt.executeUpdate();
		} catch (SQLException se) {
			System.out.println(se);
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
				if (con != null)
					con.close();
			} catch (Exception e) {
			}
		}
	}

	void insertR(DTO dto) {
		PreparedStatement pstmt = null;
		Connection con = null;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(BoardSQL.SQL_IN_RE1);
			pstmt.setString(1, dto.getC_code());
			pstmt.setString(2, dto.getM_id());
			pstmt.setInt(3, dto.getB_seq());
			pstmt.setString(4, dto.getRp_content());
			pstmt.executeUpdate();
		} catch (SQLException se) {
			System.out.println(se);
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
				if (con != null)
					con.close();
			} catch (Exception e) {
			}
		}
	}

	void insertR2(DTO dto) {
		PreparedStatement pstmt = null;
		Connection con = null;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(BoardSQL.SQL_IN_RE2);
			pstmt.setString(1, dto.getC_code());
			pstmt.setString(2, dto.getM_id());
			pstmt.setInt(3, dto.getB_seq());
			pstmt.setString(4, dto.getRp_content());
			pstmt.setInt(5, dto.getRp_group());
			pstmt.setInt(6, dto.getRp_step());
			pstmt.executeUpdate();
		} catch (SQLException se) {
			System.out.println(se);
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
				if (con != null)
					con.close();
			} catch (Exception e) {
			}
		}
	}

	void delete(int b_seq) {
		PreparedStatement pstmt = null;
		Connection con = null;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(BoardSQL.SQL_DE1);
			pstmt.setInt(1, b_seq);
			pstmt.executeUpdate();
		} catch (SQLException se) {
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
				if (con != null)
					con.close();
			} catch (Exception e) {
			}
		}
	}

	void deleteR(int rp_seq) {
		PreparedStatement pstmt = null;
		Connection con = null;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(BoardSQL.SQL_DEL_RE);
			pstmt.setInt(1, rp_seq);
			pstmt.executeUpdate();
		} catch (SQLException se) {
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
				if (con != null)
					con.close();
			} catch (Exception e) {
			}
		}
	}

	void update(DTO dto) {
		PreparedStatement pstmt = null;
		Connection con = null;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(BoardSQL.SQL_UP);
			pstmt.setString(1, dto.getB_subject());
			pstmt.setString(2, dto.getB_content());
			pstmt.setInt(3, dto.getB_seq());
			pstmt.executeUpdate();
		} catch (SQLException se) {
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
				if (con != null)
					con.close();
			} catch (Exception e) {
			}
		}
	}

	void updateD(int cgroup, int step) {
		PreparedStatement pstmt = null;
		Connection con = null;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(BoardSQL.SQL_UP);
			pstmt.setInt(1, cgroup);
			pstmt.setInt(2, step);
			pstmt.executeUpdate();
		} catch (SQLException se) {
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
				if (con != null)
					con.close();
			} catch (Exception e) {
			}
		}
	}
	void time1() {
		Statement stmt = null;
		Connection con = null;
		try {
			con = ds.getConnection();
			stmt = con.createStatement();
			stmt.executeUpdate(BoardSQL.SQL_UP_T1);
		} catch (SQLException se) {
		} finally {
			try {
				if (stmt != null)
					stmt.close();
				if (con != null)
					con.close();
			} catch (Exception e) {
			}
		}
	}
	void time2() {
		Statement stmt = null;
		Connection con = null;
		try {
			con = ds.getConnection();
			stmt = con.createStatement();
			stmt.executeUpdate(BoardSQL.SQL_UP_T2);
		} catch (SQLException se) {
		} finally {
			try {
				if (stmt != null)
					stmt.close();
				if (con != null)
					con.close();
			} catch (Exception e) {
			}
		}
	}

	void updateH(int b_seq) {
		PreparedStatement pstmt = null;
		Connection con = null;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(BoardSQL.SQL_UP2);
			pstmt.setInt(1, b_seq);;
			pstmt.executeUpdate();
		} catch (SQLException se) {
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
				if (con != null)
					con.close();
			} catch (Exception e) {
			}
		}
	}

	int findR(int rp_group) {
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		Connection con = null;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(BoardSQL.SQL_FR);
			pstmt.setInt(1, rp_group);
			rs = pstmt.executeQuery();
			rs.next();
			return rs.getInt(1);
		} catch (SQLException se) {
			return -1;
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
				if (rs != null)
					rs.close();
				if (con != null)
					con.close();
			} catch (Exception e) {
			}
		}
	}

	ArrayList<DTO> search(String select, String search) {
		ArrayList<DTO> list = new ArrayList<DTO>();
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		Connection con = null;
		try {
			con = ds.getConnection();
			if (select.equals("subject")) {
				pstmt = con.prepareStatement(BoardSQL.SQL_CH1);
			} else if (select.equals("content")) {
				pstmt = con.prepareStatement(BoardSQL.SQL_CH2);
			} else if (select.equals("mix")) {
				pstmt = con.prepareStatement(BoardSQL.SQL_CH3);
				pstmt.setString(2, search);
			}
			pstmt.setString(1, search);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				int b_seq = rs.getInt(1);
				String b_subject = rs.getString(2);
				String b_content = rs.getString(3);
				java.sql.Date b_date = rs.getDate(4);
				String b_time = rs.getString(5);
				int b_hseq = rs.getInt(6);
				String c_code = rs.getString(7);
				DTO dto = new DTO(b_seq, b_subject, b_content, b_date, b_time, b_hseq, c_code);
				list.add(dto);
			}
			return list;
		} catch (SQLException se) {
			return null;
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
				if (rs != null)
					rs.close();
				if (con != null)
					con.close();
			} catch (Exception e) {
			}
		}
	}
}
