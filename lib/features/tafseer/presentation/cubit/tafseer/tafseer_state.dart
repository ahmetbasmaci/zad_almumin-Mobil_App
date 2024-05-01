part of 'tafseer_cubit.dart';

class TafseerState extends Equatable {
  final SelectedTafseerIdModel selectedTafseerId;
  final List<TafseerManagerModel> tafseerModels;
  final TafseersDataModel tafseerDataModel;
  final String errorMessage;
  final bool loading;
  const TafseerState({
    required this.selectedTafseerId,
    required this.tafseerModels,
    required this.tafseerDataModel,
    required this.errorMessage,
    required this.loading,
  });
  TafseerState.init()
      : selectedTafseerId = const SelectedTafseerIdModel.init(),
        tafseerModels = [],
        tafseerDataModel = TafseersDataModel.init(),
        errorMessage = '',
        loading = true;
  TafseerState copyWith({
    SelectedTafseerIdModel? selectedTafseerId,
    List<TafseerManagerModel>? tafseerModels,
    TafseersDataModel? tafseerDataModel,
    String? errorMessage,
  }) {
    return TafseerState(
      selectedTafseerId: selectedTafseerId ?? this.selectedTafseerId,
      tafseerModels: tafseerModels ?? this.tafseerModels,
      tafseerDataModel: tafseerDataModel ?? this.tafseerDataModel,
      errorMessage: errorMessage ?? '',
      loading: false,
    );
  }

  @override
  List<Object> get props => [
        selectedTafseerId,
        tafseerModels,
        tafseerDataModel,
        errorMessage,
        loading,
      ];
}
