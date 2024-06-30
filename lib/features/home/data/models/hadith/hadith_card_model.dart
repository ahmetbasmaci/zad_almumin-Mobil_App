import 'package:zad_almumin/features/favorite/domain/entities/entities.dart';

import '../../../../../core/utils/enums/enums.dart';

class HadithCardModel extends BaseFavoriteEntities {

  final String hadithBookName;
  final String chapterBookname;
  final String chapterName;
  final String hadithText;
  final String hadithSanad;
  final int hadithId;

  HadithCardModel({
    super.id = 0,
    required this.hadithBookName,
    required this.chapterBookname,
    required this.chapterName,
    required this.hadithText,
    required this.hadithSanad,
    required this.hadithId,
    super.date,
  }) : super(zikrCategory: FavoriteZikrCategory.hadiths);

  @override
  Map<String, dynamic> toJson() {
    return {
      'hadithBookName': hadithBookName,
      'chapterBookname': chapterBookname,
      'chapterName': chapterName,
      'hadithText': hadithText,
      'hadithSanad': hadithSanad,
      'hadithId': hadithId,
      'date': DateTime.now().toString(),
    };
  }

  factory HadithCardModel.fromJson(Map<String, dynamic> json) {
    return HadithCardModel(
      id: json['id'] ?? 0,
      hadithBookName: json['hadithBookName'] ?? '',
      chapterBookname: json['chapterBookname'] ?? '',
      chapterName: json['chapterName'] ?? '',
      hadithText: json['hadithText'] ?? '',
      hadithSanad: json['hadithSanad'] ?? '',
      hadithId: json['hadithId'] ?? 0,
      date: DateTime.parse(json['date']),
    );
  }
}
