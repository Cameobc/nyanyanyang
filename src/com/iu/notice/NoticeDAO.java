package com.iu.notice;

import java.sql.Connection;
import java.sql.PreparedStatement;

import com.iu.util.DBConnect;

public class NoticeDAO {
	public static void main(String[] args) throws Exception {
		NoticeDAO noticeDAO = new NoticeDAO();
		for(int i=0; i<100; i++) {
			NoticeDTO noticeDTO = new NoticeDTO();
			noticeDTO.setTitle("a"+i);
			noticeDTO.setContents("contents"+i);
			noticeDTO.setWriter("wr"+i);
			noticeDAO.noticeInsert(noticeDTO);
		}
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
