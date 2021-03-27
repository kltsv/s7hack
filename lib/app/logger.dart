import 'dart:developer' as dev;

import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

final _enableLogger = kDebugMode;

final logger = Logger.root;

void initLogger() {
  Logger.root.level = _enableLogger ? Level.INFO : Level.OFF;
  if (_enableLogger) {
    Logger.root.onRecord.listen(_log);
  }
}

void _log(LogRecord record) => dev.log(
      record.message,
      time: record.time,
      error: record.error,
      stackTrace: record.stackTrace,
      zone: record.zone,
    );
