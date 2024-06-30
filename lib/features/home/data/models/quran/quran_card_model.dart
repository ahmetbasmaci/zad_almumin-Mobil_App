import 'package:zad_almumin/features/quran/quran.dart';

import '../../../../../core/utils/enums/enums.dart';
import '../../../../favorite/favorite.dart';

class QuranCardModel extends BaseFavoriteEntities {
  final int dataId;
  final String content;
  final String surahName;
  final int juz;
  final int ayahNumber;
  final int surahNumber;
  QuranCardModel({
    super.id = 0,
    required this.dataId,
    required this.content,
    required this.surahName,
    required this.juz,
    required this.ayahNumber,
    required this.surahNumber,
    super.date,
  }) : super(zikrCategory: FavoriteZikrCategory.quran);

  factory QuranCardModel.fromAyahModel(Ayah ayah) {
    return QuranCardModel(
      dataId: ayah.numberInQuran,
      content: ayah.text,
      surahName: ayah.surahName,
      juz: ayah.juz,
      ayahNumber: ayah.number,
      surahNumber: ayah.surahNumber,
    );
  }

  QuranCardModel.empty()
      : dataId = 0,
        content = '',
        surahName = '',
        juz = 0,
        ayahNumber = 0,
        surahNumber = 0,
        super(id: 0, zikrCategory: FavoriteZikrCategory.quran, date: null);

  @override
  Map<String, dynamic> toJson() {
    return {
      'dataId': dataId,
      'content': content,
      'surahName': surahName,
      'juz': juz,
      'ayahNumber': ayahNumber,
      'surahNumber': surahNumber,
      'date': DateTime.now().toString(),
    };
  }

  factory QuranCardModel.fromJson(Map<String, dynamic> json) {
    return QuranCardModel(
      id: json['id'] ?? 0,
      dataId: json['dataId'] ?? 0,
      content: json['content'] ?? '',
      surahName: json['surahName'] ?? '',
      juz: json['juz'] ?? 0,
      ayahNumber: json['ayahNumber'] ?? 0,
      surahNumber: json['surahNumber'] ?? 0,
      date: DateTime.parse(json['date']),
    );
  }
}
