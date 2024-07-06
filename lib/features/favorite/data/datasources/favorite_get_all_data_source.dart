import 'package:zad_almumin/core/database/tables/hadith_favorite_table.dart';
import 'package:zad_almumin/core/database/tables/quran_favorite_table.dart';
import '../../../../core/database/i_database_manager.dart';
import '../../../../core/database/tables/allah_names_favorite_table.dart';
import '../../../../core/database/tables/azkar_favorite_table.dart';
import '../../../azkar/azkar.dart';
import '../../../home/home.dart';
import '../../favorite.dart';

abstract class IFavoriteGetAllDataSource {
  Future<List<BaseFavoriteEntities>> getAllFavoriteItems();
}

class FavoriteGetAllDataSource implements IFavoriteGetAllDataSource {
  final IDatabaseManager databaseManager;

  const FavoriteGetAllDataSource({required this.databaseManager});

  @override
  Future<List<BaseFavoriteEntities>> getAllFavoriteItems() async {
    final quranResult = await databaseManager.getAllRows(tableName: QuranFavoriteTable.tableName);
    final hadithResult = await databaseManager.getAllRows(tableName: HadithFavoriteTable.tableName);
    final azkarResult = await databaseManager.getAllRows(tableName: AzkarFavoriteTable.tableName);
    final allahNamesResult = await databaseManager.getAllRows(tableName: AllahNamesFavoriteTable.tableName);

    List<BaseFavoriteEntities> totalResult = [];
    if (quranResult.isNotEmpty) {
      totalResult.addAll(quranResult.map((e) => QuranCardModel.fromJson(e)).toList());
    }
    if (hadithResult.isNotEmpty) {
      totalResult.addAll(hadithResult.map((e) => HadithCardModel.fromJson(e)).toList());
    }
    if (azkarResult.isNotEmpty) {
      totalResult.addAll(azkarResult.map((e) => ZikrCardModel.fromJson(e)).toList());
    }
    if (allahNamesResult.isNotEmpty) {
      totalResult.addAll(allahNamesResult.map((e) => AllahNamesCardModel.fromJson(e)).toList());
    }

    totalResult.sort((a, b) => a.date == null || b.date == null ? 0 : b.date!.compareTo(a.date!));
    return totalResult;
  }
}
