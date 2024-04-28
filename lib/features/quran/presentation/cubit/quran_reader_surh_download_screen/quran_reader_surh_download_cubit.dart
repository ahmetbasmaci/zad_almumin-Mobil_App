import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:zad_almumin/core/utils/params/params.dart';
import 'package:zad_almumin/features/quran/quran.dart';

part 'quran_reader_surh_download_state.dart';

class QuranReaderSurhDownloadCubit extends Cubit<QuranReaderSurhDownloadState> {
  QuranReaderSurhDownloadCubit({
    required GetAllSurahsUseCase getAllSurahsUsecase,
  })  : _getAllSurahsUsecase = getAllSurahsUsecase,
        super(QuranReaderSurhDownloadInitialState());

  final GetAllSurahsUseCase _getAllSurahsUsecase;

  List<Surah> get getAllSurahs {
    var result = _getAllSurahsUsecase.call(NoParams());
    List<Surah> surah = [];
    result.fold(
      (l) => {
        emit(QuranReaderSurhDownloadErrorState(message: l.message)),
      },
      (r) => surah = r,
    );

    return surah;
  }
}
