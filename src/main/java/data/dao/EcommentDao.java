package data.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.Vector;

import data.dto.EcommentDto;
import data.dto.EventDto;
import mysql.db.DbConnect;

public class EcommentDao {

		
	DbConnect db = new DbConnect();
		
		public void insertEcomment(EcommentDto dto)
		{
			Connection conn = db.getConnection();
			PreparedStatement pstmt = null;

			String sql = "insert into ecomment (num,myid,content,writeday) values (?,?,?,now())";

			try {
				pstmt = conn.prepareStatement(sql);

				//바인딩
				pstmt.setString(1,dto.getNum());
				pstmt.setString(2,dto.getMyid());
				pstmt.setString(3,dto.getContent());

				//실행
				pstmt.execute();

			}catch(SQLException e) {
				e.printStackTrace();
			}finally {
				db.dbClose(pstmt, conn);
			}

		}
		
		public boolean eCheck(String id) {
			
			boolean ec =false;
			Connection conn = db.getConnection();
			PreparedStatement ps = null;
			ResultSet rs = null;
			String sql = "select * from ecomment where name = ?";
			
			try {
				ps = conn.prepareStatement(sql);
				ps.setString(1, id);
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
		
		//페이지에서 필요한 만큼만 리턴
		public List<EcommentDto> getList(int start,int perpage)
		{
			List<EcommentDto> list=new Vector<EcommentDto>();
			Connection conn=db.getConnection();
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			String sql="select * from ecomment order by num desc limit ?,?";

			try {
				pstmt=conn.prepareStatement(sql);
				//바인딩
				pstmt.setInt(1, start);
				pstmt.setInt(2, perpage);
				rs=pstmt.executeQuery();
				while(rs.next())
				{
					EcommentDto dto=new EcommentDto();
					dto.setIdx(rs.getString("idx"));
					dto.setNum(rs.getString("num"));
					dto.setContent(rs.getString("content"));
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
		public EcommentDto getData(String idx)
		{
			EcommentDto dto=new EcommentDto();
			Connection conn=db.getConnection();
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			String sql="select * from ecomment where idx=?";

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
		
		//num 에 해당하는 id 반환
	public EcommentDto getName(String idx)
	{
		EcommentDto dto=new EcommentDto();
		Connection conn=db.getConnection();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql="select myid from ecomment where idx=?";
		
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
	//전체 갯수
	public int getTotalCount()
	{
		int n=0;
		Connection conn=db.getConnection();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql="select count(*) from ecomment";

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


		public List<EcommentDto> getAllEcomment(String num)
		{
			List<EcommentDto> list = new Vector<EcommentDto>(); 
			
			Connection conn = db.getConnection();
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = "select * from ecomment where num=? order by idx";

			try {
				pstmt = conn.prepareStatement(sql);
				//바인딩
				pstmt.setString(1, num);

				rs = pstmt.executeQuery();

				while(rs.next())
				{
					EcommentDto dto = new EcommentDto();
					dto.setIdx(rs.getString("idx"));
					dto.setNum(rs.getString("num"));
					dto.setMyid(rs.getString("myid"));
					dto.setContent(rs.getString("content"));
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
		
		public void deleteEcomment(String idx)
		{
			Connection conn = db.getConnection();
			PreparedStatement pstmt = null;
			String sql = "delete from ecomment where idx=?";

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
		
		public void	updateEcomment(EcommentDto dto)
		{
			Connection conn = db.getConnection();
			PreparedStatement pstmt = null;

			String sql = "update ecomment set content=? where idx=?";

			try {
				pstmt = conn.prepareStatement(sql);

				//바인딩
				pstmt.setString(1,dto.getContent());
				pstmt.setString(2,dto.getIdx());

				//실행
				pstmt.execute();

			}catch(SQLException e) {
				e.printStackTrace();
			}finally {
				db.dbClose(pstmt, conn);
			}

		}


	}
