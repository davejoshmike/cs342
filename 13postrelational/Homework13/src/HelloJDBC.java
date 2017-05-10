
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javafx.collections.transformation.SortedList;
import oracle.kv.*;
import sun.reflect.generics.reflectiveObjects.NotImplementedException;

import java.util.*;

/**
 * This program used JDBC to query all the movies from the IMDB Movies table.
 * Include ojdbc6.jar (from the J2EE library) in the system path to support the JDBC functions.
 * C:\glassfish-4.1-web\glassfish4\glassfish\lib\ojdbc6.jar
 *
 * @author kvlinden
 * @version Spring, 2015
 */
public class HelloJDBC {

	public static void main(String[] args) throws SQLException {
		Connection jdbcConnection = DriverManager.getConnection(
				"jdbc:oracle:thin:@localhost:1521:xe", "imdb", "bjarne");
		KVStore store = KVStoreFactory.getStore(new KVStoreConfig(
				"kvstore", "localhost:5000"));

		LoadDB(jdbcConnection, store);
//		Hashtable<String, String> movieTableValues = GetTableValues(store);
//		System.out.println(movieTableValues);

//		String roleValues = GetMovieActorRoles(store);
//		System.out.println(roleValues);

//		String movieActorValues = GetMovieActors(store);
//		System.out.println(movieActorValues);

		String sortedMovies = GetSortedMovies(store);
		System.out.println(sortedMovies);

		jdbcConnection.close();
		store.close();
	}

	// pull data from the OracleXE IMDB Movie, Actor, Role tables and stores it in KVLite
	public static void LoadDB(Connection jdbcConnection, KVStore store) throws SQLException {
		Statement jdbcStatement = jdbcConnection.createStatement();

		//region LoadMovieTable
		String table = "movie";
		ResultSet resultSet = jdbcStatement.executeQuery("SELECT id, name, year FROM " + table);

		//region Fields
		String movieId;
		String name;
		String year;
		//endregion
		Key movieKey;
		Value movieValue;
		while (resultSet.next()) {
			//region Store fields from Oracle into variables
			movieId = String.valueOf(resultSet.getInt(1));
			name = String.valueOf(resultSet.getString(2));
			year = String.valueOf(resultSet.getString(3));
			//endregion

			//region Put name to KVlite
			movieKey = Key.createKey(Arrays.asList(table, movieId), Arrays.asList("name"));
			movieValue = Value.createValue(name.getBytes());
			store.put(movieKey, movieValue);
			//endregion

			//region Put year to KVlite
			movieKey = Key.createKey(Arrays.asList(table, movieId), Arrays.asList("year"));
			movieValue = Value.createValue(year.getBytes());
			store.put(movieKey, movieValue);
			//endregion

			//System.out.println(movieId + "\t" + name + "\t" + year);
		}
		resultSet.close();
		//endregion

		//region LoadActorTable
		table = "actor";
		resultSet = jdbcStatement.executeQuery("SELECT id, firstName, lastName, gender FROM " + table);

		//region Fields
		String actorId;
		String firstName;
		String lastName;
		String gender;
		//endregion
		Key actorKey;
		Value actorValue;
		while (resultSet.next()) {
			//region Store fields from Oracle into variables
			actorId = String.valueOf(resultSet.getInt(1));
			firstName = String.valueOf(resultSet.getString(2));
			lastName = String.valueOf(resultSet.getString(3));
			gender = String.valueOf(resultSet.getString(4));
			//endregion

			//region Put firstName to KVlite
			actorKey = Key.createKey(Arrays.asList(table, actorId), Arrays.asList("firstName"));
			actorValue = Value.createValue(firstName.getBytes());
			store.put(actorKey, actorValue);
			//endregion

			//region Put lastName to KVlite
			actorKey = Key.createKey(Arrays.asList(table, actorId), Arrays.asList("lastName"));
			actorValue = Value.createValue(lastName.getBytes());
			store.put(actorKey, actorValue);
			//endregion

			//region Put gender to KVlite
			actorKey = Key.createKey(Arrays.asList(table, actorId), Arrays.asList("gender"));
			actorValue = Value.createValue(gender.getBytes());
			store.put(actorKey, actorValue);
			//endregion

			//System.out.println(actorId + "\t" + firstName + "\t" + lastName + "\t" + gender);
		}
		resultSet.close();
		//endregion LoadActorTable

		//region LoadRoleTable
		table = "role";
		resultSet = jdbcStatement.executeQuery("SELECT actorId, movieId, role FROM " + table);

		//region Fields
		actorId = "";
		movieId = "";
		String role;
		//endregion
		Key roleKey;
		Value roleValue;
		while (resultSet.next()) {
			//region Store fields from Oracle into variables
			actorId = String.valueOf(resultSet.getInt(1));
			movieId = String.valueOf(resultSet.getInt(2));
			role = String.valueOf(resultSet.getString(3));
			//endregion

			//region Put role to KVlite
			roleKey = Key.createKey(Arrays.asList(table, actorId, movieId), Arrays.asList("role"));
			roleValue = Value.createValue(role.getBytes());
			store.put(roleKey, roleValue);
			//endregion

			//System.out.println(actorId + "\t" + movieId + "\t" + role);
		}
		resultSet.close();
		//endregion LoadMovie

		jdbcStatement.close();
	}

	//Get the basic field values from the Movie table
	// @return something like this:
	//		Table: movie
	//		ID: 92616
	//			name: Dr. Strangelove or: How I Learned to Stop Worrying and Love the Bomb
	// 			year: 1964
	public static Hashtable<String, String> GetTableValues(KVStore store) {
		String returnValue = "";
		String table = "movie";
		String movieId = "92616";

		returnValue += "Table: " + table;
		returnValue += "\nID: " + movieId + "\n";

		Hashtable<String, String> returnValues = new Hashtable<String,String>();

		Key majorkeyPathOnly = Key.createKey(Arrays.asList(table, movieId));
		Map<Key, ValueVersion> fields = store.multiGet(majorkeyPathOnly, null, null);
		for (Map.Entry<Key, ValueVersion> field : fields.entrySet()) {
			String fieldName = field.getKey().getMinorPath().get(0);
			String fieldValue = new String(field.getValue().getValue().getValue());
			returnValue += "\t" + fieldName + "\t: " + fieldValue + "\n";
			returnValues.put(fieldName, fieldValue);
		}
		System.out.println(returnValue);
		return returnValues;
	}

	public static String GetMovieActorRoles(KVStore store) {
		String table = "role";
		String actorId = "429719";
		String movieId = "92616";
		String minorField = "role";
		String returnValue = "";

		returnValue += "Table: " + table;

		returnValue += "\nActor ID: " + actorId;
		returnValue += "\nMovie ID: " + movieId + "\n";


		Key majorkeyPathOnly = Key.createKey(Arrays.asList(table, actorId, movieId),
				Arrays.asList(minorField));

		// gets everything from role
		Map<Key, ValueVersion> fields = store.multiGet(majorkeyPathOnly, null, null);
		for (Map.Entry<Key, ValueVersion> field : fields.entrySet()) {
			String fieldName = field.getKey().getMinorPath().get(0);
			String fieldValue = new String(field.getValue().getValue().getValue());

			returnValue += "\t" + fieldName + "\t: " + fieldValue;
		}

		return returnValue;
	}


	public static void GetMovieActors(KVStore store) {
		throw new NotImplementedException();
	}

	// Lists all the movies in order of year
	public static String GetSortedMovies(KVStore store) {
		String table = "movie";
		String returnValue = "";

		Key myKey = Key.createKey(Arrays.asList(table));
		ArrayList<KeyValueVersion> sortedRecords = new ArrayList<KeyValueVersion>();
		Iterator<KeyValueVersion> i = store.storeIterator(Direction.UNORDERED, 0, myKey, null, null);
		while(i.hasNext()) {
			KeyValueVersion current = i.next();

			returnValue += "\nMovieID: " + current.getKey().getMajorPath().get(1);

			String fieldName = current.getKey().getMinorPath().get(0);
			Value value = current.getValue();
			returnValue += "\n\t" + fieldName + ": \t " + new String(value.getValue());

			fieldName = current.getKey().getMinorPath().get(1);
			value = current.getValue();
			returnValue += "\n\t" + fieldName + ": " + new String(value.getValue());
		}
		return returnValue;
	}
}
