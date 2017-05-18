import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javafx.collections.transformation.SortedList;
import jdk.nashorn.internal.runtime.WithObject;
import oracle.kv.*;
import sun.reflect.generics.reflectiveObjects.NotImplementedException;

import java.util.*;

/**
 * This program used JDBC to query all the People, Wages and IncomeTaxes from the PersonalFinance database.
 * Include ojdbc6.jar (from the J2EE library) in the system path to support the JDBC functions.
 * C:\glassfish-4.1-web\glassfish4\glassfish\lib\ojdbc6.jar
 * See notes.txt for explanation of nosql and the purposes of using it
 *
 * @author djm43
 * @version Spring, 2017
 */
public class JDBC2KVLiteAdapter {

    public static void main(String[] args) throws SQLException {
        Connection jdbcConnection = DriverManager.getConnection(
                "jdbc:oracle:thin:@localhost:1521:xe", "PersonalFinance", "BuyMe8");
        KVStore store = KVStoreFactory.getStore(new KVStoreConfig(
                "kvstore", "localhost:5000"));

        LoadDB(jdbcConnection, store);

        String people = getPersonTable(store);
        System.out.println(people);

        String incomeTaxes = getIncomeTaxTable(store);
        System.out.println(incomeTaxes);

        String wages = getWageTable(store);
        System.out.println(wages);

        jdbcConnection.close();
        store.close();

        try {
            PrintWriter writer = new PrintWriter("output.txt", "UTF-8");
            writer.println(people);
            writer.println(incomeTaxes);
            writer.println(wages);
            writer.close();
        } catch(IOException e){
            //
        }
    }

    // pull data from the OracleXE PersonalFinance Person, IncomeTax, Wage tables and stores it in KVLite
    public static void LoadDB(Connection jdbcConnection, KVStore store) throws SQLException {
        Statement jdbcStatement = jdbcConnection.createStatement();

        //region LoadPersonTable and join Person table with Wage table - person/id/-/...
        String table = "person";
        ResultSet resultSet = jdbcStatement.executeQuery("SELECT id, firstname, lastname, state, city, filingtype FROM " + table);

        Key personKey;
        Value personValue;
        while (resultSet.next()) {
            //region Store results into fields
            String personId = String.valueOf(resultSet.getInt(1));
            String firstname = String.valueOf(resultSet.getString(2));
            String lastname = String.valueOf(resultSet.getString(3));
            String state = String.valueOf(resultSet.getString(4));
            String city = String.valueOf(resultSet.getString(5));
            String filingtype = String.valueOf(resultSet.getString(6));
            //endregion

            //region Put firstname to KVlite
            personKey = Key.createKey(Arrays.asList(table, personId), Arrays.asList("firstname"));
            personValue = Value.createValue(firstname.getBytes());
            store.put(personKey, personValue);
            //endregion

            //region Put lastname to KVlite
            personKey = Key.createKey(Arrays.asList(table, personId), Arrays.asList("lastname"));
            personValue = Value.createValue(lastname.getBytes());
            store.put(personKey, personValue);
            //endregion

            //region Put state to KVlite
            personKey = Key.createKey(Arrays.asList(table, personId), Arrays.asList("state"));
            personValue = Value.createValue(state.getBytes());
            store.put(personKey, personValue);
            //endregion

            //region Put city to KVlite
            personKey = Key.createKey(Arrays.asList(table, personId), Arrays.asList("city"));
            personValue = Value.createValue(city.getBytes());
            store.put(personKey, personValue);
            //endregion

            //region Put filingtype to KVlite
            personKey = Key.createKey(Arrays.asList(table, personId), Arrays.asList("filingtype"));
            personValue = Value.createValue(filingtype.getBytes());
            store.put(personKey, personValue);
            //endregion

            //System.out.println(movieId + "\t" + name + "\t" + year);
        }
        resultSet.close();

        //region person/id/-/wage
        resultSet = jdbcStatement.executeQuery("SELECT p.id, w.hourlywage, w.yearlywage, w.bonus FROM (Person p JOIN Wage w ON p.id=w.personid)");

        while (resultSet.next()) {
            //region Store results into fields
            String personId = String.valueOf(resultSet.getInt(1));
            String hourlywage = String.valueOf(resultSet.getDouble(2));
            String yearlywage = String.valueOf(resultSet.getDouble(3));
            String bonus = String.valueOf(resultSet.getDouble(4));
            //endregion

            //region Put hourlywage to KVlite
            personKey = Key.createKey(Arrays.asList(table, personId), Arrays.asList("hourlywage"));
            personValue = Value.createValue(hourlywage.getBytes());
            store.put(personKey, personValue);
            //endregion

            //region Put yearlywage to KVlite
            personKey = Key.createKey(Arrays.asList(table, personId), Arrays.asList("yearlywage"));
            personValue = Value.createValue(yearlywage.getBytes());
            store.put(personKey, personValue);
            //endregion

            //region Put bonus to KVlite
            personKey = Key.createKey(Arrays.asList(table, personId), Arrays.asList("bonus"));
            personValue = Value.createValue(bonus.getBytes());
            store.put(personKey, personValue);
            //endregion
        }
        resultSet.close();

        //endregion

        //endregion

        //region LoadIncomeTaxTable and join IncomeTax table with IncomeTaxBracket table - incometax/id/-/...
        table = "IncomeTax";
        resultSet = jdbcStatement.executeQuery("SELECT tx.id, type, state, filingtype, flat, year, " +
                "txb.bracketlevel, txb.bmin, txb.bmax, txb.rate FROM " +
                "IncomeTax tx JOIN IncomeTaxBracket txb ON tx.id=txb.id " +
                "ORDER BY tx.id DESC");

        Key incomeTaxKey;
        Value incomeTaxValue;
        while (resultSet.next()) {
            //region Store fields from Oracle into variables
            String id = String.valueOf(resultSet.getInt(1));
            String type = String.valueOf(resultSet.getString(2));
            String state = String.valueOf(resultSet.getString(3));
            String filingtype = String.valueOf(resultSet.getString(4));
            String flat = String.valueOf(resultSet.getString(5));
            String year = String.valueOf(resultSet.getString(6));
            String bracketlevel = String.valueOf(resultSet.getString(7));
            String bmin = String.valueOf(resultSet.getString(8));
            String bmax = String.valueOf(resultSet.getString(9));
            String rate = String.valueOf(resultSet.getString(10));
            //endregion

            //region Put type to KVlite
            incomeTaxKey = Key.createKey(Arrays.asList(table, id), Arrays.asList("type"));
            incomeTaxValue = Value.createValue(type.getBytes());
            store.put(incomeTaxKey, incomeTaxValue);
            //endregion

            //region Put state to KVlite
            incomeTaxKey = Key.createKey(Arrays.asList(table, id), Arrays.asList("state"));
            incomeTaxValue = Value.createValue(state.getBytes());
            store.put(incomeTaxKey, incomeTaxValue);
            //endregion

            //region Put filingtype to KVlite
            incomeTaxKey = Key.createKey(Arrays.asList(table, id), Arrays.asList("filingtype"));
            incomeTaxValue = Value.createValue(filingtype.getBytes());
            store.put(incomeTaxKey, incomeTaxValue);
            //endregion

            //region Put flat to KVlite
            incomeTaxKey = Key.createKey(Arrays.asList(table, id), Arrays.asList("flat"));
            incomeTaxValue = Value.createValue(flat.getBytes());
            store.put(incomeTaxKey, incomeTaxValue);
            //endregion

            //region Put year to KVlite
            incomeTaxKey = Key.createKey(Arrays.asList(table, id), Arrays.asList("year"));
            incomeTaxValue = Value.createValue(year.getBytes());
            store.put(incomeTaxKey, incomeTaxValue);
            //endregion

            //region Put bracketlevel to KVlite
            incomeTaxKey = Key.createKey(Arrays.asList(table, id), Arrays.asList("bracketlevel"));
            incomeTaxValue = Value.createValue(bracketlevel.getBytes());
            store.put(incomeTaxKey, incomeTaxValue);
            //endregion

            //region Put bmin to KVlite
            incomeTaxKey = Key.createKey(Arrays.asList(table, id), Arrays.asList("bmin"));
            incomeTaxValue = Value.createValue(bmin.getBytes());
            store.put(incomeTaxKey, incomeTaxValue);
            //endregion

            //region Put bmax to KVlite
            incomeTaxKey = Key.createKey(Arrays.asList(table, id), Arrays.asList("bmax"));
            incomeTaxValue = Value.createValue(bmax.getBytes());
            store.put(incomeTaxKey, incomeTaxValue);
            //endregion

            //region Put rate to KVlite
            incomeTaxKey = Key.createKey(Arrays.asList(table, id), Arrays.asList("rate"));
            incomeTaxValue = Value.createValue(rate.getBytes());
            store.put(incomeTaxKey, incomeTaxValue);
            //endregion

            //System.out.println(actorId + "\t" + firstName + "\t" + lastName + "\t" + gender);
        }
        resultSet.close();
        //endregion

        //region LoadWageTable - wage/id/-/...
        table = "wage";
        resultSet = jdbcStatement.executeQuery("SELECT personId, hourlywage, yearlywage, bonus FROM " + table);

        Key wageKey;
        Value wageValue;
        while (resultSet.next()) {
            //region Store results into fields
            String personId = String.valueOf(resultSet.getInt(1));
            String hourlywage = String.valueOf(resultSet.getDouble(2));
            String yearlywage = String.valueOf(resultSet.getDouble(3));
            String bonus = String.valueOf(resultSet.getDouble(4));
            //endregion

            //region Put hourlywage to KVlite
            wageKey = Key.createKey(Arrays.asList(table, personId), Arrays.asList("hourlywage"));
            wageValue = Value.createValue(hourlywage.getBytes());
            store.put(wageKey, wageValue);
            //endregion

            //region Put yearlywage to KVlite
            wageKey = Key.createKey(Arrays.asList(table, personId), Arrays.asList("yearlywage"));
            wageValue = Value.createValue(yearlywage.getBytes());
            store.put(wageKey, wageValue);
            //endregion

            //region Put bonus to KVlite
            wageKey = Key.createKey(Arrays.asList(table, personId), Arrays.asList("bonus"));
            wageValue = Value.createValue(bonus.getBytes());
            store.put(wageKey, wageValue);
            //endregion

            //System.out.println(actorId + "\t" + movieId + "\t" + role);
        }
        resultSet.close();
        //endregion

        jdbcStatement.close();
    }

    // Load the Person table which is joined with the Wage table from KVLite
    public static String getPersonTable(KVStore store){
        String table = "person";
        String returnValue = "";
        Key majorkeyPathOnly = Key.createKey(Arrays.asList(table));

        Integer fieldCount = 8;
        Integer j = 0;
        Iterator<KeyValueVersion> fields = store.storeIterator(Direction.UNORDERED, 0, majorkeyPathOnly, null, null);
        while(fields.hasNext()) {
            KeyValueVersion current = fields.next();
            if(j%fieldCount==0) {
                returnValue += "\n\nPerson: \n\tpersonid: " + current.getKey().getMajorPath().get(1);
            }
            String fieldName = current.getKey().getMinorPath().get(0);
            String fieldValue = new String(current.getValue().getValue());

            returnValue += "\n\t" + fieldName + ": " + fieldValue;
            j++;
        }
        return returnValue;
    }

    // Load the IncomeTax table which is joined with the IncomeTaxBracket table from KVLite
    public static String getIncomeTaxTable(KVStore store){
        String table = "IncomeTax";
        String returnValue = "";
        Key majorkeyPathOnly = Key.createKey(Arrays.asList(table));

        Integer fieldCount = 9;
        Integer j = 0;
        Iterator<KeyValueVersion> fields = store.storeIterator(Direction.UNORDERED, 0, majorkeyPathOnly, null, null);
        while(fields.hasNext()) {
            KeyValueVersion current = fields.next();
            if(j%fieldCount==0) {
                returnValue += "\n\nIncomeTax: \n\tid: " + current.getKey().getMajorPath().get(1);
            }
            String fieldName = current.getKey().getMinorPath().get(0);
            String fieldValue = new String(current.getValue().getValue());

            returnValue += "\n\t" + fieldName + ": " + fieldValue;
            j++;
        }
        return returnValue;
    }

    // Load the Wage table from KVLite
    public static String getWageTable(KVStore store){
        String table = "wage";
        String returnValue = "";
        Key majorkeyPathOnly = Key.createKey(Arrays.asList(table));

        Integer fieldCount = 3;
        Integer j = 0;
        Iterator<KeyValueVersion> fields = store.storeIterator(Direction.UNORDERED, 0, majorkeyPathOnly, null, null);
        while(fields.hasNext()) {
            KeyValueVersion current = fields.next();
            if(j%fieldCount==0) {
                returnValue += "\n\nWage: \n\tpersonid: " + current.getKey().getMajorPath().get(1);
            }
            String fieldName = current.getKey().getMinorPath().get(0);
            String fieldValue = new String(current.getValue().getValue());

            returnValue += "\n\t" + fieldName + ": " + fieldValue;
            j++;
        }
        return returnValue;
    }
}
