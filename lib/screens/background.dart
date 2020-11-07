import 'package:flutter/material.dart';

class MyPainter extends CustomPainter {
  var size;
  MyPainter({
    this.size,
  });
  @override
  void paint(Canvas canvas, Size size) {
    final height=this.size.height;
    final width=this.size.width;
    Rect mainBackground=Rect.fromLTRB(-width*0.6, -height*0.2,width*0.825, height*0.375);

  final paint = Paint()
    ..color = Color(0xFF1D0477)
    ..style = PaintingStyle.fill;
  canvas.drawOval(mainBackground, paint);
  }

  @override
  bool shouldRepaint(MyPainter oldDelegate) => false;

  
}