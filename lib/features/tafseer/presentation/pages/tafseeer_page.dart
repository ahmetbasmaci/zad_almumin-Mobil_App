import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zad_almumin/core/helpers/toats_helper.dart';
import '../../../../core/widget/app_scaffold.dart';
import '../../../../core/widget/progress_indicator/progress_indicator.dart';
import '../../tafseer.dart';

class TafseeerPage extends StatelessWidget {
  const TafseeerPage({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TafseerCubit, TafseerState>(
      listener: (context, state) {
        if (state.errorMessage.isNotEmpty) {
          ToatsHelper.showError(state.errorMessage);
        }
      },
      builder: (context, state) {
        return AppScaffold(
          title: 'تفاسير القرآن',
          usePadding: false,
          body: body(context.read<TafseerCubit>().state),
        );
      },
    );
  }

  Widget body(TafseerState state) {
    if (state.loading) return const AppCircularProgressIndicator();

    //if no tafseers for current local
    if (state.tafseerModels.isEmpty) return const NoTafseersForCurrentLocalWidget();

    //if there is tafseers for current local
    return TafssersListWidget(tafseerModels: state.tafseerModels);
  }
}
