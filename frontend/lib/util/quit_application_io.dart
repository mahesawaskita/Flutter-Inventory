import 'dart:io' show Platform, exit;

import 'package:flutter/services.dart';

/// Mobile: tutup lewat navigator sistem. Desktop: hentikan proses (quit).
void quitApplication() {
  if (Platform.isAndroid || Platform.isIOS) {
    SystemNavigator.pop();
  } else {
    exit(0);
  }
}
