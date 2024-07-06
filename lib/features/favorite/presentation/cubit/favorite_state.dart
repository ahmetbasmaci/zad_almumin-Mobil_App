part of 'favorite_cubit.dart';

abstract class FavoriteState extends Equatable {
  final FavoriteZikrCategory favoriteZikrCategory;

  const FavoriteState({required this.favoriteZikrCategory});

  const FavoriteState.init() : favoriteZikrCategory = FavoriteZikrCategory.all;

  @override
  List<Object> get props => [favoriteZikrCategory];
}

class FavoriteInitState extends FavoriteState {
  const FavoriteInitState({FavoriteZikrCategory? favoriteZikrCategory})
      : super(favoriteZikrCategory: favoriteZikrCategory ?? FavoriteZikrCategory.all);

  @override
  List<Object> get props => [favoriteZikrCategory];
}

class FavoriteLoadedState extends FavoriteState {
  final List<BaseFavoriteEntities> favoriteZikrModels;

  const FavoriteLoadedState({required this.favoriteZikrModels, required super.favoriteZikrCategory});

  @override
  List<Object> get props => [favoriteZikrModels, favoriteZikrCategory];
}

class FavoriteErrorState extends FavoriteState {
  final String message;

  const FavoriteErrorState({required this.message, required super.favoriteZikrCategory});

  @override
  List<Object> get props => [message, favoriteZikrCategory];
}
