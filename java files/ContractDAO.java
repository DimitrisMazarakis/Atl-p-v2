package team40;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ContractDAO{

    public List<Contract> getContracts() throws Exception {
				
		DB db = new DB();
		Connection con = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sqlQuery = "SELECT * FROM contracts";
		try {
			List<Contract> contracts =  new ArrayList<Contract>();

			con = db.getConnection();
			stmt = con.prepareStatement(sqlQuery);
			rs = stmt.executeQuery();

			while(rs.next()) {

				contracts.add( new Contract(rs.getInt("id_contract"),rs.getInt("previous_contract"), rs.getInt("afm"),rs.getInt("id_agency"),
							rs.getString ("vehicle_type"),rs.getString ("plate"),rs.getString ("packag"),rs.getString ("transport"),rs.getDate("starting_date"),
							rs.getInt("duration"),rs.getFloat("amount")) );

			}

			rs.close();
			stmt.close();
			
			return contracts;

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

    

