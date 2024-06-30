import 'package:zad_almumin/core/database/i_database_manager.dart';
import 'package:zad_almumin/features/home/data/models/quran/quran_card_model.dart';

import '../../../../core/database/tables/favorite_table.dart';
import '../../../../core/database/tables/quran_favorite_table.dart';
import '../../../favorite/favorite.dart';

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
        column: QuranFavoriteTable.dataId,
        value: itemModel.dataId,
      );
      return result.isNotEmpty;
    } //TODO add other categories

    final result = await databaseManager.getRowById(
      tableName: FavoriteTable.tableName,
      id: itemModel.id,
    );
    return result != null;
  }
}
