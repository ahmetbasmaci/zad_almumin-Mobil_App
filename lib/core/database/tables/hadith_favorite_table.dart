import '../database_query_helper.dart';

class HadithFavoriteTable {
  static const String tableName = 'HadithFavorite';

  //Columns
  static const String id = 'id';
  static const String hadithId = 'hadithId';
  static const String hadithBookName = 'hadithBookName';
  static const String chapterBookname = 'chapterBookname';
  static const String chapterName = 'chapterName';
  static const String hadithText = 'hadithText';
  static const String hadithSanad = 'hadithSanad';
  static const String date = 'date';

  static String get onCreateString => DatabaseQueryHelper.createTableQuery(
        tableName,
        {
          id: DatabaseQueryHelper.intPrimaryKey,
          hadithId: DatabaseQueryHelper.intNotNull,
          hadithBookName: DatabaseQueryHelper.textNotNull,
          chapterBookname: DatabaseQueryHelper.textNotNull,
          chapterName: DatabaseQueryHelper.textNotNull,
          hadithText: DatabaseQueryHelper.textNotNull,
          hadithSanad: DatabaseQueryHelper.textNotNull,
          date: DatabaseQueryHelper.textNotNull,
        },
      );
}
