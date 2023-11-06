

import 'package:famelink/util/config/color.dart';
import 'package:flutter/material.dart';

class HeartThumbShape extends SliderComponentShape {
  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(12.0);
  }

  @override
  void paint(
      PaintingContext context,
      Offset center, {
        required Animation<double> activationAnimation,
        required Animation<double> enableAnimation,
        required bool isDiscrete,
        required TextPainter labelPainter,
        required RenderBox parentBox,
        required SliderThemeData sliderTheme,
        required TextDirection textDirection,
        required double value,
        required double textScaleFactor,
        required Size sizeWithOverflow,
      }) {
    final Canvas canvas = context.canvas;
    final Tween<double> radiusTween = Tween<double>(
      begin: 12.0,
      end: 16.0,
    );
    final double radius = radiusTween.evaluate(activationAnimation);
    final Paint paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;

    final Path path = Path();
    path.moveTo(center.dx, center.dy - radius);
    path.cubicTo(
        center.dx + radius * 0.7,
        center.dy - radius,
        center.dx + radius,
        center.dy - radius * 0.7,
        center.dx + radius,
        center.dy);
    path.cubicTo(
        center.dx + radius,
        center.dy + radius * 0.7,
        center.dx + radius * 0.7,
        center.dy + radius,
        center.dx,
        center.dy + radius);
    path.cubicTo(
        center.dx - radius * 0.7,
        center.dy + radius,
        center.dx - radius,
        center.dy + radius * 0.7,
        center.dx - radius,
        center.dy);
    path.cubicTo(
        center.dx - radius,
        center.dy - radius * 0.7,
        center.dx - radius * 0.7,
        center.dy - radius,
        center.dx,
        center.dy - radius);

    canvas.drawPath(path, paint);
  }
}


class HeartSlider extends StatefulWidget {
  final double min;
  final double max;
  final ValueChanged<double> onChanged;
  final double thumbSize;
  double? value;

  HeartSlider({
    this.min = 0,
    this.max = 1,
    required this.onChanged,
    this.thumbSize = 40, this.value,
  });

  @override
  _HeartSliderState createState() => _HeartSliderState();
}

class _HeartSliderState extends State<HeartSlider> {


  @override
  void initState() {
    widget.value = (widget.min + widget.max) / 2;
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        thumbShape: HeartThumbShape(),
        activeTrackColor: orange,
        inactiveTrackColor: Colors.grey,
        valueIndicatorColor: orange,
        showValueIndicator: ShowValueIndicator.always,
        valueIndicatorTextStyle: TextStyle(color: Colors.white)
      ),
      child: Slider(
        value: widget.value!,
        min: widget.min,
        max: widget.max,
        divisions: 4,
          label: widget.value!.round().toString(),
        onChanged: widget.onChanged
      ),
    );
  }
}
