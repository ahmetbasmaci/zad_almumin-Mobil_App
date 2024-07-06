import '../database_query_helper.dart';

class AllahNamesFavoriteTable {
  static const String tableName = 'AllahNamesFavorite';

  //Columns
  static const String id = 'id';
  static const String name = 'name';
  static const String content = 'content';
  static const String date = 'date';

  static String get onCreateString => DatabaseQueryHelper.createTableQuery(
        tableName,
        {
          id: DatabaseQueryHelper.intPrimaryKey,
          name: DatabaseQueryHelper.textNotNull,
          content: DatabaseQueryHelper.textNotNull,
          date: DatabaseQueryHelper.textNotNull,
        },
      );
}
