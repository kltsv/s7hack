import 'package:s7hack/domain/engine/engine.dart';

class EngineHolder {
  Engine? _engine;

  set engine(Engine engine) => _engine = engine;

  Engine get engine {
    if (_engine == null) {
      throw Exception('No engine');
    }
    return _engine!;
  }

  void clear() => _engine = null;
}
