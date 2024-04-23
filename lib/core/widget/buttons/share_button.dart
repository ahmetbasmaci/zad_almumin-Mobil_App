import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import '../../utils/resources/app_icons.dart';

class ShareButton extends StatelessWidget {
  final String content;
  final VoidCallback? onDone;
  const ShareButton({
    super.key,
    required this.content,
    this.onDone,
  });
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Share.share(content);

        onDone?.call();
      },
      icon: AnimatedSwitcher(duration: const Duration(milliseconds: 300), child: AppIcons.share),
    );
  }
}
