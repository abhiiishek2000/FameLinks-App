import 'dart:ui' as UI;

import 'package:flutter/material.dart';

class AnimationDemo extends StatefulWidget {
  @override
  _AnimationDemoState createState() => _AnimationDemoState();
}

class _AnimationDemoState extends State<AnimationDemo> with TickerProviderStateMixin {
  AnimationController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
          animation: _controller!,
          builder: (context, snapshot) {
            return Center(
              child: CustomPaint(
                painter: AtomPaint(
                  value: _controller!.value,
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.play_arrow),
        onPressed: () {
          _controller!.reset();
          _controller!.repeat();
          Future.delayed(Duration(milliseconds: 305), (){_controller!.reset();_controller!.stop();});
        },
      ),
    );
  }
}

class AtomPaint extends CustomPainter {
  AtomPaint({
    this.value,
  });

  final double? value;

  Paint _axisPaint = Paint()
    ..color = Colors.black
    ..strokeWidth = 1.0
    ..style = PaintingStyle.stroke;

  @override
  void paint(Canvas canvas, Size size) {
    drawAxis(value!, canvas, 100, Paint()..color = Colors.black);
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
        pathMetric.length * 0.45 / value,
        pathMetric.length / 0.1 * value,
      );
      try {
        var metric = extractPath.computeMetrics().first;
        final offset = metric.getTangentForOffset(metric.length/2)!.position;
        // canvas.drawCircle(offset, 12.0, paint);
        canvas.drawCircle(offset, 12.0, paint);      } catch (e) {}
    }

    for (UI.PathMetric pathMetric in pathMetrics2) {
      Path extractPath1 = pathMetric.extractPath(
        pathMetric.length * 0.3 / value,
        pathMetric.length / 0.5 * value,
      );
      try {
        var metric2 = extractPath1.computeMetrics().first;
        final offset2 = metric2.getTangentForOffset(metric2.length/4)!.position;
        canvas.drawCircle(offset2, 12.0, paint);
      } catch (e) {}
    }

    // for (UI.PathMetric pathMetric in pathMetrics3) {
    //   Path extractPath1 = pathMetric.extractPath(
    //     pathMetric.length * 0.05 * value,
    //     pathMetric.length * 0.09 / value,
    //   );
    //   try {
    //     var metric3 = extractPath1.computeMetrics().first;
    //     final offset3 = metric3.getTangentForOffset(metric3.length/2).position;
    //     canvas.drawCircle(offset3, 12.0, paint);
    //   } catch (e) {}
    // }

    // for (UI.PathMetric pathMetric in pathMetrics4) {
    //   Path extractPath1 = pathMetric.extractPath(
    //     pathMetric.length * 0.0001 * value,
    //     pathMetric.length * 0.01 / value,
    //   );
    //   try {
    //     var metric4 = extractPath1.computeMetrics().first;
    //     final offset4 = metric4.getTangentForOffset(metric4.length / 4).position;
    //     canvas.drawCircle(offset4, 12.0, paint);
    //   } catch (e) {}
    // }
  }

  Path getCirclePath(double radius) =>
      Path()..addOval(Rect.fromCircle(center: Offset(0, 0), radius: radius));

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}