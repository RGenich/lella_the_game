import 'package:Leela/leela_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../bloc/overlay_bloc/overlay_bloc.dart';

class OverlayInfo extends StatefulWidget {
  const OverlayInfo({super.key});

  @override
  State<OverlayInfo> createState() => _OverlayInfoState();
}

class _OverlayInfoState extends State<OverlayInfo> {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<LeelaAppState>();
    // var droppedFields = appState.openedCells;
    // int lastScore = appState.getLastDiceScore;
    return BlocBuilder<OverlayBloc, TopOverlayState>(
      builder: (context, state) {
        if (state is InfoAddedState) {
          return Row(
            children: generateTrace(state.info));
        }
         else return Text('DO FIRST MOVE');
      },
    );
  }

  List<Widget> generateTrace(List<String> infos) {
    List<Widget> overlayData = [];
    for (var info in infos) {
      overlayData.add(Text(' ${info} '));
      overlayData.add(Icon(Icons.arrow_right_outlined));
    }
    return overlayData;
  }
}
