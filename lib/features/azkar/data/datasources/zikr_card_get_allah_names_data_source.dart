import '../../../../core/services/json_service.dart';
import '../../../../core/utils/resources/resources.dart';
import '../../azkar.dart';

abstract class IZikrCardGetAllahNamesDataSource {
  Future<List<AllahNamesCardModel>> getAllahNamesModels();
}

class ZikrCardGetAllahNamesDataSource implements IZikrCardGetAllahNamesDataSource {
  IJsonService jsonService;

  ZikrCardGetAllahNamesDataSource({required this.jsonService});
  List<AllahNamesCardModel> result = [];
  @override
  Future<List<AllahNamesCardModel>> getAllahNamesModels() async {
    if (result.isEmpty) await _loadAllahNamesDataList();

    return result;
  }

  Future<void> _loadAllahNamesDataList() async {
    var data = await jsonService.readJson(AppJsonPaths.allhNamesAzkarPath);
    List<dynamic> mapList = data['list'];

    for (var model in mapList) {
      result.add(AllahNamesCardModel.fromJson(model));
    }
  }
}
