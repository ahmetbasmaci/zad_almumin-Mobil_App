import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/resources/resources.dart';
import '../../../quran.dart';

class QuranRichText extends StatelessWidget {
  final List<InlineSpan> textSpanChilderen;
  const QuranRichText({super.key, required this.textSpanChilderen});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: context.read<QuranCubit>().state.showTafseerPage ? TextAlign.start : TextAlign.justify,
      textDirection: TextDirection.rtl,
      text: TextSpan(
        children: textSpanChilderen,
        style: AppStyles.quran(context),
      ),
    );
  }
}