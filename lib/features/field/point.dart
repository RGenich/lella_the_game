import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Point extends StatefulWidget {
  const Point({super.key});

  @override
  State<Point> createState() => _PointState();
}

class _PointState extends State<Point> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: 200,
        top: 400,
        child: Container(

      child: Lottie.asset('assets/lotties/point.json'),
    ));
  }
}
