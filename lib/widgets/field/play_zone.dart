
import 'package:Leela/widgets/field/marker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'main_field.dart';

class PlayZone extends StatefulWidget {
  PlayZone({required Key key}) : super(key: key);
  @override
  State<PlayZone> createState() => PlayZoneState();
}

class PlayZoneState extends State<PlayZone> {

  PlayZoneState();

  @override
  Widget build(BuildContext context) {
    // context.read<MarkerBloc>().add(PlayZoneKeyDefinedEvent(key));
    //Игровое поле
    return AspectRatio(
      aspectRatio: 16/9,
      child: NotificationListener<SizeChangedLayoutNotification>(
        onNotification: rebuildPositions,
        child: SizeChangedLayoutNotifier(
          child: Stack(children: [
            Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
              image: AssetImage("assets/images/girl3.jpg"),
              fit: BoxFit.fill,
            ))),
            SizedBox(
                // width: 5000,
                // height: 5000,
                child: SvgPicture.asset(
              "assets/images/transfer_background.svg",
              fit: BoxFit.fill,
            )),
            // Snakes(),
            MainField(),
            Marker()
          ]),
        ),
      ),
    );
  }
}


bool rebuildPositions(notification) {

  print('size changed');
  // context.read<RequestBloc>()..add(RequestCellBuiltEvent());
  //TODO: thats how sizes changed
  // WidgetsBinding.instance.addPostFrameCallback((_) {
  //   var state = Provider.of<LeelaAppState>(context, listen: false);
  //   state.refreshCellPositions();
  //   // state.notify();
  //   state.defineCellSize();
  //   state.addNewMarkerPosition();
  //   state.notify();
  //   // state.rereadSnakesCellPositions();
  // });
  return true;
}
