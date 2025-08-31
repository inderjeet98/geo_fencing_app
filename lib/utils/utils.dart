import 'package:flutter/foundation.dart';

class Utils {
  static void printLog(var msg) {
    if (kDebugMode) {
      print(msg);
    }
  }
}
