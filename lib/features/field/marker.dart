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
    var currentMarkerPosition = appState.currentMarkerPosition;

    return Positioned(
        // left: markerOffset.dx,
        left: currentMarkerPosition.dx,
        // top: markerOffset.dy,
        top: currentMarkerPosition.dy,
        child: Container(
          // width: playzoneWidth / 8,
          child: Lottie.asset('assets/lotties/point.json'),
        ));
  }
}
