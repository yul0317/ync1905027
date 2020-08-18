package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	//��Ʈ�� ����Ʈ o ������ java.sql.connection Ŭ���ؼ� ������ �׷� ���� import ~~~ ����
	public UserDAO() {//�����ͺ��̽��� ������ �� �ִ� �κ�
		try {//�ڵ����� �����ͺ��̽��� Ŀ�ؼ�??!!!
			String dbURL="jdbc:mysql://localhost:8080/ipy?serverTimezone=UTC"; //localhost�� �ڱ���ǻ�Ϳ� ��ġ�� mysql����? IPY��� ������
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
	
	public int login(String ID,String PW) {
		String SQL = "SELECT PW FROM user WHERE ID = ?";// �������̺��� �ش������� ��й�ȣ�� ������
		try {
			pstmt = conn.prepareStatement(SQL); //prepareStatement ��� ������ sql������ �����ͺ��̽��� �����ϴ� �׷��� �������� �ν��Ͻ��� ������
			pstmt.setString(1, ID); // �߿�?! ��ŷ����� ����ϱ����� ����? �ϳ��� ������ �غ�(sql����) 
			rs = pstmt.executeQuery();// ����� Ȯ���� �ϳ��� ��ü���ٰ� �������� �־���
			if(rs.next()) {//������� ������ �Ϸε��ͼ� 
				if(rs.getString(1).equals(PW)) {// ����� ���� ��й�ȣ�� ������ �õ��� ��й�ȣ�� ��ġ�ϸ���
					return 1; //�α��� ����
				}
				else
					return 0; // ��й�ȣ ����ġ
			}
			return -1; //���̵� ����
		}catch (Exception e) {
			e.printStackTrace();//�����߻��� �ڵ����� ���
		}
		return -2; // �����ͺ��̽� ����
	}
	
	public int join(User user) { //userŬ������ �̿��Ͽ� �Ѹ��� ����ڸ� �Է¤��ٵ��� ��.
		String SQL = "INSERT INTO user VALUES (?,?,?,?);"; //�ϳ��� �־���. �����ͺ��̽���!!
		try {
			pstmt = conn.prepareStatement(SQL); //
			pstmt.setString(1, user.getID()); //�����ͺ��̽��� ���缭 �ְԲ� ���ʴ�� �־���.
			pstmt.setString(2, user.getPW());
			pstmt.setString(3, user.getNAME());
			pstmt.setString(4, user.getEmail());
			return pstmt.executeUpdate();//������ ����� �־���!
		}catch(Exception e){ //���� �߻��� ó�����ټ� �ְ�~
			e.printStackTrace();
		}
		return -1;//�����ͺ��̽� ����
	}
	
	public String getName(String ID) {
		String SQL = "SELECT NAME FROM user WHERE ID = ?;";
		try {
			PreparedStatement pstmt= conn.prepareStatement(SQL);//���� ����� ��ü(conn)�� �̿��ؼ� sql������ �����غ�ܰ�� �������
			pstmt.setString(1,ID);
			rs=pstmt.executeQuery(); // ������ ���������� ������ ����� ������
			if(rs.next()) { //����� ������~~
				return rs.getString(1); //������ �� ���� �״�� �ݿ����ֵ��� ����
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return "";//�����ͺ��̽� ������ �˷���.		
	}
	
	public String getEmail(String ID) {
		String SQL = "SELECT email FROM user WHERE ID = ?;";
		try {
			PreparedStatement pstmt= conn.prepareStatement(SQL);//���� ����� ��ü(conn)�� �̿��ؼ� sql������ �����غ�ܰ�� �������
			pstmt.setString(1,ID);
			rs=pstmt.executeQuery(); // ������ ���������� ������ ����� ������
			if(rs.next()) { //����� ������~~
				return rs.getString(1); //������ �� ���� �״�� �ݿ����ֵ��� ����
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return "";//�����ͺ��̽� ������ �˷���.		
	}
	
	public int updateUser(String pw, String name, String id) {
		String SQL = "UPDATE user SET PW = ?, NAME = ? WHERE ID= ?";
		try {
			PreparedStatement pstmt= conn.prepareStatement(SQL);//���� ����� ��ü(conn)�� �̿��ؼ� sql������ �����غ�ܰ�� �������
			pstmt.setString(1, pw); //���ʴ�� �� �ֱ�
			pstmt.setString(2, name);
			pstmt.setString(3, id); //
			return pstmt.executeUpdate(); //���������� ��ȯ������ 1??
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}

}
