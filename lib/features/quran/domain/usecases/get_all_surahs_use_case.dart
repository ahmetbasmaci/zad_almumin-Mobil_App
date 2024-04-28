import 'package:dartz/dartz.dart';
import 'package:zad_almumin/features/quran/quran.dart';
import '../../../../core/error/failure/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/params/params.dart';

class GetAllSurahsUseCase extends IUseCase<List<Surah>, NoParams> {
  final IQuranDataRepository repository;

  GetAllSurahsUseCase({required this.repository});
  @override
  Either<Failure, List<Surah>> call(NoParams params) {
    return repository.allSurahs;
  }
}
