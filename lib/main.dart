import 'package:flutter/material.dart';
import 'src/app.dart';
import 'src/injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetItManager.instance.init();
  runApp(const App());
  // runApp(DevicePreview(enabled: true, builder: (context) => const App()));
}
