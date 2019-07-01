package cafe.board.model;

public class BoardSQL {
	static final String SQL_SE1 = "select * from BOARD order by B_SEQ desc";
	static final String SQL_UP_T1 = "update board set b_time=TO_CHAR(b_date, 'HH24:MI') where TO_DATE(b_date,'yyyy/MM/dd') = TO_DATE(sysdate,'yyyy/MM/dd')";
	static final String SQL_UP_T2 = "update board set b_time=null where TO_DATE(b_date,'yyyy/MM/dd') != TO_DATE(sysdate,'yyyy/MM/dd')";
	static final String SQL_IN1 = "insert into BOARD values(BOARD_WSEQ.nextval,?,?,SYSDATE,null,0,?)";
	static final String SQL_UP = "update BOARD set B_SUBJECT=?, B_CONTENT=? where B_SEQ=?";
	static final String SQL_UP2 = "update BOARD set B_HSEQ=B_HSEQ+1 where b_seq=?";
	static final String SQL_SE2 = "select * from BOARD where B_SEQ=?";
	static final String SQL_DE1 = "delete from BOARD where B_SEQ=?";
	static final String SQL_SE_RE = "select * from REPLY where B_SEQ=? order by RP_GROUP, RP_STEP, RP_INDENT";
	static final String SQL_JO = "select m_name from reply natural join member where c_code=? and m_id=?";
	static final String SQL_IN_RE1 = "insert into REPLY values(REPLY_WSEQ.nextval,?,?,?,?,SYSDATE,REPLY_GSEQ.nextval,0,0)";
	static final String SQL_DEL_RE = "delete from REPLY where RP_SEQ=?";
	static final String SQL_IN_RE2 = "insert into REPLY values(REPLY_WSEQ.nextval,?,?,?,?,SYSDATE,?,?,1)";
	static final String SQL_FR = "select MAX(RP_STEP) from REPLY where RP_GROUP=? and RP_INDENT=1";
	static final String SQL_CH1 = "select * from BOARD where B_SUBJECT like '%' || ? || '%' order by B_SEQ desc";
	static final String SQL_CH2 = "select * from BOARD where B_CONTENT like '%' || ? || '%' order by B_SEQ desc";
	static final String SQL_CH3 = "select * from BOARD where B_CONTENT like '%' || ? || '%' or B_SUBJECT like '%' || ? || '%' order by B_SEQ desc";
}
