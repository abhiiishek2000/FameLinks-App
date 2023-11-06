import 'package:flutter/material.dart';

class GradientText extends StatelessWidget {
  const GradientText(
      this.text, {
        this.gradient,
      });

  final String text;
  final Gradient? gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient!.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(text,
          style: TextStyle(
            fontSize: 20,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 2
              ..color = Colors.red,
          )),
    );
  }
}