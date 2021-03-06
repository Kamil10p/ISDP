package pl.lodz.p.it.isdp;

import java.sql.SQLException;
import java.util.Arrays;
import java.util.Map;

/**
 * Uwaga: Klasa zawiera błędy, które trzeba zidentyfikować i usunąć z
 * zastosowaniem trybu debug (nadzorowane wykonanie z wykorzystanie debuggera), tak by
 * tablica była inicjowana wartościami losowymi a następnie sortowana.
 */
public class SortTabNumbers {

    private long tab[];

    public SortTabNumbers(final int max) {
        tab = new long[max];
        for (int i = 0; i < max; i++) {
            tab[i] = (long) (Math.random() * Long.MAX_VALUE);
        }
    }

    /*
     * W metodzie należy zminimalizować liczbę wykonywanych porównań
     * opdpowiednio ustalając wartości początkową dla zmienej j.
     */
    public void sort() {
        for (int i = 0; i < tab.length - 1; i++) {
            for (int j = i + 1; j < tab.length; j++) {
                if (tab[i] > tab[j]) {
                    swap(i, j);
                }
            }
        }

        saveTabToDatabase();
    }

    private void saveTabToDatabase() {
        String baseDir = System.getProperty("user.dir");

        String databaseName = System.getenv("DATABASE_NAME");
        String username = System.getenv("USER_NAME");
        String password = System.getenv("PASSWORD");

        String url = "jdbc:derby:" + baseDir + "/" + databaseName;

        try (Database database = new Database(url, username, password)) {
            database.saveToDatabase(tab);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void swap(final int i, final int j) {
        long tmp = tab[i];
        tab[i] = tab[j];
        tab[j] = tmp;
    };

    public boolean checkMinOrderSort() {
        for (int k = 0; k < tab.length - 1; k++) {
            if (tab[k] > tab[k + 1]) {
                return false;
            }
        }
        return true;
    }

    @Override
    public String toString() {
        return "tab=" + Arrays.toString(tab);
    }
}
