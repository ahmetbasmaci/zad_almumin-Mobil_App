part of 'favorite_cubit.dart';

class FavoriteState extends Equatable {
  final FavoriteZikrCategory favoriteZikrCategory;
  final List<BaseFavoriteEntities> favoriteZikrModels;

  const FavoriteState({required this.favoriteZikrModels, required this.favoriteZikrCategory});

  const FavoriteState.init()
      : favoriteZikrCategory = FavoriteZikrCategory.all,
        favoriteZikrModels = const [];

  FavoriteState copyWith({
    FavoriteZikrCategory? favoriteZikrCategory,
    List<BaseFavoriteEntities>? favoriteZikrModels,
  }) {
    return FavoriteState(
      favoriteZikrCategory: favoriteZikrCategory ?? this.favoriteZikrCategory,
      favoriteZikrModels: favoriteZikrModels ?? this.favoriteZikrModels,
    );
  }

  @override
  List<Object> get props => [favoriteZikrCategory, favoriteZikrModels];
}
