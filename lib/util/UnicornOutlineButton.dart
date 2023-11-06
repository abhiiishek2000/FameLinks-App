import 'package:flutter/material.dart';

class UnicornOutlineButton extends StatelessWidget {
  final _GradientPainter? _painter;
  final Widget? _child;
  final VoidCallback? _callback;
  final double? topLeftRadius;
  final double? topRightRadius;
  final double? bottomLeftRadius;
  final double? bottomRightRadius;

  UnicornOutlineButton({
    @required double? strokeWidth,
    @required double? topLeftRadius,
    @required double? topRightRadius,
    @required double? bottomLeftRadius,
    @required double? bottomRightRadius,
    @required Gradient? gradient,
    @required Widget? child,
    @required VoidCallback? onPressed,
  })  : this._painter = _GradientPainter(strokeWidth: strokeWidth!, topLeftRadius: topLeftRadius!,topRightRadius:topRightRadius!,bottomLeftRadius:bottomLeftRadius!,bottomRightRadius: bottomRightRadius! , gradient: gradient!),
        this._child = child,
        this._callback = onPressed,
        this.topLeftRadius = topLeftRadius,
        this.topRightRadius = topRightRadius,
        this.bottomLeftRadius = bottomLeftRadius,
        this.bottomRightRadius = bottomRightRadius;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _painter,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: _callback,
        child: InkWell(
          borderRadius: BorderRadius.only(
            topLeft:  Radius.circular(topLeftRadius!),
            topRight:  Radius.circular(topRightRadius!),
              bottomLeft:
              Radius.circular(bottomLeftRadius!),
              bottomRight: Radius.circular(
                  bottomRightRadius!)),
          onTap: _callback,
          child:  _child,
        ),
      ),
    );
  }
}

class _GradientPainter extends CustomPainter {
  final Paint _paint = Paint();
  final double? topLeftRadius;
  final double? topRightRadius;
  final double? bottomLeftRadius;
  final double? bottomRightRadius;
  final double? strokeWidth;
  final Gradient? gradient;

  _GradientPainter({@required double? strokeWidth, @required double? topLeftRadius,@required double? topRightRadius,@required double? bottomLeftRadius,@required double? bottomRightRadius, @required Gradient? gradient})
      : this.strokeWidth = strokeWidth,
        this.topLeftRadius = topLeftRadius,
        this.topRightRadius = topRightRadius,
        this.bottomLeftRadius = bottomLeftRadius,
        this.bottomRightRadius = bottomRightRadius,
        this.gradient = gradient;

  @override
  void paint(Canvas canvas, Size size) {
    // create outer rectangle equals size
    Rect outerRect = Offset.zero & size;
    var outerRRect = RRect.fromRectAndCorners(outerRect, topLeft: Radius.circular(topLeftRadius!),topRight: Radius.circular(topRightRadius!),bottomLeft: Radius.circular(bottomLeftRadius!),bottomRight: Radius.circular(bottomRightRadius!));

    // create inner rectangle smaller by strokeWidth
    Rect innerRect = Rect.fromLTWH(strokeWidth!, strokeWidth!, size.width - strokeWidth! * 2, size.height - strokeWidth! * 2);
    var innerRRect = RRect.fromRectAndCorners(innerRect, topLeft: Radius.circular(topLeftRadius!),topRight: Radius.circular(topRightRadius!),bottomLeft: Radius.circular(bottomLeftRadius! - strokeWidth!),bottomRight: Radius.circular(bottomRightRadius! - strokeWidth!));

    // apply gradient shader
    _paint.shader = gradient!.createShader(outerRect);

    // create difference between outer and inner paths and draw it
    Path path1 = Path()..addRRect(outerRRect);
    Path path2 = Path()..addRRect(innerRRect);
    var path = Path.combine(PathOperation.difference, path1, path2);
    canvas.drawPath(path, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => oldDelegate != this;
}