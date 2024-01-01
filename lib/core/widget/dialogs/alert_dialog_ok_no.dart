import 'package:flutter/material.dart';
import 'package:zad_almumin/config/local/l10n.dart';
import 'package:zad_almumin/core/extentions/extentions.dart';

import '../../utils/resources/resources.dart';

class AlertDialogOkNo extends StatelessWidget {
  AlertDialogOkNo(
      {super.key,
      required this.title,
      required this.content,
      this.okText,
      this.noText,
      required this.onOk,
      required this.onNo});

  String title;
  String content;
  String? okText;
  String? noText;
  VoidCallback onOk;
  VoidCallback onNo;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.all(AppSizes.screenPadding),
      title: Text(title, style: AppStyles.title2),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: () async => onOk.call(),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              context.theme.colorScheme.primary,
            ),
          ),
          child: Text(
            okText ?? AppStrings.of(context).ok,
            style: AppStyles.content.copyWith(
              color: context.theme.colorScheme.background,
            ),
          ),
        ),
        TextButton(
          onPressed: () => onNo.call(),
          child: Text(
            noText ?? AppStrings.of(context).cancel,
            style: AppStyles.content.copyWith(
              color: context.theme.colorScheme.error,
            ),
          ),
        ),
      ],
    );
  }
}
