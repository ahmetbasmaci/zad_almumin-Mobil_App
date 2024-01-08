import '../../../../core/utils/enums/enums.dart';
import 'alarm_model.dart';

class AlarmPartModel {
  final String title;
  final AlarmPart aLarmType;
  final String imagePath;
  final List<AlarmModel> alarmModels;

  AlarmPartModel({
    required this.title,
    required this.aLarmType,
    required this.imagePath,
    required this.alarmModels,
  });

  AlarmPartModel.empty()
      : title = '',
        aLarmType = AlarmPart.dua,
        imagePath = '',
        alarmModels = [];
}
