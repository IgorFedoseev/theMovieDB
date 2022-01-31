import 'dart:math';

import 'package:flutter/material.dart';

class DrawRadialPercentWidget extends StatefulWidget {
  const DrawRadialPercentWidget({Key? key}) : super(key: key);

  @override
  State<DrawRadialPercentWidget> createState() =>
      _DrawRadialPercentWidgetState();
}

class _DrawRadialPercentWidgetState extends State<DrawRadialPercentWidget> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SizedBox(
          height: 180.0,
          width: 180.0,
          child: RadialPercentWidget(
            percent: 0.128,
            backgroungColor: Colors.blue,
            activeLineColor: Colors.amber,
            restLineColor: Colors.white,
            lineWidth: 10.0,
          ),
        ),
      ),
    );
  }
}

class RadialPercentWidget extends StatelessWidget {
  const RadialPercentWidget(
      {Key? key,
      required this.percent,
      required this.backgroungColor,
      required this.activeLineColor,
      required this.restLineColor,
      required this.lineWidth})
      : super(key: key);
  final double percent;
  final Color backgroungColor;
  final Color activeLineColor;
  final Color restLineColor;
  final double lineWidth;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        CustomPaint(
            painter: MyPainter(
          percent: percent,
          backgroungColor: backgroungColor,
          activeLineColor: activeLineColor,
          restLineColor: restLineColor,
          lineWidth: lineWidth,
        )),
        Center(
          child: PercentText(percent: percent),
        ),
      ],
    );
  }
}

class MyPainter extends CustomPainter {
  const MyPainter(
      {Key? key,
      required this.percent,
      required this.backgroungColor,
      required this.activeLineColor,
      required this.restLineColor,
      required this.lineWidth});

  final double percent;
  final Color backgroungColor;
  final Color activeLineColor;
  final Color restLineColor;
  final double lineWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final Rect arcOffsetAndSize = calculateArcsRect(size);
    drawBackground(canvas, size);
    drawRestLine(canvas, arcOffsetAndSize);
    drawActiveLine(canvas, arcOffsetAndSize);
  }

  void drawRestLine(Canvas canvas, Rect arcOffsetAndSize) {
    final restArcPaint = Paint();
    restArcPaint.color = restLineColor;
    restArcPaint.style = PaintingStyle.stroke;
    restArcPaint.strokeWidth = lineWidth;
    canvas.drawArc(
      arcOffsetAndSize,
      -pi / 2 + 2 * pi * percent, // начало в радианах
      2 * pi * (1.0 - percent), // длина
      false, // исп центр
      restArcPaint, // стиль
    );
  }

  void drawActiveLine(Canvas canvas, Rect arcOffsetAndSize) {
    final arcPaint = Paint();
    arcPaint.color = activeLineColor;
    arcPaint.style = PaintingStyle.stroke;
    arcPaint.strokeWidth = lineWidth;
    arcPaint.strokeCap = StrokeCap.round;
    canvas.drawArc(
      arcOffsetAndSize,
      -pi / 2, // начало в радианах
      2 * pi * percent, // длина
      false, // исп центр
      arcPaint, // стиль
    );
  }

  void drawBackground(Canvas canvas, Size size) {
    final backgroundPaint = Paint();
    backgroundPaint.color = backgroungColor;
    backgroundPaint.style = PaintingStyle.fill;
    canvas.drawOval(Offset.zero & size, backgroundPaint);
  }

  Rect calculateArcsRect(Size size) {
    const int margin = 3;
    final offset = lineWidth / 2 + margin;
    final arcOffsetAndSize = Offset(offset, offset) &
        Size(size.width - lineWidth - margin * 2,
            size.height - lineWidth - margin * 2);
    return arcOffsetAndSize;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class PercentText extends StatelessWidget {
  const PercentText({Key? key, required this.percent}) : super(key: key);
  final double percent;

  @override
  Widget build(BuildContext context) {
    return Text(
      '${(percent * 100).round()}%',
      style: const TextStyle(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
