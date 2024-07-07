import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zad_almumin/core/extentions/dart_extention.dart';

import '../../../../config/local/l10n.dart';
import '../../../../core/utils/resources/resources.dart';
import '../../tafseer.dart';

class TafseerLocaleListTile extends StatelessWidget {
  const TafseerLocaleListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(AppStrings.of(context).language),
      subtitle: Text(AppStrings.of(context).changeTafseerLanguage),
      leading: AppIcons.language,
      trailing: BlocBuilder<TafseerCubit, TafseerState>(
        builder: (context, state) {
          return DropdownButton<String>(
            value: state.locale.isEmpty ? context.localeCode : state.locale,
            onChanged: (String? newValue) async {
              await context.read<TafseerCubit>().changeLocale(newValue!);
            },
            items: AppStrings.delegate.supportedLocales.map<DropdownMenuItem<String>>(
              (Locale value) {
                return DropdownMenuItem<String>(
                  value: value.languageCode,
                  child: Text(value.languageCode),
                );
              },
            ).toList(),
          );
        },
      ),
    );
  }
}
