part of 'tafseer_cubit.dart';

class TafseerState extends Equatable {
  final SelectedTafseerIdModel selectedTafseerId;
  final List<TafseerManagerModel> tafseerModels;
  final TafseersDataModel tafseerDataModel;
  final String errorMessage;
  final bool loading;
  final String locale;
  const TafseerState({
    required this.selectedTafseerId,
    required this.tafseerModels,
    required this.tafseerDataModel,
    required this.errorMessage,
    required this.loading,
    required this.locale,
  });
  TafseerState.init()
      : selectedTafseerId = const SelectedTafseerIdModel.init(),
        tafseerModels = [],
        tafseerDataModel = TafseersDataModel.init(),
        errorMessage = '',
        loading = true,
        locale = '';
  TafseerState copyWith({
    SelectedTafseerIdModel? selectedTafseerId,
    List<TafseerManagerModel>? tafseerModels,
    TafseersDataModel? tafseerDataModel,
    String? errorMessage,
    bool? loading,
    String? locale,
  }) {
    return TafseerState(
      selectedTafseerId: selectedTafseerId ?? this.selectedTafseerId,
      tafseerModels: tafseerModels ?? this.tafseerModels,
      tafseerDataModel: tafseerDataModel ?? this.tafseerDataModel,
      errorMessage: errorMessage ?? '',
      loading: loading ?? false,
      locale: locale ?? this.locale,
    );
  }

  @override
  List<Object> get props => [
        selectedTafseerId,
        tafseerModels,
        tafseerDataModel,
        errorMessage,
        loading,
        locale,
      ];
}
