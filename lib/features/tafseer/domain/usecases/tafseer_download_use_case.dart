import 'package:dartz/dartz.dart';
import 'package:zad_almumin/core/error/failure/failure.dart';
import 'package:zad_almumin/core/usecase/usecase.dart';
import 'package:zad_almumin/features/tafseer/tafseer.dart';

import '../../../../core/utils/params/params.dart';

class TafseerDownloadUseCase extends IUseCaseAsync<bool, DownloadTafseerParams> {
  //StreamedResponse
  ITafseerRepository tafseerRepository;

  TafseerDownloadUseCase({required this.tafseerRepository});

  @override
  Future<Either<Failure, bool>> call(DownloadTafseerParams params) {
    return tafseerRepository.downloadTafseer(params.tafseerId);
  }
}
