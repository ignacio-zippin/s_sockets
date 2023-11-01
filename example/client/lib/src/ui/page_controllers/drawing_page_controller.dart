// Package imports:
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:socket_example_2_client/src/managers/socket_manager.dart';

// Project imports:
import '../../interfaces/i_view_controller.dart';
import '../../utils/page_args.dart';

class DrawingPageController extends ControllerMVC implements IViewController {
  static late DrawingPageController _this;

  factory DrawingPageController() {
    _this = DrawingPageController._();
    return _this;
  }

  static DrawingPageController get con => _this;
  PageArgs? args;
  DrawingPageController._();

  final List<Offset?> points = [];
  final GlobalKey key = GlobalKey();

  @override
  void initPage({PageArgs? arguments}) {
    super.initState();

    Future.delayed(const Duration(seconds: 5)).then(
      (_) => SocketManager().clearCanvas().listen((event) {
        points.clear();
      }),
    );
  }

  @override
  disposePage() {}

  void addPointsForCurrentFrame(Offset globalPosition) {
    final RenderBox renderBox =
        key.currentContext!.findRenderObject() as RenderBox;
    final Offset offset = renderBox.globalToLocal(globalPosition);

    SocketManager().emitPaint(offset.dx, offset.dy);
  }

  void finishLine() {
    SocketManager().emitEndLine();
  }

  void clearCanvas() {
    SocketManager().emitClearCanvas();
  }
}
