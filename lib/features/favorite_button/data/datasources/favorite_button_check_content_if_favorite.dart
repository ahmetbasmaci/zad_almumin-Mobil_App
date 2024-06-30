import 'package:zad_almumin/core/database/i_database_manager.dart';
import '../../../../core/database/tables/tables.dart';
import '../../../favorite/favorite.dart';
import '../../../home/home.dart';

abstract class IFavoriteButtonCheckContentIfFavoriteDataSource {
  Future<bool> checkItemIfFavorite(BaseFavoriteEntities itemModel);
}

class FavoriteButtonCheckContentIfFavoriteDataSource implements IFavoriteButtonCheckContentIfFavoriteDataSource {
  final IDatabaseManager databaseManager;

  FavoriteButtonCheckContentIfFavoriteDataSource({required this.databaseManager});

  @override
  Future<bool> checkItemIfFavorite(BaseFavoriteEntities itemModel) async {
    if (itemModel is QuranCardModel) {
      final result = await databaseManager.getFirstRowWhere(
        tableName: QuranFavoriteTable.tableName,
        column: QuranFavoriteTable.ayahId,
        value: itemModel.ayahId,
      );
      return result.isNotEmpty;
    }
    if (itemModel is HadithCardModel) {
      final result = await databaseManager.getFirstRowWhere(
        tableName: HadithFavoriteTable.tableName,
        column: HadithFavoriteTable.hadithId,
        value: itemModel.hadithId,
      );
      return result.isNotEmpty;
    }

    //TODO add other categories

    return false;
  }
}
