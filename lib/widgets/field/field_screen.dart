import 'package:Leela/widgets/field/play_zone.dart';
import 'package:Leela/widgets/overlay_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/marker_bloc/marker_bloc.dart';
import '../dice_widget.dart';

class FieldWidget extends StatefulWidget {
  @override
  State<FieldWidget> createState() => _FieldWidgetState();
}

class _FieldWidgetState extends State<FieldWidget>
    with TickerProviderStateMixin {
  final pzKey = new GlobalKey<PlayZoneState>();

  @override
  initState() {
    var markerBloc = BlocProvider.of<MarkerBloc>(context);
    markerBloc..add(PlayZoneKeyDefinedEvent(pzKey));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(flex: 5, child: OverlayInfo()),
        Flexible(
          flex: 72,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                  flex: 10,
                  child: Align(
                      child: AspectRatio(
                          aspectRatio: 18 / 9,
                          child: PlayZone(key: pzKey)))),
              Flexible(
                  flex: 1,
                  child: Container(child: Dice())),
            ],
          ),
        ),
      ],
    );
  }
}
