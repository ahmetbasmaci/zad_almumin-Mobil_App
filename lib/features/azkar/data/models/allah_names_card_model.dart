import '../../../../core/utils/enums/enums.dart';
import '../../../favorite/domain/entities/base_favorite_entities.dart';

class AllahNamesCardModel extends BaseFavoriteEntities {
  final String name;
  final String content;

  AllahNamesCardModel({
    super.id = 0,
    required this.name,
    required this.content,
    super.date,
  }) : super(zikrCategory: FavoriteZikrCategory.allahNames);

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'content': content,
        'date': DateTime.now().toString(),
      };

  factory AllahNamesCardModel.fromJson(Map<String, dynamic> json) => AllahNamesCardModel(
        id: json['id'] ?? 0,
        name: json['name'],
        content: json['content'],
      date: DateTime.parse(json['date']?? DateTime.now().toString()),
      );
}
