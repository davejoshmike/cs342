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
 * @author djm43
 * @version Spring, 2017
 */
public class JDBCAdapter {

    public static void main(String[] args) throws SQLException {
        Connection jdbcConnection = DriverManager.getConnection(
                "jdbc:oracle:thin:@localhost:1521:xe", "PersonalFinance", "BuyMe8");
        KVStore store = KVStoreFactory.getStore(new KVStoreConfig(
                "kvstore", "localhost:5000"));

        LoadDB(jdbcConnection, store);
    }

    // pull data from the OracleXE PersonalFinance Person, IncomeTax, tables and stores it in KVLite
    public static void LoadDB(Connection jdbcConnection, KVStore store) throws SQLException {
        Statement jdbcStatement = jdbcConnection.createStatement();

        //region LoadPersonTable
        String table = "Person";
        ResultSet resultSet = jdbcStatement.executeQuery("SELECT id, firstname, lastname, state, city, filingtype FROM " + table);

        //region Fields
        String personId;
        String firstname;
        String lastname;
        String state;
        String city;
        String filingtype;
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

        //region LoadIncomeTaxTable
        table = "IncomeTax";
        resultSet = jdbcStatement.executeQuery("SELECT id, type, state, filingtype, flat, year FROM " + table);

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
}
