import 'package:dartz/dartz.dart';
import 'package:zad_almumin/features/quran/quran.dart';
import '../../../../core/error/failure/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/params/params.dart';

class CheckIfAyahDownloadedBeforeUseCase extends IUseCaseAsync<bool, CheckIfAyahDownloadedBeforeParams> {
  final IQuranDataRepository repository;

  CheckIfAyahDownloadedBeforeUseCase({required this.repository});
  @override
  Future<Either<Failure, bool>> call(CheckIfAyahDownloadedBeforeParams params) async {
    return repository.checkIfAyahDownloadedBefore(params.surahNumber, params.ayahNumber, params.quranReader);
  }
}
