import 'package:dartz/dartz.dart';
import 'package:zad_almumin/features/quran/domain/repositories/i_quran_data_repository.dart';
import '../../../../core/error/failure/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/params/params.dart';

class DownloadReaderAyahUseCase extends IUseCaseAsync<Stream<double>, DownloadAyahParams> {
  final IQuranDataRepository repository;

  DownloadReaderAyahUseCase({required this.repository});
  @override
  Future<Either<Failure, Stream<double>>> call(DownloadAyahParams params) {
    return repository.downloadAyah(params.surahNumber, params.ayahNumber, params.quranReader);
  }
}
