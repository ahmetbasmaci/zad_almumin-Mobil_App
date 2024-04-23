import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:zad_almumin/core/utils/resources/app_styles.dart';

import '../../../config/local/l10n.dart';
import '../../../core/extentions/extentions.dart';

class SplahTextWidget extends StatelessWidget {
  const SplahTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: EdgeInsets.only(top: context.height * 0.1),
        child: AnimatedTextKit(
          animatedTexts: [
            TyperAnimatedText(
              AppStrings.of(context).appName,
              speed: const Duration(milliseconds: 200),
              textStyle: AppStyles.title(context),
            ),
          ],
          isRepeatingAnimation: false,
          repeatForever: false,
          displayFullTextOnTap: false,
        ),
      ),
    );
  }
}
