import 'package:flutter/services.dart';

/// Web / VM tanpa `dart:io` — coba tutup seperti tab / embed.
void quitApplication() {
  SystemNavigator.pop();
}
