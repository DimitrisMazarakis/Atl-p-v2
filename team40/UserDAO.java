package team40;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;


/**
 * UserDAO provides all the necessary methods related to users in order to connect to the database and store/retrieve users etc.
 * 
 * @author 
 *
 */
public class UserDAO {	

	public User authenticate(String username, String password) throws Exception {
		
			
		DB db = new DB();
		Connection con = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sqlQuery = "SELECT * FROM users WHERE username=? AND user_password=?;";

		try {

			con = db.getConnection();
			stmt = con.prepareStatement(sqlQuery);
			stmt.setString(1, username);
			stmt.setString(2, password);

			rs = stmt.executeQuery();

			if (!rs.next()) {
				throw new Exception("Wrong username or password");
			}

			User usr = new User(rs.getInt("id_user"), rs.getString("username"),rs.getString("user_password"),rs.getString("departement"));
			rs.close();
			stmt.close();
			db.close();

			return usr;


		} catch (Exception e) {
			throw new Exception(e.getMessage());
		} finally {

			try {
				db.close();
			} catch (Exception e) {

			}

		}
			
		
	} //End of authenticate
}