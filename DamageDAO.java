package team40;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;


public class DamageDAO{

    public List<Damage> getDamages() throws Exception {

		DB db = new DB();
		Connection con = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sqlQuery = "SELECT * FROM damages";
		try {
			List<Damage> damages =  new ArrayList<Damage>();

			con = db.getConnection();
			stmt = con.prepareStatement(sqlQuery);
			rs = stmt.executeQuery();

			while(rs.next()) {

				damages.add( new Damage(rs.getString("id_damage"),rs.getInt("id_contract"), rs.getFloat("amount"),rs.getDate("damage_date")) );

			}

			rs.close();
			stmt.close();

			return damages;

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



