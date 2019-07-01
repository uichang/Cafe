package cafe.member.model;

import java.sql.*;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import cafe.MemberDTO;
import cafe.DTO;

import cafe.MemberDTO;

public class MemberDAO {
	DataSource ds;

	MemberDAO() {
		try {
			Context initContext = new InitialContext();
			Context envContext = (Context) initContext.lookup("java:/comp/env");
			ds = (DataSource) envContext.lookup("jdbc/myoracle");
		} catch (NamingException ne) {
		}
	}

	void insert(MemberDTO dto) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(MemberSQL.SQL_IN);
			pstmt.setString(1, dto.getC_code());
			pstmt.setString(2, dto.getM_id());
			pstmt.setString(3, dto.getM_pw());
			pstmt.setString(4, dto.getM_name());
			pstmt.setString(5, dto.getM_addr());
			pstmt.setString(6, dto.getM_phone());
			pstmt.setString(7, dto.getM_sex());
			pstmt.executeUpdate();
		} catch (SQLException se) {
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
				if (con != null)
					con.close();
			} catch (SQLException se) {
			}
		}
	}

	void delete(String c_code, String m_id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(MemberSQL.SQL_DEL);
			pstmt.setString(1, c_code);
			pstmt.setString(2, m_id);
			pstmt.executeUpdate();
		} catch (SQLException se) {
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
				if (con != null)
					con.close();
			} catch (SQLException se) {
			}
		}
	}

	void update(MemberDTO dto) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(MemberSQL.SQL_UP);
			pstmt.setString(1, dto.getM_name());
			pstmt.setString(2, dto.getM_addr());
			pstmt.setString(3, dto.getM_phone());
			pstmt.setString(4, dto.getM_sex());
			pstmt.setInt(5, dto.getM_point());
			pstmt.setString(6, dto.getC_code());
			pstmt.setString(7, dto.getM_id());
			pstmt.executeUpdate();
		} catch (SQLException se) {
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
				if (con != null)
					con.close();
			} catch (SQLException se) {
			}
		}
	}

	void updateP(MemberDTO dto, int point) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(MemberSQL.SQL_POINT);
			pstmt.setInt(1, point);
			pstmt.setString(2, dto.getC_code());
			pstmt.setString(3, dto.getM_id());
			pstmt.executeUpdate();
		} catch (SQLException se) {
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
				if (con != null)
					con.close();
			} catch (SQLException se) {
			}
		}
	}

	void updateC(MemberDTO dto) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(MemberSQL.SQL_UP_C);
			pstmt.setString(1, dto.getM_pw());
			pstmt.setString(2, dto.getM_name());
			pstmt.setString(3, dto.getM_phone());
			pstmt.setString(4, dto.getM_addr());
			pstmt.setString(5, dto.getM_sex());
			pstmt.setString(6, dto.getC_code());
			pstmt.setString(7, dto.getM_id());
			pstmt.executeUpdate();
		} catch (SQLException se) {
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
				if (con != null)
					con.close();
			} catch (SQLException se) {
			}
		}
	}

	MemberDTO compare(String c_code, String id, String pw) {
		ResultSet rs = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(MemberSQL.SQL_COM);
			pstmt.setString(1, c_code);
			pstmt.setString(2, id);
			pstmt.setString(3, pw);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				String m_name = rs.getString(4);
				String m_addr = rs.getString(5);
				String m_phone = rs.getString(6);
				String m_sex = rs.getString(7);
				java.sql.Date m_joindate = rs.getDate(8);
				int m_point = rs.getInt(9);
				String m_grade = rs.getString(10);
				MemberDTO dto = new MemberDTO(c_code, id, null, m_name, m_addr, m_phone, m_sex, m_joindate, m_point,
						m_grade);
				return dto;
			}
			return null;
		} catch (SQLException se) {
			System.out.println("sql 에러");
			return null;
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (con != null)
					con.close();
			} catch (SQLException se) {
			}
		}
	}

	String searchPW(String c_code, String m_id) {
		ResultSet rs = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(MemberSQL.SQL_ID);
			pstmt.setString(1, c_code);
			pstmt.setString(2, m_id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getString("M_PW");
			}
			return null;
		} catch (SQLException se) {
			System.out.println("sql 에러");
			return null;
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (con != null)
					con.close();
			} catch (SQLException se) {
			}
		}
	}

	MemberDTO selectS(String c_code, String m_id) {
		ResultSet rs = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(MemberSQL.SQL_ID);
			pstmt.setString(1, c_code);
			pstmt.setString(2, m_id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				String m_name = rs.getString(4);
				String m_addr = rs.getString(5);
				String m_phone = rs.getString(6);
				String m_sex = rs.getString(7);
				Date m_joindate = rs.getDate(8);
				int m_point = rs.getInt(9);
				String m_grade = rs.getString(10);
				MemberDTO dto = new MemberDTO(c_code, m_id, null, m_name, m_addr, m_phone, m_sex, m_joindate, m_point,
						m_grade);
				return dto;
			}
			return null;
		} catch (SQLException se) {
			System.out.println("sql 에러");
			return null;
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (con != null)
					con.close();
			} catch (SQLException se) {
			}
		}
	}

	void leave(String c_code, String m_id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(MemberSQL.SQL_LE);
			pstmt.setString(1, c_code);
			pstmt.setString(2, m_id);
			pstmt.executeUpdate();
		} catch (SQLException se) {
			System.out.println("sql 에러");
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
				if (con != null)
					con.close();
			} catch (SQLException se) {
			}
		}
	}

	ArrayList<MemberDTO> selectAll(String c_code) {
		ArrayList<MemberDTO> list = new ArrayList<MemberDTO>();
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		Connection con = null;
		String m_id = null, m_grade = null;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(MemberSQL.SQL_ALL);
			pstmt.setString(1, c_code);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				m_id = rs.getString(2);
				m_grade = rs.getString(10);
				MemberDTO dto = new MemberDTO(c_code, m_id, null, null, null, null, null, null, -1, m_grade);
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