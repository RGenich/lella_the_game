import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../leela_app.dart';

class Pointer extends StatefulWidget {
  const Pointer({super.key});

  @override
  State<Pointer> createState() => _PointerState();
}

class _PointerState extends State<Pointer> {
  double cellWidth = 0.0;
  Offset markerOffset = Offset(0, 0);

  // @override
  // void initState() {
  //   var appState = context.watch<LeelaAppState>();
  // setState(() {
  //   cellWidth = appState.playZoneSize.width;
  //   markerOffset = appState.markerPos;
  // });
  // super.initState();
  // }
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<LeelaAppState>();
    cellWidth = appState.playZoneSize.width;
    markerOffset = appState.markerPos;
    var cp = appState.currentPosition;
    return Positioned(
        left: markerOffset.dx,
        top: markerOffset.dy,
        child: Container(
          width: cellWidth / 8,
          child: Lottie.asset('assets/lotties/point.json'),
        ));
  }
}
