import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'src/app.dart';
import 'src/injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetItManager.instance.init();
  await Firebase.initializeApp();
  await FirebaseAppCheck.instance.activate(
    webProvider: ReCaptchaV3Provider('recaptcha-v3-site-key'),
    androidProvider: kDebugMode ? AndroidProvider.debug : AndroidProvider.playIntegrity,
    appleProvider: kDebugMode ? AppleProvider.debug : AppleProvider.appAttest,
  );

  runApp(const App());
  // runApp(DevicePreview(enabled: true, builder: (context) => const App()));
}
