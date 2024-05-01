import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:zad_almumin/features/alarm/domain/usecases/update_alarm_model_use_case.dart';
import '../../../../core/utils/enums/enums.dart';
import '../../../../core/utils/params/params.dart';
import '../../../pray_times/data/models/time.dart';
import '../../data/models/alarm_part_model.dart';
import '../../domain/usecases/get_alarm_part_data_use_case.dart';

import '../../data/models/alarm_model.dart';

part 'alarm_state.dart';

class AlarmCubit extends Cubit<AlarmState> {
  final GetAlarmPartDataUseCase _getAlarmPartDataUseCase;
  final UpdateAlarmModelUseCase _updateAlarmModelUseCase;
  AlarmCubit({
    required GetAlarmPartDataUseCase getAlarmPartDataUseCase,
    required UpdateAlarmModelUseCase triggerAlarmActivatingUseCase,
  })  : _updateAlarmModelUseCase = triggerAlarmActivatingUseCase,
        _getAlarmPartDataUseCase = getAlarmPartDataUseCase,
        super(AlarmInitial());

  AlarmPartModel getAlarmPart(AlarmPart aLarmType) {
    var result = _getAlarmPartDataUseCase.call(
      GetAlarmDataPartParams(aLarmType: aLarmType),
    );
    AlarmPartModel alarmPartModel = result.fold(
      (l) => AlarmPartModel.empty(),
      (r) => r,
    );

    return alarmPartModel;
  }

  void updateAlarmModel(AlarmModel alarmModel) {
    _updateAlarmModelUseCase.call(UpdateAlarmModelParams(alarmModel: alarmModel));
    emit(AlarmUpdatedState(alarmModel));
  }

  void triggerAlarmActivation(AlarmModel alarmModel) {
    alarmModel.isActive = !alarmModel.isActive;
    updateAlarmModel(alarmModel);
  }

  void updateAlarmTime(PeriodicAlarmModel alarmModel, Time time) {
    alarmModel.time = time;
    updateAlarmModel(alarmModel);
  }

  void updateAlarmRepeated(RepeatedAlarmModel alarmModel, RepeatAlarmType newValue) {
    alarmModel.repeatAlarmType = newValue;
    updateAlarmModel(alarmModel);
  }
}
