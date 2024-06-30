import 'package:dartz/dartz.dart';
import 'package:zad_almumin/core/error/failure/failure.dart';
import 'package:zad_almumin/core/usecase/i_use_case_async.dart';
import 'package:zad_almumin/features/favorite/favorite.dart';

import '../../../../core/utils/params/params.dart';
import '../repositories/i_favorite_repository.dart';

class FavoriteGetAllUseCase extends IUseCaseAsync<List<BaseFavoriteEntities>, NoParams> {
  final IFavoriteRepository favoriteRepository;

  FavoriteGetAllUseCase({required this.favoriteRepository});
  @override
  Future<Either<Failure, List<BaseFavoriteEntities>>> call(params) async {
    return await favoriteRepository.getAllFavoriteItems();
  }
}
