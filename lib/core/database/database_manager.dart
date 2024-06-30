import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../helpers/printer_helper.dart';
import 'database_query_helper.dart';
import 'i_database_manager.dart';
import 'tables/tables.dart';

class DatabaseManager implements IDatabaseManager {
  static const int _databaseVersion = 2;
  static const String _databaseName = "zad-almumin.db";

  Database? _database;

  DatabaseManager();

  Future<Database> get _getDatabase async {
    _database ??= await _initDB();

    return _database!;
  }

  Future<Database> _initDB() async {
    // await deleteDB();
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _databaseName);
    return await openDatabase(
      path,
      onCreate: (Database db, int version) async {
        //? Add new table creation here
        onCreate(db, version, QuranFavoriteTable.onCreateString);
        onCreate(db, version, HadithFavoriteTable.onCreateString);
      },
      onUpgrade: (Database db, int oldVersion, int newVersion) async {
        //? Add new table upgrade here
        onUpgrade(db, oldVersion, newVersion, QuranFavoriteTable.tableName, QuranFavoriteTable.onCreateString);
        onUpgrade(db, oldVersion, newVersion, HadithFavoriteTable.tableName, HadithFavoriteTable.onCreateString);
      },
      version: _databaseVersion,
    );
  }

  @override
  Future<void> onCreate(Database db, int version, String creatString) async {
    try {
      await db.execute(creatString);
    } catch (e) {
      PrinterHelper.printError(e.toString());
      throw Exception('Error: Can\'nt create table !!! $e');
    }
  }

  @override
  Future<void> onUpgrade(Database db, int oldVersion, int newVersion, String tableName, String creatString) async {
    await db.execute('${DatabaseQueryHelper.dropTableIfExist} $tableName');
    await onCreate(db, newVersion, creatString);
  }

  @override
  Future<int> insert({
    required String tableName,
    required Map<String, dynamic> values,
  }) async {
    final db = await _getDatabase;
    try {
      return await db.insert(
        tableName,
        values,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      PrinterHelper.printError(e.toString());
      throw Exception('Error: Can\'nt insert data into table !!! $e');
    }
  }

  @override
  Future<int> updateById({
    required String tableName,
    required Map<String, dynamic> values,
    required int id,
  }) async {
    final db = await _getDatabase;
    return await db.update(
      tableName,
      values,
      where: 'id= ?',
      whereArgs: [id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<int> deleteById({
    required String tableName,
    required int id,
  }) async {
    final db = await _getDatabase;
    return await db.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<Map<String, dynamic>?> getRowById({
    required String tableName,
    required int id,
  }) async {
    final db = await _getDatabase;
    final query = await db.query(
      tableName,
      where: "id = ?",
      whereArgs: [id],
      limit: 1,
    );

    if (query.isEmpty) return null;
    return query.first;
  }

  @override
  Future<List<Map<String, dynamic>>> getAllRows({required String tableName}) async {
    final db = await _getDatabase;
    return db.query(tableName, orderBy: 'id');
  }

  @override
  Future<List<Map<String, dynamic>>> getRowsWhere({
    required String tableName,
    required String column,
    required dynamic value,
  }) async {
    final db = await _getDatabase;
    return db.query(
      tableName,
      where: '$column = ?',
      whereArgs: [value],
    );
  }

  @override
  Future<Map<String, dynamic>> getFirstRowWhere({
    required String tableName,
    required String column,
    required dynamic value,
  }) async {
    var data = await getRowsWhere(tableName: tableName, column: column, value: value);
    if (data.isEmpty) return <String, dynamic>{};
    return data.first;
  }

  @override
  Future<List<Map<String, dynamic>>> rawQuery(String query) async {
    final db = await _getDatabase;
    return db.rawQuery(query);
  }

  @override
  Future<int> getRowCount({required String tableName}) async {
    final db = await _getDatabase;
    int? count = Sqflite.firstIntValue(await db.rawQuery('${DatabaseQueryHelper.selectCountFrom} $tableName'));
    return count ?? -1;
  }

  @override
  Future<void> deleteDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _databaseName);
    await deleteDatabase(path);
    _database = null;
  }

  @override
  Future<int> deleteRowsWhere({
    required String tableName,
    required String column,
    required dynamic value,
  }) async {
    final db = await _getDatabase;
    return await db.delete(
      tableName,
      where: '$column = ?',
      whereArgs: [value],
    );
  }
}
