import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zad_almumin/features/tafseer/presentation/cubit/tafseer/tafseer_cubit.dart';
import '../config/local/l10n.dart';
import '../core/utils/app_router.dart';
import '../features/theme/theme.dart';
import '../features/locale/cubit/locale_cubit.dart';
import 'injection_container.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => GetItManager.instance.themeCubit..getSavedTheme()),
        BlocProvider(create: (context) => GetItManager.instance.localeCubit..getSavedLocale()),
        BlocProvider(create: (context) => GetItManager.instance.prayTimesCubit..updateTodayPrayerTimes()),
        BlocProvider(create: (context) => GetItManager.instance.quranCubit),
        BlocProvider(create: (context) => GetItManager.instance.quranReaderCubit),
        BlocProvider(create: (context) => GetItManager.instance.quranAudioButtonCubit),
        BlocProvider(create: (context) => GetItManager.instance.tafseerCubit..initTafseerPage()),
        BlocProvider(create: (context) => GetItManager.instance.quranQuestionsCubit),
        BlocProvider(create: (context) => GetItManager.instance.homeQuranCardCubit),
        
      ],
      child: _buildChild(),
    );
  }

  BlocBuilder<LocaleCubit, LocaleState> _buildChild() {
    return BlocBuilder<LocaleCubit, LocaleState>(
      builder: (context, lcoaleState) => BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, themeState) => BlocBuilder<TafseerCubit, TafseerState>(
          builder: (context, tafseerState) => _materialWidget(lcoaleState, themeState),
        ),
      ),
    );
  }

  Widget _materialWidget(LocaleState lcoaleState, ThemeState themeState) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          // locale: DevicePreview.locale(context),
          // builder: DevicePreview.appBuilder,
          builder: BotToastInit(), // Call BotToastInit
          locale: Locale(lcoaleState.locale),
          routerConfig: appRouter,
          localizationsDelegates: [
            AppStrings.delegate,
            const AppLocalizationDelegate(),
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppStrings.delegate.supportedLocales,
          theme: themeState.theme,
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
/*


TODO- favorite button
TODO- add download progress when downloading quran
TODO- isPlaying listenere must set in audio player after change package
TODO- localizations
TODO- 
TODO- 
TODO- 
TODO- 
TODO- 
TODO- 
TODO- 
*/