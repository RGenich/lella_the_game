import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../leela_app.dart';
import '../request_card/mini_card.dart';

class Marker extends StatefulWidget {
  const Marker({super.key});

  @override
  State<Marker> createState() => _MarkerState();
}

class _MarkerState extends State<Marker> {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<LeelaAppState>();
    Offset currentMarkerPosition = Offset.zero;
    // appState.refreshCellPositions();
    var newMarkerPosition = appState.getNextMarkerPosition;
    bool isOpenCard = appState.isAllCellsVisited();
    var request = appState.getRequestByNumber(appState.currentPosition);
    var cellSize = appState.currentCellSize;
    if (newMarkerPosition != null) currentMarkerPosition = newMarkerPosition;
    return currentMarkerPosition == Offset.zero
        ? SizedBox.shrink()
        : AnimatedPositioned(
            width: cellSize.width,
            height: cellSize.height,
            left: currentMarkerPosition.dx,
            top: currentMarkerPosition.dy,
            duration: Duration(milliseconds: 1500),
            curve: Curves.decelerate,
            onEnd: () {
              if (isOpenCard) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return  MiniCard(request);
                  },
                ).then((value) {
                  appState.openPosition();
                  appState.checkTransfer(request);
                  appState.checkUnvisitedMarkerPositions();
                });
              } else appState.checkUnvisitedMarkerPositions();
            },
            child: IgnorePointer(
              child: Container(
                child: Lottie.asset('assets/lotties/point.json',
                    fit: BoxFit.contain),
              ),
            ));
  }
}
