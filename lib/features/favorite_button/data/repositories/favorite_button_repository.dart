import 'package:dartz/dartz.dart';
import 'package:zad_almumin/core/error/failure/failure.dart';
import 'package:zad_almumin/features/favorite/favorite.dart';
import '../../favorite_button.dart';

class FavoriteButtonRepository implements IFavoriteButtonRepository {
  final IFavoriteButtonCheckContentIfFavoriteDataSource checkContentIfFavoriteDataSource;
  final IFavoriteButtonReadWriteDataSource readWriteDataSource;

  FavoriteButtonRepository({
    required this.checkContentIfFavoriteDataSource,
    required this.readWriteDataSource,
  });

  @override
  Future<Either<Failure, Unit>> addItem(BaseFavoriteEntities item) async {
    try {
      await readWriteDataSource.addItem(item);
      return const Right(unit);
    } catch (e) {
      return Left(SqliteFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> checkItemIfFavorite(BaseFavoriteEntities itemModel) async {
    try {
      final result = await checkContentIfFavoriteDataSource.checkItemIfFavorite(itemModel);
      return Right(result);
    } catch (e) {
      return Left(SqliteFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> removeItem(BaseFavoriteEntities item) async {
    try {
      await readWriteDataSource.removeItem(item);
      return const Right(unit);
    } catch (e) {
      return Left(SqliteFailure(e.toString()));
    }
  }
}
