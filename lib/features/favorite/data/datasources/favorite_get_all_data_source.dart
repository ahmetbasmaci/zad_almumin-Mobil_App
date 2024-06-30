import 'package:zad_almumin/core/database/tables/hadith_favorite_table.dart';
import 'package:zad_almumin/core/database/tables/quran_favorite_table.dart';
import '../../../../core/database/i_database_manager.dart';
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
    //TODO add other categories

    if (quranResult.isEmpty && hadithResult.isEmpty) return [];
    List<BaseFavoriteEntities> totalResult = [];
    if (quranResult.isNotEmpty) {
      totalResult.addAll(quranResult.map((e) => QuranCardModel.fromJson(e)).toList());
    }
    if (hadithResult.isNotEmpty) {
      totalResult.addAll(hadithResult.map((e) => HadithCardModel.fromJson(e)).toList());
    }
    //TODO add other categories
    totalResult.sort((a, b) => a.date == null || b.date == null ? 0 : b.date!.compareTo(a.date!));

    return totalResult;
  }
}
