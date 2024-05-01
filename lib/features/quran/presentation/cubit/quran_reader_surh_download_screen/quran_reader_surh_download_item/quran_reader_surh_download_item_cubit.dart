import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:zad_almumin/core/extentions/extentions.dart';
import 'package:zad_almumin/core/helpers/toats_helper.dart';
import 'package:zad_almumin/core/utils/enums/enums.dart';
import 'package:zad_almumin/core/utils/params/params.dart';
import 'package:zad_almumin/features/quran/domain/usecases/check_if_surah_downloaded_before_use_case.dart';
import 'package:zad_almumin/features/quran/quran.dart';

part 'quran_reader_surh_download_item_state.dart';

class QuranReaderSurhDownloadItemCubit extends Cubit<QuranReaderSurhDownloadItemState> {
  QuranReaderSurhDownloadItemCubit({
    required CheckIfSurahDownloadedBeforeUseCase checkIfSurahDownloadedBeforeUsecase,
    required DownloadReaderSurahUseCase downloadReaderSurahUseCase,
  })  : _checkIfSurahDownloadedBeforeUsecase = checkIfSurahDownloadedBeforeUsecase,
        _downloadReaderSurahUseCase = downloadReaderSurahUseCase,
        super(QuranReaderSurhDownloadItemInitialState(surah: Surah.empty()));

  final CheckIfSurahDownloadedBeforeUseCase _checkIfSurahDownloadedBeforeUsecase;
  final DownloadReaderSurahUseCase _downloadReaderSurahUseCase;

  Future<DownloadState> checkIfSurahDownloadedBefore(Surah surah, QuranReader reader) async {
    if (state is QuranReaderSurhDownloadItemDownloadingState) {
      return DownloadState.notDownloaded;
    }
    var result = await _checkIfSurahDownloadedBeforeUsecase
        .call(CheckIfSurahDownloadedBeforeParams(surahNumber: surah.number, quranReader: reader));

    bool isDownloadedBefore = false;
    result.fold(
      (l) => {
        emit(QuranReaderSurhDownloadItemErrorState(surah: surah, message: l.message)),
      },
      (r) => isDownloadedBefore = r,
    );
    return isDownloadedBefore ? DownloadState.downloaded : DownloadState.notDownloaded;
  }

  void downlaodSurah(Surah surah, QuranReader reader) async {
    ToatsHelper.show("Downloading Surah ${surah.name} for ${reader.translatedName} reader");
    var result = await _downloadReaderSurahUseCase.call(
      DownloadSurahParams(
        surahNumber: surah.number,
        quranReader: reader,
      ),
    );
    result.fold(
      (l) => {
        emit(QuranReaderSurhDownloadItemErrorState(surah: surah, message: l.message)),
      },
      (Stream<double> downloadStream) {
        downloadStream.listen((value) async {
          if (value >= 1) {
            surah = surah.copyWith(downloadState: DownloadState.downloaded);
            emit(QuranReaderSurhDownloadItemInitialState(surah: surah));
          } else {
            emit(QuranReaderSurhDownloadItemDownloadingState(surah: surah, downloadValue: value));
          }
        });
        // for (var value in downloadStream) {
        //   if (value >= 1) {
        //     surah = surah.copyWith(downloadState: DownloadState.downloaded);
        //     emit(QuranReaderSurhDownloadItemInitialState(surah: surah));
        //   } else {
        //     emit(QuranReaderSurhDownloadItemDownloadingState(surah: surah, downloadValue: value));
        //   }
        // }
      },
    );
  }
}
