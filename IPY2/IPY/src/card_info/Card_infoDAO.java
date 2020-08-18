package card_info;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;


public class Card_infoDAO {
	private Connection conn;
	private ResultSet rs;
	//��Ʈ�� ����Ʈ o ������ java.sql.connection Ŭ���ؼ� ������ �׷� ���� import ~~~ ����
	public Card_infoDAO() {//�����ͺ��̽��� ������ �� �ִ� �κ�
		try {//�ڵ����� �����ͺ��̽��� Ŀ�ؼ�??!!!
			String dbURL="jdbc:mysql://localhost:8080/ipy?serverTimezone=UTC";//localhost�� �ڱ���ǻ�Ϳ� ��ġ�� mysql����? IPY��� ������
			//jdbc:mysql://220.67.5.50:23306/ipy_database?serverTimezone=UTC
			//jdbc:mysql://its.rexalcove.com:23306/ipy_database
			String dbID="root";
			String dbPassword="q1w2e3r4a1s2d3f4";//id password ��,�� ���� ������ ���̵� ���
			Class.forName("com.mysql.cj.jdbc.Driver");// mysql����̹��� ã���� �ְԲ�.. mysql�� �����Ҽ� �ְԲ� �ϴ� ���̺귯��
			//�̰� �߰��� 
			conn = DriverManager.getConnection(dbURL,dbID,dbPassword); //conn��ü�ȿ� mysql�� ���ӵ� ������ ���@@!!@!@!@!
		}catch (Exception e) {//���� ó����?
			e.printStackTrace();//�����߻��� �ڵ����� �������� ����Ҽ� �ְԲ�
		}
	}
	
	public Card_info getCard_info(String pay_card) {
		String SQL = "SELECT * FROM card_info WHERE card_num = ?;";
		try {
			PreparedStatement pstmt= conn.prepareStatement(SQL);//���� ����� ��ü(conn)�� �̿��ؼ� sql������ �����غ�ܰ�� �������
			pstmt.setString(1,pay_card); //�� ���ڿ� �ش��ϴ� �Խñ� �״�� �������°�
			rs=pstmt.executeQuery(); // ������ ���������� ������ ����� ������
			if(rs.next()) { //����� ������~~
				Card_info info = new Card_info(); 
				info.setCard_owner(rs.getString(1));
				info.setCard_num(rs.getString(2));
				return info;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
}
