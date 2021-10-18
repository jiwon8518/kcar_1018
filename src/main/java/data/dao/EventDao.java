package data.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.Vector;

import data.dto.EventDto;
import mysql.db.DbConnect;

public class EventDao {

	DbConnect db=new DbConnect();

	//insert
	public void insertEvent(EventDto dto)	
	{
		Connection conn=db.getConnection();
		PreparedStatement pstmt=null;
		String sql="insert into event (writer,subject,content,photoname,writeday) values (?,?,?,?,now())";

		try {
			pstmt=conn.prepareStatement(sql);
			//바인딩
			pstmt.setString(1, dto.getWriter());
			pstmt.setString(2, dto.getSubject());
			pstmt.setString(3, dto.getContent());
			pstmt.setString(4, dto.getPhotoname());
			//실행
			pstmt.execute();

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.dbClose(pstmt, conn);
		}
	}



	//전체 갯수
	public int getTotalCount()
	{
		int n=0;
		Connection conn=db.getConnection();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql="select count(*) from event";

		try {
			pstmt=conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			if(rs.next())
				n=rs.getInt(1);

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.dbClose(rs,pstmt, conn);
		}
		return n;
	}



	//페이지에서 필요한 만큼만 리턴
	public List<EventDto> getList(int start,int perpage)
	{
		List<EventDto> list=new Vector<EventDto>();
		Connection conn=db.getConnection();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql="select * from event order by num desc limit ?,?";

		try {
			pstmt=conn.prepareStatement(sql);
			//바인딩
			pstmt.setInt(1, start);
			pstmt.setInt(2, perpage);
			rs=pstmt.executeQuery();
			while(rs.next())
			{
				EventDto dto=new EventDto();
				dto.setNum(rs.getString("num"));
				dto.setWriter(rs.getString("writer"));
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setPhotoname(rs.getString("photoname"));
				dto.setReadcount(rs.getInt("readcount"));
				dto.setWriteday(rs.getTimestamp("writeday"));
				//list 에 추가
				list.add(dto);
			}			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.dbClose(rs,pstmt, conn);
		}
		return list;
	}
	
	//리스트 전체 출력
	public List<EventDto> List()
	{
		List<EventDto> list=new Vector<EventDto>();
		Connection conn=db.getConnection();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql="select * from event order by num desc";

		try {
			pstmt=conn.prepareStatement(sql);
			//바인딩
			rs=pstmt.executeQuery();
			while(rs.next())
			{
				EventDto dto=new EventDto();
				dto.setNum(rs.getString("num"));
				dto.setWriter(rs.getString("writer"));
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setPhotoname(rs.getString("photoname"));
				dto.setReadcount(rs.getInt("readcount"));
				dto.setWriteday(rs.getTimestamp("writeday"));
				//list 에 추가
				list.add(dto);
			}			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.dbClose(rs,pstmt, conn);
		}
		return list;
	}


	//num 에 해당하는 dto 반환
	public EventDto getData(String num)
	{
		EventDto dto=new EventDto();
		Connection conn=db.getConnection();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql="select * from event where num=?";

		try {
			pstmt=conn.prepareStatement(sql);
			//바인딩
			pstmt.setString(1, num);
			rs=pstmt.executeQuery();
			if(rs.next())
			{				
				dto.setNum(rs.getString("num"));
				dto.setWriter(rs.getString("writer"));
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setPhotoname(rs.getString("photoname"));
				dto.setReadcount(rs.getInt("readcount"));
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


	//조회수 증가
	public void updateReadcount(String num)
	{
		Connection conn=db.getConnection();
		PreparedStatement pstmt=null;
		String sql="update event set readcount=readcount+1 where num=?";

		try {
			pstmt=conn.prepareStatement(sql);
			//바인딩
			pstmt.setString(1,num);			
			//실행
			pstmt.execute();

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.dbClose(pstmt, conn);
		}
	}

	//방금 추가된 최종 시퀀스 num 값 리턴
	public String getMaxNum()
	{
		EventDto dto=new EventDto();
		Connection conn=db.getConnection();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql="select max(num) from event";
		String num="";
		try {
			pstmt=conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			if(rs.next())
			{			
				num=rs.getString(1);
			}			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.dbClose(rs,pstmt, conn);
		}
		return num;
	}
	
	//수정하기
		public void	updateEvent(EventDto dto)
		{
			Connection conn = db.getConnection();
			PreparedStatement pstmt = null;

			String sql = "update event set subject=?, content=?, photoname=? where num=?";

			try {
				pstmt = conn.prepareStatement(sql);

				//바인딩
				pstmt.setString(1,dto.getSubject());
				pstmt.setString(2,dto.getContent());
				pstmt.setString(3,dto.getPhotoname());
				pstmt.setString(4,dto.getNum());

				//실행
				pstmt.execute();

			}catch(SQLException e) {
				e.printStackTrace();
			}finally {
				db.dbClose(pstmt, conn);
			}

		}
	//	SELECT * FROM event WHERE num > 3 ORDER BY num ASC LIMIT 1;  

	//	SELECT * FROM event WHERE num < 23 ORDER BY num DESC LIMIT 1;

		//삭제
		public void	deleteEvent(String num)
		{
			Connection conn = db.getConnection();
			PreparedStatement pstmt = null;

			String sql = "delete from event where num=?";

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
		
		//이전글
		public EventDto getPre(String num)
		{
			EventDto dto=new EventDto();
			Connection conn=db.getConnection();
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			String sql="SELECT * FROM event WHERE num < ? ORDER BY num DESC LIMIT 1";

			try {
				pstmt=conn.prepareStatement(sql);
				//바인딩
				pstmt.setString(1, num);
				rs=pstmt.executeQuery();
				if(rs.next())
				{				
					dto.setNum(rs.getString("num"));
					dto.setWriter(rs.getString("writer"));
					dto.setSubject(rs.getString("subject"));
					dto.setContent(rs.getString("content"));
					dto.setPhotoname(rs.getString("photoname"));
					dto.setReadcount(rs.getInt("readcount"));
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
		
		//다음글
		public EventDto getNext(String num)
		{
			EventDto dto=new EventDto();
			Connection conn=db.getConnection();
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			String sql="SELECT * FROM event WHERE num > ? ORDER BY num ASC LIMIT 1"; 

			try {
				pstmt=conn.prepareStatement(sql);
				//바인딩
				pstmt.setString(1, num);
				rs=pstmt.executeQuery();
				if(rs.next())
				{				
					dto.setNum(rs.getString("num"));
					dto.setWriter(rs.getString("writer"));
					dto.setSubject(rs.getString("subject"));
					dto.setContent(rs.getString("content"));
					dto.setPhotoname(rs.getString("photoname"));
					dto.setReadcount(rs.getInt("readcount"));
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
	
}

