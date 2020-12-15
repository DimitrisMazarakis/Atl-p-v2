package team40;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CustomerDAO{
    public List<Customer> getCustomers() throws Exception {
				
		DB db = new DB();
		Connection con = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sqlQuery = "SELECT * FROM customers";
		try {
			List<Customer> Customers =  new ArrayList<Customer>();

			con = db.getConnection();
			stmt = con.prepareStatement(sqlQuery);
			rs = stmt.executeQuery();

			while(rs.next()) {

				Customers.add( new Customer(rs.getInt("afm"), rs.getInt("age"),rs.getString("namesurname"),rs.getString("sex"),rs.getString("county")) );

			}

			rs.close();
			stmt.close();
			
			return Customers;

		} catch (Exception e) {
			throw new Exception(e.getMessage());
		} finally {

			try {
				db.close();
			} catch (Exception e) {

			}

		}
		
	}
}