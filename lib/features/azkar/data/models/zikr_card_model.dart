import '../../../../core/utils/enums/enums.dart';
import '../../../favorite/domain/entities/base_favorite_entities.dart';

class ZikrCardModel extends BaseFavoriteEntities {
  ZikrCardModel({
    super.id = 0,
    this.title = '',
    this.content = '',
    this.description = '',
    this.count = 1,
    this.haveList = false,
    this.list = const [],
    super.date,
  }) : super(zikrCategory: FavoriteZikrCategory.azkar);

  String title;
  String content;
  String description;
  int count;
  bool haveList;
  dynamic list;

  @override
  Map<String, dynamic> toJson() => {
        'title': title,
        'content': content,
        'description': description,
        'count': count,
        'haveList': haveList,
        'list': list,
        'date': DateTime.now().toString(),
      };

  factory ZikrCardModel.fromJson(Map<String, dynamic> json) {
    var count = json['count'] ?? 0;
    int intCount = (count.runtimeType == String) ? int.parse(count) : count;
    var haveList = json['haveList'] ?? false;
    bool boolHaveList = (haveList.runtimeType == int) ? haveList != 0 : haveList;
    return ZikrCardModel(
      id: json['id'] ?? 0,
      title: json['title'],
      content: json['content'] ?? '',
      description: json['description'] ?? '',
      count: intCount,
      haveList: boolHaveList,
      list: json['list'] ?? [],
      date: DateTime.parse(json['date'] ?? DateTime.now().toString()),
    );
  }
}
