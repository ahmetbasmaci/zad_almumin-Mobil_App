import 'package:http/http.dart';
import 'package:zad_almumin/core/error/exceptions/app_exceptions.dart';
import 'package:zad_almumin/core/packages/app_internet_connection/app_internet_connection.dart';
import 'package:zad_almumin/core/services/files_service.dart';
import 'package:zad_almumin/core/utils/api/ayah/ayah_api.dart';
import 'package:zad_almumin/core/utils/api/consumer/consumer.dart';
import 'package:zad_almumin/core/utils/enums/enums.dart';

abstract class IQuranDownloadDataSource {
  // Future<bool> downloadSurah2(int surahNumber, QuranReader quranReader);
  Stream<double> downloadSurah(int surahNumber, QuranReader quranReader);
}

class QuranDownloadDataSource implements IQuranDownloadDataSource {
  QuranDownloadDataSource({
    required this.apiConsumer,
    required this.fileService,
    required this.ayahApi,
    required this.appInternetConnection,
  });
  final ApiConsumer apiConsumer;
  final IFilesService fileService;
  final IAyahApi ayahApi;
  final IAppInternetConnection appInternetConnection;

  // @override
  Future<bool> downloadSurah2(int surahNumber, QuranReader quranReader) async {
    //check internet connection
    AppConnectivityResult connectivityResult = await appInternetConnection.checkAppConnectivity();
    if (connectivityResult == AppConnectivityResult.none) {
      throw ServerException('No Internet Connection');
    }

    String url = ayahApi.getSurahZipDownloadUrl(surahNumber, quranReader);
    Response response = await apiConsumer.get(url);
    if (response.statusCode != 200) return false;

    String filePath = fileService.surahPath(surahNumber, quranReader);
    await fileService.writeDataIntoFileAsBytes(filePath, response.bodyBytes);
    await fileService.unArchiveAndSave(filePath);
    return true;
  }

  @override
  Stream<double> downloadSurah(int surahNumber, QuranReader quranReader) async* {
    AppConnectivityResult connectivityResult = await appInternetConnection.checkAppConnectivity();
    if (connectivityResult == AppConnectivityResult.none) {
      throw ServerException('No Internet Connection');
    }

    String url = ayahApi.getSurahZipDownloadUrl(surahNumber, quranReader);
    var response = await apiConsumer.getStream(url);
    if (response.statusCode != 200)
      throw ServerException('Error while downloading file from server status code: ${response.statusCode}');

    String filePath = fileService.surahPath(surahNumber, quranReader);

    int totalDataLength = response.contentLength ?? 0;
    int downloadedDataLength = 0;
    double progress = 0;

    await for (var element in response.stream) {
      await fileService.writeDataIntoFileAsBytes(filePath, element);
      downloadedDataLength += element.length;
      progress = double.parse((downloadedDataLength / totalDataLength * 100).toStringAsFixed(1));
      yield progress / 100;
    }
    await fileService.unArchiveAndSave(filePath);
  }
}
