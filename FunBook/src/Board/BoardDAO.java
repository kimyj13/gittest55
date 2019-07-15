package Board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;




public class BoardDAO {
Connection con;
PreparedStatement ps;
ResultSet rs;
	public Connection getConnection() throws Exception{
		Context init = new InitialContext();
		DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MysqlDB");
		con = ds.getConnection();
		return con;
	}//getConnection()
	
	public void closeDB() {
		if(rs != null) try {rs.close();}catch(SQLException ex){}
		if(ps != null)try {ps.close();}catch (SQLException ex) {}
		if(con != null)try {con.close();} catch (SQLException ex) {}
	}// closeDB() 
	
	public void insertBoard(BoardBean bb) {
		con = null;
		 ps = null;
		rs= null;
		int num = 0;
		try {
			con = getConnection();
			String sql="select max(num) from board";
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();
			
			 if(rs.next()) {//MAX해서 가져온 글번호로 커서 이동
				 num = rs.getInt("max(num)")+1; //가져온 글번호 +1해서 num에 저장하기
				 //가져온 값이 null이면 글번호 1이 생성되는거고 1이면 다음 값으로 생성해서 넘기는거고
			 }
			 
			sql="insert into board(num, name, pass, subject, content, readcount, date, file)"
					+ " values(?, ?, ?, ?, ?, ?, now(),?)";
			 ps = con.prepareStatement(sql);
			 ps.setInt(1, num);//글번호 값은 위에서 생성하는 식을 따로 작성했음
			 ps.setString(2, bb.getName());
			 ps.setString(3, bb.getPass());
			 ps.setString(4, bb.getSubject());
			 ps.setString(5, bb.getContent());
			 ps.setInt(6, 0);//readcount
			 ps.setString(7, bb.getFile());
			 ps.executeUpdate(); //sql실행		
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
		closeDB();
		}
	}//insertBoard()
	
	public int getBoardCount() {
		con = null;
		ps =null; 
		rs =null;
		int count = 0;
		try {
			con = getConnection();//디비연결
			String sql = "select count(num) from board"; //sql 게시판 글수 세기
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();// sql실행
			rs.next();//커서 다음행 이동 //위에서처럼 if문 사용해서 해도 되고 안해도 되고 알아서~
			count = rs.getInt("count(num)"); //개수 가져오기
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		return count;
	}//getBoardCount()
	
	public int getBoardCount(String search) {
		con = null;
		ps =null; 
		 rs =null;
		int count = 0;
		try {
			con = getConnection();//디비연결
			String sql = "select count(*) from board where subject like ?"; //sql 게시판 글수 세기
			ps = con.prepareStatement(sql);
			ps.setString(1, "%"+search+"%");
			rs = ps.executeQuery();// sql실행
			rs.next();//커서 다음행 이동 //위에서처럼 if문 사용해서 해도 되고 안해도 되고 알아서~
			count = rs.getInt("count(*)"); //개수 가져오기
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		return count;	
	}
	
	public List<BoardBean> getBoardList(int startRow, int pageSize) {//게시판 목록 
		con = null;
		 ps =null; 
		rs =null;
		List<BoardBean> boardList = new ArrayList<BoardBean>(); //자바 API 배열 형태 자료형 List
		try {
			con = getConnection();
			 
			 //3단계 sql문 
			 String sql="select * from board order by num desc limit ?, ?";
			ps = con.prepareStatement(sql);
			ps.setInt(1, startRow-1);//시작행-1(시작행을 포함하지 않기 때문에 -1을 해준다)
			ps.setInt(2, pageSize);
			 //4단계 결과저장
			 rs = ps.executeQuery();
			 //5단계 rs->boardList 저장
			 while(rs.next()) { //첫행 이동
				 BoardBean bb = new BoardBean(); //한개의 글을 저장할 객체 생성
				 //한개의 글 객체 생성한 기억장소에 저장
				 bb.setNum(rs.getInt("num"));
				 bb.setSubject(rs.getString("subject"));
				 bb.setName(rs.getString("name"));
				 bb.setReadcount(rs.getInt("readcount"));
				 bb.setDate(rs.getDate("date"));
				 bb.setFile(rs.getString("file"));
				 boardList.add(bb);//배열에 한개의 글 정보를 배열 한칸에 저장						 
			 }
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			//마무리작업 //메모리 사용 후 회수하는 작업
			closeDB();
		}
		return boardList;
	}//getboardList()
	
	public List<BoardBean> getBoardList(int startRow, int pageSize, String search) {
		 con = null;
		 ps =null; 
		rs =null;
		List<BoardBean> boardList = new ArrayList<BoardBean>(); //자바 API 배열 형태 자료형 List
		try {
			con = getConnection();
			 
			 //3단계 sql문 
			 String sql="select * from board where subject like ? order by num desc limit ?, ?";		
			ps = con.prepareStatement(sql);
			ps.setString(1, "%"+search+"%");
			ps.setInt(2, startRow-1);//시작행-1(시작행을 포함하지 않기 때문에 -1을 해준다)
			ps.setInt(3, pageSize);

			 //4단계 결과저장
			 rs = ps.executeQuery();
			 //5단계 rs->boardList 저장
			 while(rs.next()) { //첫행 이동
				 BoardBean bb = new BoardBean(); //한개의 글을 저장할 객체 생성
				 //한개의 글 객체 생성한 기억장소에 저장
				 bb.setNum(rs.getInt("num"));
				 bb.setSubject(rs.getString("subject"));
				 bb.setName(rs.getString("name"));
				 bb.setReadcount(rs.getInt("readcount"));
				 bb.setDate(rs.getDate("date"));
				 boardList.add(bb);//배열에 한개의 글 정보를 배열 한칸에 저장		
				 
			 }
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			//마무리작업 //메모리 사용 후 회수하는 작업
			closeDB();
		}
		return boardList;
	}

	public void updateReadcount(int num) {
		con = null;
		ps =null; 
		BoardBean bb = new BoardBean();
		try {
			con = getConnection();
			//3단계 sql문
			//조회수 증가(update구문 : update     set      readcount=readcount + 1)로 sql 구문 작성하기
			String sql = "update board set readcount =readcount+1 where num=?";
			ps = con.prepareStatement(sql);
			ps.setInt(1, num);
			//4단계
			ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {		
			//마무리작업 //메모리 사용 후 회수하는 작업
			closeDB();
		}
	}//updateReadcount(int num)
	
	public BoardBean getboard(int num) {
		con = null;
		ps =null; 
		rs =null;
		BoardBean bb = new BoardBean();
		try {
			con = getConnection();
			//3단계 sql문
			String sql = "select * from board where num=?";
			ps = con.prepareStatement(sql);
			ps.setInt(1, num);//받아온 세션값을 sql에 입력해 조회
			//4단계실행
			rs = ps.executeQuery(); //실행결과를 rs저장
			while(rs.next()) {
			bb.setNum(rs.getInt("num"));
			bb.setReadcount(rs.getInt("readcount"));
			bb.setName(rs.getString("name"));
			bb.setDate(rs.getDate("date"));
			bb.setSubject(rs.getString("subject"));
			bb.setContent(rs.getString("content"));
			bb.setFile(rs.getString("file"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {		
			//마무리작업 //메모리 사용 후 회수하는 작업
			closeDB();
		}
		return bb;	
	} //getboard(int num)
	
	public int  numCheck(int num, String pass) {
		int check = -1;
		con = null;
		 ps = null;
		rs = null; 
		
		try {
		con=getConnection();
		String sql="select * from board where num=?";
		ps = con.prepareStatement(sql);
		ps.setInt(1, num);
		rs = ps.executeQuery();	
		if(rs.next()) {
			if(pass.equals(rs.getString("pass"))) {
			return check=1;
				}else {
					return check = 0;
				}
			}else {
				return check=-1;
		}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			closeDB();
			}
		return check;
		}//numCheck
	
	public void updateBoard(BoardBean bb) {
		 con = null;
		ps =null; 
		try {
			con = getConnection();			
			String sql = "update board set name=?, subject=?, content=?, file=? where num=? ";
			ps = con.prepareStatement(sql);
			ps.setString(1, bb.getName());
			ps.setString(2, bb.getSubject());
			ps.setString(3, bb.getContent());
			ps.setString(4, bb.getFile());
			ps.setInt(5, bb.getNum());
			ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			closeDB();
		}
	} //updateBoard(BoardBean bb)
	
	public void deleteBoard(BoardBean bb) {
		con = null;
		ps = null;	
		try {
			con = getConnection();
			String sql = "delete from board where num=?";
			ps = con.prepareStatement(sql);
			ps.setInt(1, bb.getNum());
			ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			closeDB();
		}	
	} //deleteBoard
	
	public void commentBoard(BoardBean bb) {
		con = null;
		ps = null;
		rs=null;
		int num = bb.getNum();
		int conum = 0;
		
		try {			
			con = getConnection();	
			String sql="select max(conum) from comments";
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();		
			 if(rs.next()) {//MAX해서 가져온 글번호로 커서 이동
				 conum = rs.getInt("max(conum)")+1; //가져온 글번호 +1해서 num에 저장하기
				 //가져온 값이 null이면 글번호 1이 생성되는거고 1이면 다음 값으로 생성해서 넘기는거고
			 }
			
			sql  ="insert into comments (num, id, comment, conum, co_date) values(?, ?,?, ?, now())";
			ps = con.prepareStatement(sql);
			ps.setInt(1, num);
			ps.setString(2, bb.getName());
			ps.setString(3, bb.getComment());
			ps.setInt(4, conum);
			ps.executeUpdate();					
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			closeDB();
		}
	} //commentBoard(BoardBean bb)

	public List<BoardBean> getcomment(int num) {
		con = null;
		ps =null; 
		rs =null;
		List<BoardBean> boardList = new ArrayList<BoardBean>();
		try {
			con = getConnection();
			//3단계 sql문
			String sql = "select * from comments where num=?";
			ps = con.prepareStatement(sql);
			ps.setInt(1, num);
			//4단계실행
			rs = ps.executeQuery(); //실행결과를 rs저장
			while(rs.next()) {
				BoardBean bb = new BoardBean();
				bb.setNum(rs.getInt("num"));
				bb.setName(rs.getString("id"));
				bb.setComment(rs.getString("comment"));
				bb.setConum(rs.getInt("conum"));
				bb.setCo_cate(rs.getDate("co_date"));
				boardList.add(bb);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {		
			//마무리작업 //메모리 사용 후 회수하는 작업
			closeDB();
		}
		return boardList;
	} //getboard(int num)
	
	public void deleteComment(BoardBean bb) {
		con = null;
		ps = null;
	
		try {
			con =getConnection();
			String sql = "delete from comments where num=? AND conum=?";
			ps = con.prepareStatement(sql);
			ps.setInt(1, bb.getNum());
			ps.setInt(2, bb.getConum());
			ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			closeDB();
		}	
	}//deleteComment(BoardBean bb) 
	
	public int couserCheck(String id,  int conum) {
		int check= -1;

		try {
			con = getConnection();
			String sql = "select * from comments where id=? AND conum=?";
			ps = con.prepareStatement(sql);
			ps.setString(1, id);
			ps.setInt(2, conum);
			rs = ps.executeQuery();
			if(rs.next()) {
				check = 1;
			}	
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			closeDB();
		}
		return check;
	}//couserCheck(String id)
	
	
	
	
}
