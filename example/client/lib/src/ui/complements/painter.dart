// ignore_for_file: unnecessary_null_comparison

import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Painter extends CustomPainter {
  final List<Offset?> offsets;
  final Color drawColor;

  Painter({required this.offsets, required this.drawColor}) : super();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = drawColor
      ..isAntiAlias = true
      ..strokeWidth = 6.0;

    for (int i = 0; i < offsets.length; i++) {
      if (shouldDrawLine(i)) {
        log("line");
        canvas.drawLine(offsets[i]!, offsets[i + 1]!, paint);
      }
      if (shouldDrawPoint(i)) {
        canvas.drawPoints(PointMode.points, [offsets[i]!], paint);
        log("point");
      }
    }
  }

  bool shouldDrawPoint(int i) =>
      offsets[i] != null && offsets.length > (i + 1) && offsets[i + 1] == null;

  bool shouldDrawLine(int i) =>
      offsets[i] != null && offsets.length > (i + 1) && offsets[i + 1] != null;

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
