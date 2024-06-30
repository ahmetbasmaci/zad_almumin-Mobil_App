import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zad_almumin/core/extentions/dart_extention.dart';

import '../../../../src/injection_container.dart';
import 'favorite_body.dart';

class FavoriteSearchDelegate extends SearchDelegate {
  @override
  String get searchFieldLabel => 'بحث';

  @override
  ThemeData appBarTheme(BuildContext context) => Theme.of(context).copyWith(
        scaffoldBackgroundColor: context.themeColors.background,
        iconTheme: IconThemeData(color: context.themeColors.primary),
        appBarTheme: AppBarTheme(
          color: context.themeColors.background,
          iconTheme: IconThemeData(color: context.themeColors.primary),
          titleTextStyle: TextStyle(color: context.themeColors.primary),
          toolbarTextStyle: TextStyle(color: context.themeColors.primary),
        ),
        textTheme: TextTheme(
          bodySmall: TextStyle(color: context.themeColors.onBackground),
          bodyMedium: TextStyle(color: context.themeColors.onBackground),
          bodyLarge: TextStyle(color: context.themeColors.onBackground),
          titleSmall: TextStyle(color: context.themeColors.onBackground),
          titleMedium: TextStyle(color: context.themeColors.onBackground), //dropdown
          titleLarge: TextStyle(color: context.themeColors.onBackground), //search text
          displaySmall: TextStyle(color: context.themeColors.onBackground),
          displayMedium: TextStyle(color: context.themeColors.onBackground),
          displayLarge: TextStyle(color: context.themeColors.onBackground),
          headlineSmall: TextStyle(color: context.themeColors.onBackground),
          headlineMedium: TextStyle(color: context.themeColors.onBackground),
          headlineLarge: TextStyle(color: context.themeColors.onBackground),
          labelSmall: TextStyle(color: context.themeColors.onBackground),
          labelMedium: TextStyle(color: context.themeColors.onBackground),
          labelLarge: TextStyle(color: context.themeColors.onBackground),
        ),
        textSelectionTheme: TextSelectionThemeData(cursorColor: context.themeColors.primary),
        inputDecorationTheme: const InputDecorationTheme(focusedBorder: InputBorder.none, border: InputBorder.none),
      );

  @override
  List<Widget>? buildActions(BuildContext context) =>
      [IconButton(icon: const Icon(Icons.arrow_forward), onPressed: () => close(context, null))];

  @override //back button
  Widget? buildLeading(BuildContext context) => IconButton(icon: const Icon(Icons.close), onPressed: () => query = '');

  @override
  Widget buildResults(BuildContext context) => _body();

  @override
  Widget buildSuggestions(BuildContext context) => _body();

  Widget _body() {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => GetItManager.instance.favoriteCubit),
        BlocProvider(create: (context) => GetItManager.instance.homeQuranCardCubit),
      ],
      child: FavoriteBody.withSearchText(searchText: query),
    );
  }
}
