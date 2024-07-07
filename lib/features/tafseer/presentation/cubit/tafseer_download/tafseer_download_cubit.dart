import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/utils/enums/enums.dart';
import '../../../../../core/utils/params/params.dart';
import '../../../domain/usecases/tafseer_download_stream_use_case.dart';
import '../../../tafseer.dart';

part 'tafseer_download_state.dart';

class TafseerDownloadCubit extends Cubit<TafseerDownloadState> {
  final TafseerDownloadUseCase tafseerDownloadUseCase;
  final TafseerCheckIfDownloadedUseCase checkTafseerIfDownloadedUseCase;
  final TafseerDownloadStreamUseCase tafseerDownloadStreamUseCase;
  final TafseerWriteDataIntoFileAsBytesSyncUseCase tafseerWriteDataIntoFileAsBytesSyncUseCase;

  TafseerDownloadCubit({
    required this.tafseerDownloadUseCase,
    required this.checkTafseerIfDownloadedUseCase,
    required this.tafseerDownloadStreamUseCase,
    required this.tafseerWriteDataIntoFileAsBytesSyncUseCase,
  }) : super(TafseerDownloadInitialState());

  void downlaodTafseer(TafseerManagerModel tafseerModel) async {
    emit(TafseerDownloadDownloadingState(progress: 0, tafseerManagerModel: tafseerModel));

    var result = await tafseerDownloadStreamUseCase.call(DownloadTafseerParams(tafseerId: tafseerModel.id));
    result.fold(
      (l) => emit(TafseerDownloadErrorState(message: l.message)),
      (Stream<double> downloadStream) async {
        downloadStream.listen(
          (value) async {
            if (value >= 1) {
              //downlaod complated
              tafseerModel.downloadState = DownloadState.downloaded;
              emit(TafseerDownloadedState());
            } else {
              emit(TafseerDownloadDownloadingState(tafseerManagerModel: tafseerModel, progress: value));
            }
          },
        );
      },
    );

    // result.fold(
    //   (l) => emit(TafseerDownloadErrorState(message: l.message)),
    //   (response) async {
    //     if (response) {
    //       tafseerModel.downloadState = DownloadState.downloaded;
    //       emit(TafseerDownloadedState());
    //     } else {
    //       tafseerModel.downloadState = DownloadState.notDownloaded;
    //       emit(const TafseerDownloadErrorState(message: 'Error downloading tafseer'));
    //     }
    //   },
    // );
  }
}
