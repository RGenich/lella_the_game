import 'package:Leela/model/ovelay_step.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/overlay_bloc/overlay_bloc.dart';

class OverlayInfo extends StatefulWidget {
  const OverlayInfo({super.key});

  @override
  State<OverlayInfo> createState() => _OverlayInfoState();
}

class _OverlayInfoState extends State<OverlayInfo> {
  Map<StepType, IconData> types = {
    StepType.USUAL: Icons.arrow_forward,
    StepType.SNAKE: Icons.arrow_downward,
    StepType.ARROW: Icons.arrow_upward,
    StepType.START: Icons.circle_sharp
  };

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OverlayBloc, TopOverlayState>(
      builder: (context, state) {
        return state is InfoAddedState
            ? ListView(
                scrollDirection: Axis.horizontal,
                children: generateTrace(state.steps))
            :  Text('DO FIRST MOVE');
      },
    );
  }

  List<Widget> generateTrace(List<OverlayStep> steps) {
    List<Widget> overlayData = [];
    for (var step in steps) {
      overlayData.add(Center(child: Icon(types[step.stepType])));
      overlayData.add(Center(child: Text(' ${step.header} ')));
    }
    return overlayData;
  }
}
