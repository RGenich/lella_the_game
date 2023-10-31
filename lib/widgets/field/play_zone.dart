// ignore_for_file: unused_import

import 'package:Leela/bloc/marker_bloc/marker_bloc.dart';
import 'package:Leela/leela_app.dart';
import 'package:Leela/service/request_keeper.dart';
import 'package:Leela/widgets/field/marker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../bloc/request_bloc/request_bloc.dart';
import '../../model/request_data.dart';
import '../../repository/repository.dart';
import 'field_cell.dart';
import 'main_field.dart';
import 'transfer.dart';

class PlayZone extends StatefulWidget {
  @override
  State<PlayZone> createState() => _PlayZoneState();
}

class _PlayZoneState extends State<PlayZone> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Bloc requestBloc = BlocProvider.of<RequestBloc>(context);
      Bloc markerBloc = BlocProvider.of<MarkerBloc>(context);
      // requestBloc.add(event)
      // RenderBox cellBox = cellKey.currentContext?.findRenderObject() as RenderBox;
      // Size size = cellBox.size;
      // Offset pos = cellBox.localToGlobal(Offset.zero);

      // requestBloc.add(RequestCellBuiltEvent());
      // markerBloc.add(MarkerSizeDefinedEvent());
    });
    super.initState();
  }

  _PlayZoneState();

  @override
  Widget build(BuildContext context) {
    //Игровое поле
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Container(
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
      ),
    );
  }
}

bool rebuildPositions(notification) {
  print('size changed');

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
