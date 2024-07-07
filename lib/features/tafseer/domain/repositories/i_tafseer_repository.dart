import 'package:dartz/dartz.dart';

import '../../../../core/error/failure/failure.dart';
import '../../tafseer.dart';

abstract class ITafseerRepository {
  Future<Either<Failure, List<TafseerManagerModel>>> get getAllTafsers;
  Future<Either<Failure, Stream<double>>> downloadTafseerStream(int tafseerId);
  Future<Either<Failure, bool>> checkTafseerIfDownloaded(int tafseerId);
  Either<Failure, Unit> writeDataIntoFileIntoFileAsBytesSync(int tafseerid, List<int> data);
  Future<Either<Failure, bool>> downloadTafseer(int tafseerid);
  Future<Either<Failure, Unit>> saveSelectedTafseer(SelectedTafseerIdModel tafseerIdModel);
  Future<Either<Failure, SelectedTafseerIdModel>> get getSelectedTafseerId;
  Future<Either<Failure, Unit>> updateSelectedTafseer(int tafseerId);
  Future<Either<Failure, TafseersDataModel>> getTafseersData(int tafseerId);
}
