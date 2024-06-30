import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zad_almumin/features/home/presentation/widgets/hadith_part/hadith_card_widget.dart';
import '../../../../../core/helpers/toats_helper.dart';
import '../../../../../core/widget/app_card_widgets/app_card_widgets.dart';
import '../../../../../src/injection_container.dart';
import '../../../../../config/local/l10n.dart';
import '../../cubit/cubit_hadith/home_hadith_card_cubit.dart';

class AppCardContentHadith extends StatelessWidget {
  const AppCardContentHadith({super.key});

  @override
  Widget build(BuildContext context) {
    return AppCardWithTitle(
      outsideTitle: AppStrings.of(context).hadithBigTitle,
      child: BlocProvider(
        create: (context) => GetItManager.instance.homeHadithCardCubit..getRandomHadith(),
        child: BlocConsumer<HomeHadithCardCubit, HomeHadithCardState>(
          listener: (context, state) {
            if (state is HomeHadithCardFieldState) ToatsHelper.showError(state.message);
          },
          builder: (context, state) {
            if (state is HomeHadithCardLoadingState) return const Center(child: CircularProgressIndicator());
            if (state is HomeHadithCardLoadedState)
              return HadithCardWidget(
                hadithCardModel: state.hadithCardModel,
                onReferesh: () => context.read<HomeHadithCardCubit>().getRandomHadith(),
              );

            return const Text('HomeHadithCardErrorState');
          },
        ),
      ),
    );
  }
}
