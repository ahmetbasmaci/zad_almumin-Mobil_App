import 'package:dartz/dartz.dart';
import 'package:zad_almumin/features/quran/quran.dart';
import '../../../../core/error/failure/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/params/params.dart';

class CheckIfSurahDownloadedBeforeUseCase extends IUseCaseAsync<bool, CheckIfSurahDownloadedBeforeParams> {
  final IQuranDataRepository repository;

  CheckIfSurahDownloadedBeforeUseCase({required this.repository});
  @override
  Future<Either<Failure, bool>> call(CheckIfSurahDownloadedBeforeParams params) async {
    return repository.checkIfSurahDownloadedBefore(params.surahNumber, params.quranReader);
  }
}
