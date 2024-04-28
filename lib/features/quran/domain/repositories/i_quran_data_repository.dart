import 'dart:core';
import 'package:dartz/dartz.dart';
import '../../../../core/error/failure/failure.dart';
import '../../../../core/packages/audio_manager/audio_manager.dart';
import '../../../../core/utils/enums/enums.dart';
import '../../quran.dart';

abstract class IQuranDataRepository {
  Either<Failure, List<Surah>> get allSurahs;
  Either<Failure, bool> get isEmpty;
  Either<Failure, bool> get isNotEmpty;
  Either<Failure, int> get surahsCount;
  Either<Failure, Surah> getSurahByPage(int page);
  Either<Failure, Surah> getSurahByName(String surahName);
  Either<Failure, Surah> getSurahByNumber(int surahNumber);
  Either<Failure, List<Ayah>> getAyahsInPage(int page);
  Either<Failure, List<Surah>> getMatchedSurah(String surahName);
  Either<Failure, Ayah> getAyah(int surahNumber, int ayahNumber);
  Either<Failure, Ayah> getRandomAyah();
  Either<Failure, Ayah> getRandomAyahBySureNumber(int sureNumber);
  Either<Failure, int> getJuzNumberByPage(int page);
  Either<Failure, int> getPageInJuz(int page);
  Future<Either<Failure, void>> saveCurrentPageIndex(int page);
  Either<Failure, int> get getSavedCurrentPageIndex;
  Either<Failure, List<dynamic>> get getSavedSearchFilterList;
  Future<Either<Failure, void>> savedSearchFilterList(List<FilterChipModel> filterChipModels);
  Either<Failure, List<int>> searchPages(int num);
  Either<Failure, List<Surah>> searchSurahs(String query);
  Either<Failure, List<Ayah>> searchAyahs(String query);
  Either<Failure, bool> get getSavedQuranViewMode;
  Future<Either<Failure, void>> saveQuranViewMode(bool quranViewModeInImages);
  Either<Failure, double> get getSavedQuranFontSize;
  Future<Either<Failure, void>> saveQuranFontSize(double fontSize);
  Either<Failure, bool> get getSavedQuranTafsserMode;
  Future<Either<Failure, void>> saveQuranTafsserMode(bool quranTafsserMode);
  Either<Failure, QuranReader> get getSavedSelectedReader;
  Future<Either<Failure, void>> savedSelectedReader(QuranReader quranReader);
  Either<Failure, List<MarkedPage>> get getSavedMarkedPages;
  Future<Either<Failure, void>> savedMarkedPages(List<MarkedPage> markedPages);
  Either<Failure, List<Ayah>> get getSavedMarkedAyahs;
  Future<Either<Failure, void>> savedMarkedAyahs(List<Ayah> markedAyahs);
  Future<Either<Failure, bool>> playPauseSingleAudio(
    List<Ayah> ayahs,
    int startAyahIndex,
    QuranReader quranReader,
    Function(Ayah complatedAyah, bool partEnded) onComplated,
  );
  Future<Either<Failure, bool>> stopAudio();

  Future<Either<Failure, AudioStreamModel>> getAudioProgress();
  Either<Failure, bool> get isAudioPlaying;
  Future<Either<Failure, bool>> checkIfSurahDownloadedBefore(int surahNumber, QuranReader reader);
  Future<Either<Failure,  Stream<double>>> downloadSurah(int surahNumber, QuranReader reader);
}
