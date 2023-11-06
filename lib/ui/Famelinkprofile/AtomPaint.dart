import 'dart:ui' as UI;

import 'package:flutter/material.dart';

import '../../util/constants.dart';

class AtomPaint extends CustomPainter {
  AtomPaint({this.value, this.image, this.isAnimating, this.controller});

  final double? value;
  final List? image;
  var isAnimating;
  var controller;

  Paint _axisPaint = Paint()
    ..color = Colors.transparent
    ..strokeWidth = 1.0
    ..style = PaintingStyle.stroke;

  @override
  void paint(Canvas canvas, Size size) {
    Constants.isReversed == false
        ? drawAxis(value!, canvas, 124, Paint()..color = Colors.black)
        : drawAxisReverse(value!, canvas, 124, Paint()..color = Colors.black);
    Future.delayed(Duration(milliseconds: 295), () {
      isAnimating = false;
      controller.reset();
      controller.stop();
    });
  }

  drawAxis(double value, Canvas canvas, double radius, Paint paint) {
    var firstAxis = getCirclePath(radius);
    canvas.drawPath(firstAxis, _axisPaint);
    UI.PathMetrics pathMetrics = firstAxis.computeMetrics();
    UI.PathMetrics pathMetrics2 = firstAxis.computeMetrics();
    UI.PathMetrics pathMetrics3 = firstAxis.computeMetrics();
    UI.PathMetrics pathMetrics4 = firstAxis.computeMetrics();

    for (UI.PathMetric pathMetric in pathMetrics) {
      Path extractPath = pathMetric.extractPath(
        pathMetric.length * 0.45 * value,
        pathMetric.length / 0.1 / value * value,
      );
      try {
        var metric = extractPath.computeMetrics().first;
        final offset = metric.getTangentForOffset(metric.length / 2)!.position;
        // canvas.drawCircle(offset, 12.0, paint);
        canvas.drawImage(image![3], offset, new Paint());
      } catch (e) {}
    }

    for (UI.PathMetric pathMetric in pathMetrics2) {
      Path extractPath1 = pathMetric.extractPath(
        pathMetric.length * 0.4 * value,
        pathMetric.length / 1 / value * value,
      );
      try {
        var metric2 = extractPath1.computeMetrics().first;
        final offset2 =
            metric2.getTangentForOffset(metric2.length / 4)!.position;
        canvas.drawImage(image![0], offset2, new Paint());
      } catch (e) {}
    }

    for (UI.PathMetric pathMetric in pathMetrics3) {
      Path extractPath1 = pathMetric.extractPath(
        pathMetric.length * 0.1 * value,
        pathMetric.length / 4 * value,
      );
      try {
        var metric3 = extractPath1.computeMetrics().first;
        final offset3 = metric3.getTangentForOffset(metric3.length)!.position;
        canvas.drawImage(image![1], offset3, new Paint());
      } catch (e) {}
    }

    for (UI.PathMetric pathMetric in pathMetrics4) {
      Path extractPath1 = pathMetric.extractPath(
        pathMetric.length / 0.75 * value,
        pathMetric.length / value * value,
      );
      try {
        var metric4 = extractPath1.computeMetrics().first;
        final offset4 =
            metric4.getTangentForOffset(metric4.length * 0.75)!.position;
        canvas.drawImage(image![2], offset4, new Paint());
      } catch (e) {}
    }
  }

  drawAxisReverse(double value, Canvas canvas, double radius, Paint paint) {
    var firstAxis = getCirclePath(radius);
    canvas.drawPath(firstAxis, _axisPaint);
    UI.PathMetrics pathMetrics = firstAxis.computeMetrics();
    UI.PathMetrics pathMetrics2 = firstAxis.computeMetrics();
    UI.PathMetrics pathMetrics3 = firstAxis.computeMetrics();
    UI.PathMetrics pathMetrics4 = firstAxis.computeMetrics();
    for (UI.PathMetric pathMetric in pathMetrics) {
      Path extractPath = pathMetric.extractPath(
        pathMetric.length * 0.45 / value,
        pathMetric.length / 0.1 * value,
      );
      try {
        var metric = extractPath.computeMetrics().first;
        final offset = metric.getTangentForOffset(metric.length / 2)!.position;
        canvas.drawImage(image![3], offset, new Paint());
      } catch (e) {}
    }

    for (UI.PathMetric pathMetric in pathMetrics2) {
      Path extractPath1 = pathMetric.extractPath(
        pathMetric.length * 0.3 / value,
        pathMetric.length / 0.5 * value,
      );
      try {
        var metric2 = extractPath1.computeMetrics().first;
        final offset2 =
            metric2.getTangentForOffset(metric2.length / 4)!.position;
        canvas.drawImage(image![0], offset2, new Paint());
      } catch (e) {}
    }

    for (UI.PathMetric pathMetric in pathMetrics3) {
      Path extractPath1 = pathMetric.extractPath(
        pathMetric.length * 0.25 * value,
        pathMetric.length / 4 / value,
      );
      try {
        var metric3 = extractPath1.computeMetrics().first;
        final offset3 =
            metric3.getTangentForOffset(metric3.length / 2)!.position;
        canvas.drawImage(image![1], offset3, new Paint());
      } catch (e) {}
    }

    for (UI.PathMetric pathMetric in pathMetrics4) {
      Path extractPath1 = pathMetric.extractPath(
        pathMetric.length * 0.01 * value,
        pathMetric.length / 4 / value,
      );
      try {
        var metric4 = extractPath1.computeMetrics().first;
        final offset4 =
            metric4.getTangentForOffset(metric4.length / 4)!.position;
        canvas.drawImage(image![2], offset4, new Paint());
      } catch (e) {}
    }
  }

  Path getCirclePath(double radius) => Path()
    ..addOval(Rect.fromCircle(center: Offset(-25, -30), radius: radius));

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
