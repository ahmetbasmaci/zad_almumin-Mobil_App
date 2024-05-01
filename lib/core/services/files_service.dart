import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:archive/archive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:zad_almumin/core/extentions/dart_extention.dart';
import 'package:zad_almumin/core/utils/resources/app_constants.dart';
import '../utils/enums/enums.dart';
import 'package:path/path.dart' as p;

abstract class IFilesService {
  Future<bool> checkIfTafseerFileDownloaded(int tafseerId);
  Future<bool> checkIfAyahFileDownloaded(int surahNumber, int ayahNumber, QuranReader quranReader);
  Future<bool> checkIfSurahFileDownloaded(int surahNumber, QuranReader quranReader);

  String ayahPath(int surahNumber, int ayahNumber, QuranReader quranReader);
  String ayahFromSurahPath(int surahNumber, int ayahNumber, QuranReader quranReader);

  Future<void> writeDataIntoTafseerFileAsBytes(int tafseerId, List<int> data);
  Future<void> writeDataIntoSurahFileAsBytes(int surahNumber, QuranReader quranReader, List<int> data);
  Future<void> writeDataIntoAyahFileAsBytes(int surahNumber, int ayahNumber, QuranReader quranReader, List<int> data);

  Future<Map?> getTafseerFile(int tafseerId);
  Future<Map?> getSurahFile(int surahNumber, QuranReader quranReader);

  Future unArchiveAndSaveSurah(int surahNumber, QuranReader quranReader);
  Future unArchiveAndSaveTafseer(int tafseerId);
}

class FilesService implements IFilesService {
  FilesService() {
    _initFileDir();
  }

  Future<void> _initFileDir() async {
    _filesDir = (await getApplicationDocumentsDirectory()).path;
  }

  static String _filesDir = "";

  @override
  String ayahPath(int surahNumber, int ayahNumber, QuranReader quranReader) {
    return '$_filesDir/quran_ayahs/${quranReader.name}/${surahNumber.formated3}_${ayahNumber.formated3}.mp3';
  }

  @override
  String ayahFromSurahPath(int surahNumber, int ayahNumber, QuranReader quranReader) {
    return '$_filesDir/quran_surahs/${quranReader.name}/${surahNumber.formated3}${ayahNumber.formated3}.mp3';
  }

  @override
  Future<bool> checkIfTafseerFileDownloaded(int tafseerId) async {
    String filePath = _tafseerPath(tafseerId);

    bool exist = await _checkIfFileExist(filePath);

    return exist;
  }

  @override
  Future<bool> checkIfAyahFileDownloaded(int surahNumber, int ayahNumber, QuranReader quranReader) async {
    String filePath = ayahPath(surahNumber, ayahNumber, quranReader);

    bool exist = await _checkIfFileExist(filePath);

    return exist;
  }

  @override
  Future<bool> checkIfSurahFileDownloaded(int surahNumber, QuranReader quranReader) async {
    String filePath = _surahPath(surahNumber, quranReader);

    bool exist = await _checkIfFileExist(filePath);

    return exist;
  }

  @override
  Future<void> writeDataIntoSurahFileAsBytes(int surahNumber, QuranReader quranReader, List<int> data) async {
    String filePath = _surahPath(surahNumber, quranReader);
    await _writeDataIntoFileAsBytes(filePath, data);
  }

  @override
  Future<void> writeDataIntoAyahFileAsBytes(
      int surahNumber, int ayahNumber, QuranReader quranReader, List<int> data) async {
    String filePath = ayahPath(surahNumber, ayahNumber, quranReader);
    await _writeDataIntoFileAsBytes(filePath, data);
  }

  @override
  Future<void> writeDataIntoTafseerFileAsBytes(int tafseerId, List<int> data) async {
    String filePath = _tafseerPath(tafseerId);
    await _writeDataIntoFileAsBytes(filePath, data);
  }

  @override
  Future<Map?> getTafseerFile(int tafseerId) async {
    String filePath = _tafseerPath(tafseerId);
    return _getFile(filePath);
  }

  @override
  Future<Map?> getSurahFile(int surahNumber, QuranReader quranReader) async {
    String filePath = _surahPath(surahNumber, quranReader);
    return _getFile(filePath);
  }

  @override
  Future unArchiveAndSaveTafseer(int tafseerId) async {
    String filePath = _tafseerPath(tafseerId);
    return _unArchiveAndSave(filePath);
  }

  @override
  Future unArchiveAndSaveSurah(int surahNumber, QuranReader quranReader) async {
    String filePath = _surahPath(surahNumber, quranReader);
    return _unArchiveAndSave(filePath);
  }

  Future<void> _writeDataIntoFileAsBytes(String filePath, List<int> data) async {
    File file = await File(filePath).create(recursive: true);
    await file.writeAsBytes(data, mode: FileMode.append);
  }

  String _tafseerPath(int id) {
    return '$_filesDir/tafseer_${AppConstants.context.localeCode}_$id.json';
  }

  String _surahPath(int surahNumber, QuranReader quranReader) {
    return '$_filesDir/quran_surahs/${quranReader.name}/${surahNumber.formated3}.zib';
  }

  Future<Map?> _getFile(String filePath) async {
    var file = File(filePath);
    if (await file.exists()) {
      var data = jsonDecode(await file.readAsString());
      return data;
    }
    return null;
  }

  Future _unArchiveAndSave(String filePath) async {
    File zippedFile = File(filePath);
    var bytes = zippedFile.readAsBytesSync();
    var archive = ZipDecoder().decodeBytes(bytes);
    for (var file in archive) {
      var directory = p.dirname(filePath); // Get the directory part of the path
      var folder = Directory(directory);
      await folder.create(recursive: true);
      var fileName = '$directory/${file.name}'; // Construct the new file path
      if (file.isFile) {
        var outFile = File(fileName);
        outFile = await outFile.create(recursive: true);
        await outFile.writeAsBytes(file.content);
      }
    }
  }

  Future<bool> _checkIfFileExist(String filePath) {
    var file = File(filePath);
    return file.exists();
  }
}

class JsonObjectTransformer extends StreamTransformerBase<String, dynamic> {
  static final _openingBracketChar = '{'.codeUnitAt(0);
  static final _closingBracketChar = '}'.codeUnitAt(0);

  @override
  Stream<dynamic> bind(Stream<String> stream) async* {
    final sb = StringBuffer();
    var bracketsCount = 0;

    await for (final string in stream) {
      for (var i = 0; i < string.length; i++) {
        final current = string.codeUnitAt(i);
        sb.writeCharCode(current);

        if (current == _openingBracketChar) {
          bracketsCount++;
        }

        if (current == _closingBracketChar && --bracketsCount == 0) {
          yield json.decode(sb.toString());
          sb.clear();
        }
      }
    }
  }
}
