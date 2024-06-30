import '../database_query_helper.dart';

class FavoriteTable {
  static const String tableName = 'Faforite';

  //Columns
  static const String id = 'id';
  static const String categoryTableItemId = 'categoryTableItemId';
  static const String category = 'category';

  static String get onCreateString => DatabaseQueryHelper.createTableQuery(
        tableName,
        {
          id: DatabaseQueryHelper.intPrimaryKey,
          categoryTableItemId: DatabaseQueryHelper.intNotNull,
          category: DatabaseQueryHelper.textNotNull,
        },
      );
}
