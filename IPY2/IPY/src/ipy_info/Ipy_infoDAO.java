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
	//��Ʈ�� ����Ʈ o ������ java.sql.connection Ŭ���ؼ� ������ �׷� ���� import ~~~ ����
	public Ipy_infoDAO() {//�����ͺ��̽��� ������ �� �ִ� �κ�
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
	

	public ArrayList<Ipy_info> getList(String ID){
		String SQL = "SELECT * FROM ipy_info WHERE ipy_admin = ?;";
		ArrayList<Ipy_info> ipy_list = new ArrayList<Ipy_info>();
		try {
			PreparedStatement pstmt= conn.prepareStatement(SQL);//���� ����� ��ü(conn)�� �̿��ؼ� sql������ �����غ�ܰ�� �������
			pstmt.setString(1,ID);
			rs=pstmt.executeQuery(); // ������ ���������� ������ ����� ������
			while(rs.next()) { //����� ������~~
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
			PreparedStatement pstmt= conn.prepareStatement(SQL);//���� ����� ��ü(conn)�� �̿��ؼ� sql������ �����غ�ܰ�� �������
			pstmt.setString(1,ipy_account); //�� ���ڿ� �ش��ϴ� �Խñ� �״�� �������°�
			rs=pstmt.executeQuery(); // ������ ���������� ������ ����� ������
			if(rs.next()) { //����� ������~~
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
			PreparedStatement pstmt= conn.prepareStatement(SQL);//���� ����� ��ü(conn)�� �̿��ؼ� sql������ �����غ�ܰ�� �������
			rs=pstmt.executeQuery(); // ������ ���������� ������ ����� ������
			while(rs.next()) { //����� ������~~
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
	
	
	public int setIpy(String account, String ID, String name) { //userŬ������ �̿��Ͽ� �Ѹ��� ����ڸ� �Է¤��ٵ��� ��.
		String SQL = "INSERT INTO ipy_info VALUES (?,?,0,?);"; //�ϳ��� �־���. �����ͺ��̽���!!
		try {
			pstmt = conn.prepareStatement(SQL); //
			pstmt.setString(1, account); //�����ͺ��̽��� ���缭 �ְԲ� ���ʴ�� �־���.
			pstmt.setString(2, ID);
			pstmt.setString(3, name);
			return pstmt.executeUpdate();//������ ����� �־���!
		}catch(Exception e){ //���� �߻��� ó�����ټ� �ְ�~
			e.printStackTrace();
		}
		return -1;//�����ͺ��̽� ����
	}
	
	public int deleteIpy(String ipy_account) {
		String SQL = "DELETE FROM ipy_info WHERE ipy_account = ?;";
		try {
			PreparedStatement pstmt= conn.prepareStatement(SQL);//���� ����� ��ü(conn)�� �̿��ؼ� sql������ �����غ�ܰ�� �������
			pstmt.setString(1, ipy_account);
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}

	

}
