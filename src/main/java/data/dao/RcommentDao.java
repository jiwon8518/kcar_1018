package data.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.Vector;

import data.dto.RcommentDto;
import mysql.db.DbConnect;

public class RcommentDao {

	DbConnect db = new DbConnect();
	
	// 댓글 추가
	public void insertComment(RcommentDto dto) {
		Connection conn = db.getConnection();
		PreparedStatement pstmt = null;
		
		String sql = "insert into rcomment (num,email,name,content,writeday) values (?,?,?,?,now())";
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, dto.getNum());
			pstmt.setString(2, dto.getEmail());
			pstmt.setString(3, dto.getName());
			pstmt.setString(4, dto.getContent());
			
			pstmt.execute();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			db.dbClose(pstmt, conn);
		}
	}
	
	// 댓글 리스트 반환
	public List<RcommentDto> getAllcomment(String num) { 
		List<RcommentDto> list = new Vector<RcommentDto>();
		
		Connection conn = db.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql = "select * from rcomment where num=? order by idx";
		
		try {
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, num);
			
			rs = pstmt.executeQuery();
			while (rs.next()) {
				RcommentDto dto = new RcommentDto();
				dto.setIdx(rs.getString("idx"));
				dto.setNum(rs.getString("num"));
				dto.setEmail(rs.getString("email"));
				dto.setName(rs.getString("name"));
				dto.setContent(rs.getString("content"));
				dto.setWriteday(rs.getTimestamp("writeday"));
				
				list.add(dto);
			}
				
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			db.dbClose(rs, pstmt, conn);
		}
		return list;
		
	}
	
	// 댓글 삭제
	public void deleteComment(String idx) {
		Connection conn = db.getConnection();
		PreparedStatement pstmt = null;
		
		String sql = "delete from rcomment where idx=?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, idx);
			
			pstmt.execute();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			db.dbClose(pstmt, conn);
		}
	}
	
	// 게시글번호에 대한 댓글 갯수
	public int getCount(String num) {
		
		Connection conn = db.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int n = 0;
		
		String sql = "select count(*) from rcomment where num=?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, num);
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				n = rs.getInt(1);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			db.dbClose(rs, pstmt, conn);
		}
		return n;
	}
	
}
