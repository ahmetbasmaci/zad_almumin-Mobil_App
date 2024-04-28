import 'dart:developer';

class PrinterHelper {
  PrinterHelper._();
  static void print(String variableName, {Object? value}) {
    log(
      'debug print:--------------------------------------> $variableName: $value',
      time: DateTime.now(),
      name: 'Zad Almumin',
    );
  }

  // void print(String variableName) {
  //   PrinterHelper.print('debug print:--------------------------------------> $variableName: $value');
  // }
}
