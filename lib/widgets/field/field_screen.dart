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
    //calling the getHeight Function after the Layout is Rendered
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    var markerBloc = BlocProvider.of<MarkerBloc>(context);
    markerBloc..add(PlayZoneKeyDefinedEvent(pzKey));
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        // constraints: BoxConstraints.(),
        decoration: BoxDecoration(border: Border.all(color: Colors.white)),
        // height:  MediaQuery.of(context).size.height,
        // width:  MediaQuery.of(context).size.width,
        child: Column(
        // scrollDirection: Axis.horizontal,
          // crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisSize: MainAxisSize.max,
          children: [
            Flexible(flex: 5, child: OverlayInfo()),
            Flexible(
              flex: 72,
              child: Container(
                decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Flexible(flex: 10, child: PlayZone(key: pzKey)),
                    Flexible(flex: 1, child: Container(
                        decoration: BoxDecoration(border: Border.all(color: Colors.green)),
                        child: Dice())),
                  ],
                ),
              ),
            ),
            // SizedBox(width: 10,),
          ],
        ),
        // )
    );
  }
}
