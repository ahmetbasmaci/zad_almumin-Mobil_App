import 'package:dartz/dartz.dart';
import 'package:zad_almumin/core/error/failure/failure.dart';
import 'package:zad_almumin/core/helpers/printer_helper.dart';
import '../../tafseer.dart';

class TafseerRepository implements ITafseerRepository {
  final ITafseerManagertaSource tafseerManagerDataSource;
  final ITafseerDownloaderDataSource tafseerDownloaderDataSource;
  final ITafseerFileDataSource tafseerFileDataSource;
  final ITafseerSelectedDataSource tafseerSelectedDataSource;
  TafseerRepository({
    required this.tafseerManagerDataSource,
    required this.tafseerDownloaderDataSource,
    required this.tafseerFileDataSource,
    required this.tafseerSelectedDataSource,
  });
  @override
  Future<Either<Failure, List<TafseerManagerModel>>> get getAllTafsers async {
    try {
      var result = await tafseerManagerDataSource.getAllTafsers;
      return Future.value(Right(result));
    } catch (e) {
      return Future.value(Left(JsonFailure(e.toString())));
    }
  }

  @override
  Future<Either<Failure, bool>> checkTafseerIfDownloaded(int tafseerId) async {
    try {
      var result = await tafseerFileDataSource.checkTafseerIfDownloaded(tafseerId);
      return Right(result);
    } catch (e) {
      return Left(JsonFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Stream<double>>> downloadTafseerStream(int tafseerId) async {
    try {
      var result = tafseerDownloaderDataSource.downloadTafseerStream(tafseerId);
      return Future.value(Right(result));
    } catch (e) {
      return Future.value(Left(JsonFailure(e.toString())));
    }
  }

  @override
  Future<Either<Failure, bool>> downloadTafseer(int tafseerId) async {
    try {
      var result = await tafseerDownloaderDataSource.downloadTafseer(tafseerId);
      var isFirstDownload = await getSelectedTafseerId;
      isFirstDownload.fold(
        (l) => null,
        (selectedTafseer) {
          if (selectedTafseer.arabicId == 0 && selectedTafseer.englishId == 0) {
            updateSelectedTafseer(tafseerId);
          }
        },
      );
      return Right(result);
    } catch (e) {
      return Left(JsonFailure(e.toString()));
    }
  }

  @override
  Either<Failure, Unit> writeDataIntoFileIntoFileAsBytesSync(int tafseerid, List<int> data) {
    try {
      tafseerFileDataSource.writeDataIntoFileIntoFileAsBytesSync(tafseerid, data);
      return const Right(unit);
    } catch (e) {
      return Left(JsonFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> saveSelectedTafseer(SelectedTafseerIdModel tafseerIdModel) async {
    try {
      tafseerSelectedDataSource.saveSelectedTafseer(tafseerIdModel);
      return Future.value(const Right(unit));
    } catch (e) {
      return Future.value(Left(JsonFailure(e.toString())));
    }
  }

  @override
  Future<Either<Failure, SelectedTafseerIdModel>> get getSelectedTafseerId async {
    try {
      var result = await tafseerSelectedDataSource.getSelectedTafseerId;
      return Future.value(Right(result));
    } catch (e) {
      return Future.value(Left(JsonFailure(e.toString())));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateSelectedTafseer(int tafseerId) {
    // TODO: implement updateSelectedTafseer
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, TafseersDataModel>> getTafseersData(int tafseerId) async {
    try {
      var result = await tafseerFileDataSource.getTafseersData(tafseerId);
      return Future.value(Right(result));
    } catch (e) {
      PrinterHelper.printError(e.toString());
      return Future.value(Left(JsonFailure(e.toString())));
    }
  }
}
