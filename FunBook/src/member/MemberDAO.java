package member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class MemberDAO {
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
		
	
	public void insertMember(MemberBean mb) {
		con = null;
		ps =null; 
		rs =null;
		try {
			con = getConnection();
			
			String sql = "insert into member(id, pass, name, reg_date, email, address, phone, mobile) "
					+ "values(?, ?, ?, ?, ?, ?, ?, ?)";
			ps = con.prepareStatement(sql);
			ps.setString(1, mb.getId());
			ps.setString(2, mb.getPass());
			ps.setString(3, mb.getName());
			ps.setTimestamp(4, mb.getReg_date());
			ps.setString(5, mb.getEmail());
			ps.setString(6, mb.getAddress());
			ps.setString(7, mb.getPhone());
			ps.setString(8, mb.getMobile());
			
			//아이디 중복 체크 안한 경우 팝업 창 띄울 수 있게 해주고 비번 다르게 입력 시 경고 창 띄우게 해주고
			//등등등등 처리하는 코드 작성하기 
			ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try {rs.close();}catch(SQLException ex){} //예외처리 안하면 오류남. try { 정리할 변수 }catch(SQLException ex){}
			if(ps != null)try {ps.close();}catch (SQLException ex) {}
			if(con != null)try {con.close();} catch (SQLException ex) {}
		}
	}//insertMember()
	
	public int userCheck(String id, String pass) {
		int check = -1;
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs =null;
		try {
			con = getConnection();
			String sql = "select * from member where id=?";
			ps = con.prepareStatement(sql);
			ps.setString(1, id);
			rs = ps.executeQuery();
			if(rs.next()) {
				if(pass.equals(rs.getString("pass"))) {
					return check=1;
				}else {
					return check =0;
				}
			}else {
				return check = -1;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try {rs.close();}catch(SQLException ex){} //예외처리 안하면 오류남. try { 정리할 변수 }catch(SQLException ex){}
			if(ps != null)try {ps.close();}catch (SQLException ex) {}
			if(con != null)try {con.close();} catch (SQLException ex) {}
		}
		return check;
	}//userCheck()
	
	public int idcheck(String id) {
		int check = -1;
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs =null;
		try {
			con = getConnection();
			String sql = "select * from member where id=?";
			ps = con.prepareStatement(sql);
			ps.setString(1, id);
			rs = ps.executeQuery();

				if(rs.next()) {//true 이면 id.equals(rs.getString("id"))
					return check =1;
				}else {
				
				return check = 0;
				}

		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try {rs.close();}catch(SQLException ex){} //예외처리 안하면 오류남. try { 정리할 변수 }catch(SQLException ex){}
			if(ps != null)try {ps.close();}catch (SQLException ex) {}
			if(con != null)try {con.close();} catch (SQLException ex) {}
		}
		return check;		
	}
	
	public MemberBean getMember(String id) {
		con = null;
		 ps = null;
		 rs = null;
		 MemberBean mb = new MemberBean();
		try {
		con = getConnection();
		String sql = "select * from member where id=?";
		ps = con.prepareStatement(sql);
		ps.setString(1, id);
		rs = ps.executeQuery();
		if(rs.next()) {
			mb.setId(rs.getString("id"));
			mb.setPass(rs.getString("pass"));
			mb.setName(rs.getString("name"));
			mb.setReg_date(rs.getTimestamp("reg_date"));
			mb.setEmail(rs.getString("email"));
			mb.setAddress(rs.getString("address"));
			mb.setPhone(rs.getString("phone"));
			mb.setMobile(rs.getString("mobile"));
		}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			closeDB();
		}
		return mb;
	}
	
	public void updateMember(MemberBean mb) {
		try {
			con = getConnection();
			
			String sql = "update member set pass=?, name=?, email=?, address=?, phone=?, mobile=? where id=? ";
			ps = con.prepareStatement(sql);
			
			ps.setString(1, mb.getPass());
			ps.setString(2, mb.getName());
			ps.setString(3, mb.getEmail());
			ps.setString(4, mb.getAddress());
			ps.setString(5, mb.getPhone());
			ps.setString(6, mb.getMobile());
			ps.setString(7, mb.getId());
			
			//아이디 중복 체크 안한 경우 팝업 창 띄울 수 있게 해주고 비번 다르게 입력 시 경고 창 띄우게 해주고
			//등등등등 처리하는 코드 작성하기 
			ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try {rs.close();}catch(SQLException ex){} //예외처리 안하면 오류남. try { 정리할 변수 }catch(SQLException ex){}
			if(ps != null)try {ps.close();}catch (SQLException ex) {}
			if(con != null)try {con.close();} catch (SQLException ex) {}
		}
	}
	
	public void deleteMember(MemberBean mb) {
		try {
			Connection con = getConnection();
			//3단계 sql
			String sql="delete from member where id=?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps=con.prepareStatement(sql);
			ps.setString(1, mb.getId());
			//실행
			ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {	
			closeDB();
		}
	}//deleteMember() 끝
	
	public List getMemberList() {
		List Mblist = new ArrayList(); //자바 API 배열형태 자료형 List
		//기본적으로 기억공간 10개생성
		try {
			Connection con = getConnection();
			String sql = "select * from member";//3단계
			PreparedStatement ps = con.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();//4단계 실행
			//5단계 rs-> mblist 저장
			while(rs.next()) {//첫행 이동
				MemberBean mb = new MemberBean(); //객체 생성 및 rs에서 가져온 정보 저장
				mb.setId(rs.getString("id"));
				mb.setPass(rs.getString("pass"));
				mb.setName(rs.getString("name"));
				mb.setReg_date(rs.getTimestamp("reg_date"));
				mb.setEmail(rs.getString("email"));
				mb.setAddress(rs.getString("address"));
				mb.setPhone(rs.getString("phone"));
				mb.setMobile(rs.getString("mobile"));
				Mblist.add(mb);	//배열에 한사람의 정보를 저장
			}

		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			closeDB();
		}
		return Mblist;
	}//getMemberList()
}
