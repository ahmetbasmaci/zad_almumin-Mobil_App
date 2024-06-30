part of 'favorite_button_cubit.dart';

abstract class FavoriteButtonState extends Equatable {
  final bool isFavorite;
  const FavoriteButtonState({required this.isFavorite});

  @override
  List<Object> get props => [isFavorite];
}

class FavoriteButtonInitialState extends FavoriteButtonState {
  const FavoriteButtonInitialState({bool? isFavorite}) : super(isFavorite: isFavorite ?? false);

  @override
  List<Object> get props => [isFavorite];
}

class FavoriteButtonErrorState extends FavoriteButtonState {
  final String message;
  const FavoriteButtonErrorState({required this.message}) : super(isFavorite: false);

  @override
  List<Object> get props => [message, isFavorite];
}
