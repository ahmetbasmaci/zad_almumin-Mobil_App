import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zad_almumin/core/utils/resources/app_constants.dart';
import 'package:zad_almumin/features/quran/presentation/cubit/quran/quran_cubit.dart';
import '../../extentions/extentions.dart';

class AppStyles {
  AppStyles._();
  static TextStyle title(BuildContext context) {
    return context.theme.textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w800,
        ) ??
        const TextStyle();
  }

  static TextStyle title2(BuildContext context) {
    return context.theme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w700,
        ) ??
        const TextStyle();
  }

  static TextStyle content(BuildContext context) {
    return context.theme.textTheme.bodyMedium ?? const TextStyle();
  }

  static TextStyle contentBold(BuildContext context) {
    return content(context).copyWith(
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle quran(BuildContext context) {
    return content(context).copyWith(
      fontSize: AppConstants.context.read<QuranCubit>().state.quranFontSize,
    );
  }
}
