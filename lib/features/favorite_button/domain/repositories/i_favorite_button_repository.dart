import 'package:dartz/dartz.dart';

import '../../../../core/error/failure/failure.dart';
import '../../../favorite/favorite.dart';

abstract class IFavoriteButtonRepository {
  Future<Either<Failure, bool>> checkItemIfFavorite(BaseFavoriteEntities itemModel);
  Future<Either<Failure, Unit>> removeItem(BaseFavoriteEntities itemModel);
  Future<Either<Failure, Unit>> addItem(BaseFavoriteEntities itemModel);
}
