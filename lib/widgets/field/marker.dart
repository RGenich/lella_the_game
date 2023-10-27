import 'package:Leela/bloc/dice_bloc/dice_bloc.dart';
import 'package:Leela/bloc/marker_bloc/marker_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../repository/repository.dart';
import '../request_card/mini_card.dart';

class Marker extends StatefulWidget {
  const Marker({super.key});

  @override
  State<Marker> createState() => _MarkerState();
}

class _MarkerState extends State<Marker> {
  @override
  Widget build(BuildContext context) {
    // var appState = context.watch<LeelaAppState>();
    Offset currentMarkerPosition = Offset.zero;
    // appState.refreshCellPositions();
    // var newMarkerPosition = appState.getNextMarkerPosition;
    // bool isOpenCard = appState.isAllCellsVisited();
    // var request = appState.getRequestByNumber(appState.currentPosition);
    // var cellSize = appState.currentCellSize;
    // if (newMarkerPosition != null) currentMarkerPosition = newMarkerPosition;
    // return BlocBuilder<MarkerBloc, MarkerState>(
    return BlocBuilder<MarkerBloc, MarkerState>(
      builder: (context, state) {
        MarkerBloc markerBloc = context.watch<MarkerBloc>();
        DiceBloc diceBloc = context.watch<DiceBloc>();

        return AnimatedPositioned(
          width: 100,
          height: 100,
          // width: cellSize.width,
          // height: cellSize.height,
            left: state.position.dx,
            top: state.position.dy,
            duration: Duration(milliseconds: 1500),
            curve: Curves.decelerate,
            onEnd: () {
              // if (isDestinationReached) {
              showDialog(
                context: context,
                builder: (context) {
                  return BlocBuilder<DiceBloc, DiceBlocState>(
                    builder: (context, state) {
                      return MiniCard(state.request);
                    },
                  );
                },
              ).then((value) {

                diceBloc.add(ThrowDiceEndEvent());
                markerBloc.add(TimeToMoveMarkerEvent());
                // appState.openPosition();
                // appState.checkTransfer(request);
                // appState.checkUnvisitedMarkerPositions();
              });
              // }
              // else appState.checkUnvisitedMarkerPositions();
            },
            child: IgnorePointer(
              child: Container(
                child: Lottie.asset('assets/lotties/point.json',
                    fit: BoxFit.contain),
              ),
            ));
      },
    );
  }
}
