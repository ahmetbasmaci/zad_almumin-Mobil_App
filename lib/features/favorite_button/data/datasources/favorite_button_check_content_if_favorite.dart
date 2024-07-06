import 'package:zad_almumin/core/database/i_database_manager.dart';
import 'package:zad_almumin/features/azkar/azkar.dart';
import '../../../../core/database/tables/allah_names_favorite_table.dart';
import '../../../../core/database/tables/azkar_favorite_table.dart';
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
    if (itemModel is ZikrCardModel) {
      final result = await databaseManager.getFirstRowWhere(
        tableName: AzkarFavoriteTable.tableName,
        column: AzkarFavoriteTable.content,
        value: itemModel.content,
      );
      return result.isNotEmpty;
    }
    if (itemModel is AllahNamesCardModel) {
      final result = await databaseManager.getFirstRowWhere(
        tableName: AllahNamesFavoriteTable.tableName,
        column: AllahNamesFavoriteTable.name,
        value: itemModel.name,
      );
      return result.isNotEmpty;
    }

    return false;
  }
}
