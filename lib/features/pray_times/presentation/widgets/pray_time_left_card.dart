import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zad_almumin/core/extentions/extentions.dart';
import 'package:zad_almumin/features/pray_times/pray_times.dart';

import '../../../../core/utils/resources/resources.dart';
import '../../../../core/widget/progress_indicator/app_circular_progress_indicator.dart';

class PrayTimeLeftCard extends StatelessWidget {
  const PrayTimeLeftCard({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PrayTimesCubit, PrayTimesState>(
      builder: (context, state) {
        return Container(
          margin: EdgeInsets.only(top: AppSizes.spaceBetweanParts),
          decoration: _cardDecoration(context),
          width: context.width * .55,
          height: context.height * .25,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(child: Center(child: _prayTimeNameTitle(context))),
              Expanded(
                child: Center(child: _prayTimeLeft(context)),
              )
            ],
          ),
        );
      },
    );
  }

  BoxDecoration _cardDecoration(BuildContext context) {
    return BoxDecoration(
      color: context.themeColors.background,
      borderRadius: BorderRadius.circular(100),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(.2),
          blurRadius: 10,
          offset: const Offset(0, -3),
        ),
        BoxShadow(
          color: context.themeColors.primary,
          blurRadius: 6,
          offset: const Offset(0, 6),
        ),
      ],
    );
  }

  Widget _prayTimeLeft(BuildContext context) {
    return context.read<PrayTimesCubit>().state.isLoading
        ? const AppCircularProgressIndicator()
        : _prayTimeLeftTitle(context);
  }

  Widget _prayTimeLeftTitle(BuildContext context) {
    return Text(
      context.read<PrayTimesCubit>().state.timeLeftToNextPrayTime,
      textAlign: TextAlign.center,
      style: AppStyles.titleLarge(context),
    );
  }

  Text _prayTimeNameTitle(BuildContext context) {
    return Text(
      context.read<PrayTimesCubit>().nextPrayModel.prayTimeType.translatedName,
      style: AppStyles.titleMedium(context),
    );
  }
}
