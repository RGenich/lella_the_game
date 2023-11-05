import 'package:Leela/bloc/dice_bloc/dice_bloc.dart';
import 'package:Leela/bloc/marker_bloc/marker_bloc.dart';
import 'package:Leela/bloc/overlay_bloc/overlay_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../request_card/mini_card.dart';

class Marker extends StatefulWidget {
  const Marker({super.key});

  @override
  State<Marker> createState() => _MarkerState();
}

class _MarkerState extends State<Marker> {
  @override
  Widget build(BuildContext context) {
    // appState.refreshCellPositions();
    // var cellSize = appState.currentCellSize;

    return BlocBuilder<MarkerBloc, MarkerState>(builder: (context, markerState) {
      MarkerBloc markerBloc = context.watch<MarkerBloc>();
      DiceBloc diceBloc = context.read<DiceBloc>();
      // OverlayBloc overlayBloc = context.read<OverlayBloc>();
      OverlayBloc overlayBloc1 = BlocProvider.of<OverlayBloc>(context);
      if (markerState is MarkerReadyState) {
        return AnimatedPositioned(
            child: IgnorePointer(
              child: Container(
                child: Lottie.asset('assets/lotties/point.json',
                    fit: BoxFit.contain),
              ),
            ),

            width: markerState.size.width,
            height: markerState.size.height,
            left: markerState.position.dx,
            // left: Offset.zero.dx,
            top: markerState.position.dy,
            // top: Offset.zero.dy,
            duration: Duration(milliseconds: 1500),
            curve: Curves.decelerate,
            onEnd: () {
              if (markerState.isDestinationReach) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return BlocBuilder<DiceBloc, DiceBlocState>(
                      buildWhen: (previous, current) => markerState.isDestinationReach,
                      builder: (context, diceState) {
                        overlayBloc1.add(AddInfoEvent(diceState.request.header));
                        return MiniCard(diceState.request);
                      },
                    );
                  },
                ).then((value) {
                  diceBloc.add(CheckTransfersAfterDiceEvent());
                  markerBloc.add(IsShouldMarkerMoveEvent());
                  // diceBloc.add(UnblockDiceEvent());
                });
              } else {
                markerBloc.add(IsShouldMarkerMoveEvent());
              }
            });
      } else
        return CircularProgressIndicator();
    });
  }
}


