import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/local/l10n.dart';
import '../../../../core/widget/progress_indicator/app_circular_progress_indicator.dart';
import '../cubit/pray_times_cubit.dart';

class PrayTimeUpdateButton extends StatelessWidget {
  const PrayTimeUpdateButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        context.read<PrayTimesCubit>().updatePrayerTimes();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(AppStrings.of(context).updatePrayTimes),
          context.read<PrayTimesCubit>().state.isLoading ? const AppCircularProgressIndicator() : Container(),
        ],
      ),
    );
  }
}
