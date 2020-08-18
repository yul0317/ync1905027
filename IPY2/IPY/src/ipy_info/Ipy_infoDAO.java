package ipy_info;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;



public class Ipy_infoDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	//컨트롤 쉬프트 o 눌러서 java.sql.connection 클릭해서 누르고 그럼 위에 import ~~~ 생김
	public Ipy_infoDAO() {//데이터베이스에 접근할 수 있는 부분
		try {//자동으로 데이터베이스랑 커넥션??!!!
			String dbURL="jdbc:mysql://localhost:8080/ipy?serverTimezone=UTC";//localhost는 자기컴퓨터에 설치된 mysql서버? IPY라는 서버에
			//jdbc:mysql://220.67.5.50:23306/ipy_database?serverTimezone=UTC
			//jdbc:mysql://its.rexalcove.com:23306/ipy_database
			String dbID="root";
			String dbPassword="q1w2e3r4a1s2d3f4";//id password ㄴ,ㄴ 내가 설정한 아이디 비번
			Class.forName("com.mysql.cj.jdbc.Driver");// mysql드라이버를 찾을수 있게끔.. mysql을 연결할수 있게끔 하는 라이브러리
			//이거 추가는 
			conn = DriverManager.getConnection(dbURL,dbID,dbPassword); //conn객체안에 mysql로 접속된 정보가 담김@@!!@!@!@!
		}catch (Exception e) {//예외 처리문?
			e.printStackTrace();//오류발생시 자동으로 무엇인지 출력할수 있게끔
		}
	}
	

	public ArrayList<Ipy_info> getList(String ID){
		String SQL = "SELECT * FROM ipy_info WHERE ipy_admin = ?;";
		ArrayList<Ipy_info> ipy_list = new ArrayList<Ipy_info>();
		try {
			PreparedStatement pstmt= conn.prepareStatement(SQL);//현재 연결된 객체(conn)를 이용해서 sql문장을 실행준비단계로 만들어줌
			pstmt.setString(1,ID);
			rs=pstmt.executeQuery(); // 실제로 실행했을때 나오는 결과를 가져옴
			while(rs.next()) { //결과가 있을시~~
				Ipy_info info = new Ipy_info();
				info.setIpy_account(rs.getString(1));
				info.setIpy_admin(rs.getString(2));
				info.setIpy_total(rs.getInt(3));
				info.setIpy_name(rs.getString(4));
				ipy_list.add(info);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return ipy_list;		
	}
	
	
	
	
	public String getIpy_admin(String ipy_account) {
		String SQL = "SELECT ipy_admin FROM ipy_info WHERE ipy_account = ?;";
		try {
			PreparedStatement pstmt= conn.prepareStatement(SQL);//현재 연결된 객체(conn)를 이용해서 sql문장을 실행준비단계로 만들어줌
			pstmt.setString(1,ipy_account); //그 숫자에 해당하는 게시글 그대로 가져오는것
			rs=pstmt.executeQuery(); // 실제로 실행했을때 나오는 결과를 가져옴
			if(rs.next()) { //결과가 있을시~~
				return rs.getString(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public ArrayList<Ipy_info> getRanking(){
		String SQL = "SELECT * FROM ipy_info ORDER BY ipy_total DESC;";
		ArrayList<Ipy_info> ranking_list = new ArrayList<Ipy_info>();
		try {
			PreparedStatement pstmt= conn.prepareStatement(SQL);//현재 연결된 객체(conn)를 이용해서 sql문장을 실행준비단계로 만들어줌
			rs=pstmt.executeQuery(); // 실제로 실행했을때 나오는 결과를 가져옴
			while(rs.next()) { //결과가 있을시~~
				Ipy_info info = new Ipy_info(); 
				info.setIpy_account(rs.getString(1));
				info.setIpy_admin(rs.getString(2));
				info.setIpy_total(rs.getInt(3));
				info.setIpy_name(rs.getString(4));
				ranking_list.add(info);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return ranking_list;
	}
	
	
	public int setIpy(String account, String ID, String name) { //user클래스를 이용하여 한명의 사용자를 입력ㅂ다도록 함.
		String SQL = "INSERT INTO ipy_info VALUES (?,?,0,?);"; //하나씩 넣어줌. 데이터베이스에!!
		try {
			pstmt = conn.prepareStatement(SQL); //
			pstmt.setString(1, account); //데이터베이스에 맞춰서 넣게끔 차례대로 넣어줌.
			pstmt.setString(2, ID);
			pstmt.setString(3, name);
			return pstmt.executeUpdate();//실행한 결과를 넣어줌!
		}catch(Exception e){ //예외 발생시 처리해줄수 있게~
			e.printStackTrace();
		}
		return -1;//데이터베이스 오류
	}
	
	public int deleteIpy(String ipy_account) {
		String SQL = "DELETE FROM ipy_info WHERE ipy_account = ?;";
		try {
			PreparedStatement pstmt= conn.prepareStatement(SQL);//현재 연결된 객체(conn)를 이용해서 sql문장을 실행준비단계로 만들어줌
			pstmt.setString(1, ipy_account);
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}

	

}
