import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zad_almumin/core/widget/app_scaffold.dart';
import 'package:zad_almumin/core/widget/progress_indicator/app_circular_progress_indicator.dart';
import '../../../../core/utils/resources/resources.dart';
import '../../../../core/widget/space/space.dart';
import '../../quran_questions.dart';

class QuranQuestionsPage extends StatelessWidget {
  const QuranQuestionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'مراجعة القرآن',
      usePadding: true,
      leading: const QuranQuestionOptionsButton(),
      body: BlocBuilder<QuranQuestionsCubit, QuranQuestionsState>(
        builder: (context, state) {
          return body(context,state);
        },
      ),
    );
  }

  Widget body(BuildContext context,QuranQuestionsState state) {
    if (state.isLoading) return const AppCircularProgressIndicator();

    //if there is tafseers for current local
    return Column(
      children: [
        VerticalSpace(AppSizes.spaceBetweanWidgets),
        _title(context),
        VerticalSpace(AppSizes.spaceBetweanWidgets),
        const Expanded(child: QuranQuestionsResultWidgets()),
      ],
    );
  }

  Text _title(BuildContext context) {
    return Text(
      "اختبر حفظك للقران واختر رقم الصفحة والجزء للآية",
      textAlign: TextAlign.center,
      style: AppStyles.contentBold(context),
    );
  }
}
