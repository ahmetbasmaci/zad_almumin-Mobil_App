import 'package:flutter/material.dart';
import '../../../features/favorite/favorite.dart';
import '../buttons/copy_button.dart';
import '../../../features/favorite_button/presentation/widgets/favorite_button.dart';
import '../buttons/share_button.dart';

class AppCardContentFooterPartButtons extends StatelessWidget {
  const AppCardContentFooterPartButtons({
    super.key,
    required this.content,
    required this.item,
  });
  final String content;
  final BaseFavoriteEntities item;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        CopyButton(content: content),
        ShareButton(content: content),
        FavoriteButton(item: item),
      ],
    );
  }
}
