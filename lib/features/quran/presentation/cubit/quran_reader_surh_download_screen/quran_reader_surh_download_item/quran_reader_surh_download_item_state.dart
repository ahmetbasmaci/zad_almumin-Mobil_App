part of 'quran_reader_surh_download_item_cubit.dart';

abstract class QuranReaderSurhDownloadItemState extends Equatable {
  const QuranReaderSurhDownloadItemState({required this.surah});
  final Surah surah;

  //add copyWith
  QuranReaderSurhDownloadItemState copyWith({
    Surah? surah,
  });

  @override
  List<Object> get props => [surah];
}

class QuranReaderSurhDownloadItemInitialState extends QuranReaderSurhDownloadItemState {
  const QuranReaderSurhDownloadItemInitialState({required super.surah});

  @override
  QuranReaderSurhDownloadItemState copyWith({Surah? surah}) {
    return QuranReaderSurhDownloadItemInitialState(surah: surah ?? this.surah);
  }
}

class QuranReaderSurhDownloadItemErrorState extends QuranReaderSurhDownloadItemState {
  final String message;
  const QuranReaderSurhDownloadItemErrorState({required this.message, required super.surah});

  @override
  QuranReaderSurhDownloadItemState copyWith({Surah? surah}) {
    return QuranReaderSurhDownloadItemErrorState(message: message, surah: surah ?? this.surah);
  }

  @override
  List<Object> get props => [message, surah];
}

class QuranReaderSurhDownloadItemDownloadingState extends QuranReaderSurhDownloadItemState {
  final double downloadValue;
  const QuranReaderSurhDownloadItemDownloadingState({required super.surah, required this.downloadValue});

  @override
  QuranReaderSurhDownloadItemState copyWith({Surah? surah, double? downloadValue}) {
    return QuranReaderSurhDownloadItemDownloadingState(
        surah: surah ?? this.surah, downloadValue: downloadValue ?? this.downloadValue);
  }

  @override
  List<Object> get props => [surah, downloadValue];
}
