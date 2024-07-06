import '../database_query_helper.dart';

class AzkarFavoriteTable {
  static const String tableName = 'AzkarFavorite';

  //Columns
  static const String id = 'id';
  static const String title = 'title';
  static const String content = 'content';
  static const String description = 'description';
  static const String count = 'count';
  static const String haveList = 'haveList';
  static const String list = 'list';
  static const String date = 'date';

  static String get onCreateString => DatabaseQueryHelper.createTableQuery(
        tableName,
        {
          id: DatabaseQueryHelper.intPrimaryKey,
          title: DatabaseQueryHelper.textNotNull,
          content: DatabaseQueryHelper.textNotNull,
          description: DatabaseQueryHelper.textNotNull,
          count: DatabaseQueryHelper.intNotNull,
          haveList: DatabaseQueryHelper.intNotNull, //bool 0-1
          list: DatabaseQueryHelper.textNotNull,
          date: DatabaseQueryHelper.textNotNull,
        },
      );
}
