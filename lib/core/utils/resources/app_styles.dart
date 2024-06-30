import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zad_almumin/core/extentions/dart_extention.dart';
import 'package:zad_almumin/core/utils/resources/app_constants.dart';
import 'package:zad_almumin/features/quran/presentation/cubit/quran/quran_cubit.dart';
import 'app_fonts.dart';

class AppStyles {
  static final String fontFamily = AppFonts.naskh.name;

  AppStyles._();
  static TextStyle titleLarge(BuildContext context) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: 23,
      color: context.themeColors.onBackground,
    );
  }

  static TextStyle titleMedium(BuildContext context) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: 21,
      color: context.themeColors.onBackground,
    );
  }

  static TextStyle bodyMedium(BuildContext context) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: 17,
      color: context.themeColors.onBackground,
    );
  }

  static TextStyle bodyMediumBold(BuildContext context) {
    return bodyMedium(context).copyWith(fontWeight: FontWeight.w600);
  }

  static TextStyle quran(BuildContext context) {
    return bodyMedium(context).copyWith(
      fontSize: AppConstants.context.read<QuranCubit>().state.quranFontSize,
    );
  }
}
