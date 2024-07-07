import 'package:zad_almumin/core/error/exceptions/app_exceptions.dart';
import 'package:zad_almumin/core/packages/app_internet_connection/app_internet_connection.dart';
import 'package:zad_almumin/core/services/files_service.dart';
import 'package:zad_almumin/core/utils/api/ayah/ayah_api.dart';
import 'package:zad_almumin/core/utils/api/consumer/consumer.dart';
import 'package:zad_almumin/core/utils/enums/enums.dart';

abstract class IQuranDownloadDataSource {
  Stream<double> downloadSurahStraem(int surahNumber, QuranReader quranReader);
  Stream<double> downloadAyahStraem(int surahNumber, int ayahNumber, QuranReader quranReader);
}

class QuranDownloadDataSource implements IQuranDownloadDataSource {
  QuranDownloadDataSource({
    required this.apiConsumer,
    required this.filesService,
    required this.ayahApi,
    required this.appInternetConnection,
  });
  final ApiConsumer apiConsumer;
  final IFilesService filesService;
  final IAyahApi ayahApi;
  final IAppInternetConnection appInternetConnection;

  @override
  Stream<double> downloadSurahStraem(int surahNumber, QuranReader quranReader) async* {
    AppConnectivityResult connectivityResult = await appInternetConnection.checkAppConnectivity();
    if (connectivityResult == AppConnectivityResult.none) {
      throw ServerException('No Internet Connection');
    }

    String url = ayahApi.getSurahZipDownloadUrl(surahNumber, quranReader);
    var response = await apiConsumer.getStream(url);
    if (response.statusCode != 200)
      throw ServerException('Error while downloading file from server status code: ${response.statusCode}');

    int totalDataLength = response.contentLength ?? 0;
    int downloadedDataLength = 0;
    double progress = 0;

    await for (var element in response.stream) {
      await filesService.writeDataIntoSurahFileAsBytes(surahNumber, quranReader, element);
      downloadedDataLength += element.length;
      progress = double.parse((downloadedDataLength / totalDataLength * 100).toStringAsFixed(1));
      yield progress / 100;
    }
    await filesService.unArchiveAndSaveSurah(surahNumber, quranReader);
  }

  @override
  Stream<double> downloadAyahStraem(int surahNumber, int ayahNumber, QuranReader quranReader) async* {
    AppConnectivityResult connectivityResult = await appInternetConnection.checkAppConnectivity();
    if (connectivityResult == AppConnectivityResult.none) {
      throw ServerException('No Internet Connection');
    }

    String url = ayahApi.getAyahDownloadUrl(surahNumber, ayahNumber, quranReader);
    var response = await apiConsumer.getStream(url);
    if (response.statusCode != 200)
      throw ServerException('Error while downloading file from server status code: ${response.statusCode}');

    int totalDataLength = response.contentLength ?? 0;
    int downloadedDataLength = 0;
    double progress = 0;

    await for (var element in response.stream) {
      await filesService.writeDataIntoAyahFileAsBytes(surahNumber, ayahNumber, quranReader, element);
      downloadedDataLength += element.length;
      progress = double.parse((downloadedDataLength / totalDataLength * 100).toStringAsFixed(1));
      yield progress / 100;
    }
  }
}
