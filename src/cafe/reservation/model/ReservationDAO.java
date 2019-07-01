package cafe.reservation.model;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import cafe.DTO;

public class ReservationDAO {
	DataSource ds;

	ReservationDAO() {
		try {
			Context initContext = new InitialContext();
			Context envContext = (Context) initContext.lookup("java:/comp/env");
			ds = (DataSource) envContext.lookup("jdbc/myoracle");
		} catch (NamingException ne) {
		}
	}

	void insert(DTO dto) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(ReservationSQL.SQL_IN);
			pstmt.setInt(1, dto.getS_number());
			pstmt.setString(2, dto.getRe_starttime());
			pstmt.setString(3, dto.getRe_endtime());
			pstmt.setString(4, dto.getM_id());
			pstmt.setString(5, dto.getC_code());
			pstmt.setString(6, dto.getRe_code());
			pstmt.setInt(7, dto.getTotalamount());
			pstmt.executeUpdate();
		} catch (SQLException se) {
			System.out.println("sql_에러");
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

	int cash(long useTime, int s_number) {
		ResultSet rs = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(ReservationSQL.SQL_CASH);
			pstmt.setInt(1, s_number);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getInt(1);
			}
			return -1;
		} catch (SQLException se) {
			System.out.println("sql 에러");
			return -1;
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

	ArrayList<String> start(Date cal, int s_number, String c_code) {
		ResultSet rs = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ArrayList<String> list = new ArrayList<String>();
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(ReservationSQL.SQL_START);
			pstmt.setDate(1, cal);
			pstmt.setDate(2, cal);
			pstmt.setInt(3, s_number);
			pstmt.setString(4, c_code);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				list.add(rs.getString(1));
			}
			return list;
		} catch (SQLException se) {
			System.out.println("start : " + se);
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

	ArrayList<String> end(Date cal, int s_number, String c_code) {
		ResultSet rs = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ArrayList<String> list = new ArrayList<String>();
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(ReservationSQL.SQL_END);
			pstmt.setDate(1, cal);
			pstmt.setDate(2, cal);
			pstmt.setInt(3, s_number);
			pstmt.setString(4, c_code);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				list.add(rs.getString(1));
			}
			return list;
		} catch (SQLException se) {
			System.out.println("end : " + se);
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

	ArrayList<DTO> into(String c_code, Date cal, int s_number) {
		ResultSet rs = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ArrayList<DTO> list = new ArrayList<DTO>();
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(ReservationSQL.SQL_INTO);
			pstmt.setDate(1, cal);
			pstmt.setDate(2, cal);
			pstmt.setInt(3, s_number);
			pstmt.setString(4, c_code);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				String re_starttime = rs.getString(1);
				String re_endtime = rs.getString(2);
				String m_id = rs.getString(3);
				DTO dto = new DTO(s_number, re_starttime, re_endtime, m_id, c_code, null, -1);
				list.add(dto);
			}
			return list;
		} catch (SQLException se) {
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

	ArrayList<DTO> intoU(String c_code, String m_id) {
		ResultSet rs = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ArrayList<DTO> list = new ArrayList<DTO>();
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(ReservationSQL.SQL_INTO_U);
			pstmt.setString(1, c_code);
			pstmt.setString(2, m_id);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				String re_code = rs.getString(1);
				int s_number = rs.getInt(2);
				String re_starttime = rs.getString(3);
				String re_endtime = rs.getString(4);
				int totalamount = rs.getInt(5);
				DTO dto = new DTO(s_number, re_starttime, re_endtime, m_id, c_code, re_code, totalamount);
				list.add(dto);
			}
			return list;
		} catch (SQLException se) {
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

	ArrayList<Integer> oneday(Date cal, String c_code) {
		ResultSet rs = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ArrayList<Integer> list = new ArrayList<Integer>();
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(ReservationSQL.SQL_ONE);
			pstmt.setDate(1, cal);
			pstmt.setDate(2, cal);
			pstmt.setString(3, c_code);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				list.add(rs.getInt(1));
			}
			return list;
		} catch (SQLException se) {
			System.out.println("end : " + se);
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

	void deleteOne(DTO dto) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(ReservationSQL.SQL_DEL_ONE);
			pstmt.setDate(1, dto.getA_businessdate());
			pstmt.setString(2, dto.getC_code());
			pstmt.executeQuery();
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

	void insertOne(DTO dto) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(ReservationSQL.SQL_IN_ONE);
			pstmt.setDate(1, dto.getA_businessdate());
			pstmt.setString(2, dto.getC_code());
			pstmt.setInt(3, dto.getA_onedayamount());
			pstmt.setInt(4, dto.getA_reservationcount());
			pstmt.executeQuery();
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

	void delete(String c_code) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(ReservationSQL.SQL_DEL);
			pstmt.setString(1, c_code);
			pstmt.executeUpdate();
		} catch (SQLException se) {
			System.out.println("sql_에러");
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
}