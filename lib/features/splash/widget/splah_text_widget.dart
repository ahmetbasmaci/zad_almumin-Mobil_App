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
            FadeAnimatedText(
              AppStrings.of(context).appName,
              textStyle: AppStyles.titleLarge(context).copyWith(
                fontWeight: FontWeight.bold,
              ),
              duration: const Duration(milliseconds: 1500),
              fadeInEnd: .6,
              fadeOutBegin: .9,
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
