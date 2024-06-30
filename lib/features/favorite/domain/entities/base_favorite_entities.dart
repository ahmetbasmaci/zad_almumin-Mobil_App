import 'package:zad_almumin/core/utils/enums/enums.dart';


abstract class BaseFavoriteEntities {
  final int id;
  final FavoriteZikrCategory zikrCategory;
  final DateTime? date;

  BaseFavoriteEntities({required this.id, required this.zikrCategory, required this.date});

  Map<String, dynamic> toJson();
}
