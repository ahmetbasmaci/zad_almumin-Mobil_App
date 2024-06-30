import 'package:dartz/dartz.dart';

import 'package:zad_almumin/core/error/failure/failure.dart';
import 'package:zad_almumin/features/favorite/data/datasources/favorite_get_all_data_source.dart';

import 'package:zad_almumin/features/favorite/domain/entities/base_favorite_entities.dart';

import '../../domain/repositories/i_favorite_repository.dart';

class FavoriteRepository implements IFavoriteRepository {
  final IFavoriteGetAllDataSource getAllDataSource;

  const FavoriteRepository({required this.getAllDataSource});
  @override
  Future<Either<Failure, List<BaseFavoriteEntities>>> getAllFavoriteItems() async {
    try {
      var result = await getAllDataSource.getAllFavoriteItems();
      return Right(result);
    } catch (e) {
      return Left(SqliteFailure(e.toString()));
    }
  }
}
