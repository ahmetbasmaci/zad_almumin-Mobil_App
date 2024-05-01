import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../../../core/utils/enums/enums.dart';
import '../../../../../../core/utils/params/params.dart';
import '../../../../../quran/quran.dart';
import '../../../../home.dart';
part 'home_quran_audio_button_state.dart';

class HomeQuranAudioButtonCubit extends Cubit<HomeQuranAudioButtonState> {
  final HomeCardPlayPauseSingleAudioUseCase _playPauseSingleAudioUseCase;
  final CheckIfAyahDownloadedBeforeUseCase _checkIfAyahDownloadedBeforeUsecase;
  final DownloadReaderAyahUseCase _downloadReaderAyahUseCase;

  HomeQuranAudioButtonCubit({
    required HomeCardPlayPauseSingleAudioUseCase playPauseSingleAudioUseCase,
    required CheckIfAyahDownloadedBeforeUseCase checkIfAyahDownloadedBeforeUsecase,
    required DownloadReaderAyahUseCase downloadReaderAyahUseCase,
  })  : _playPauseSingleAudioUseCase = playPauseSingleAudioUseCase,
        _checkIfAyahDownloadedBeforeUsecase = checkIfAyahDownloadedBeforeUsecase,
        _downloadReaderAyahUseCase = downloadReaderAyahUseCase,
        super(HomeQuranAudioButtonPausingState());

  void playPause({
    required QuranCardModel quranCardModel,
    required QuranReader quranReader,
    required Function onComplate,
  }) async {
    bool fileDownloaded = state is HomeQuranAudioButtonPlayingState ? true : false;

    if (state is! HomeQuranAudioButtonPlayingState) {
      //if not playing then check if ayah downloaded before, if not download it
      fileDownloaded = await _checkIfFileDownloaded(quranCardModel.surahNumber, quranCardModel.ayahNumber, quranReader);
    }
    if (!fileDownloaded) {
      var result = await _downloadReaderAyahUseCase.call(
        DownloadAyahParams(
          surahNumber: quranCardModel.surahNumber,
          ayahNumber: quranCardModel.ayahNumber,
          quranReader: quranReader,
        ),
      );

      result.fold(
        (l) => emit(HomeQuranAudioButtonFieldState(l.message)),
        (downloadStream) async {
          await downloadStream.forEach(
            (value) async {
              if (value >= 1) {
                fileDownloaded =
                    await _checkIfFileDownloaded(quranCardModel.surahNumber, quranCardModel.ayahNumber, quranReader);
                if (!fileDownloaded) {
                  emit(HomeQuranAudioButtonFieldState('Error while downloading ayah: ${quranCardModel.surahName}'));
                  return;
                }
                _callPlyPauseMethod(
                  quranCardModel: quranCardModel,
                  quranReader: quranReader,
                  onComplate: onComplate,
                );
              } else {
                emit(HomeQuranAudioButtonLoadingState(downloadValue: value));
              }
            },
          );
        },
      );
    } else {
      _callPlyPauseMethod(
        quranCardModel: quranCardModel,
        quranReader: quranReader,
        onComplate: onComplate,
      );
    }

    // var operationSuccesState = state is HomeQuranAudioButtonPlayingState
    //     ? HomeQuranAudioButtonPausingState()
    //     : HomeQuranAudioButtonPlayingState();

    // emit(HomeQuranAudioButtonLoadingState());

    // var result = await playPauseSingleAudioUseCase.call(
    //   PlayAudioParams(
    //     ayahs: quranCardModel,
    //     quranReader: quranReader,
    //     onComplated: () => _onAudioComplated(onComplate),
    //   ),
    // );

    // result.fold(
    //   (l) {
    //     // emit(HomeQuranAudioButtonPausingState());
    //     emit(HomeQuranAudioButtonFieldState(l.message));
    //   },
    //   (r) => emit(operationSuccesState),
    // );
  }

  void _callPlyPauseMethod({
    required QuranCardModel quranCardModel,
    required QuranReader quranReader,
    required Function onComplate,
  }) async {
    var operationSuccesState = state is HomeQuranAudioButtonPlayingState
        ? HomeQuranAudioButtonPausingState()
        : HomeQuranAudioButtonPlayingState();

    var result = await _playPauseSingleAudioUseCase.call(
      PlayAudioParams(
        ayahs: quranCardModel,
        quranReader: quranReader,
        onComplated: () => _onAudioComplated(onComplate),
      ),
    );

    result.fold(
      (l) {
        // emit(QuranAudioButtonPausingState());
        emit(HomeQuranAudioButtonFieldState(l.message));
      },
      (r) => emit(operationSuccesState),
    );
  }

  Future<bool> _checkIfFileDownloaded(int surahNumber, int ayahNumebr, QuranReader quranReader) async {
    bool fileDownloaded = false;
    var resultCheckAyahIdDownload = await _checkIfAyahDownloadedBeforeUsecase.call(
        CheckIfAyahDownloadedBeforeParams(surahNumber: surahNumber, ayahNumber: ayahNumebr, quranReader: quranReader));

    resultCheckAyahIdDownload.fold(
      (l) => emit(HomeQuranAudioButtonFieldState(l.message)),
      (isDownloaded) => fileDownloaded = isDownloaded,
    );

    return fileDownloaded;
  }

  void pause() {
    emit(HomeQuranAudioButtonPausingState());
  }

  void _onAudioComplated(Function onComplate) {
    // emit(HomeQuranAudioButtonPausingState());
    onComplate();
  }
}
