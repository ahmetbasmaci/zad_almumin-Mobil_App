import 'package:http/http.dart';
import 'package:zad_almumin/core/services/files_service.dart';
import 'package:zad_almumin/core/utils/enums/enums.dart';
import '../../../../core/utils/api/consumer/api_consumer.dart';
import '../../../../core/utils/firebase/firebase.dart';
import '../../tafseer.dart';

abstract class ITafseerDownloaderDataSource {
  Future<StreamedResponse> downloadTafseerStream(int tafseerId);
  Future<bool> downloadTafseer(int tafseerId);
}

class TafseerDownloaderDataSource implements ITafseerDownloaderDataSource {
  final IFirebaseStorageConsumer firebaseStorageConsumer;
  final ApiConsumer apiConsumer;
  final IFilesService filesService;
  TafseerDownloaderDataSource({
    required this.firebaseStorageConsumer,
    required this.apiConsumer,
    required this.filesService,
  });

  List<TafseerManagerModel> allTafseerData = [];
  @override
  Future<StreamedResponse> downloadTafseerStream(int tafseerId) async {
    String downloadUrl = await firebaseStorageConsumer.getUrl(FireBaseStorageFileName.tafseers, tafseerId);

    StreamedResponse response = await apiConsumer.getStream(downloadUrl);

    if (response.statusCode != 200) throw Exception("Failed to download tafseer");

    return response;
  }

  @override
  Future<bool> downloadTafseer(int tafseerId) async {
    String downloadUrl = await firebaseStorageConsumer.getUrl(FireBaseStorageFileName.tafseers, tafseerId);

    Response response = await apiConsumer.get(downloadUrl);
    if (response.statusCode != 200) throw Exception("Failed to download tafseer");

    filesService.writeDataIntoTafseerFileAsBytes(tafseerId, response.bodyBytes);

    return true;
  }
}
