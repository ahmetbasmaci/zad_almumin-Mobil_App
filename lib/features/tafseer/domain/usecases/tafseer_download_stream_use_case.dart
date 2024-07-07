import 'package:dartz/dartz.dart';
import 'package:zad_almumin/core/error/failure/failure.dart';
import 'package:zad_almumin/core/usecase/usecase.dart';
import 'package:zad_almumin/features/tafseer/tafseer.dart';

import '../../../../core/utils/params/params.dart';

class TafseerDownloadStreamUseCase extends IUseCaseAsync<Stream<double>, DownloadTafseerParams> {
  ITafseerRepository tafseerRepository;

  TafseerDownloadStreamUseCase({required this.tafseerRepository});

  @override
  Future<Either<Failure, Stream<double>>> call(DownloadTafseerParams params) {
    return tafseerRepository.downloadTafseerStream(params.tafseerId);
  }
}
