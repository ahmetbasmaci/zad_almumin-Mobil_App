part of 'quran_reader_surh_download_cubit.dart';

abstract class QuranReaderSurhDownloadState extends Equatable {
  const QuranReaderSurhDownloadState();

  @override
  List<Object> get props => [];
}

class QuranReaderSurhDownloadInitialState extends QuranReaderSurhDownloadState {}
class QuranReaderSurhDownloadErrorState extends QuranReaderSurhDownloadState {
  final String message;
  QuranReaderSurhDownloadErrorState({required this.message});
  @override
  List<Object> get props => [message];
}
