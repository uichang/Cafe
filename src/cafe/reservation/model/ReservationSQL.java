package cafe.reservation.model;

public class ReservationSQL {
	static final String SQL_IN = "insert into RESERVATION values(?,?,?,?,?,?,?)";
	static final String SQL_CASH = "select s_amount from seminaramount where s_number=?";
	static final String SQL_START = "select TO_CHAR(re_starttime, 'HH24:MI') from reservation where re_starttime between ? and TO_DATE(?)+1 and s_number=? and c_code=?";
	static final String SQL_END = "select TO_CHAR(re_endtime, 'HH24:MI') from reservation where re_endtime between ? and TO_DATE(?)+1 and s_number=? and c_code=?";
	static final String SQL_INTO = "select TO_CHAR(re_starttime, 'HH24:MI'), TO_CHAR(re_endtime, 'HH24:MI'), M_ID from reservation where re_starttime between ? and TO_DATE(?)+1 and s_number=? and c_code=? order by re_starttime, s_number";
	static final String SQL_INTO_U = "select re_code, s_number, TO_CHAR(re_starttime, 'yyyy-mm-ddHH24:MI'), TO_CHAR(re_endtime, 'HH24:MI'), totalamount from reservation where c_code=? and m_id=? order by re_starttime desc, s_number";
	static final String SQL_ONE = "select TOTALAMOUNT from reservation where re_endtime between ? and TO_DATE(?)+1 and c_code=?";
	static final String SQL_DEL_ONE = "delete from amount where A_BUSINESSDATE=? and C_CODE=?";
	static final String SQL_IN_ONE = "insert into AMOUNT values(?,?,?,?)";
	static final String SQL_DEL = "update reservation set RE_CODE='기간만료' where re_endtime<sysdate and c_code=?";
}