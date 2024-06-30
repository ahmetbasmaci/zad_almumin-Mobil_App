import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/utils/params/params.dart';
import '../../../favorite/favorite.dart';
import '../../favorite_button.dart';

part 'favorite_button_state.dart';

class FavoriteButtonCubit extends Cubit<FavoriteButtonState> {
  final FavoriteButtonRemoveItemUseCase favoriteButtonRemoveItemUseCase;
  final FavoriteButtonCheckContentIfFavoriteUseCase favoriteButtonCheckContentIfFavoriteUseCase;
  final FavoriteButtonAddItemUseCase favoriteButtonAddItemUseCase;

  FavoriteButtonCubit({
    required this.favoriteButtonRemoveItemUseCase,
    required this.favoriteButtonCheckContentIfFavoriteUseCase,
    required this.favoriteButtonAddItemUseCase,
  }) : super(const FavoriteButtonInitialState());

  Future<void> checkIfItemIsFavorite(BaseFavoriteEntities item) async {
    var result = await favoriteButtonCheckContentIfFavoriteUseCase(FavoriteParams(item: item));

    result.fold(
      (l) => emit(FavoriteButtonErrorState(message: l.message)),
      (isFavoriteResponse) => emit(FavoriteButtonInitialState(isFavorite: isFavoriteResponse)),
    );
  }

  Future<void> changeFavoriteStatus(BaseFavoriteEntities item) async {
    if (state.isFavorite) {
      _removeItem(item);
    } else {
      _addItem(item);
    }
  }

  Future<void> _removeItem(BaseFavoriteEntities item) async {
    var result = await favoriteButtonRemoveItemUseCase(FavoriteParams(item: item));

    result.fold(
      (l) => emit(FavoriteButtonErrorState(message: l.message)),
      (r) => emit(const FavoriteButtonInitialState(isFavorite: false)),
    );
  }

  Future<void> _addItem(BaseFavoriteEntities item) async {
    var result = await favoriteButtonAddItemUseCase(FavoriteParams(item: item));

    result.fold(
      (l) => emit(FavoriteButtonErrorState(message: l.message)),
      (r) => emit(const FavoriteButtonInitialState(isFavorite: true)),
    );
  }
}
