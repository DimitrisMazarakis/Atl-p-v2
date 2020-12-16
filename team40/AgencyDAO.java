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
	public String findName(float id) throws Exception {
		String name=null;				
		DB db = new DB();
		Connection con = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sqlQuery = "SELECT agency_name FROM agencies WHERE id_agency=?;";
		try {
			con = db.getConnection();
			stmt = con.prepareStatement(sqlQuery);
			stmt.setString(1, String.valueOf(id));
			rs = stmt.executeQuery();
			if(rs.next()){
				name = rs.getString("agency_name");
			}
			rs.close();
			stmt.close();
			
			return name;

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

    

