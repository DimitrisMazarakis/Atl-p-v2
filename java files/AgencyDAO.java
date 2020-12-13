package team40;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AgencyDAO{

    public List<Agency> getAgencies() throws Exception {
				
		DB db = new DB();
		Connection con = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sqlQuery = "SELECT * FROM agencies";
		try {
			List<Agency> agencies =  new ArrayList<Agency>();

			con = db.getConnection();
			stmt = con.prepareStatement(sqlQuery);
			rs = stmt.executeQuery();

			while(rs.next()) {

				agencies.add( new Agency(rs.getInt("id_agency"), rs.getString("agency_name"),rs.getString("type_of_agency"),rs.getFloat("commission")) );

			}

			rs.close();
			stmt.close();
			
			return agencies;

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

    

