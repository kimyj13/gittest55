package Book;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;


import Book.BookBean;





public class BookDAO {

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
		
		public void insertbook(BookBean bb) {
			con = null;
			 ps = null;
			 rs= null;
			int num = 0;
			try {
				con = getConnection();
				String sql="select max(num) from books";
				ps = con.prepareStatement(sql);
				rs = ps.executeQuery();				
				 if(rs.next()) {//MAX해서 가져온 글번호로 커서 이동
					 num = rs.getInt("max(num)")+1; //가져온 글번호 +1해서 num에 저장하기
					 //가져온 값이 null이면 글번호 1이 생성되는거고 1이면 다음 값으로 생성해서 넘기는거고
				 }						 
				sql="insert into books values(?, ?, ?, ?, ?, ?, ?)";
				 ps = con.prepareStatement(sql);
				 ps.setInt(1, num);
				 ps.setString(2, bb.getBnum());
				 ps.setString(3, bb.getBname());
				 ps.setString(4, bb.getWname());
				 ps.setString(5, bb.getBdate());
				 ps.setString(6, bb.getContent());
				 ps.setString(7, bb.getBfile());
				 ps.executeUpdate(); //sql실행		
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
			closeDB();
			}
		}//insertbooks()
		
		public int getbooksCount() {
			con = null;
			ps =null; 
			rs =null;
			int count = 0;
			try {
				con = getConnection();//디비연결
				String sql = "select count(num) from books"; //sql 게시판 글수 세기
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
		}//getbooksCount()
		
		public List<BookBean> getbooksList(int startRow, int pageSize) {//게시판 목록 
			con = null;
			 ps =null; 
			rs =null;
			List<BookBean> booksList = new ArrayList<BookBean>(); //자바 API 배열 형태 자료형 List
			try {
				con = getConnection();
				 
				 //3단계 sql문 
				 String sql="select * from books order by num desc limit ?, ?";
				ps = con.prepareStatement(sql);
				ps.setInt(1, startRow-1);//시작행-1(시작행을 포함하지 않기 때문에 -1을 해준다)
				ps.setInt(2, pageSize);
				 //4단계 결과저장
				 rs = ps.executeQuery();
				 //5단계 rs->booksList 저장
				 while(rs.next()) { //첫행 이동
					 BookBean bb = new BookBean(); //한개의 글을 저장할 객체 생성
					 //한개의 글 객체 생성한 기억장소에 저장
					 bb.setNum(rs.getInt("num"));
					 bb.setBnum(rs.getString("bnum"));
					 bb.setBname(rs.getString("bname"));
					 bb.setWname(rs.getString("wname"));
					 bb.setBdate(rs.getString("bdate"));
					 bb.setBfile(rs.getString("bfile"));
					 bb.setContent(rs.getString("content"));
					 booksList.add(bb);//배열에 한개의 글 정보를 배열 한칸에 저장						 
				 }
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				//마무리작업 //메모리 사용 후 회수하는 작업
				closeDB();
			}
			return booksList;
		}//getbooksList()
		
//		public void updateReadcount(int num) {
//			con = null;
//			ps =null; 
//			BookBean bb = new BookBean();
//			try {
//				con = getConnection();
//				//3단계 sql문
//				//조회수 증가(update구문 : update     set      readcount=readcount + 1)로 sql 구문 작성하기
//				String sql = "update books set readcount =readcount+1 where num=?";
//				ps = con.prepareStatement(sql);
//				ps.setInt(1, num);
//				//4단계
//				ps.executeUpdate();
//			} catch (Exception e) {
//				e.printStackTrace();
//			}finally {		
//				//마무리작업 //메모리 사용 후 회수하는 작업
//				closeDB();
//			}
//		}//updateReadcount(int num)
		
		public BookBean getbook(int num) {
			con = null;
			ps =null; 
			rs =null;
			BookBean bb = new BookBean();
			try {
				con = getConnection();
				//3단계 sql문
				String sql = "select * from books where num=?";
				ps = con.prepareStatement(sql);
				ps.setInt(1, num);//받아온 세션값을 sql에 입력해 조회
				//4단계실행
				rs = ps.executeQuery(); //실행결과를 rs저장
				 while(rs.next()) { //첫행 이동
					 bb.setNum(rs.getInt("num"));
					 bb.setBnum(rs.getString("bnum"));
					 bb.setBname(rs.getString("bname"));
					 bb.setWname(rs.getString("wname"));
					 bb.setBdate(rs.getString("bdate"));
					 bb.setBfile(rs.getString("bfile"));
					 bb.setContent(rs.getString("content"));			 
				 }
			} catch (Exception e) {
				e.printStackTrace();
			}finally {		
				//마무리작업 //메모리 사용 후 회수하는 작업
				closeDB();
			}
			return bb;	
		} //getboard(int num)
		
		public int getBookCount(String search) {
			con = null;
			ps =null; 
			 rs =null;
			int count = 0;
			try {
				con = getConnection();//디비연결
				String sql = "select count(*) from books where bname like ?"; //sql 게시판 글수 세기
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
		
		public int getBookbnum(String bnum) {
			con = null;
			ps =null; 
			 rs =null;
			int count = 0;
			try {
				con = getConnection();//디비연결
				String sql = "select count(*) from books where bnum like ?"; //sql 게시판 글수 세기
				ps = con.prepareStatement(sql);
				ps.setString(1, "%"+bnum+"%");
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
		
		public List<BookBean> getBookList(int startRow, int pageSize, String search) {
			 con = null;
			 ps =null; 
			rs =null;
			List<BookBean> BookList = new ArrayList<BookBean>(); //자바 API 배열 형태 자료형 List
			try {
				con = getConnection();
				 
				 //3단계 sql문 
				 String sql="select * from Books where bname like ? order by num desc limit ?, ?";		
				ps = con.prepareStatement(sql);
				ps.setString(1, "%"+search+"%");
				ps.setInt(2, startRow-1);//시작행-1(시작행을 포함하지 않기 때문에 -1을 해준다)
				ps.setInt(3, pageSize);

				 //4단계 결과저장
				 rs = ps.executeQuery();
				 //5단계 rs->BookList 저장
				 while(rs.next()) { //첫행 이동
					 BookBean bb = new BookBean(); //한개의 글을 저장할 객체 생성
					 //한개의 글 객체 생성한 기억장소에 저장
					 
					 bb.setNum(rs.getInt("num"));
					 bb.setBnum(rs.getString("bnum"));
					 bb.setBname(rs.getString("bname"));
					 bb.setWname(rs.getString("wname"));
					 bb.setBdate(rs.getString("bdate"));
					 bb.setBfile(rs.getString("bfile"));
					 bb.setContent(rs.getString("content"));	

					 BookList.add(bb);//배열에 한개의 글 정보를 배열 한칸에 저장		
					 
				 }
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				//마무리작업 //메모리 사용 후 회수하는 작업
				closeDB();
			}
			return BookList;
		}
		
		
		public List<BookBean> getBookBnumList(int startRow, int pageSize, String bnum) {
			 con = null;
			 ps =null; 
			rs =null;
			List<BookBean> BookList = new ArrayList<BookBean>(); //자바 API 배열 형태 자료형 List
			try {
				con = getConnection();
				 
				 //3단계 sql문 
				 String sql="select * from Books where bnum like ? order by num desc limit ?, ?";		
				ps = con.prepareStatement(sql);
				ps.setString(1, "%"+bnum+"%");
				ps.setInt(2, startRow-1);//시작행-1(시작행을 포함하지 않기 때문에 -1을 해준다)
				ps.setInt(3, pageSize);

				 //4단계 결과저장
				 rs = ps.executeQuery();
				 //5단계 rs->BookList 저장
				 while(rs.next()) { //첫행 이동
					 BookBean bb = new BookBean(); //한개의 글을 저장할 객체 생성
					 //한개의 글 객체 생성한 기억장소에 저장
					 
					 bb.setNum(rs.getInt("num"));
					 bb.setBnum(rs.getString("bnum"));
					 bb.setBname(rs.getString("bname"));
					 bb.setWname(rs.getString("wname"));
					 bb.setBdate(rs.getString("bdate"));
					 bb.setBfile(rs.getString("bfile"));
					 bb.setContent(rs.getString("content"));	

					 BookList.add(bb);//배열에 한개의 글 정보를 배열 한칸에 저장		
					 
				 }
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				//마무리작업 //메모리 사용 후 회수하는 작업
				closeDB();
			}
			return BookList;
		}
		
		public List<BookBean> getBookBdateList(int startRow, int pageSize) {
			 con = null;
			 ps =null; 
			rs =null;
			List<BookBean> BookList = new ArrayList<BookBean>(); //자바 API 배열 형태 자료형 List
			try {
				con = getConnection();
				 
				 //3단계 sql문 
				 String sql="select * from Books order by STR_TO_DATE(bdate, '%m/%d/%Y')  desc limit ?, ?";		
				ps = con.prepareStatement(sql);

				ps.setInt(1, startRow-1);//시작행-1(시작행을 포함하지 않기 때문에 -1을 해준다)
				ps.setInt(2, pageSize);

				 //4단계 결과저장
				 rs = ps.executeQuery();
				 //5단계 rs->BookList 저장
				 while(rs.next()) { //첫행 이동
					 BookBean bb = new BookBean(); //한개의 글을 저장할 객체 생성
					 //한개의 글 객체 생성한 기억장소에 저장
					 bb.setNum(rs.getInt("num"));
					 bb.setBnum(rs.getString("bnum"));
					 bb.setBname(rs.getString("bname"));
					 bb.setWname(rs.getString("wname"));
					 bb.setBdate(rs.getString("bdate"));
					 bb.setBfile(rs.getString("bfile"));

					 BookList.add(bb);//배열에 한개의 글 정보를 배열 한칸에 저장		
					 
				 }
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				//마무리작업 //메모리 사용 후 회수하는 작업
				closeDB();
			}
			return BookList;
		}
}
