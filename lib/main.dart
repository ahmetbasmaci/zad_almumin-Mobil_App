import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zad_almumin/classes/helper_methods.dart';
import 'package:zad_almumin/pages/alarms/alarms_page.dart';
import 'package:zad_almumin/pages/ayahsTest/ayahs_questions.dart';
import 'package:zad_almumin/pages/quran/quran_page.dart';
import 'package:zad_almumin/services/app_local.dart';
import 'package:zad_almumin/services/theme_service.dart';
import 'package:zad_almumin/pages/azkar_page.dart';
import 'package:zad_almumin/pages/home_page.dart';
import 'package:zad_almumin/pages/settings/settings_page.dart';
import 'package:zad_almumin/splash_screen.dart';
import 'classes/controllers.dart';
import 'constents/constents.dart';
import 'pages/favorite/favorite_page.dart';

void main() async {
  await GetStorage.init();

  WidgetsFlutterBinding.ensureInitialized();
  Get.put(ThemeCtr());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // SqlDb().deleteDB();

    return GetMaterialApp(
      initialBinding: ControllerBinding(),
      navigatorKey: Constants.navigatorKey,
      localizationsDelegates: [
        AppLocale.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      builder: BotToastInit(), //1. call BotToastInit
      navigatorObservers: [BotToastNavigatorObserver()], //2. registered route observer
      supportedLocales: [const Locale('ar')],
      localeResolutionCallback: (locales, supportedLocales) {
        return supportedLocales.first;
      },
      locale: Locale('ar'),
      // getPages: [
      //   GetPage(name: '/${HomePage.id}', page: () => HomePage()),
      // ],
      routes: {
        SplashPage.id: (context) => SplashPage(),
        HomePage.id: (context) => HomePage(), //'/${HomePage.id}'
        SettingsPage.id: (context) => SettingsPage(),
        AlarmPage.id: (context) => AlarmPage(),
        FavoritePage.id: (context) => FavoritePage(),
        AzkarPage.id: (context) => AzkarPage(),
        QuranPage.id: (context) => QuranPage(),
        AyahsQuestions.id: (context) => AyahsQuestions(),
      },
      // home: DebouncedSearchBar(),
      initialRoute: HelperMethods.isInDebugMode ? HomePage.id : SplashPage.id,
      debugShowCheckedModeBanner: false,
      theme: Get.find<ThemeCtr>().lightThemeMode.value,
      darkTheme: Get.find<ThemeCtr>().darkThemeMode.value,
      themeMode: Get.find<ThemeCtr>().getThemeMode(),
    );
  }
}
