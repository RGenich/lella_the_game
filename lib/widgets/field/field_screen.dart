import 'package:Leela/widgets/field/play_zone.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/marker_bloc/marker_bloc.dart';
import '../dice_widget.dart';
import '../overlay_data.dart';

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
    return Scaffold(

      body: Column(
        children: [
          OverlayInfo(),
          Row(

            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                flex: 10,
                  child: PlayZone(key: pzKey)),
              // SizedBox(width: 10,),
              Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.all(5.0),
                  // color: Colors.red,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,

                    children: [Dice()],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
