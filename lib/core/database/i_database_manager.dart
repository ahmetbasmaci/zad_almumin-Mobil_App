import 'package:sqflite/sqflite.dart';

abstract class IDatabaseManager {
  Future<int> insert({
    required String tableName,
    required Map<String, dynamic> values,
  });

  Future<int> updateById({
    required String tableName,
    required Map<String, dynamic> values,
    required int id,
  });

  Future<int> deleteById({
    required String tableName,
    required int id,
  });

  Future<Map<String, dynamic>?> getRowById({
    required String tableName,
    required int id,
  });

  Future<List<Map<String, dynamic>>> getAllRows({required String tableName});

  // Gets the rows where specified column is specified value
  Future<List<Map<String, dynamic>>> getRowsWhere({
    required String tableName,
    required String column,
    required dynamic value,
  });
  Future<Map<String, dynamic>> getFirstRowWhere({
    required String tableName,
    required String column,
    required dynamic value,
  });
  Future<List<Map<String, dynamic>>> rawQuery(String query);

  Future<int> deleteRowsWhere({
    required String tableName,
    required String column,
    required dynamic value,
  });

  Future<int> getRowCount({required String tableName});

  Future<void> deleteDB();

  Future<void> onCreate(Database db, int version, String creatString);

  Future<void> onUpgrade(Database db, int oldVersion, int newVersion, String tableName, String creatString);
  Future<void> closeDatabase();
}
