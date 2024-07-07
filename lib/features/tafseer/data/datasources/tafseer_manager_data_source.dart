import '../../../../core/services/files_service.dart';
import '../../../../core/services/json_service.dart';
import '../../../../core/utils/enums/enums.dart';
import '../../../../core/utils/resources/resources.dart';
import '../../tafseer.dart';

abstract class ITafseerManagertaSource {
  Future<List<TafseerManagerModel>> get getAllTafsers;
}

class TafseerManagerDataSource implements ITafseerManagertaSource {
  final IJsonService jsonService;
  final IFilesService filesService;
  TafseerManagerDataSource({
    required this.jsonService,
    required this.filesService,
  });

  List<TafseerManagerModel> allTafseerData = [];
  @override
  Future<List<TafseerManagerModel>> get getAllTafsers async {
    if (allTafseerData.isEmpty) await _loadTafseerData();
    await _updateTafseersDownloadState();
    //return tafseers by selected language
    return allTafseerData;
  }

  Future<void> _loadTafseerData() async {
    List<dynamic> data = await jsonService.readJson(AppJsonPaths.tafseersPath);
    if (data.isEmpty) return;
    allTafseerData = data.map((e) => TafseerManagerModel.fromJson(e)).toList();
  }

  Future<void> _updateTafseersDownloadState() async {
    //check if tafseer is downloaded
    for (var element in allTafseerData) {
      bool downloaded = await filesService.checkIfTafseerFileDownloaded(element.id);
      if (downloaded) {
        element.downloadState = DownloadState.downloaded;
      }
    }
  }
}
