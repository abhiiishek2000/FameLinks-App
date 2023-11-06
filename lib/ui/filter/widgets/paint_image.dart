import 'dart:developer';
import 'package:famelink/ui/filter/models/face_filter.dart';
import 'package:famelink/ui/filter/models/vignette.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_vision/google_ml_vision.dart';
import 'dart:ui' as ui;

class PaintImage extends CustomPainter {
  final ui.Image? image;
  final FaceFilter? faceFilter;
  final List<Face>? faces;
  final Vignette? vignette;
  final List<double>? filterMatrix;
  final Color? skinColor;
  final Color? eyesColor;
  final double? eyesColorOpacity;

  const PaintImage({
    this.faces,
    @required this.image,
    this.faceFilter,
    @required this.filterMatrix,
    @required this.skinColor,
    @required this.vignette,
    @required this.eyesColor,
    @required this.eyesColorOpacity,
  }) : super();

  @override
  Future<void> paint(Canvas canvas, Size size) async {
    print('Painttimg image');
    print(size);
    // canvas.drawImage(image, const Offset(0.0, 0.0), Paint());
    paintImage(
        canvas: canvas,
        rect: Rect.fromLTWH(0, 0, size.width, size.height),
        image: image!);

    paintImage(
        canvas: canvas,
        rect: Rect.fromLTWH(0, 0, size.width, size.height),
        image: image!,
        colorFilter: ColorFilter.matrix(filterMatrix!));

    if (faceFilter != null && faces != null) {
      Paint paint = Paint();
      paint.color = Colors.green;
      paint.strokeWidth = (size.width * 3) / 640;
      paint.style = PaintingStyle.fill;

      final opacityOfSkinColor = (faceFilter!.foundationColorMultiply)! / 100;
      print("Opacity of skin colors : $opacityOfSkinColor");
      Color eyeColor = Colors.black.withOpacity(faceFilter!.eyesSharpen! / 100);

      for (Face face in faces!) {
        FaceContour? leftEyeContour = face.getContour(FaceContourType.leftEye);
        if (leftEyeContour != null) {
          Path path = Path();
          path.addPolygon(leftEyeContour.positionsList, true);
          canvas.drawPath(
              path,
              paint
                ..style = PaintingStyle.fill
                ..color = eyeColor.withOpacity(eyesColorOpacity!));
        }
        FaceContour? rightEyeContour =
            face.getContour(FaceContourType.rightEye);
        if (rightEyeContour != null) {
          Path path = Path();
          path.addPolygon(rightEyeContour.positionsList, true);
          canvas.drawPath(path, paint);
        }

        FaceContour? faceContour = face.getContour(FaceContourType.face);

        if (faceContour != null) {
          Path path = Path();

          List<Offset> positions = [...faceContour.positionsList];
          positions.removeRange(0, 4);
          positions.removeRange(28, 32);
          // positions.add(face.boundingBox.topCenter);
          Offset leftSidePoint = positions.last;
          Offset rightSidePoint = positions.first;
          Offset incrementLeft = Offset(
              (face.boundingBox.topCenter.dx - leftSidePoint.dx) / 4,
              (leftSidePoint.dy - face.boundingBox.topCenter.dy) / 4);
          Offset incrementRight = Offset(
              (face.boundingBox.topCenter.dx - rightSidePoint.dx) / 4,
              (rightSidePoint.dy - face.boundingBox.topCenter.dy) / 4);
          List<Offset> tempList = [positions.last];
          for (int i = 0; i < 4; i++) {
            Offset crossAxisOffset = Offset(tempList.last.dx + incrementLeft.dx,
                tempList.last.dy - incrementLeft.dy);
            tempList.add(Offset(
                leftSidePoint.dx + (crossAxisOffset.dx - leftSidePoint.dx) / 2,
                crossAxisOffset.dy));
            // canvas.drawCircle(tempList.last, 5, paint..color = Colors.red);
          }
          Path secondPath = Path()..addPolygon(tempList, false);

          List<Offset> centerPoints = [tempList.first];

          Offset centerPointDiff = Offset(
              (tempList.last.dx - tempList.first.dx) / 4,
              (tempList.first.dy - tempList.last.dy) / 4);
          print("center points off ${centerPointDiff}");
          for (int i = 0; i < 4; i++) {
            centerPoints.add(Offset(centerPoints.last.dx + centerPointDiff.dx,
                centerPoints.last.dy - centerPointDiff.dy));
          }
          positions.removeLast();
          positions.removeLast();
          for (int i = 0; i < 5; i++) {
            Offset toAdd = Offset(
                centerPoints[i].dx + (centerPoints[i].dx - tempList[i].dx),
                centerPoints[i].dy + (centerPoints[i].dx - tempList[i].dx));
            positions.add(toAdd);
          }

          //Right side
          tempList = [positions.first];

          for (int i = 0; i < 4; i++) {
            Offset crossAxisOffset = Offset(
                tempList.first.dx + incrementRight.dx,
                tempList.first.dy - incrementRight.dy);
            tempList.insert(
                0,
                Offset(
                    rightSidePoint.dx -
                        ((rightSidePoint.dx - crossAxisOffset.dx) / 2),
                    crossAxisOffset.dy));
          }

          centerPoints = [tempList.first];

          centerPointDiff = Offset((tempList.last.dx - tempList.first.dx) / 4,
              (tempList.last.dy - tempList.first.dy) / 4);
          secondPath = Path()..addPolygon(centerPoints, false);

          for (int i = 0; i < 4; i++) {
            centerPoints.add(Offset(centerPoints.last.dx + centerPointDiff.dx,
                centerPoints.last.dy + centerPointDiff.dy));
          }
          canvas.drawPath(Path()..addPolygon(centerPoints, false),
              paint..color = Colors.purpleAccent);
          // positions.removeAt(0);
          // positions.removeAt(0);

          positions.removeAt(0);
          for (int i = 0; i < 4; i++) {
            Offset toAdd = Offset(
                centerPoints[i].dx + (centerPoints[i].dx - tempList[i].dx),
                centerPoints[i].dy + (centerPoints[i].dy - tempList[i].dy));
            positions.add(toAdd);
          }

          // positions.add(face.boundingBox.topCenter);

          RadialGradient gradient = RadialGradient(
            stops: [0.7, 0.90, 0.99],
            colors: [
              skinColor!.withOpacity(opacityOfSkinColor / 1.5),
              skinColor!.withOpacity(opacityOfSkinColor / 2),
              skinColor!.withOpacity(opacityOfSkinColor / 4),
            ],
          );

          log(positions.toString());
          log("size : $size");

          for (int i = 0; i < positions.length; i++) {
            double dx = size.width * positions[i].dx / image!.width;
            double dy = size.height * positions[i].dy / image!.height;
            positions[i] = Offset(dx, dy);
          }
          Rect boundingBox = Rect.fromLTRB(
              face.boundingBox.left * size.width / image!.width,
              face.boundingBox.top * size.height / image!.height - 100,
              face.boundingBox.right * size.width / image!.width,
              face.boundingBox.bottom * size.height / image!.height + 100);
          // Rect boundingBox = Rect.fromLTRB(
          //     positions[28].dx,
          //     face.boundingBox.top * size.height / image.height,
          //     positions[5].dx,
          //     face.boundingBox.bottom * size.height / image.height);
          path.addPolygon(positions, true);
          canvas.drawPath(
              path, paint..shader = gradient.createShader(boundingBox));
          // canvas.drawPath(
          //     Path()
          //       ..addPolygon(
          //           face.getContour(FaceContourType.face)!.positionsList, true),
          //     Paint()
          //       ..style = PaintingStyle.fill
          //       ..shader = gradient.createShader(face.boundingBox));

          if (vignette!.vignetteType == VignetteType.radial) {
            RadialGradient radialGradient = RadialGradient(colors: [
              Colors.black.withOpacity(0.0),
              Colors.black.withOpacity(vignette!.amount! / 800),
              Colors.black.withOpacity(vignette!.amount! / 600),
              Colors.black.withOpacity(vignette!.amount! / 200),
              Colors.black.withOpacity(vignette!.amount! / 100),
            ]);
            canvas.drawRect(
                Rect.fromLTWH(
                    0, 0, size.width.toDouble(), size.height.toDouble()),
                Paint()
                  ..style = PaintingStyle.fill
                  ..shader = radialGradient.createShader(Rect.fromLTWH(
                      0, 0, size.width.toDouble(), size.height.toDouble())));
          } else if (vignette!.vignetteType == VignetteType.leftAndRight) {
            LinearGradient linearGradient = LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Colors.black.withOpacity(vignette!.amount! / 100),
                  Colors.black.withOpacity(vignette!.amount! / 200),
                  Colors.black.withOpacity(vignette!.amount! / 600),
                  Colors.black.withOpacity(vignette!.amount! / 800),
                  Colors.black.withOpacity(vignette!.amount! / 600),
                  Colors.black.withOpacity(vignette!.amount! / 200),
                  Colors.black.withOpacity(vignette!.amount! / 100),
                ]);
            canvas.drawRect(
                Rect.fromLTWH(
                    0, 0, size.width.toDouble(), size.height.toDouble()),
                Paint()
                  ..style = PaintingStyle.fill
                  ..shader = linearGradient.createShader(Rect.fromLTWH(
                      0, 0, size.width.toDouble(), size.height.toDouble())));
          } else if (vignette!.vignetteType == VignetteType.topAndBottom) {
            LinearGradient linearGradient = LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(vignette!.amount! / 100),
                  Colors.black.withOpacity(vignette!.amount! / 200),
                  Colors.black.withOpacity(vignette!.amount! / 600),
                  Colors.black.withOpacity(vignette!.amount! / 800),
                  Colors.black.withOpacity(vignette!.amount! / 600),
                  Colors.black.withOpacity(vignette!.amount! / 200),
                  Colors.black.withOpacity(vignette!.amount! / 100),
                ]);
            canvas.drawRect(
                Rect.fromLTWH(
                    0, 0, size.width.toDouble(), size.height.toDouble()),
                Paint()
                  ..style = PaintingStyle.fill
                  ..shader = linearGradient.createShader(Rect.fromLTWH(
                      0, 0, size.width.toDouble(), size.height.toDouble())));
          }
        }
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldR
    return true;
  }
}
