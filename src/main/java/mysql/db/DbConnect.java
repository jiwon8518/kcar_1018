package mysql.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class DbConnect {
	
	static final String MYSQLDRIVER="com.mysql.jdbc.Driver";
	
	static final String MYSQL_URL="jdbc:mysql://localhost:3306/test?serverTimezone=Asia/Seoul";

	//생성자
	public DbConnect() {
		try {
			Class.forName(MYSQLDRIVER);//Class.forName으로 오라클드라이버 로딩
		} catch (ClassNotFoundException e) {
			System.out.println("mysql 드라이버 실패:" + e.getMessage());
		}
	}

	public Connection getConnection() {
		Connection conn = null;
		try {
			//로딩성공되었으니 드라이버 메니저를사용해서 오라클db와 커넥트한다
			conn = DriverManager.getConnection(MYSQL_URL, "root", "1234");
		} catch (SQLException e) {
			System.out.println("mysql 연결 실패:" + e.getMessage());
		}
		//성공시 성공된 커넥션을 리턴해준다
		return conn;

	}
	
	//close 메서드는 총 4개, 오버로딩 메서드
	//ResultSet없음
	public void dbClose(Statement stmt, Connection conn) {
		try {
			if(stmt != null) stmt.close();
			if(conn != null) conn.close();
		} catch (SQLException e) {}
	}
	public void dbClose(PreparedStatement pstmt, Connection conn) {
		try {
			if(pstmt != null) pstmt.close();
			if(conn != null) conn.close();
		} catch (SQLException e) {}
	}
	//ResultSet있음
	public void dbClose(ResultSet rs, Statement stmt, Connection conn) {
		try {
			if(rs != null) rs.close();
			if(stmt != null) stmt.close();
			if(conn != null) conn.close();
		} catch (SQLException e) {}
	}
	public void dbClose(ResultSet rs, PreparedStatement pstmt, Connection conn) {
		try {
			if(rs != null) rs.close();
			if(pstmt != null) pstmt.close();
			if(conn != null) conn.close();
		} catch (SQLException e) {}
	}
	
}
