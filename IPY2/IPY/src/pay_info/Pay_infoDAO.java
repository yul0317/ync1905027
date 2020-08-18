package pay_info;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;


public class Pay_infoDAO {
	private Connection conn;
	private ResultSet rs;
	//컨트롤 쉬프트 o 눌러서 java.sql.connection 클릭해서 누르고 그럼 위에 import ~~~ 생김
	public Pay_infoDAO() {//데이터베이스에 접근할 수 있는 부분
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
	
	
	
	public ArrayList<Pay_info> getList(String ipy_account){
		String SQL = "SELECT * FROM pay_info WHERE pay_account = ? ORDER BY pay_date DESC";
		ArrayList<Pay_info> pay_list = new ArrayList<Pay_info>();
		try {
			PreparedStatement pstmt= conn.prepareStatement(SQL);//현재 연결된 객체(conn)를 이용해서 sql문장을 실행준비단계로 만들어줌
			pstmt.setString(1,ipy_account);
			rs=pstmt.executeQuery(); // 실제로 실행했을때 나오는 결과를 가져옴
			while(rs.next()) { //결과가 있을시~~
				Pay_info info = new Pay_info();
				info.setPay_num(rs.getInt(1));
				info.setPrice(rs.getInt(2));
				info.setPay_date(rs.getString(3));
				info.setPay_account(rs.getString(4));
				info.setPay_card(rs.getString(5));
				pay_list.add(info);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return pay_list;
	}

	
	public int getTotalpage(String ipy_account) {
		String SQL = "SELECT COUNT(*) FROM pay_info WHERE pay_account = ?;";
		try {
			PreparedStatement pstmt= conn.prepareStatement(SQL);//현재 연결된 객체(conn)를 이용해서 sql문장을 실행준비단계로 만들어줌
			pstmt.setString(1, ipy_account);
			rs=pstmt.executeQuery(); // 실제로 실행했을때 나오는 결과를 가져옴
			if(rs.next()) { //결과가 있을시~~
				return rs.getInt(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	

	
	public int getTotalpay(String pay_account) {
		String SQL = "SELECT SUM(price) FROM pay_info WHERE pay_account = ?;";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, pay_account);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	
	
	
	
}
