import 'dart:async';

import 'package:flutter/widgets.dart';

abstract class BaseProvider<T> with ChangeNotifier {
  final _streamController = StreamController<T>.broadcast();

  Stream<T> get stream => _streamController.stream;

  @protected
  Sink<T> get sink => _streamController.sink;

  @protected
  @mustCallSuper
  void dispose() {
    super.dispose();
    _streamController.close();
  }
}
