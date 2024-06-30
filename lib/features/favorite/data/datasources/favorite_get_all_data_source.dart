import 'package:zad_almumin/core/database/tables/quran_favorite_table.dart';
import 'package:zad_almumin/features/home/data/models/quran/quran_card_model.dart';

import '../../../../core/database/i_database_manager.dart';
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
    //TODO add other categories



    if(quranResult.isEmpty) return [];
    List<BaseFavoriteEntities> totalResult = [];
    if (quranResult.isNotEmpty) {
      totalResult.addAll(quranResult.map((e) => QuranCardModel.fromJson(e)).toList());
    }

    totalResult.sort((a, b) => a.date == null || b.date == null ? 0 : b.date!.compareTo(a.date!));

    return totalResult;
  }
}
