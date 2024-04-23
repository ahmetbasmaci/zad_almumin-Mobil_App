import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zad_almumin/core/extentions/dart_extention.dart';
import 'package:zad_almumin/core/utils/resources/app_constants.dart';
import 'package:zad_almumin/features/theme/cubit/theme_cubit.dart';
import '../../quran.dart';

class QuranPage extends StatefulWidget {
  const QuranPage({super.key, this.showInKahf = false});
  final bool showInKahf;
  @override
  State<QuranPage> createState() => _QuranPageState();
}

class _QuranPageState extends State<QuranPage> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    context.read<QuranCubit>().initPage(this, widget.showInKahf);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuranCubit, QuranState>(
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          key: AppConstants.scaffoldKey,
          endDrawer: const QuranEndDrawer(),
          body: Container(
            color: context.read<ThemeCubit>().state.theme.colorScheme.onBackground,
            height: context.height,
            width: context.width,
            child: const Stack(
              children: [
                QuranPageBody(),
                QuranPageTop(),
                QuranPageFooter(),
              ],
            ),
          ),
        );
      },
    );
  }
}
