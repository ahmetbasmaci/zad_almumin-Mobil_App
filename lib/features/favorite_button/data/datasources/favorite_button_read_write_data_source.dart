import 'package:zad_almumin/core/database/i_database_manager.dart';
import 'package:zad_almumin/core/database/tables/hadith_favorite_table.dart';
import 'package:zad_almumin/core/database/tables/quran_favorite_table.dart';
import 'package:zad_almumin/features/home/home.dart';

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
    }
    else if (item is HadithCardModel) {
      await databaseManager.insert(tableName: HadithFavoriteTable.tableName, values: map);
    }
    
     //TODO add other categories
  }

  @override
  Future<void> removeItem(BaseFavoriteEntities item) async {
    if (item is QuranCardModel) {
      await databaseManager.deleteRowsWhere(
        tableName: QuranFavoriteTable.tableName,
        column: QuranFavoriteTable.id,
        value: item.id,
      );
    } else if (item is HadithCardModel) {
      await databaseManager.deleteRowsWhere(
        tableName: HadithFavoriteTable.tableName,
        column: HadithFavoriteTable.id,
        value: item.id,
      );
    } //TODO add other categories
  }
}
