// ignore_for_file: prefer_final_fields

import 'dart:async';

class CounterBloc {
  int _counter = 0;

  StreamController _inputController = StreamController();
  Sink get inputan => _inputController.sink;

  StreamController _outputController = StreamController();
  StreamSink get _sinkOut => _outputController.sink;

  Stream get output => _outputController.stream;

  CounterBloc() {
    _inputController.stream.listen((event) {
      if (event == "add") {
        _counter++;
      } else {
        _counter--;
      }

      _sinkOut.add(_counter);
    });
  }

  void dispose() {
    _inputController.close();
    _outputController.close();
  }
}
