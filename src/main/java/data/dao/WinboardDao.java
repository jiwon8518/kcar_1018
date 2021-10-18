package data.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.Vector;

import data.dto.EventDto;
import data.dto.WinboardDto;
import mysql.db.DbConnect;

public class WinboardDao {
	DbConnect db = new DbConnect();

	//insert
	public void insertWinboard(WinboardDto dto)
	{
		Connection conn = db.getConnection();
		PreparedStatement pstmt = null;

		String sql = "insert into winboard (writer,subject,content,writeday) values (?,?,?,now())";

		try {
			pstmt = conn.prepareStatement(sql);

			//바인딩
			pstmt.setString(1,dto.getWriter());
			pstmt.setString(2,dto.getSubject());
			pstmt.setString(3,dto.getContent());

			//실행
			pstmt.execute();

		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			db.dbClose(pstmt, conn);
		}

	}

	//전체 개수
	public int getTotalCount()
	{
		int n = 0;

		Connection conn = db.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select count(*) from winboard";

		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next())
				n = rs.getInt(1); //열번호로 가져오기 첫번째가 1번임


		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			db.dbClose(rs,pstmt, conn);
		}

		return n;
	}

	//페이지에서 필요한 만큼만 리턴
	public List<WinboardDto> getList(int start,int perpage)
	{
		List<WinboardDto> list = new Vector<WinboardDto>();

		Connection conn = db.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select * from winboard order by num desc limit ?,?";

		try {
			pstmt = conn.prepareStatement(sql);
			//바인딩
			pstmt.setInt(1, start);
			pstmt.setInt(2, perpage);

			rs = pstmt.executeQuery();

			while(rs.next())
			{
				WinboardDto dto = new WinboardDto();
				dto.setNum(rs.getString("num"));
				dto.setWriter(rs.getString("writer"));
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setReadcount(rs.getInt("readcount"));
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


	//num에 해당하는 dto 반환
	public WinboardDto getData(String num)
	{
		WinboardDto dto = new WinboardDto();

		Connection conn = db.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select * from winboard where num=?";

		try {
			pstmt = conn.prepareStatement(sql);
			//바인딩
			pstmt.setString(1, num);
			rs = pstmt.executeQuery();
			if(rs.next())
			{
				dto.setNum(rs.getString("num"));
				dto.setWriter(rs.getString("writer"));
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setReadcount(rs.getInt("readcount"));
				dto.setWriteday(rs.getTimestamp("writeday"));
			}

		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			db.dbClose(rs,pstmt, conn);
		}

		return dto;
	}

	
	//조회수 증가
	public void	updateReadcount(String num)
	{
		Connection conn = db.getConnection();
		PreparedStatement pstmt = null;
		String sql = "update winboard set readcount = readcount+1 where num = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			//바인딩
			pstmt.setString(1,num);
			//실행
			pstmt.execute();
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			db.dbClose(pstmt, conn);
		}

	}
	
	
	//방금 추가된 최종 시퀀스 num 값 리턴
	public String getMaxNum()
	{

		Connection conn = db.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select max(num) from winboard";
		String num = "";
		try {
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			if(rs.next())
			{
				num=rs.getString(1);
			}

		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			db.dbClose(rs,pstmt, conn);
		}

		return num;
	}

	public void	updateWin(WinboardDto dto)
	{
		Connection conn = db.getConnection();
		PreparedStatement pstmt = null;

		String sql = "update winboard set subject=?, content=? where num=?";

		try {
			pstmt = conn.prepareStatement(sql);

			//바인딩
			pstmt.setString(1,dto.getSubject());
			pstmt.setString(2,dto.getContent());
			pstmt.setString(3,dto.getNum());

			//실행
			pstmt.execute();

		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			db.dbClose(pstmt, conn);
		}

	}
	
	//삭제
	public void	deleteWin(String num)
	{
		Connection conn = db.getConnection();
		PreparedStatement pstmt = null;

		String sql = "delete from winboard where num=?";

		try {
			pstmt = conn.prepareStatement(sql);
			//바인딩
			pstmt.setString(1,num);
			//실행
			pstmt.execute();

		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			db.dbClose(pstmt, conn);
		}

	}
	
	


}



























