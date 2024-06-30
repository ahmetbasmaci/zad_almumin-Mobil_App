import '../database_query_helper.dart';

class QuranFavoriteTable {
  static const String tableName = 'QuranFavorite';

  //Columns
  static const String id = 'id';
  static const String dataId = 'dataId';
  static const String content = 'content';
  static const String surahname = 'surahName';
  static const String juz = 'juz';
  static const String ayahNumber = 'ayahNumber';
  static const String surahNumber = 'surahNumber';
  static const String date = 'date';

  static String get onCreateString => DatabaseQueryHelper.createTableQuery(
        tableName,
        {
          id: DatabaseQueryHelper.intPrimaryKey,
          dataId: DatabaseQueryHelper.intNotNull,
          content: DatabaseQueryHelper.textNotNull,
          surahname: DatabaseQueryHelper.textNotNull,
          juz: DatabaseQueryHelper.intNotNull,
          ayahNumber: DatabaseQueryHelper.intNotNull,
          surahNumber: DatabaseQueryHelper.intNotNull,
          date: DatabaseQueryHelper.textNotNull,
        },
      );
}
