import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../leela_app.dart';

class Marker extends StatefulWidget {
  const Marker({super.key});

  @override
  State<Marker> createState() => _MarkerState();
}

class _MarkerState extends State<Marker> {

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<LeelaAppState>();
    var positionToMove = appState.currentMarkerPosition;
    var cellSize = appState.currentMarkerSize;

    return Positioned(
        width: cellSize.width,
        height: cellSize.height,
        // left: markerOffset.dx,
        left: positionToMove.dx,
        // top: markerOffset.dy,
        top: positionToMove.dy,
        child: Container(
          child: Lottie.asset(
              'assets/lotties/point.json',
            fit: BoxFit.contain
          ),
        ));
  }
}
