package pl.lodz.p.it.isdp;

import java.sql.*;
import java.util.Properties;

public class Database implements AutoCloseable{
    private Connection connection;

    public Database(String strUrl, String login, String password) throws SQLException, ClassNotFoundException {
        Class.forName("org.apache.derby.jdbc.EmbeddedDriver");
        Properties props = new Properties();
        props.put("user", login);
        props.put("password", password);
        connection = DriverManager.getConnection(strUrl, props);
    }


    public void saveToDatabase(final long[] tab) throws SQLException {
        PreparedStatement insertSave = connection.prepareStatement(
                "insert into saves (DATE, TIME) values (current date ,current time)", PreparedStatement.RETURN_GENERATED_KEYS);
        insertSave.executeUpdate();
        ResultSet rs = insertSave.getGeneratedKeys();
        if (rs.next()) {
            saveValues(rs.getInt(1),tab);
        }
    }

    void saveValues(int saveId, long[] tab) throws SQLException {
        StringBuilder mySql = new StringBuilder("insert into save_values (VALUE, SAVE_ID) VALUES (?, ?)");
        for (int i = 0; i < tab.length - 1; i++) {
            mySql.append(", (?, ?)");
        }
        PreparedStatement insertValues = connection.prepareStatement(mySql.toString());
        for (int i = 1, j = 0; i < tab.length * 2; i += 2, j++) {
            insertValues.setLong(i, tab[j]);
            insertValues.setInt(i + 1, saveId);
        }
        insertValues.executeUpdate();
    }

    @Override
    public void close() throws Exception {
        connection.close();
    }
}
