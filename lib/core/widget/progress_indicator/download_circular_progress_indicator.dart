import 'package:flutter/material.dart';
import 'package:zad_almumin/core/extentions/dart_extention.dart';
import 'package:zad_almumin/core/utils/resources/app_sizes.dart';

class DownloadCircularProgressIndicator extends StatelessWidget {
  const DownloadCircularProgressIndicator({super.key, required this.downloadValue});
  final double downloadValue;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppSizes.icon,
      height: AppSizes.icon,
      child: CircularProgressIndicator(
        strokeWidth: 3,
        value: downloadValue,
        color: context.themeColors.secondary,
      ),
    );
  }
}
