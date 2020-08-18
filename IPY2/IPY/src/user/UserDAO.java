package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	//컨트롤 쉬프트 o 눌러서 java.sql.connection 클릭해서 누르고 그럼 위에 import ~~~ 생김
	public UserDAO() {//데이터베이스에 접근할 수 있는 부분
		try {//자동으로 데이터베이스랑 커넥션??!!!
			String dbURL="jdbc:mysql://localhost:8080/ipy?serverTimezone=UTC"; //localhost는 자기컴퓨터에 설치된 mysql서버? IPY라는 서버에
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
	
	public int login(String ID,String PW) {
		String SQL = "SELECT PW FROM user WHERE ID = ?";// 유저테이블에서 해당사용자의 비밀번호를 가져옴
		try {
			pstmt = conn.prepareStatement(SQL); //prepareStatement 어떠한 정해진 sql문장을 데이터베이스에 삽입하는 그러한 형식으로 인스턴스를 가져옴
			pstmt.setString(1, ID); // 중요?! 해킹기법을 방어하기위한 수단? 하나의 문장을 준비(sql문장) 
			rs = pstmt.executeQuery();// 결과를 확인할 하나의 객체에다가 실행결과를 넣어줌
			if(rs.next()) {//결과값이 있으면 일로들어와서 
				if(rs.getString(1).equals(PW)) {// 결과를 받은 비밀번호와 접속을 시도한 비밀번호가 일치하면은
					return 1; //로그인 성공
				}
				else
					return 0; // 비밀번호 불일치
			}
			return -1; //아이디가 없음
		}catch (Exception e) {
			e.printStackTrace();//오류발생시 자동으로 출력
		}
		return -2; // 데이터베이스 오류
	}
	
	public int join(User user) { //user클래스를 이용하여 한명의 사용자를 입력ㅂ다도록 함.
		String SQL = "INSERT INTO user VALUES (?,?,?,?);"; //하나씩 넣어줌. 데이터베이스에!!
		try {
			pstmt = conn.prepareStatement(SQL); //
			pstmt.setString(1, user.getID()); //데이터베이스에 맞춰서 넣게끔 차례대로 넣어줌.
			pstmt.setString(2, user.getPW());
			pstmt.setString(3, user.getNAME());
			pstmt.setString(4, user.getEmail());
			return pstmt.executeUpdate();//실행한 결과를 넣어줌!
		}catch(Exception e){ //예외 발생시 처리해줄수 있게~
			e.printStackTrace();
		}
		return -1;//데이터베이스 오류
	}
	
	public String getName(String ID) {
		String SQL = "SELECT NAME FROM user WHERE ID = ?;";
		try {
			PreparedStatement pstmt= conn.prepareStatement(SQL);//현재 연결된 객체(conn)를 이용해서 sql문장을 실행준비단계로 만들어줌
			pstmt.setString(1,ID);
			rs=pstmt.executeQuery(); // 실제로 실행했을때 나오는 결과를 가져옴
			if(rs.next()) { //결과가 있을시~~
				return rs.getString(1); //현재의 그 값을 그대로 반영해주도록 해줌
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return "";//데이터베이스 오류를 알려줌.		
	}
	
	public String getEmail(String ID) {
		String SQL = "SELECT email FROM user WHERE ID = ?;";
		try {
			PreparedStatement pstmt= conn.prepareStatement(SQL);//현재 연결된 객체(conn)를 이용해서 sql문장을 실행준비단계로 만들어줌
			pstmt.setString(1,ID);
			rs=pstmt.executeQuery(); // 실제로 실행했을때 나오는 결과를 가져옴
			if(rs.next()) { //결과가 있을시~~
				return rs.getString(1); //현재의 그 값을 그대로 반영해주도록 해줌
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return "";//데이터베이스 오류를 알려줌.		
	}
	
	public int updateUser(String pw, String name, String id) {
		String SQL = "UPDATE user SET PW = ?, NAME = ? WHERE ID= ?";
		try {
			PreparedStatement pstmt= conn.prepareStatement(SQL);//현재 연결된 객체(conn)를 이용해서 sql문장을 실행준비단계로 만들어줌
			pstmt.setString(1, pw); //차례대로 쭉 넣기
			pstmt.setString(2, name);
			pstmt.setString(3, id); //
			return pstmt.executeUpdate(); //성공적으로 반환했을시 1??
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}

}
