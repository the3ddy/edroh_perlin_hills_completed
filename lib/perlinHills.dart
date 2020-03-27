import 'package:flutter/material.dart';
import 'dart:math';
import './perlinNoise1D.dart';

class PerlinHills extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var mountainPaint = Paint()
        ..color = Color(0xFFf6979d)
        ..style = PaintingStyle.fill;

    var hillPaint = Paint()
        ..color = Color(0xFF63045f)
        ..style = PaintingStyle.fill;

    var groundFillPaint = Paint()
        ..color = Color(0xFF0d014c)
        ..style = PaintingStyle.fill;

    var groundBorderPaint = Paint()
        ..color = Color(0xFF910b67)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 5;
    
    var sunPaint = Paint()
        ..color = Color(0xFFfffb89)
        ..style = PaintingStyle.fill;

    Random random = Random();
    var randomSeed = random.nextInt(4294967296);
    print(randomSeed);

    var seed = 152274093;
    var mountainValues = generatePerlinNoise1D(225, 90, 4, 6, size.width, seed);
    var hillValues = generatePerlinNoise1D(40, 75, 2, 1, size.width, seed);

    drawPerlinNoise1D(perlinNoiseValues, startHeight, paint) {
      var path = Path();
      path.moveTo(0, startHeight + perlinNoiseValues[0]);
      for (var i = 0; i < perlinNoiseValues.length; i++) {
        path.lineTo(i.toDouble(), startHeight + perlinNoiseValues[i]);
      }
      path.lineTo(size.width + 1, size.height);
      path.lineTo(0, size.height);
      path.close();
      canvas.drawPath(path, paint);
    }

    drawPerlinNoise1D(mountainValues, size.height / 8, mountainPaint);
    drawPerlinNoise1D(hillValues, size.height / 2.10, hillPaint);

    // creates ground line
    var straightPath = Path();
    straightPath.moveTo(0, size.height / 1.3);
    straightPath.lineTo(size.width, size.height / 1.3);
    canvas.drawPath(straightPath, groundBorderPaint);

    // creates ground area
    straightPath.lineTo(size.width, size.height);
    straightPath.lineTo(0, size.height);
    straightPath.close();
    canvas.drawPath(straightPath, groundFillPaint);

    // creates the sun
    canvas.drawCircle(Offset( (4 * size.width) / 5, size.height / 8), 50, sunPaint);
  } 

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
