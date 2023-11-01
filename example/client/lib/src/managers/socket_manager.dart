import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:s_sockets/s_sockets.dart';

class SocketManager {
  static final SocketManager _instance = SocketManager._constructor();

  factory SocketManager() {
    return _instance;
  }

  SocketManager._constructor();

  bool isConnected = true;

  final _paintStreamController = StreamController<Offset?>.broadcast();
  final _clearStreamController = StreamController<bool>.broadcast();

  emitPaint(double dx, double dy) {
    if (isConnected) {
      SSockets().emit('canvas', '{"dx": $dx, "dy": $dy}');
    }
  }

  emitEndLine() {
    if (isConnected) {
      SSockets().emit('endLine', null);
    }
  }

  emitClearCanvas() {
    if (isConnected) {
      SSockets().emit('clearCanvas', '');
    }
  }

  Stream<Offset?> recivedPaint() {
    if (isConnected) {
      SSockets().on('draw', (data) {
        final offset = jsonDecode(data);

        _paintStreamController.add(Offset(offset['dx'], offset['dy']));
      });

      SSockets().on(
        'endLine',
        (data) => _paintStreamController.add(null),
      );
    }

    return _paintStreamController.stream;
  }

  Stream<bool> clearCanvas() {
    if (isConnected) {
      SSockets().on('cleaningCanvas', (_) {
        _clearStreamController.add(true);
      });
    }

    return _clearStreamController.stream;
  }
}
