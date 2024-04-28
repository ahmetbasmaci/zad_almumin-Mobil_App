import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zad_almumin/core/extentions/extentions.dart';
import 'package:zad_almumin/core/helpers/toats_helper.dart';
import 'package:zad_almumin/core/utils/enums/enums.dart';
import 'package:zad_almumin/core/utils/resources/resources.dart';
import 'package:zad_almumin/core/widget/app_scaffold.dart';
import 'package:zad_almumin/core/widget/progress_indicator/progress_indicator.dart';
import 'package:zad_almumin/features/quran/quran.dart';
import 'package:zad_almumin/src/injection_container.dart';

class QuranReaderSurahDownloadScreen extends StatelessWidget {
  const QuranReaderSurahDownloadScreen({super.key, required this.reader});
  final QuranReader reader;
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: reader.translatedName,
      usePadding: true,
      body: BlocBuilder<QuranReaderSurhDownloadCubit, QuranReaderSurhDownloadState>(
        builder: (context, state) {
          var quranReaderSurahDownlaodCubit = context.read<QuranReaderSurhDownloadCubit>();
          List<Surah> allSurahs = quranReaderSurahDownlaodCubit.getAllSurahs;
          return ListView.builder(
            itemCount: allSurahs.length,
            itemBuilder: (context, index) {
              return _surahItem(allSurahs[index], quranReaderSurahDownlaodCubit);
            },
          );
        },
      ),
    );
  }

  Widget _surahItem(Surah surah, QuranReaderSurhDownloadCubit quranReaderSurahDownlaodItemCubit) {
    return BlocProvider(
      create: (context) => GetItManager.instance.quranReaderSurhDownloadItemCubit,
      child: BlocConsumer<QuranReaderSurhDownloadItemCubit, QuranReaderSurhDownloadItemState>(
        listener: (context, state) {
          if (state is QuranReaderSurhDownloadItemErrorState) {
            ToatsHelper.showError(state.message);
          } else if (state is QuranReaderSurhDownloadItemDownloadingState) {
            surah = state.surah;
          }
        },
        builder: (context, state) {
          Future<DownloadState> downoloadStateFuture =
              Future.delayed(Duration.zero).then((value) => DownloadState.notDownloaded);

          if (state is! QuranReaderSurhDownloadItemDownloadingState) {
            downoloadStateFuture =
                context.read<QuranReaderSurhDownloadItemCubit>().checkIfSurahDownloadedBefore(surah, reader);
          }

          return FutureBuilder<DownloadState>(
            future: downoloadStateFuture,
            builder: (_, snapShot) {
              print("build");
              surah = surah.copyWith(downloadState: snapShot.data ?? DownloadState.notDownloaded);

              return ListTile(
                title: _itemTitle(surah, context),
                subtitle: _itemSubtitle(context, surah),
                trailing: _itemTrailing(surah, context, state),
              );
            },
          );
        },
      ),
    );
  }

  IconButton _itemTrailing(
    Surah surah,
    BuildContext context,
    QuranReaderSurhDownloadItemState state,
  ) {
    return IconButton(
      icon: _itemDownloadIcon(surah, context, state),
      onPressed: surah.downloadState == DownloadState.notDownloaded
          ? () => _itemDownloadOnPressed(surah, context, state)
          : null,
    );
  }

  Widget _itemDownloadIcon(
    Surah surah,
    BuildContext context,
    QuranReaderSurhDownloadItemState state,
  ) {
    if (surah.downloadState == DownloadState.downloaded) {
      return AppIcons.downlaodDone;
    } else if (state is QuranReaderSurhDownloadItemDownloadingState) {
      print(state.downloadValue);
      return DownloadCircularProgressIndicator(
        downloadValue: state.downloadValue,
      );
    } else //if (surah.downloadState == DownloadState.notDownloaded)
      return AppIcons.downlaod;
  }

  void _itemDownloadOnPressed(Surah surah, BuildContext context, QuranReaderSurhDownloadItemState state) {
    if (state is QuranReaderSurhDownloadItemDownloadingState) {
      ToatsHelper.show('جاري تحميل سورة أخرى');
      return;
    }
    context.read<QuranReaderSurhDownloadItemCubit>().downlaodSurah(surah, reader);
  }

  Text _itemSubtitle(BuildContext context, Surah surah) {
    return Text.rich(
      style: AppStyles.content(context),
      TextSpan(
        children: [
          TextSpan(text: '${'ألجزء'}: ${surah.ayahs[0].juz}'),
          TextSpan(
            text: ' | ',
            style: AppStyles.contentBold(context).copyWith(color: context.themeColors.primary),
          ),
          TextSpan(text: '${'عدد الآيات'}: ${surah.ayahs.length}'),
        ],
      ),
    );
  }

  Text _itemTitle(Surah surah, BuildContext context) {
    return Text(
      surah.name.removeTashkil,
      style: AppStyles.contentBold(context).copyWith(color: context.themeColors.primary),
    );
  }
}
