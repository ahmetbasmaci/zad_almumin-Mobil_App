import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zad_almumin/core/extentions/extentions.dart';
import 'package:zad_almumin/core/helpers/navigator_helper.dart';
import 'package:zad_almumin/core/utils/app_router.dart';

import '../../../../../../core/utils/enums/enums.dart';
import '../../../../../../core/utils/resources/resources.dart';
import '../../../../quran.dart';

class QuranSelectReaderDropDown extends StatelessWidget {
  const QuranSelectReaderDropDown({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuranReaderCubit, QuranReaderState>(
      builder: (context, state) {
        return DropdownButton<QuranReader>(
          value: context.read<QuranReaderCubit>().state.selectedQuranReader,
          menuMaxHeight: context.height * .3,
          onChanged: (newReader) {
            context.read<QuranReaderCubit>().updateQuranReader(newReader!);
          },
          items: context
              .read<QuranReaderCubit>()
              .sortedQuranReader
              .map(
                (item) => DropdownMenuItem(
                  value: item,
                  child: _dropDownItem(context, item),
                ),
              )
              .toList(),
        );
      },
    );
  }

  Widget _dropDownItem(BuildContext context, QuranReader item) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _title(context, item),
        infoButton(context, item),
      ],
    );
  }

  Widget _title(BuildContext context, QuranReader item) {
    return Text(
      item.translatedName,
      style: context.read<QuranReaderCubit>().state.selectedQuranReader == item
          ? AppStyles.contentBold(context)
          : AppStyles.content(context),
    );
  }

  Widget infoButton(BuildContext context, QuranReader item) {
    return IconButton(
      icon: AppIcons.info,
      onPressed: () {
         NavigatorHelper.pushNamed(AppRoutes.quranReaderSurahDownloadScreen,extra: item);
      },
    );
  }
}
