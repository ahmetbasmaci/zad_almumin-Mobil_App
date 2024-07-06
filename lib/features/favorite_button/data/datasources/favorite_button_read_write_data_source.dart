import 'package:zad_almumin/core/database/i_database_manager.dart';
import 'package:zad_almumin/core/database/tables/azkar_favorite_table.dart';
import 'package:zad_almumin/core/database/tables/hadith_favorite_table.dart';
import 'package:zad_almumin/core/database/tables/quran_favorite_table.dart';
import 'package:zad_almumin/features/azkar/azkar.dart';
import 'package:zad_almumin/features/home/home.dart';

import '../../../../core/database/tables/allah_names_favorite_table.dart';
import '../../../favorite/favorite.dart';

abstract class IFavoriteButtonReadWriteDataSource {
  Future<void> removeItem(BaseFavoriteEntities item);
  Future<void> addItem(BaseFavoriteEntities item);
}

class FavoriteButtonReadWriteDataSource implements IFavoriteButtonReadWriteDataSource {
  final IDatabaseManager databaseManager;

  FavoriteButtonReadWriteDataSource({required this.databaseManager});
  @override
  Future<void> addItem(BaseFavoriteEntities item) async {
    var map = item.toJson();
    if (item is QuranCardModel) {
      await databaseManager.insert(tableName: QuranFavoriteTable.tableName, values: map);
    } else if (item is HadithCardModel) {
      await databaseManager.insert(tableName: HadithFavoriteTable.tableName, values: map);
    } else if (item is ZikrCardModel) {
      await databaseManager.insert(tableName: AzkarFavoriteTable.tableName, values: map);
    } else if (item is AllahNamesCardModel) {
      await databaseManager.insert(tableName: AllahNamesFavoriteTable.tableName, values: map);
    }
  }

  @override
  Future<void> removeItem(BaseFavoriteEntities item) async {
    if (item is QuranCardModel) {
      await databaseManager.deleteRowsWhere(
        tableName: QuranFavoriteTable.tableName,
        column: QuranFavoriteTable.ayahId,
        value: item.ayahId,
      );
    } else if (item is HadithCardModel) {
      await databaseManager.deleteRowsWhere(
        tableName: HadithFavoriteTable.tableName,
        column: HadithFavoriteTable.hadithId,
        value: item.hadithId,
      );
    } else if (item is ZikrCardModel) {
      await databaseManager.deleteRowsWhere(
        tableName: AzkarFavoriteTable.tableName,
        column: AzkarFavoriteTable.content,
        value: item.content,
      );
    } else if (item is AllahNamesCardModel) {
      await databaseManager.deleteRowsWhere(
        tableName: AllahNamesFavoriteTable.tableName,
        column: AllahNamesFavoriteTable.name,
        value: item.name,
      );
    }
  }
}
