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
  Offset markerPosition = Offset.zero;

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<LeelaAppState>();
    var newMarkerPosition = appState.getFirstMarkerPosition;
    var cellSize = appState.currentCellSize;
    if (markerPosition!=newMarkerPosition && newMarkerPosition!=null)
      markerPosition = newMarkerPosition;
    return markerPosition == Offset.zero
        ? SizedBox.shrink()
        : AnimatedPositioned(
        width: cellSize.width,
        height: cellSize.height,
        left: markerPosition.dx,
        top: markerPosition.dy,
        duration: Duration(seconds: 5),
        onEnd: ()=>{appState.checkMoreMarkerPositions()},
        child: Container(
          child: Lottie.asset(
              'assets/lotties/point.json',
            fit: BoxFit.contain
          ),
        ));
  }
}
