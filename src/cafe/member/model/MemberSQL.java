package cafe.member.model;

public class MemberSQL {
	static final String SQL_IN = "insert into MEMBER values(?,?,?,?,?,?,?,SYSDATE,0,'B')";
	static final String SQL_ID = "select * from MEMBER where C_CODE=? and  M_ID=?";
	static final String SQL_ALL = "select * from MEMBER where C_CODE=?";
	static final String SQL_LE = "delete from MEMBER where C_CODE=? and  M_ID=?";
	static final String SQL_COM = "select * from MEMBER where c_code=? and M_ID=? and M_PW=?";
	static final String SQL_DEL = "delete from MEMBER where C_CODE=? and  M_ID=?";
	static final String SQL_UP = "update MEMBER set M_NAME=?, M_ADDR=?, M_PHONE=?, M_SEX=?, M_POINT=? where C_CODE=? and  M_ID=?";
	static final String SQL_UP_C = "update MEMBER set M_PW=?,  M_NAME=?, M_PHONE=?, M_ADDR=?, M_SEX=? where C_CODE=? and  M_ID=?";
	static final String SQL_POINT = "update MEMBER set M_POINT=M_POINT+? where C_CODE=? and  M_ID=?";
}
