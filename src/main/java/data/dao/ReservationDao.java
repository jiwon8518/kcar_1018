package data.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;
import java.util.Vector;

import data.dto.ReservationDto;
import mysql.db.DbConnect;

public class ReservationDao {

	DbConnect db = new DbConnect();
	
	public void insertData(ReservationDto dto) {
		Connection conn = db.getConnection();
		PreparedStatement pstmt = null;
		String sql="insert into reservation (name,carname,addr1,addr2,postcode,pw) values (?,?,?,?,?,?)";
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			//바인딩
			pstmt.setString(1, dto.getName());
			pstmt.setString(2, dto.getCarname());
			pstmt.setString(3, dto.getAddr1());
			pstmt.setString(4, dto.getAddr2());
			pstmt.setString(5, dto.getPostcode());
			pstmt.setString(6, dto.getPw());
			
			pstmt.execute();
		} catch (Exception e) {
			// TODO: handle exception
		}finally {
			db.dbClose(pstmt, conn);
		}
	}
	
	public List<ReservationDto> getList(String name,String pass){
		List<ReservationDto> list = new Vector<ReservationDto>();		
		Connection conn = db.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select * from reservation where name=? and pw=?";
		
		
		try {
			pstmt=conn.prepareStatement(sql);
			//바인딩
			pstmt.setString(1, name);
			pstmt.setString(2, pass);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ReservationDto dto = new ReservationDto();
				dto.setNum("num");
				dto.setName("name");
				dto.setCarname("carname");
				dto.setAddr1("addr1");
				dto.setAddr2("addr2");
				dto.setPostcode("postcode");
				
				list.add(dto);
			}
		} catch (Exception e) {
			// TODO: handle exception
		}finally {
			db.dbClose(rs, pstmt, conn);
		}
		
		
		return list;
	}
}
