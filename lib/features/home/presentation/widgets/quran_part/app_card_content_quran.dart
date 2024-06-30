import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../config/local/l10n.dart';
import '../../../../../core/widget/app_card_widgets/app_card_widgets.dart';

import '../../../home.dart';
import 'quran_card_widget.dart';

class AppCardContentQuran extends StatelessWidget {
  const AppCardContentQuran({super.key});

  @override
  Widget build(BuildContext context) {
    return AppCardWithTitle(
      outsideTitle: AppStrings.of(context).quranBigTitle,
      child: FutureBuilder(
        future: context.read<HomeQuranCardCubit>().getRandomAyah(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return const Center(child: CircularProgressIndicator());
          if (snapshot.connectionState == ConnectionState.done) {
            return BlocBuilder<HomeQuranCardCubit, HomeQuranCardState>(
              builder: (context, state) {
                if (state is HomeQuranCardLoadingState) return const Text('HomeQuranCardLoadingState');
                if (state is HomeQuranCardLoadedState)
                  return QuranCardWidget(
                    quranCardModel: state.quranCardModel,
                    onReferesh: () => context.read<HomeQuranCardCubit>().getRandomAyah(),
                  );
                return const Text('HomeQuranCardErrorState');
              },
            );
          }
          return Text(snapshot.error.toString());
        },
      ),
    );
  }
}
