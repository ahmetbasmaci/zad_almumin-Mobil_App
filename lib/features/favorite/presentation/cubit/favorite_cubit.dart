import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:zad_almumin/core/extentions/extentions.dart';
import 'package:zad_almumin/core/utils/enums/enums.dart';
import 'package:zad_almumin/core/utils/params/params.dart';
import '../../../azkar/azkar.dart';
import '../../../home/home.dart';
import '../../favorite.dart';
part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  final GlobalKey<AnimatedListState> listKey = GlobalKey();
  final FavoriteGetAllUseCase favoriteGetAllUseCase;

  FavoriteCubit({required this.favoriteGetAllUseCase}) : super(const FavoriteInitState()) {
    getAllSavedData();
  }

  void changeFavoriteZikrCategory(FavoriteZikrCategory newFavoriteZikrCategory) {
    emit(FavoriteInitState(favoriteZikrCategory: newFavoriteZikrCategory));
    getAllSavedData();
  }

  Future<void> getAllSavedData() async {
    var result = await favoriteGetAllUseCase.call(NoParams());

    result.fold(
      (l) {
        emit(FavoriteErrorState(message: l.message, favoriteZikrCategory: state.favoriteZikrCategory));
      },
      (r) {
        if (state.favoriteZikrCategory == FavoriteZikrCategory.all) {
          emit(FavoriteLoadedState(favoriteZikrModels: r, favoriteZikrCategory: state.favoriteZikrCategory));
        } else {
          emit(
            FavoriteLoadedState(
              favoriteZikrModels: r.where((element) => element.zikrCategory == state.favoriteZikrCategory).toList(),
              favoriteZikrCategory: state.favoriteZikrCategory,
            ),
          );
        }
      },
    );
  }

  Future<void> getFilteredZikrModels(String searchText) async {
    var result = await favoriteGetAllUseCase.call(NoParams());

    result.fold(
      (l) {
        emit(FavoriteErrorState(message: l.message, favoriteZikrCategory: state.favoriteZikrCategory));
      },
      (r) {
        var filteredList = <BaseFavoriteEntities>[];
        if (searchText.isEmpty) {
          filteredList = r;
        } else {
          filteredList.addAll(_filterList(r, searchText));
        }

        emit(FavoriteLoadedState(favoriteZikrModels: filteredList, favoriteZikrCategory: state.favoriteZikrCategory));
      },
    );
  }

  List<BaseFavoriteEntities> _filterList(List<BaseFavoriteEntities> list, String searchText) {
    bool showQuran = state.favoriteZikrCategory == FavoriteZikrCategory.quran ||
        state.favoriteZikrCategory == FavoriteZikrCategory.all;
    bool showHadith = state.favoriteZikrCategory == FavoriteZikrCategory.hadiths ||
        state.favoriteZikrCategory == FavoriteZikrCategory.all;
    bool showAzkar = state.favoriteZikrCategory == FavoriteZikrCategory.azkar ||
        state.favoriteZikrCategory == FavoriteZikrCategory.all;
    bool showAllahNames = state.favoriteZikrCategory == FavoriteZikrCategory.allahNames ||
        state.favoriteZikrCategory == FavoriteZikrCategory.all;

    return list.where(
      (element) {
        if (element is QuranCardModel && showQuran) {
          return element.zikrCategory == state.favoriteZikrCategory &&
                  element.content.removeTashkil.contains(searchText) ||
              element.surahName.contains(searchText);
        } else if (element is HadithCardModel && showHadith) {
          return element.hadithText.contains(searchText) ||
              element.hadithBookName.contains(searchText) ||
              element.chapterBookname.contains(searchText);
        } else if (element is ZikrCardModel && showAzkar) {
          return element.content.contains(searchText) || element.description.contains(searchText);
        } else if (element is AllahNamesCardModel && showAllahNames) {
          return element.name.contains(searchText) || element.content.contains(searchText);
        } else
          return false;
      },
    ).toList();
  }
}
