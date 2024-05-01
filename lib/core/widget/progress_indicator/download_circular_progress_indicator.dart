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
      child: Stack(
        children: [
          downloadValue >= 0
              ? Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(3),
                  child: FittedBox(
                    child: Text(
                      "${(downloadValue * 100).toInt()}%",
                      maxLines: 1,
                    ),
                  ),
                )
              : Container(),
          CircularProgressIndicator(
            strokeWidth: 3,
            value: downloadValue >= 0 ? downloadValue : null,
            color: context.themeColors.secondary,
          ),
        ],
      ),
    );
  }
}
