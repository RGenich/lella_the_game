import 'package:Leela/bloc/dice_bloc/dice_bloc.dart';
import 'package:Leela/bloc/marker_bloc/marker_bloc.dart';
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

    return BlocBuilder<MarkerBloc, MarkerState>(
      builder: (context, state) {
        MarkerBloc markerBloc = context.watch<MarkerBloc>();
        DiceBloc diceBloc = context.watch<DiceBloc>();
        if (state is MarkerInitialState/* || state is MarkerSizeDefinedState*/) {
          markerBloc..add(MarkerFirstShowEvent());
          return SizedBox.shrink();
        }
        return AnimatedPositioned(
            child: IgnorePointer(
              child: Container(
                child: Lottie.asset('assets/lotties/point.json',
                    fit: BoxFit.contain),
              ),
            ),
            width: state.size.width,
            height: state.size.height,
            left: state.position.dx,
            // left: state is MarkerFirstShowState ? state.position.dx : Offset
            //     .zero.dx,
            top: state.position.dy,
            duration: Duration(milliseconds: 600),
            curve: Curves.decelerate,
            onEnd: () {
              if (state.isDestinationReach) {
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
                  diceBloc.add(CheckTransfersAfterDiceEvent());
                  markerBloc.add(TimeToMoveMarkerEvent());
                  diceBloc.add(ThrowDiceEndEvent());
                });
              } else {
                markerBloc.add(TimeToMoveMarkerEvent());
              }
            });
        // } else return SizedBox();
      }
    );
  }
}
