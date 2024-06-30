import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:zad_almumin/core/extentions/dart_extention.dart';
import 'package:zad_almumin/core/utils/enums/enums.dart';
import 'package:zad_almumin/core/utils/params/params.dart';

import '../../../home/home.dart';
import '../../domain/usecases/favorite_get_all_use_case.dart';
import '../../favorite.dart';
part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  final GlobalKey<AnimatedListState> listKey = GlobalKey();
  final FavoriteGetAllUseCase favoriteGetAllUseCase;

  FavoriteCubit({required this.favoriteGetAllUseCase}) : super(const FavoriteState.init());

  void changeFavoriteZikrCategory(FavoriteZikrCategory newFavoriteZikrCategory) {
    emit(state.copyWith(favoriteZikrCategory: newFavoriteZikrCategory));
  }

  Future<List<BaseFavoriteEntities>> getAllSavedData() async {
    var result = await favoriteGetAllUseCase.call(NoParams());

    return result.fold(
      (l) => [],
      (r) {
        if (state.favoriteZikrCategory == FavoriteZikrCategory.all) return r;

        return r.where((element) => element.zikrCategory == state.favoriteZikrCategory).toList();
      },
    );
  }

  Future<List<BaseFavoriteEntities>> getFilteredZikrModels(String searchText) async {
    var result = await getAllSavedData();

    if (result.isEmpty) return [];

    return result.where(
      (element) {
        if (element is QuranCardModel) {
          return (element.content.removeTashkil.contains(searchText.removeTashkil) ||
              element.surahName.removeTashkil.contains(searchText.removeTashkil));
        } //TODO add other models
        return false;
      },
    ).toList();
  }
}
