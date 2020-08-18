package pay_info;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;


public class Pay_infoDAO {
	private Connection conn;
	private ResultSet rs;
	//��Ʈ�� ����Ʈ o ������ java.sql.connection Ŭ���ؼ� ������ �׷� ���� import ~~~ ����
	public Pay_infoDAO() {//�����ͺ��̽��� ������ �� �ִ� �κ�
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
	
	
	
	public ArrayList<Pay_info> getList(String ipy_account){
		String SQL = "SELECT * FROM pay_info WHERE pay_account = ? ORDER BY pay_date DESC";
		ArrayList<Pay_info> pay_list = new ArrayList<Pay_info>();
		try {
			PreparedStatement pstmt= conn.prepareStatement(SQL);//���� ����� ��ü(conn)�� �̿��ؼ� sql������ �����غ�ܰ�� �������
			pstmt.setString(1,ipy_account);
			rs=pstmt.executeQuery(); // ������ ���������� ������ ����� ������
			while(rs.next()) { //����� ������~~
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
			PreparedStatement pstmt= conn.prepareStatement(SQL);//���� ����� ��ü(conn)�� �̿��ؼ� sql������ �����غ�ܰ�� �������
			pstmt.setString(1, ipy_account);
			rs=pstmt.executeQuery(); // ������ ���������� ������ ����� ������
			if(rs.next()) { //����� ������~~
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
