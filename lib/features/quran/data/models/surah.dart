import '../../../../core/utils/enums/enums.dart';
import '../../quran.dart';

class Surah {
  Surah({
    required this.name,
    required this.startAtPage,
    required this.ayahs,
    required this.number,
    required this.downloadState,
  });

  Surah.empty({
    this.name = '',
    this.startAtPage = 0,
    this.number = 0,
    this.ayahs = const [],
    this.downloadState = DownloadState.notDownloaded,
  });

  Surah copyWith({
    String? name,
    int? startAtPage,
    int? number,
    List<Ayah>? ayahs,
    DownloadState? downloadState,
  }) {
    return Surah(
      name: name ?? this.name,
      startAtPage: startAtPage ?? this.startAtPage,
      number: number ?? this.number,
      ayahs: ayahs ?? this.ayahs,
      downloadState: downloadState ?? this.downloadState,
    );
  }

  final String name;
  final int startAtPage;
  final int number;
  final List<Ayah> ayahs;
  DownloadState downloadState;
  factory Surah.fromJson(dynamic json) {
    List<Ayah> ayahs = [];
    for (var ayah in json['ayahs']) {
      Ayah newAyah = Ayah.fromJson(ayah);
      newAyah = newAyah.copyWith(
        surahName: json['name'],
        surahNumber: json['number'],
      );
      ayahs.add(newAyah);
    }
    return Surah(
      name: json['name'],
      startAtPage: ayahs[0].page,
      number: json['number'],
      ayahs: ayahs,
      downloadState: DownloadState.notDownloaded,
    );
  }
}
