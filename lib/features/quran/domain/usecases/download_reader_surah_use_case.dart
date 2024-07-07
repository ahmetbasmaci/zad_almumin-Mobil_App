import 'package:dartz/dartz.dart';
import 'package:zad_almumin/features/quran/domain/repositories/i_quran_data_repository.dart';
import '../../../../core/error/failure/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/params/params.dart';

class DownloadReaderSurahUseCase extends IUseCaseAsync<Stream<double>, DownloadSurahParams> {
  final IQuranDataRepository repository;

  DownloadReaderSurahUseCase({required this.repository});
  @override
  Future<Either<Failure, Stream<double>>> call(DownloadSurahParams params) {
    return repository.downloadSurahStraem(params.surahNumber, params.quranReader);
  }
}
