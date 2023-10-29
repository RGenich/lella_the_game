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
import 'transfer.dart';

class PlayZone extends StatefulWidget {
  @override
  State<PlayZone> createState() => _PlayZoneState();
}

class _PlayZoneState extends State<PlayZone> {
  var zoneKey = GlobalKey();

  _PlayZoneState();

  List<GameRow> buildRows(List<RequestData> requests) {
    var startPos = 65;
    var endPos = 74;
    List<GameRow> rows = [];
    for (var j = 1; j < 9; ++j) {
      var requestsOfRow = requests.getRange(startPos, endPos).toList();
      // RequestsKeeper.requests.getRange(startPos, endPos).toList();
      rows.add(GameRow(requestsOfRow, j % 2 == 0));
      startPos -= 9;
      endPos -= 9;
    }
    return rows;
  }

  @override
  Widget build(BuildContext context) {
    //Игровое поле

    return BlocBuilder<RequestBloc, RequestState>(builder: (context, state) {
      MarkerBloc markerBloc = context.watch<MarkerBloc>();
      if (state is RequestLoadedState) {
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
                      width: 5000,
                      height: 5000,
                      child: SvgPicture.asset(
                        "assets/images/transfer_background.svg",
                        fit: BoxFit.fill,
                      )),
                  // Snakes(),
                  Container(
                      key: zoneKey,
                      // decoration: BoxDecoration(border: Border.all(color: Colors.brown)),
                      child: Column(
                        children: buildRows(state.requests),
                      )),
                  Container(child: BlocBuilder<MarkerBloc, MarkerState>(
                      builder: (context, state) {
                    if (state is MarkerInitialState)
                      markerBloc..add(MarkerFirstShowEvent());
                    return !(state is MarkerInitialState)
                        ? Marker()
                        : SizedBox();
                  }))
                ]),
              ),
            ),
          ),
        );
      } else {
        return CircularProgressIndicator(color: Colors.white);
      }
    });
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
}

class GameRow extends StatelessWidget {
  final List<RequestData> requestsOfRow;
  final bool isDirectSequence;
  late final List<Widget> cells;

  GameRow(List<RequestData> this.requestsOfRow, bool this.isDirectSequence,
      {Key? key})
      : super(key: key) {
    cells = createRowSequence(isDirectSequence);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(child: Row(children: cells));
  }

  List<Widget> createRowSequence(bool isDirectSequence) {
    List<Widget> cells = [];
    var sequence = isDirectSequence ? requestsOfRow : requestsOfRow.reversed;
    for (var req in sequence) {
      cells.add(GameCell(req));
    }
    return cells;
  }
}
