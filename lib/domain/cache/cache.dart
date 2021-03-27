import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:s7hack/app/assets/assets.dart';
import 'package:s7hack/app/logger.dart';

class Cache {
  static const _cacheBoxKey = '${AppAssets.appName}_cache';

  Box<String>? _cache;

  Future<void> init() async {
    if (!kIsWeb) {
      var dir = await getApplicationDocumentsDirectory();
      Hive.init(dir.path);
    }
    _cache = await Hive.openBox<String>(_cacheBoxKey);
  }

  Future<void> save(String key, Map<String, dynamic> json) async {
    final string = _json(json);
    await _cache?.put(key, string);
    logger.info('Save $key: $string');
  }

  Map<String, dynamic>? load(String key) {
    final json = _cache?.get(key);
    logger.info('Load $key: $json');
    return json != null ? _parse(json) : null;
  }

  String _json(Map<String, dynamic> map) => jsonEncode(map);

  Map<String, dynamic> _parse(String json) => jsonDecode(json);
}
