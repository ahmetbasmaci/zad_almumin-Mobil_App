import 'package:dartz/dartz.dart';
import 'package:zad_almumin/core/error/failure/failure.dart';

import '../../favorite.dart';

abstract class IFavoriteRepository {
  Future<Either< Failure,List<BaseFavoriteEntities>>> getAllFavoriteItems();
}
