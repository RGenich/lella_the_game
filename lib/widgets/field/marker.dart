import 'package:Leela/bloc/dice_bloc/dice_bloc.dart';
import 'package:Leela/bloc/marker_bloc/marker_bloc.dart';
import 'package:Leela/bloc/overlay_bloc/overlay_bloc.dart';
import 'package:Leela/bloc/request_bloc/request_bloc.dart';
import 'package:Leela/model/request_data.dart';
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
  double previousHeight = 0;
  double previousWidth = 0;
  @override
  Widget build(BuildContext context) {
    late RequestData requestData;

    return BlocBuilder<MarkerBloc, MarkerState>(
        builder: (context, markerState) {
      MarkerBloc markerBloc = context.watch<MarkerBloc>();
      if (markerState is MarkerReadyState) {
          return AnimatedPositioned(
              child: IgnorePointer(
                child: Container(
                  child: Lottie.asset('assets/lotties/point.json',
                      fit: BoxFit.contain),
                ),
              ),
              height:  markerState.size.height,
              width: markerState.size.width,
              left: markerState.position.dx,
              top: markerState.position.dy,

              duration: Duration(milliseconds: 400),
              curve: Curves.decelerate,
              onEnd: () {
                if (markerState.isDestinationReach ) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return BlocBuilder<DiceBloc, DiceBlocState>(
                        buildWhen: (previous, current) =>
                        markerState.isDestinationReach,
                        builder: (context, diceState) {
                          requestData = diceState.request;
                          return MiniCard(requestData);
                        },
                      );
                    },
                  ).then((value) {
                    print('then');
                    // if (markerState is !MarkerStopState) {
                      context.read<OverlayBloc>().add(UpdateOverlayEvent());
                      markerBloc.add(IsShouldMarkerMoveEvent());
                      context.read<DiceBloc>().add(CheckTransfersAfterDiceEvent());
                    // }
                    // context.read<RequestBloc>().add(RebuildCellsEvent());
                  });
                } else {
                  markerBloc.add(IsShouldMarkerMoveEvent());
                }
              });
        // }
        /*  } else if (markerState is MarkerStopState) {
        return BlocBuilder<DiceBloc, DiceBlocState>(
            builder: (BuildContext context, diceState) {
          return MiniCard(diceState.request);
        });*/
      } else
        return CircularProgressIndicator();
    });
  }
}
