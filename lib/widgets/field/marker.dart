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
    var cellSize = appState.currentCellSize;

    return positionToMove == Offset.zero
        ? SizedBox.shrink()
        : AnimatedPositioned(
        width: cellSize.width,
        height: cellSize.height,
        left: positionToMove.dx,
        top: positionToMove.dy,
        duration: Duration(seconds: 5),
        child: Container(
          child: Lottie.asset(
              'assets/lotties/point.json',
            fit: BoxFit.contain
          ),
        ));
  }
}
