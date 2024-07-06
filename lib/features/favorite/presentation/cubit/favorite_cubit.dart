import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:zad_almumin/core/extentions/dart_extention.dart';
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
        filteredList.addAll(
          r.where(
            (BaseFavoriteEntities element) {
              if (element is QuranCardModel) {
                element.content.removeTashkil.contains(searchText.removeTashkil) ||
                    element.surahName.removeTashkil.contains(searchText.removeTashkil);
              } else if (element is HadithCardModel) {
                return element.hadithText.removeTashkil.contains(searchText.removeTashkil) ||
                    element.hadithSanad.removeTashkil.contains(searchText.removeTashkil) ||
                    element.hadithBookName.removeTashkil.contains(searchText.removeTashkil);
              } else if (element is ZikrCardModel) {
                return element.title.removeTashkil.contains(searchText.removeTashkil) ||
                    element.content.removeTashkil.contains(searchText.removeTashkil) ||
                    element.description.removeTashkil.contains(searchText.removeTashkil);
              } else if (element is AllahNamesCardModel) {
                return element.name.removeTashkil.contains(searchText.removeTashkil) ||
                    element.content.removeTashkil.contains(searchText.removeTashkil);
              }

              return false;
            },
          ),
        );

        emit(FavoriteLoadedState(favoriteZikrModels: filteredList, favoriteZikrCategory: state.favoriteZikrCategory));
      },
    );
  }


}
