package data.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.Vector;

import data.dto.EpartiDto;
import mysql.db.DbConnect;

public class EpartiDao {
	
DbConnect db = new DbConnect();
	
	public void insertEparti(EpartiDto dto)
	{
		Connection conn = db.getConnection();
		PreparedStatement pstmt = null;

		String sql = "insert into eparti (num,myid,writeday) values (?,?,now())";

		try {
			pstmt = conn.prepareStatement(sql);

			//바인딩
			pstmt.setString(1,dto.getNum());
			pstmt.setString(2,dto.getMyid());

			//실행
			pstmt.execute();

		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			db.dbClose(pstmt, conn);
		}

	}
	
	public boolean eCheck(String id,String num) {
		
		boolean ec =false;
		Connection conn = db.getConnection();
		PreparedStatement ps = null;
		ResultSet rs = null;
		String sql = "select * from eparti where myid = ? and num = ?";
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, id);
			ps.setString(2, num);
			rs = ps.executeQuery();
			if(rs.next()) {
				ec = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			db.dbClose(rs, ps, conn);
		}
		
		return ec;
	}
	
	//num 에 해당하는 dto 반환
	public EpartiDto getData(String idx)
	{
		EpartiDto dto=new EpartiDto();
		Connection conn=db.getConnection();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql="select * from eparti where idx=?";

		try {
			pstmt=conn.prepareStatement(sql);
			//바인딩
			pstmt.setString(1, idx);
			rs=pstmt.executeQuery();
			if(rs.next())
			{				
				dto.setIdx(rs.getString("idx"));
				dto.setMyid(rs.getString("myid"));
				dto.setWriteday(rs.getTimestamp("writeday"));			
			}			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.dbClose(rs,pstmt, conn);
		}
		return dto;
	}

	public List<EpartiDto> getAllEparti(String num)
	{
		List<EpartiDto> list = new Vector<EpartiDto>(); 
		
		Connection conn = db.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select * from eparti where num=? order by idx";

		try {
			pstmt = conn.prepareStatement(sql);
			//바인딩
			pstmt.setString(1, num);

			rs = pstmt.executeQuery();

			while(rs.next())
			{
				EpartiDto dto = new EpartiDto();
				dto.setIdx(rs.getString("idx"));
				dto.setNum(rs.getString("num"));
				dto.setMyid(rs.getString("myid"));
				dto.setWriteday(rs.getTimestamp("writeday"));
				//list에 추가
				list.add(dto);
			}

		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			db.dbClose(rs,pstmt, conn);
		}
		return list;
	}
	
	public void deleteEparti(String idx)
	{
		Connection conn = db.getConnection();
		PreparedStatement pstmt = null;
		String sql = "delete from eparti where idx=?";

		try {
			pstmt = conn.prepareStatement(sql);

			//바인딩
			pstmt.setString(1,idx);

			//실행
			pstmt.execute();

		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			db.dbClose(pstmt, conn);
		}
	}
	
	


}
