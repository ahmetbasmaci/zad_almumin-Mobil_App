import 'dart:developer';

class PrinterHelper {
  PrinterHelper._();
  static void print(String message, {Object? value}) {
    log(
      'INFO:   $message: $value',
      time: DateTime.now(),
      name: 'Zad Almumin',
    );
  }

  static void printError(String message, {Object? value}) {
    log(
      'ERROR:   $message: $value',
      time: DateTime.now(),
      name: 'Zad Almumin',
    );
  }
}
