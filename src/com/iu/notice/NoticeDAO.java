package com.iu.notice;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import com.iu.util.DBConnect;

public class NoticeDAO {
	
	public int totalCount() throws Exception {
		Connection con = DBConnect.getConnect();
		String sql ="select count(num) from notice";
		PreparedStatement st = con.prepareStatement(sql);
		ResultSet rs = st.executeQuery();
		rs.next();
		int result = rs.getInt(1);
		DBConnect.disConnect(con, st, rs);
		return result;
	}
	
/*	public static void main(String[] args) throws Exception {
		NoticeDAO noticeDAO = new NoticeDAO();
		for(int i=0; i<100; i++) {
			NoticeDTO noticeDTO = new NoticeDTO();
			noticeDTO.setTitle("a"+i);
			noticeDTO.setContents("contents"+i);
			noticeDTO.setWriter("wr"+i);
			noticeDAO.noticeInsert(noticeDTO);
		}
	}*/
	
	public ArrayList<NoticeDTO> noticeSelectList(int startRow, int lastRow, String kind, String search) throws Exception {
		ArrayList<NoticeDTO> ar = new ArrayList<NoticeDTO>();
		Connection con = DBConnect.getConnect();
		String sql = "select * from "
				+ " (select rownum r, n.* from "
				+ " (select num, title, contents, writer, reg_date, hit from notice where "+ kind + " like ? ) n ) "
				+ " where r between ? and ? ";
		PreparedStatement st = con.prepareStatement(sql);
		st.setString(1, "%"+search+"%");
		st.setInt(2, startRow);
		st.setInt(3, lastRow);
		ResultSet rs = st.executeQuery();
		while(rs.next()) {
			NoticeDTO noticeDTO = new NoticeDTO();
			noticeDTO.setNum(rs.getInt("num"));
			noticeDTO.setTitle(rs.getString("title"));
			noticeDTO.setWriter(rs.getString("writer"));
			noticeDTO.setReg_date(rs.getString("reg_date"));
			noticeDTO.setHit(rs.getInt("hit"));
			ar.add(noticeDTO);
		}
		DBConnect.disConnect(con, st, rs);
		return ar;
	}
	
	public int noticeInsert(NoticeDTO noticeDTO) throws Exception {
		Connection con = DBConnect.getConnect();
		String sql = "insert into notice values (notice_seq.nextval, ?, ?, ?, sysdate, 1)";
		PreparedStatement st = con.prepareStatement(sql);
		st.setString(1, noticeDTO.getTitle());
		st.setString(2, noticeDTO.getContents());
		st.setString(3, noticeDTO.getWriter());
		int result = st.executeUpdate();
		DBConnect.disConnect(con, st);
		return result;
	}

}
