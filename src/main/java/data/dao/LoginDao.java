package data.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;

import data.dto.LoginDto;
import mysql.db.DbConnect;

public class LoginDao {
	DbConnect db = new DbConnect();
	//CREATE
	
	//회원등록
	public boolean insertUser(LoginDto dto) {
		boolean check = false;
		Connection conn = db.getConnection();
		PreparedStatement ps = null;
		String sql = "insert into usertest ( pw, name, email, postcode, addr1, addr2, mobile1, mobile2, mobile3, registerday) values ( ?, ?, ?, ?, ?, ?, ?, ?, ?,  now())";
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, dto.getPw());
			ps.setString(2, dto.getName());
			ps.setString(3, dto.getEmail());
			ps.setString(4, dto.getPostcode());
			ps.setString(5, dto.getAddr1());
			ps.setString(6, dto.getAddr2());
			ps.setString(7, dto.getMobile1());
			ps.setString(8, dto.getMobile2());
			ps.setString(9, dto.getMobile3());
			int num = ps.executeUpdate();
			if(num != 0) {
				check = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			db.dbClose(ps, conn);
		}
		return check;
	}
		
		
	
	
	//READ
	
	//유저정보 체크
	public boolean userInfoCheck(int number, String data) {
		//찾고싶은 데이터의 종류  1 name, 2 email, 3 pw
		
		//그 데이터에 맞는 값을 입력 data
		
		boolean sameUserInfo =false;
		Connection conn = db.getConnection();
		PreparedStatement ps = null;
		ResultSet rs = null;
		String sql = "";
		switch (number) {
		case 1:
			sql = "select * from usertest where name = ?";
			break;
		case 2:
			sql = "select * from usertest where email = ?";
			break;
		case 3:
			sql = "select * from usertest where pw = ?";
			break;
		}
		try {
			ps = conn.prepareStatement(sql);
			//바인딩
			ps.setString(1, data);
			//실행
			rs = ps.executeQuery();
			if(rs.next()) {
				sameUserInfo = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			db.dbClose(rs, ps, conn);
		}
		
		return sameUserInfo;
	}
	
	//유저정보 얻기
	public LoginDto getUserInfo(int number, String data) {
		//찾고싶은 데이터의 종류  1 name, 2 email, 3 pw
		
		//그 데이터에 맞는 값을 입력 data
		Connection conn = db.getConnection();
		LoginDto dto = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		String sql = "";
		switch (number) {
		case 1:
			sql = "select * from usertest where name = ?";
			break;
		case 2:
			sql = "select * from usertest where email = ?";
			break;
		case 3:
			sql = "select * from usertest where pw = ?";
			break;
		}
		try {
			ps = conn.prepareStatement(sql);
			//바인딩
			ps.setString(1, data);
			//실행
			rs = ps.executeQuery();
			if(rs.next()) {
				String num = rs.getString("num");
				String pw = rs.getString("pw");
				String email = rs.getString("email");
				String name = rs.getString("name");
				String postcode = rs.getString("postcode");
				String addr1 = rs.getString("addr1");
				String addr2 = rs.getString("addr2");
				String mobile1 = rs.getString("mobile1");
				String mobile2 = rs.getString("mobile2");
				String mobile3 = rs.getString("mobile3");
				Timestamp registerday = rs.getTimestamp("registerday");
				dto = new LoginDto(num, pw, email, name, postcode, addr1, addr2, mobile1, mobile2, mobile3, registerday);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			db.dbClose(rs, ps, conn);
		}
		
		return dto;
	}
	
	
	//비밀번호체크
	public String getPw(String email) {
		String pw = "";
		Connection conn = db.getConnection();
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		String sql = "select pw from usertest where email = ?";
		try {
			ps = conn.prepareStatement(sql);
			//바인딩
			ps.setString(1, email);
			//실행
			rs = ps.executeQuery();
			if(rs.next()) {
				pw = rs.getString("pw");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			db.dbClose(rs, ps, conn);
		}
		
		return pw;
	}
	
	
	
	
	//UPDATE
	
	//회원정보 수정
	public boolean updateMember(String postcode, String addr1, String addr2, String mobile1, String mobile2, String mobile3,String name, String email ) {
		boolean check = false;
		Connection conn = db.getConnection();
		PreparedStatement ps = null;
		String sql = "update usertest set postcode = ?, addr1 = ?, addr2 = ?, mobile1 = ?, mobile2 = ?, mobile3 = ?, name = ?  where email = ?";
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, postcode);
			ps.setString(2, addr1);
			ps.setString(3, addr2);
			ps.setString(4, mobile1);
			ps.setString(5, mobile2);
			ps.setString(6, mobile3);
			ps.setString(7, name);
			ps.setString(8, email);
			int num = ps.executeUpdate();
			if(num != 0) {
				check = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			db.dbClose(ps, conn);
		}
		
		return check;
		
	}
	
	//비밀번호변경
	public boolean updatePw(String email, String pw) {
		boolean check = false;
		Connection conn = db.getConnection();
		PreparedStatement ps = null;
		String sql = "update usertest set pw = ? where email = ?";
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, pw);
			ps.setString(2, email);
			int num = ps.executeUpdate();
			if(num != 0) {
				check = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			db.dbClose(ps, conn);
		}
		
		return check;
		
	}
	
	
	
	
	//DELETE
	public boolean deleteMember(String email) {
		Connection conn = db.getConnection();
		PreparedStatement ps = null;
		int num = 0;
		String sql = "delete from usertest where email = ?";
		boolean check = false;
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, email);
			num = ps.executeUpdate();
			if(num!=0) {
				check = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			db.dbClose(ps, conn);
		}
		return check;
	}
	
	

}
