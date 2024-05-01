import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zad_almumin/features/quran/domain/usecases/check_if_surah_downloaded_before_use_case.dart';
import '../../../../../../core/utils/enums/enums.dart';
import '../../../../../../core/utils/params/params.dart';
import '../../../quran.dart';
part 'quran_audio_btn_state.dart';

class QuranAudioButtonCubit extends Cubit<QuranAudioButtonState> {
  final QuranPlayPauseAudioUseCase _playPauseAudioUseCase;
  final QuranStopAudioUseCase _stopAudioUseCase;
  final CheckIfSurahDownloadedBeforeUseCase _checkIfSurahDownloadedBeforeUsecase;
  final DownloadReaderSurahUseCase _downloadReaderSurahUseCase;

  QuranAudioButtonCubit({
    required QuranPlayPauseAudioUseCase playPauseAudioUseCase,
    required QuranStopAudioUseCase stopAudioUseCase,
    required CheckIfSurahDownloadedBeforeUseCase checkIfSurahDownloadedBeforeUsecase,
    required DownloadReaderSurahUseCase downloadReaderSurahUseCase,
  })  : _downloadReaderSurahUseCase = downloadReaderSurahUseCase,
        _checkIfSurahDownloadedBeforeUsecase = checkIfSurahDownloadedBeforeUsecase,
        _stopAudioUseCase = stopAudioUseCase,
        _playPauseAudioUseCase = playPauseAudioUseCase,
        super(QuranAudioButtonStopedState());

  int currentAyahRepeatCount = 0;
  int currentAllPartRepeatCount = 0;

  Future<void> playPause({
    required List<Ayah> ayahs,
    required int startAyahIndex,
    required QuranReader quranReader,
    required void Function(Ayah complatedAyah, bool partEnded) onComplate,
  }) async {
    bool fileDownloaded = state is QuranAudioButtonPlayingState ? true : false;

    if (state is! QuranAudioButtonPlayingState) {
      //if not playing then check if surah downloaded before, if not download it
      fileDownloaded = await _checkIfFileDownloaded(ayahs[0].surahNumber, quranReader);
    }
    if (!fileDownloaded) {
      var result = await _downloadReaderSurahUseCase
          .call(DownloadSurahParams(surahNumber: ayahs[0].surahNumber, quranReader: quranReader));

      result.fold(
        (l) => emit(QuranAudioButtonFieldState(l.message)),
        (downloadStream) async {
          await downloadStream.forEach(
            (value) async {
              if (value >= 1) {
                fileDownloaded = await _checkIfFileDownloaded(ayahs[0].surahNumber, quranReader);
                if (!fileDownloaded) {
                  emit(QuranAudioButtonFieldState('Error while downloading surah: ${ayahs[0].surahName}'));
                  return;
                }
                _callPlyPauseMethod(
                  ayahs: ayahs,
                  startAyahIndex: startAyahIndex,
                  quranReader: quranReader,
                  onComplate: onComplate,
                );
              } else {
                emit(QuranAudioButtonLoadingState(downloadValue: value));
              }
            },
          );
        },
      );
    } else {
      _callPlyPauseMethod(
        ayahs: ayahs,
        startAyahIndex: startAyahIndex,
        quranReader: quranReader,
        onComplate: onComplate,
      );
    }
  }

  Future<void> stop() async {
    // emit(QuranAudioButtonLoadingState());
    var result = await _stopAudioUseCase.call(NoParams());
    result.fold(
      (l) {
        emit(QuranAudioButtonFieldState(l.message));
      },
      (r) => emit(QuranAudioButtonStopedState()),
    );
  }

  void onComplated({required Function onCmplated, required bool partEnded}) async {
    onCmplated.call();
    if (partEnded) {
      stop();
    }
  }

  Future<bool> _checkIfFileDownloaded(int surahNumber, QuranReader quranReader) async {
    bool fileDownloaded = false;
    var resultCheckSurahIdDownload = await _checkIfSurahDownloadedBeforeUsecase
        .call(CheckIfSurahDownloadedBeforeParams(surahNumber: surahNumber, quranReader: quranReader));

    resultCheckSurahIdDownload.fold(
      (l) => emit(QuranAudioButtonFieldState(l.message)),
      (isDownloaded) => fileDownloaded = isDownloaded,
    );

    return fileDownloaded;
  }

  void _callPlyPauseMethod({
    required List<Ayah> ayahs,
    required int startAyahIndex,
    required QuranReader quranReader,
    required void Function(Ayah complatedAyah, bool partEnded) onComplate,
  }) async {
    var operationSuccesState =
        state is QuranAudioButtonPlayingState ? QuranAudioButtonPausingState() : QuranAudioButtonPlayingState();

    var result = await _playPauseAudioUseCase.call(
      PlayMultibleAudioParams(
          ayahs: ayahs,
          startAyahIndex: startAyahIndex,
          quranReader: quranReader,
          onComplated: (Ayah complatedAyah, bool partEnded) {
            onComplated(
              onCmplated: () => onComplate(complatedAyah, partEnded),
              partEnded: partEnded,
            );
          }),
    );

    result.fold(
      (l) {
        // emit(QuranAudioButtonPausingState());
        emit(QuranAudioButtonFieldState(l.message));
      },
      (r) => emit(operationSuccesState),
    );
  }


}
