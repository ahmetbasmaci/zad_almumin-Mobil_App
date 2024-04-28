import '../../../../core/error/exceptions/app_exceptions.dart';
import '../../../../core/packages/app_internet_connection/app_internet_connection.dart';
import '../../../../core/packages/audio_manager/audio_manager.dart';
import '../../../../core/services/files_service.dart';
import '../../../../core/utils/api/ayah/ayah_api.dart';
import '../../../../core/utils/api/consumer/consumer.dart';
import '../../../../core/utils/enums/enums.dart';
import '../../quran.dart';

abstract class IQuranAudioDataSource {
  Future<bool> playPauseMultibleAudio(
    List<Ayah> ayahs,
    int startAyahIndex,
    QuranReader quranReader,
    Function(Ayah complatedAyah, bool partEnded) onComplated,
  );

  Future<bool> stopAudio();
  Future<AudioStreamModel> getAudioProgress();
  bool get isAudioPlaying;
}

class QuranAudioDataSource implements IQuranAudioDataSource {
  final IAudioPlayer _audioService;
  final IFilesService _fileService;

  QuranAudioDataSource({
    required IAudioPlayer audioService,
    required ApiConsumer apiConsumer,
    required IFilesService fileService,
    required IAyahApi ayahApi,
    required IAppInternetConnection appInternetConnection,
  })  : _fileService = fileService,
        _audioService = audioService;

  @override
  Future<AudioStreamModel> getAudioProgress() {
    // TODO: implement getAudioProgress
    throw UnimplementedError();
  }

  @override
  Future<bool> playPauseMultibleAudio(
    List<Ayah> ayahs,
    int startAyahIndex,
    QuranReader quranReader,
    Function(Ayah complatedAyah, bool partEnded) onComplate,
  ) async {
    try {
      List<AudioFile> audioFiles = [];

      for (Ayah ayah in ayahs) {
        audioFiles.add(
          AudioFile(
            path: _fileService.ayahFromSurahPath(ayah.surahNumber, ayah.number, quranReader),
            metasTitle: ayah.surahName,
            metasArtist: quranReader.name,
            metasAlbum: ayah.number.toString(),
            extra: ayah.toJson(),
          ),
        );
      }
      bool audioComplated = await _audioService.playPauseMultibleAudio(audioFiles, startAyahIndex, onComplate);
      return audioComplated;
    } catch (e) {
      throw AudioException(e.toString());
    }
  }

  @override
  Future<bool> stopAudio() async {
    await _audioService.stopAudio();
    return true;
  }

  @override
  bool get isAudioPlaying {
    return _audioService.isPlaying;
  }
}
