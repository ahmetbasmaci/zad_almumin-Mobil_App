class DatabaseQueryHelper {
  static const String createTable = 'CREATE TABLE';
  static const String insertInto = 'INSERT INTO';
  static const String intPrimaryKey = 'INTEGER PRIMARY KEY AUTOINCREMENT';
  static const String intNotNull = 'INTEGER';
  static const String textNotNull = 'TEXT';
  static const String doubleNotNull = 'REAL NOT NULL';
  static const String dropTableIfExist = 'DROP TABLE IF EXISTS';
  static const String selectCountFrom = 'SELECT COUNT(*) FROM';

  static String createTableQuery(String tableName, Map<String, String> columns) {
    final List<String> columnStrings = columns.entries.map((entry) => '${entry.key} ${entry.value}').toList();
    final String columnString = columnStrings.join(', ');

    return '$createTable $tableName ($columnString)';
  }
}
