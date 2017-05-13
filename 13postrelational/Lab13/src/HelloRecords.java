import oracle.kv.*;

import java.util.Arrays;
import java.util.Map;

/**
 * Created by djm43 on 5/5/2017.
 */
public class HelloRecords {

    public static KVStore store = KVStoreFactory.getStore(new KVStoreConfig("kvstore", "localhost:5000"));

    public static void main(String[] args) {
        String movieIdString = "92616";
        String[] valueStrings = {"Dr. Strangelove", "1964", "8.7"};
        //Exercise 13.2
        //createMovieRecord(movieIdString, valueStrings);

        //Exercise 13.3
        createMovieRecordMultValued(movieIdString, valueStrings);
        store.close();
    }

    public static void createMovieRecord(String movieIdString, String[] valueStrings) {
        System.out.println("New movie record:");

        //create/put key-value pair for each field
        String[] fieldNames = {"name", "year", "rating"};

        Key[] keys = new Key[fieldNames.length];
        Value[] values = new Value[valueStrings.length];
        String result;

        for (int i = 0; i < fieldNames.length; i++) {
            keys[i] = Key.createKey(Arrays.asList("movie", movieIdString), Arrays.asList(fieldNames[i]));
            values[i] = Value.createValue(valueStrings[i].getBytes());
            store.put(keys[i], values[i]);

            result = new String(store.get(keys[i]).getValue().getValue());
            System.out.println("\t" + keys[i].toString() + " : " + result);
        }
    }

    public static void createMovieRecordMultValued(String movieIdString, String[] valueStrings) {
        System.out.println("New movie record:");

        //create/put key-value pair for each field
        String[] fieldNames = {"name", "year", "rating"};

        Key[] keys = new Key[fieldNames.length];
        Value[] values = new Value[valueStrings.length];
        String result;

        for (int i = 0; i < fieldNames.length; i++) {
            keys[i] = Key.createKey(Arrays.asList("movie", movieIdString), Arrays.asList(fieldNames[i]));
            values[i] = Value.createValue(valueStrings[i].getBytes());
            store.put(keys[i], values[i]);
        }

        Key majorkeyPathOnly = Key.createKey(Arrays.asList("movie", movieIdString));
        Map<Key, ValueVersion> fields = store.multiGet(majorkeyPathOnly, null, null);
        for (Map.Entry<Key, ValueVersion> field : fields.entrySet()) {
            String fieldName = field.getKey().getMinorPath().get(0);
            String fieldValue = new String(field.getValue().getValue().getValue());
            System.out.println("\t" + fieldName + "\t: " + fieldValue);
        }
    }
}
